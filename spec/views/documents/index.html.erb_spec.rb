require 'rails_helper'

describe 'documents/index' do
  before(:each) do
    assign(:new_document, Document.new)
    assign(:documents, [ FactoryGirl.create(:document), FactoryGirl.create(:document) ])
  end

  it 'renders a list of documents' do
    render
    assert_select 'tbody>tr', count: 2
  end

  it 'renders the upload form' do
    render
    assert_select 'form.new_document', count: 1
  end
end
