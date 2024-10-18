# frozen_string_literal: true

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:the_post) { create(:post, user:) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'redirects to the post show page' do
      get "/posts/#{the_post.id}/comments"
      expect(response).to redirect_to(post_path(the_post))
    end
  end

  describe 'GET /new' do
    it 'renders the new template' do
      get "/posts/#{the_post.id}/comments/new"
      expect(response).to have_http_status(:ok)
      expect(assigns(:comment)).to be_a_new(Comment)
      expect(response).to render_template(:new)
    end

    context 'when parent_id is provided' do
      let(:parent_comment) { create(:comment, post: the_post, user:) }

      it 'assigns a parent comment if parent_id is provided' do
        get "/posts/#{the_post.id}/comments/new?parent_id=#{parent_comment.id}"
        expect(assigns(:comment).parent_id).to eq(parent_comment.id)
      end
    end
  end

  describe 'POST /create' do
    let(:make_request) { post "/posts/#{the_post.id}/comments", params: { comment: comment_attributes } }

    context 'with valid attributes' do
      let(:comment_attributes) { { body: 'This is a valid comment' } }

      it 'creates a new comment' do
        expect { make_request }.to change(Comment, :count).by(1)
        expect(Comment.last).to have_attributes(
          body: 'This is a valid comment',
          post_id: the_post.id,
          user_id: user.id
        )
      end

      it 'redirects to the post show page with a success notice' do
        make_request
        expect(response).to redirect_to(post_path(the_post))
        expect(flash[:notice]).to eq(I18n.t('comments.comment_added'))
      end
    end

    context 'with invalid attributes' do
      let(:comment_attributes) { { body: '' } }

      it 'does not create a new comment' do
        expect { make_request }.not_to change(Comment, :count)
      end

      it 're-renders the new template with status unprocessable entity' do
        make_request
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  it_behaves_like 'not authenticated user'
end
