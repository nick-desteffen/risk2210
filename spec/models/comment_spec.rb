require 'rails_helper'

describe Comment do

  let(:topic) { create(:topic, comment_count: 10, last_comment_at: 1.week.ago) }

  describe "update_topic_stats" do
    it "update the stats on the topic after the comment has been created" do
      comment = create(:topic_comment, commentable: topic)

      expect(topic.comment_count).to eq(11)
      expect(topic.last_comment_at.to_s).to eq(DateTime.now.utc.to_s)
    end
  end

  describe "decrement_comment_counter" do
    it "decrement the comment counter when a comment is destroyed" do
      comment = create(:topic_comment, commentable: topic)

      expect(topic.comment_count).to eq(11)
      comment.destroy
      expect(topic.comment_count).to eq(10)
    end
  end

  describe "topic" do
    it "should return the parent topic" do
      comment = create(:topic_comment, commentable: topic)

      expect(comment.topic).to eq(topic)
    end
    it "should return the commentable's topic if it is a comment" do
      comment = create(:topic_comment, commentable: topic)
      second_comment = create(:comment_comment, commentable: comment)

      expect(second_comment.topic).to eq(topic)
    end
    it "should return nil if the parent is nil" do
      comment = create(:comment, commentable: nil)

      expect(comment.topic).to be_nil
    end
  end

end
