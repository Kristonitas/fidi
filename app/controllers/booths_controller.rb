class BoothsController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @highscores = @booth.attempts.where(is_record: true).sort_by{|attempt| attempt.score}
  end

  def map
    @booths = Booth.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @booth = Booth.find(params[:id])
    end
end
