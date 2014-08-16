class TopicsController < ApplicationController

  active_tab :forums

  before_filter :find_forum
  before_filter :find_topic, only: [:show]
  before_filter :login_required, only: [:create]
  before_filter :setup_title, except: [:create]

  def show
    unless topics_viewed.include?(@topic.id)
      @topic.increment_view_counter
      topics_viewed << @topic.id
    end
    @comments = @topic.comments.asc(:created_at)
  end

  def create
    @topic = @forum.topics.build(topic_params)
    @topic.player = current_player
    @topic.comments.first.player = current_player

    if @topic.save
      topics_viewed << @topic.id
      redirect_to forum_topic_path(@forum, @topic), notice: "Thanks for posting!"
    else
      @topics = @forum.topics.all
      flash.now.alert = "There was an creating your topic."
      render template: "forums/show"
    end
  end

private

  def find_forum
    @forum = Forum.find(params[:forum_id])
  end

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def topics_viewed
    session[:topics_viewed] ||= []
  end

  def setup_title
    @page_title = "#{@topic.subject} | #{@forum.name}"
  end

  def topic_params
    params.require(:topic).permit(:subject, comments_attributes: [:body])
  end

end
