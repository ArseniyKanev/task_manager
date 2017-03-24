require 'rails_helper'

describe User::TasksController do
  context 'not signed in' do
    let!(:task) { create(:task) }

    it 'redirects on start' do
      put :start, { id: task.id }
      expect(response).to redirect_to(new_session_path)
    end

    it 'redirects on finish' do
      put :finish, { id: task.id }
      expect(response).to redirect_to(new_session_path)
    end
  end

  context 'signed in, no permissions' do
    let!(:user) { create(:user) }
    let!(:tasks) { create_list(:task, 5) }
    before { request.session[:user_id] = user.id }

    it 'index' do
      get :index
      expect(assigns(:tasks)).to be_blank
    end

    it 'show' do
      get :show, { id: tasks.first.id }
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.no_permissions')])
    end

    it 'edit' do
      get :edit, { id: tasks.first.id }
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.no_permissions')])
    end

    it 'update' do
      put :update, { id: tasks.first.id, task: { name: 'test_task' } }
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.no_permissions')])
    end

    it 'destroy' do
      delete :destroy, { id: tasks.first.id }
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.no_permissions')])
    end

    it 'start' do
      put :start, { id: tasks.first.id }
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.no_permissions')])
    end

    it 'finish' do
      put :finish, { id: tasks.first.id }
      expect(flash[:danger]).to be_eql([I18n.t('auth.errors.no_permissions')])
    end

    it 'create' do
      post :create, { task: { name: 'test_task', user_id: tasks.first.user_id } }
      expect(Task.where(user_id: user.id).count).to be_eql(1)
    end
  end

  context 'index' do
    let!(:user) { create(:admin) }
    let!(:tasks) { create_list(:task, 5) }
    before { request.session[:user_id] = user.id }

    it 'assigns tasks' do
      get :index
      expect(assigns(:tasks).length).to be_eql(5)
    end

    it 'renders index template' do
      get :index
      expect(subject).to render_template(:index)
    end

    it 'paginats tasks' do
      allow(Task).to receive(:per_page).and_return(1)
      get :index
      expect(assigns(:tasks).length).to eq(1)
    end
  end

  context 'show and edit' do
    let!(:user) { create(:admin) }
    let!(:task) { create(:task) }
    before { request.session[:user_id] = user.id }

    it 'renders show template' do
      get :show, { id: task.id }
      expect(subject).to render_template(:show)
    end

    it 'renders edit template' do
      get :edit, { id: task.id }
      expect(subject).to render_template(:edit)
    end
  end

  context 'new' do
    let!(:user) { create(:admin) }
    before { request.session[:user_id] = user.id }

    it 'renders new template' do
      get :new
      expect(subject).to render_template(:new)
    end
  end

  context 'update' do
    let!(:user) { create(:admin) }
    let!(:task) { create(:task) }
    before { request.session[:user_id] = user.id }

    it 'renders edit template because of validation errors' do
      put :update, { id: task.id, task: { name: nil } }
      expect(subject).to render_template(:edit)
    end

    it 'changes task name' do
      put :update, { id: task.id, task: { name: 'test' } }
      expect(task.reload.name).to be_eql('test')
    end
  end

  context 'create' do
    let!(:user) { create(:admin) }
    before { request.session[:user_id] = user.id }

    it 'renders new template because of validation errors' do
      post :create, { task: { name: '' } }
      expect(subject).to render_template(:new)
    end

    it 'creates task' do
      post :create, { task: { name: 'test', user_id: user.id } }
      expect(Task.count).to eq(1)
    end

    it 'creates task with attachment' do
      task_attrs = {
        task: {
          name: 'test',
          user_id: user.id,
          attachments_attributes: {
            '0': {
              file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'files', '1.jpg'))
            }
          }
        }
      }
      post :create, task_attrs
      expect(Attachment.count).to eq(1)
    end
  end

  context 'destroy' do
    let!(:user) { create(:admin) }
    let!(:task) { create(:task) }
    before { request.session[:user_id] = user.id }

    it 'destroys task' do
      delete :destroy, { id: task.id }
      expect(Task.count).to eq(0)
    end
  end

  context 'start' do
    let!(:user) { create(:admin) }
    let!(:task) { create(:task) }
    before { request.session[:user_id] = user.id }

    it 'starts task' do
      put :start, { id: task.id }
      expect(task.reload.started?).to be_truthy
    end
  end

  context 'finish' do
    let!(:user) { create(:admin) }
    let!(:task) { create(:task) }
    before { request.session[:user_id] = user.id }

    it 'finishes' do
      put :start, { id: task.id }
      put :finish, { id: task.id }
      expect(task.reload.finished?).to be_truthy
    end
  end
end
