class AttemptsController < ApplicationController

  before_action :authenticate_fidder!, :except => :log_code
  skip_before_filter :verify_authenticity_token, :except => [:create, :new]

  def new
    @current_fidder = current_fidder
    @attempt = Attempt.new
    @user = User.find(params[:id])
  end

  def log_code
    input = params.permit(:code, :user_id)
    code_booth = Booth.for_code input[:code]
    if code_booth.nil?
      render json: {message: 'no booth with this code'}
    else
      if Attempt.where(user_id: input[:user_id], booth_id: code_booth.id).take.nil?
        Attempt.create(user_id: input[:user_id], booth_id: code_booth.id, score: code_booth.available_scores.first)
        render json: {new_code: true}
      else
        render json: {new_code: false}
      end
    end
  end

  def create
    last_attempt = Attempt.where(user_id: attempt_params[:user_id], booth_id: attempt_params[:booth_id]).take

    if last_attempt.nil?
      @attempt = Attempt.new(attempt_params)
    else
      @attempt = last_attempt
      if last_attempt.score < attempt_params[:score]
        @attempt.score = attempt_params[:score]
      end
    end
    # Refactor for redirecting back to attempt or something + test for record

    #Add support for mobile phone app-keys
    @attempt = Attempt.new(attempt_params)

    respond_to do |format|
      if @attempt.save
        format.html { redirect_to root_path, notice: 'attempt was successfully created.' }
        format.json { render json: 'newRecord: ' }
      else
        flash[:warrning] = "Error creating or logging attempt #{@attempt.errors.inspect}"

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
