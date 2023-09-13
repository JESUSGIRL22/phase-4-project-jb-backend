require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      job = create(:job) # Use FactoryBot or your preferred method to create a job
      get :show, params: { id: job.id }
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
      it 'creates a new job' do
        expect do
          post :create, params: { job: { title: 'New Job', description: 'Job Description' } }
        end.to change(Job, :count).by(1)
      end

      it 'redirects to the job show page' do
        post :create, params: { job: { title: 'New Job', description: 'Job Description' } }
        expect(response).to redirect_to(Job.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new job' do
        expect do
          post :create, params: { job: { title: '', description: 'Job Description' } }
        end.not_to change(Job, :count)
      end

      it 're-renders the new job form' do
        post :create, params: { job: { title: '', description: 'Job Description' } }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      job = create(:job)
      get :edit, params: { id: job.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:job) { create(:job) }

    context 'with valid parameters' do
      it 'updates the job' do
        new_title = 'Updated Job Title'
        patch :update, params: { id: job.id, job: { title: new_title } }
        job.reload
        expect(job.title).to eq(new_title)
      end

      it 'redirects to the job show page' do
        patch :update, params: { id: job.id, job: { title: 'Updated Job Title' } }
        expect(response).to redirect_to(job)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the job' do
        old_title = job.title
        patch :update, params: { id: job.id, job: { title: '' } }
        job.reload
        expect(job.title).to eq(old_title)
      end

      it 're-renders the edit job form' do
        patch :update, params: { id: job.id, job: { title: '' } }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the job' do
      job = create(:job)
      expect do
        delete :destroy, params: { id: job.id }
      end.to change(Job, :count).by(-1)
    end

    it 'redirects to the jobs index page' do
      job = create(:job)
      delete :destroy, params: { id: job.id }
      expect(response).to redirect_to(jobs_path)
    end
  end
end
