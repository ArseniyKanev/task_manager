require 'rails_helper'

describe Auth::UsersController do
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
    it 'expects 200' do
      get :new
      expect(response.status).to eql(200)
    end
  end

  context 'create' do
    let!(:user) { build(:user) }

    it 'creates user anf signing in' do
      post :create, { user: { email: user.email, password: user.password, password_confirmation: user.password } }
      expect(User.count).to be_eql(1)
    end

  end
end
