require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = create(:user) # Use FactoryBot or your preferred method to create a user
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: { username: 'new_user', email: 'user@example.com', password: 'password' } }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the user show page' do
        post :create, params: { user: { username: 'new_user', email: 'user@example.com', password: 'password' } }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect do
          post :create, params: { user: { username: '', email: 'user@example.com', password: 'password' } }
        end.not_to change(User, :count)
      end

      it 're-renders the new user form' do
        post :create, params: { user: { username: '', email: 'user@example.com', password: 'password' } }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      user = create(:user)
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }

    context 'with valid parameters' do
      it 'updates the user' do
        new_username = 'updated_username'
        patch :update, params: { id: user.id, user: { username: new_username } }
        user.reload
        expect(user.username).to eq(new_username)
      end

      it 'redirects to the user show page' do
        patch :update, params: { id: user.id, user: { username: 'new_username' } }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the user' do
        old_username = user.username
        patch :update, params: { id: user.id, user: { username: '' } }
        user.reload
        expect(user.username).to eq(old_username)
      end

      it 're-renders the edit user form' do
        patch :update, params: { id: user.id, user: { username: '' } }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the user' do
      user = create(:user)
      expect do
        delete :destroy, params: { id: user.id }
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users index page' do
      user = create(:user)
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_path)
    end
  end
end
