class ResponsesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  prepend_before_filter :find_questionnaire # run before #set_locale

  # http://broadcastingadam.com/2012/07/advanced_caching_part_1-caching_strategies/
  caches_action :new, cache_path: ->(c) do
    record = @questionnaire.responses.build
    cache_key(record)
  end
  caches_action :show, cache_path: ->(c) do
    record = @questionnaire.responses.find(params[:id])
    cache_key(record)
  end

  def new
    @response = @questionnaire.responses.build(initialized_at: Time.now.utc)
    build_questionnaire
    fresh_when(@questionnaire, public: true) if Rails.env.production?
  end

  def show
    @response = @questionnaire.responses.find(params[:id])
    build_questionnaire
    fresh_when(@response, public: true) if Rails.env.production?
  end

  def create
    @response = @questionnaire.responses.build(params[:response])
    @response.answers = params.select{|k,_| k[/\A[a-f0-9]{24}\z/]}
    @response.ip      = request.ip
    @response.save! # There shouldn't be errors.

    Notifier.thank_you(@response).deliver if @questionnaire.thank_you_template? && @questionnaire.reply_to? && @response.email.present?
    redirect_to response_path(@response, params.slice(:token)), notice: @questionnaire.response_notice.present? ? @questionnaire.response_notice : t(:create_response)
  end

  def count
    render json: @questionnaire.responses.count
  end

  def charts
    render json: @questionnaire.chart_data
  end

  def offline
  end

private

  def set_locale
    I18n.locale = locale_from_record(@questionnaire) || super
  end

  def find_questionnaire
    @questionnaire = Questionnaire.where(authorization_token: params[:token]).first if params[:token]
    @questionnaire ||= Questionnaire.find(params[:id]) if params[:id]
    @questionnaire ||= Questionnaire.find_by_domain(request.host)

    # In development, we generally work on the latest questionnaire.
    @questionnaire ||= Questionnaire.last if Rails.env.development?

    if @questionnaire.nil?
      @questionnaire = Questionnaire.by_domain(request.host).first
      # #render will cause #set_locale to not be run.
      I18n.locale = locale_from_record(@questionnaire) || I18n.default_locale
      render 'offline'
    end
  end

  def build_questionnaire
    @simulator = @questionnaire.sections.simulator
    @fields = @questionnaire.sections.nonbudgetary
    @groups = @simulator.group_by(&:group)

    @maximum_difference = [
      @questionnaire.maximum_amount.abs,
      @questionnaire.minimum_amount.abs,
    ].max
  end

  def cache_key(record)
    parts = [record.cache_key]
    parts << params[:token] if params[:token] # use a different cache for token access
    parts << 'flash' if flash[:notice] # cache flash separately
    parts.join '-'
  end
end
