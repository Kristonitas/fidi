require 'rqrcode'
require 'rqrcode_png'

class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :except => :create
  protect_from_forgery :except => :create

  before_action :set_user, only: [:show]

  api!
  def show
    @best_attempts = @user.best_attempts
  end

  def new
    #Fill this place for fallback registration
  end

  api!
  def login
    params = user_params
    @user = User.find_by(name: params[:name]).authenticate(params[:password])

    respond_to do |format|
      if @user
        format.json { render :show, location: @user }
      else
        flash[:warrning] = "Error creating new user #{@user.errors.inspect}"

        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  api!
  def create
    #Add support for mobile phone app-keys
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render :show, location: @user }
      else
        flash[:warrning] = "Error creating new user #{@user.errors.inspect}"

        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  api!
  def leaderboard
    @leaderboard = User.leaderboard
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name, :password, :password_confirmation, :first_name, :last_name)
    end
end
