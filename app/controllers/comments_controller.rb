class CommentsController < ApplicationController

  active_tab :forums

  before_action :find_forum
  before_action :find_topic
  before_action :login_required

  def create
    if params[:comment_parent_id].present?
      parent = Comment.find(params[:comment_parent_id])
    else
      parent = @topic
    end

    @comment = parent.comments.build(comment_params)
    @comment.player = current_player
    if @comment.save
      redirect_to forum_topic_path(@forum, @topic), notice: "Thanks for posting!"
    else
      @comments = @topic.comments.all
      flash.now.alert = "You can't post blank comments!"
      render template: "topics/show"
    end
  end

  def edit
    @comment = current_player.comments.find(params[:id])
    raise Mongoid::Errors::DocumentNotFound.new(Comment, params[:id], params[:id]) if @comment.nil?
  end

  def update
    @comment = current_player.comments.find(params[:id])
    raise Mongoid::Errors::DocumentNotFound.new(Comment, params[:id], params[:id]) if @comment.nil?
    if @comment.update_attributes(comment_params)
      redirect_to forum_topic_path(@forum, @topic), notice: "Successfully updated your comment."
    else
      flash.now.alert = "You can't post blank comments!"
      render action: :edit
    end
  end

private

  def find_forum
    @forum = Forum.find(params[:forum_id])
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :topic_id)
  end

end
