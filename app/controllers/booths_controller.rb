class BoothsController < ApplicationController
  resource_description do
    name "Booths"
    short "Attractions in which the points are logged"
  end

  before_action :set_user, only: [:show]

  api :GET, '/booths/:id', "Gets booth and highscore for it"
  def show
    @highscores = @booth.attempts.where(is_record: true).sort_by{|attempt| attempt.score}.limit(50)
  end

  api :GET, '/map', "Get all booths with their positions"
  def map
    @booths = Booth.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @booth = Booth.find(params[:id])
    end
end
