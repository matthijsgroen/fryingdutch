require 'test_helper'

class Boards::Topics::DiscussionTopicsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:boards/topics_discussion_topics)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_discussion_topic
    assert_difference('Boards::Topics::DiscussionTopic.count') do
      post :create, :discussion_topic => { }
    end

    assert_redirected_to discussion_topic_path(assigns(:discussion_topic))
  end

  def test_should_show_discussion_topic
    get :show, :id => boards/topics_discussion_topics(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => boards/topics_discussion_topics(:one).id
    assert_response :success
  end

  def test_should_update_discussion_topic
    put :update, :id => boards/topics_discussion_topics(:one).id, :discussion_topic => { }
    assert_redirected_to discussion_topic_path(assigns(:discussion_topic))
  end

  def test_should_destroy_discussion_topic
    assert_difference('Boards::Topics::DiscussionTopic.count', -1) do
      delete :destroy, :id => boards/topics_discussion_topics(:one).id
    end

    assert_redirected_to boards/topics_discussion_topics_path
  end
end
