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
  def create
    #Add support for mobile phone app-keys
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        qr = RQRCode::QRCode.new( "http://79.98.25.158/attempt_for/#{@user.id}", :size => 3, :level => :l )
        png = qr.to_img
        png.resize(256, 256).save("public/qr_codes/#{@user.id}_qr.png")

        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, location: @user }
      else
        flash[:warrning] = "Error creating new user #{@user.errors.inspect}"

        format.html { render :new }
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
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
