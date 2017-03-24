require 'rails_helper'

describe Auth::SessionsController do
  context 'already authorized' do
    let!(:user) { create(:user) }
    before { request.session[:user_id] = user.id }

    it 'rises flash on new' do
      get :new
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.already_signed_in')])
    end

    it 'rises flash on create' do
      post :create
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.already_signed_in')])
    end
  end

  context 'new' do
    it 'renders form' do
      get :new
      expect(response.status).to eql(200)
    end
  end

  context 'create' do
    let!(:user) { create(:user) }

    it 'can not sign in, wrong email ' do
      post :create, { session: { email: 'wrong@email.ru' } }
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.wrong_password_email')])
    end

    it 'can not sign in, wrong password' do
      post :create, { session: { email: user.email, password: 'wrong_password' } }
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.wrong_password_email')])
    end

    it 'can sign in' do
      post :create, { session: { email: user.email, password: user.password } }
      expect(session[:user_id]).to be_eql(user.id)
    end
  end

  context 'destroy' do
    it 'redirects because already signed out' do
      get :destroy
      expect(response.status).to eql(302)
    end

    it 'destroys session on sign out' do
      user = create(:user)
      request.session[:user_id] = user.id
      get :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end
