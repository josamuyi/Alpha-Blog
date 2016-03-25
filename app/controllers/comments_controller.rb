class CommentsController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @article = Article.find(params[:comment][:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    @comment.save 
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @article = @comment.article
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end