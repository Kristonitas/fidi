class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # CATEGORY: dieninė: 0, eisena: 1, vakarinė: 2

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(visible: true).order( 'priority' )
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
end
