class BoothsController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @highscores = Attempt.find_by_sql [
        "SELECT *
        FROM attempts AS t1
        WHERE NOT EXISTS 
        (SELECT * FROM attempts AS t2
        WHERE t1.user_id = t2.user_id AND t1.score < t2.score and t1.booth_id = ?)
        LIMIT 50;", @booth.id]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @booth = Booth.find(params[:id])
    end
end
