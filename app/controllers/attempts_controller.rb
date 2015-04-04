class AttemptsController < ApplicationController

  before_action :authenticate_fidder!

  def new
    @current_fidder = current_fidder
  end

  def create
    # Refactor for redirecting back to user or something + test for record

    #Add support for mobile phone app-keys
    @attempt = Attempt.new(user_params)

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
end
