require 'rails_helper'

describe 'documents/index' do
  before(:each) do
    assign(:new_document, Document.new)
    assign(:documents, [ FactoryGirl.create(:document), FactoryGirl.create(:document) ])
    render
  end

  it 'renders a list of documents' do
    assert_select 'tbody>tr', count: 2
  end

  it 'renders the upload form' do
    assert_select 'form.new_document', count: 1
  end

  it 'shows the file name' do
    assert_select 'td.actions>p.file-name', count: 2
  end

  it 'provides destroy links' do
    assert_select 'td.actions>p>span.destroy-link', count: 2
  end

  it 'provides download links' do
    assert_select 'td.actions>p>span.download-link', count: 2
  end
end
