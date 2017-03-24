require 'rails_helper'

describe WelcomeController do
  context 'index' do
    let!(:tasks) { create_list(:task, 10) }

    it 'renders index template' do
      get :index
      expect(subject).to render_template(:index)
    end

    it 'order tasks' do
      task = create(:task)
      get :index
      expect(assigns(:tasks).first).to eq(task)
    end

    it 'paginates tasks' do
      allow(Task).to receive(:per_page).and_return(5)
      get :index
      expect(assigns(:tasks).length).to eq(5)
    end
  end
end
