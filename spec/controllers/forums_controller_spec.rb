require 'spec_helper'

describe ForumsController do

  describe "index" do
    it "should list all forums" do
      FactoryGirl.create(:forum)
      FactoryGirl.create(:forum)

      get :index

      expect(assigns(:forums).size).to eq(2)
      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "show" do
    it "should have a forum" do
      forum = FactoryGirl.create(:forum)
      topic = FactoryGirl.create(:topic, forum: forum)
      comment = FactoryGirl.create(:topic_comment, commentable: topic)

      get :show, id: forum.slug

      expect(assigns(:forum)).to eq(forum)
      expect(assigns(:page_title)).to include(forum.name)
      expect(assigns(:topics).size).to eq(forum.topics.size)
      expect(assigns(:topic)).to be_new_record
      expect(assigns(:topic).comments.size).to eq(1)
      expect(response).to be_success
    end
    it "should render a 404 for a forum that doesn't exist" do
      get :show, id: "foo-bar"

      expect(response.status).to eq(404)
    end
  end

end
