module AdminAuthentication
  def self.included(controller)
    controller.before_filter :authenticate_admin
  end

  private

  def authenticate_admin
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == 'fidi47'
    end
  end
end