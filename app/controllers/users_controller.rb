class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :except => :create
  protect_from_forgery :except => :create

  before_action :set_user, only: [:show]

  def show
    #Need to show some more stuff
  end

  def new
    #Fill this place for fallback registration
  end

  def create
    #Add support for mobile phone app-keys
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, location: @user }
      else
        flash[:warrning] = "Error creating new user #{@user.errors.inspect}"

        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      { name: params[:name], password: params[:password], password_confirmation: params[:password_confirmation] }
    end
end
