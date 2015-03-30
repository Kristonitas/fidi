class Admin::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :except => :create
  protect_from_forgery :except => :create
  include AdminAuthentication

  layout 'admin'

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path
    else
      flash[:warrning] = "Error updating user #{@user.errors.inspect}"
      redirect_to admin_users_path
    end
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      qr = RQRCode::QRCode.new( "http://79.98.25.158/attempt_for/#{@user.id}", :size => 3, :level => :l )
      png = qr.to_img
      png.resize(256, 256).save("public/qr_codes/#{@user.id}_qr.png")

      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      flash[:warrning] = "Error creating new user #{@user.errors.inspect}"

      redirect_to admin_users_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :is_fidi, :booth_id, :password, :password_confirmation)
    end
end