class PagesController < ApplicationController
  def home
    @query = Post.ransack(params[:q])
    @posts = @query.result(distinct: true)
  end

  def about
  end
end
