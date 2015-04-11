class BoothsController < ApplicationController
  resource_description do
    name "Booths"
    short "Attractions in which the points are logged"
  end

  before_action :set_user, only: [:show]

  api :GET, '/booths/:id', "Gets booth and highscore for it"
  def show
    @highscores = @booth.attempts.limit(3).order('score DESC') if @booth.min_score.present? && @booth.max_score.present?
  end

  api :GET, '/map', "Get all booths with their positions"
  def map
    @booths = Booth.where(visible: true).order('pos_y ASC')
  end

  def map_for_user
    @booths = Booth.where(visible: true).order('pos_y ASC')
    @booths_visited = User.find(params[:id]).best_attempts.map(&:booth_id)
    render 'map'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @booth = Booth.find(params[:id])
    end
end
