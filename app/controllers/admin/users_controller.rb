class Admin::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :except => :create
  protect_from_forgery :except => :create
  include AdminAuthentication

  layout 'admin'
end