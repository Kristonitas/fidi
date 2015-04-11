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
      last_attempt = Attempt.where(user_id: input[:user_id], booth_id: code_booth.id).take
      if last_attempt.nil?
        Attempt.create(user_id: input[:user_id], booth_id: code_booth.id, score: code_booth.available_scores.first)
        render json: {new_code: true}
      else
        last_attempt.update(entries: last_attempt + 1)
        render json: {new_code: false}
      end
    end
  end

  def create
    last_attempt = Attempt.where(user_id: attempt_params[:user_id], booth_id: attempt_params[:booth_id]).take
    the_booth = Booth.find(attempt_params[:booth_id])

    if last_attempt.nil?
      @attempt = Attempt.new(attempt_params)
    else
      @attempt = last_attempt
      if the_booth.max_attempts > 0
        @attempt.score += attempt_params[:score] if @attempt.entries < the_booth.max_attempts
      else
        @attempt.score = attempt_params[:score] if @attempt.score < attempt_params[:score]
      end

      @attempt.entries += 1
    end

    @attempt = Attempt.new(attempt_params)

    respond_to do |format|
      if @attempt.save
        format.html { redirect_to info_path, notice: 'attempt was successfully created.' }
        format.json { render json: 'newRecord: ' }
      else
        flash[:warrning] = "Error creating or logging attempt #{@attempt.errors.inspect}"

        format.html { redirect_to info_path }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def attempt_params
      params.require(:attempt).permit(:booth_id, :user_id, :comment, :score)
    end
end
