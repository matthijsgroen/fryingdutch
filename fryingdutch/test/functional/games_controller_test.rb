require 'test_helper'

class GamesControllerTest < ActionController::TestCase
 
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
    assert_select "div.game h2 a", "Travian"
  end

  def test_no_access_new
    get :new
    assert_login_required
  end

  def test_should_get_new
    login_as :thaisi
    get :new
    assert_not_nil assigns(:game)
    assert_response :success
  end

  def test_no_access_create_game
    post :create, :game => { }
    assert_login_required
  end

  def test_invalid_game_values
    login_as :thaisi
    assert_difference('Game.count', 0) do
      post :create, :game => { }
    end
    assert_response :success
    assert_select "div.fieldWithErrors", :minimum => 2
  end

  def test_should_create_game
    login_as :thaisi
    assert_difference('Game.count', 1) do
      post :create, :game => { :name => "Test game", :description => "this game is cool", :tag_list => "test, game, browser" }
    end
    assert_redirected_to games_path
  end

  def test_should_show_game
    get :show, :id => games(:games_001).permalink
    assert_response :success
  end

  def test_should_show_by_tagname
    get :by_tagname, :tagname => "space"
    assert_response :success
    assert_not_nil assigns(:games)
    assert_select "div.game h2 a", "Planetarion"
  end
  
  def test_should_not_get_edit
    get :edit, :id => games(:games_001).permalink
    assert_login_required
  end

  def test_should_get_edit
    login_as :thaisi
    get :edit, :id => games(:games_001).permalink
    assert_response :success
  end

  def test_should_update_game
#    put :update, :id => games(:one).id, :game => { }
#    assert_redirected_to game_path(assigns(:game))
  end

  def test_should_destroy_game
#    assert_difference('Game.count', -1) do
#      delete :destroy, :id => games(:one).id
#    end
#
#    assert_redirected_to games_path
  end
end
