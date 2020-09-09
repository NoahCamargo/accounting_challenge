class ApplicationController < ActionController::API
  before_action :allow_ajax_request_from_other_domains

  def options
    head(:no_content)
  end

  def authenticate_user!
    if get_token.blank?
      return render_json({ error: 'Missing token' }, 401)
    end

    render_json({}, 401) unless current_user
  end

  def current_user
    return @current_user if @current_user
    return unless JwtStorage.exist?(verify_signature)

    @current_user = Account.cached_find(JwtStorage.decode(get_token).first['account_id'])
  rescue StandardError
    nil
  end

  def get_token
    @get_token ||= request.headers['Authorization']&.match(/JWT (.+)/).try(:[], 1)
  end

  def verify_signature(token = get_token)
    token.to_s.split('.').last
  end

  def render_json(data, status = :ok)
    if Rails.env.production? && !params.key?(:debug)
      render json: data, status: status
    else
      render plain: JSON.pretty_generate(data), status: status
    end
  end

  protected

  def allow_ajax_request_from_other_domains
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
