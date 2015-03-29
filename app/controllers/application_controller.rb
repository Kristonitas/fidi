class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  api :GET, '/info', 'General information for FIDI'
  def info
    # Might need to fetch some global data
  end
end
