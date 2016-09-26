require 'rails_helper'

describe DocumentsController do
  # We're using :back redirects for the only view in the app
  before(:each) { request.env['HTTP_REFERER'] = '/' }

  let(:invalid_attributes) {
    { provided_tags: 10 }
  }
  let(:valid_attributes) {
    { provided_tags: 'layer, README, Active Record', content: 'This is a README about Active Record. Ogres have layers.' }
  }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all documents as @documents' do
      document = Document.create! valid_attributes
      get :index, {}, session: valid_session
      expect(assigns(:documents)).to eq([document])
    end

    it 'assigns a newly created but unsaved document as @new_document' do
      get :index, {}, session: valid_session
      expect(assigns(:new_document)).to be_a_new(Document)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Document' do
        expect {
          post :create, { document: valid_attributes }, session: valid_session
        }.to change(Document, :count).by(1)
      end

      it 'confirms the new document with a success notice' do
        post :create, { document: valid_attributes }, session: valid_session
        expect(flash[:notice]).to be_present
        expect(flash[:alert]).to be_nil
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved document as @new_document' do
        post :create, { document: invalid_attributes }, session: valid_session
        expect(assigns(:document)).to be_a_new(Document)
      end

      it 'redirects to the home page' do
        post :create, { document: invalid_attributes }, session: valid_session
        expect(response).to redirect_to(root_path)
      end

      it 'returns an error message to the user' do
        post :create, { document: invalid_attributes }, session: valid_session
        expect(flash[:alert]).to be_present
        expect(flash[:notice]).to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested document' do
      document = Document.create! valid_attributes
      expect {
        delete :destroy, { id: document.to_param }, session: valid_session
      }.to change(Document, :count).by(-1)
    end

    it 'redirects to the documents list' do
      document = Document.create! valid_attributes
      delete :destroy, { id: document.to_param }, session: valid_session
      expect(response).to redirect_to(root_path)
    end
  end
end
