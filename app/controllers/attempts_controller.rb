class AttemptsController < ApplicationController

  before_action :authenticate_fidder!

  def new
    @current_fidder = current_fidder
    @attempt = Attempt.new
    @user = User.find(params[:id])
  end

  def create
    # Refactor for redirecting back to attempt or something + test for record

    #Add support for mobile phone app-keys
    @attempt = Attempt.new(attempt_params)

    respond_to do |format|
      if @attempt.save
        format.html { redirect_to root_path, notice: 'attempt was successfully created.' }
        format.json { render json: 'newRecord: ' }
      else
        flash[:warrning] = "Error creating new attempt #{@attempt.errors.inspect}"

        format.html { redirect_to root_path }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def attempt_params
      params.require(:attempt).permit(:booth_id, :user_id, :comment, :score)
    end
end
