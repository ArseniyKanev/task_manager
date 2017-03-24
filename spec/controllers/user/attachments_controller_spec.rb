require 'rails_helper'

describe User::AttachmentsController do
  describe 'not signed in' do
    let!(:attachment) { create(:attachment) }

    it 'redirects on show' do
      get :show, { id: attachment.id }
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe 'signed in, no permissions' do
    let!(:user) { create(:user) }
    let!(:attachment) { create(:attachment) }
    before { request.session[:user_id] = user.id }

    it 'rises flash on show' do
      get :show, { id: attachment.id }
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.no_permissions')])
    end
  end

  describe 'file' do
    let!(:user) { create(:admin) }
    let!(:attachment) { create(:attachment) }
    before { request.session[:user_id] = user.id }

    it 'show' do
      get :show, { id: attachment.id }
      expect(controller.headers['Content-Transfer-Encoding']).to be_eql('binary')
    end
  end

  describe 'image' do
    let!(:user) { create(:admin) }
    let!(:attachment) { create(:image) }
    before { request.session[:user_id] = user.id }

    it 'show' do
      get :show, { id: attachment.id }
      expect(controller.headers['Content-Transfer-Encoding']).to be_eql('binary')
    end
  end
end
