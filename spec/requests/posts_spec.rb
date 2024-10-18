# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:user_post) { create(:post, user:) }

  before do
    sign_in user
  end

  describe 'GET /posts' do
    it 'returns a success response' do
      get posts_path
      expect(response).to have_http_status(:ok)
      expect(assigns(:posts)).to eq([user_post.decorate])
    end

    context 'when filtering by another user' do
      let!(:other_post) { create(:post, user: other_user) }

      it 'returns posts of the specified user' do
        get posts_path(user_id: other_user.id)
        expect(response).to have_http_status(:ok)
        expect(assigns(:posts)).to eq([other_post.decorate])
      end
    end
  end

  describe 'GET /posts/:id' do
    it 'returns the post and its comments' do
      get post_path(user_post)
      expect(response).to have_http_status(:ok)
      expect(assigns(:post)).to eq(user_post.decorate)
      expect(assigns(:comments)).to be_a(Hash)
    end

    context 'when post is not found' do
      it 'returns a 404 error' do
        get post_path(id: 'nonexistent')
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /posts/new' do
    it 'renders the new post form' do
      get new_post_path
      expect(response).to have_http_status(:ok)
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'POST /posts' do
    let(:make_request) { post posts_path, params: { post: post_attributes } }

    context 'with valid parameters' do
      let(:post_attributes) { { title: 'My Title', body: 'My Post Body' } }

      it 'creates a new post and redirects to the posts index' do
        expect { make_request }.to change(Post, :count).by(1)
        expect(response).to redirect_to(posts_path)
        expect(flash[:notice]).to eq(I18n.t('posts.create.success'))
        expect(Post.last).to have_attributes(
          title: 'My Title',
          body: 'My Post Body',
          user_id: user.id
        )
      end
    end

    context 'with invalid parameters' do
      let(:post_attributes) { { title: '', body: '' } }

      it 'does not create a new post and renders the new template' do
        expect { make_request }.not_to change(Post, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  it_behaves_like 'not authenticated user'
end
