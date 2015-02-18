class BoothsController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @highscores = @booth.attempts.limit(10).sort_by{|booth| booth.score}.reverse
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @booth = Booth.find(params[:id])
    end
end
