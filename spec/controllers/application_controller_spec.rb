require 'rails_helper'

describe ApplicationController do
  context 'application controller' do
    let!(:user) { create(:user) }
    before { request.session[:user_id] = user.id }

    it 'checks current_user' do
      expect(controller.current_user).to be_eql(user)
    end

    it 'checks user_signed_in?' do
      expect(controller.user_signed_in?).to be_truthy
    end
  end
end
