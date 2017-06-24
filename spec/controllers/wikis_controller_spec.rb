require 'rails_helper'
include RandomData

RSpec.describe WikisController, type: :controller do

  let(:my_wiki) { Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, private: false) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_wiki] to @wikis" do
       get :index
       expect(assigns(:wikis)).to eq([my_wiki])
     end
  end

  describe "GET new" do
  it "returns http success" do
    get :new
    expect(response).to have_http_status(:success)
  end

  it "renders the #new view" do
    get :new
    expect(response).to render_template :new
  end

  it "instantiates @wiki" do
    get :new
    expect(assigns(:wiki)).not_to be_nil
  end
end

describe "POST create" do
      it "returns http redirect" do
        post :create, params: { topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph} }
        expect(response).to redirect_to(new_session_path)
      end
    end





  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
       get :show, {id: my_wiki.id}
       expect(response).to render_template :show
     end

     it "assigns my_wiki to @wiki" do
       get :show, {id: my_wiki.id}
       expect(assigns(:wiki)).to eq(my_wiki)
     end
  end

=begin
  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
=end

end
