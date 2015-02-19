class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :except => :create
  protect_from_forgery :except => :create

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    best_attempts
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

    def best_attempts
      # @best_attempts ||= Attempt.find_by_sql [
      #   "SELECT t1.*
      #   FROM attempts AS t1
      #   LEFT OUTER JOIN attempts AS t2
      #    ON (t1.booth_id = t2.booth_id AND t1.score < t2.score AND t1.user_id = ?)
      #   WHERE t2.booth_id IS NULL;", @user.id]
      @best_attempts = Attempt.find_by_sql [
        "SELECT *
        FROM attempts AS t1
        WHERE NOT EXISTS 
        (SELECT * FROM attempts AS t2
        WHERE t1.booth_id = t2.booth_id AND t1.score < t2.score and t1.user_id = ?);", @user.id]
    end
end
