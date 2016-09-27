require 'rails_helper'

describe Document do
  let(:params) { { provided_tags: 'layer, Active Record, README', original_document: original_file } }
  let(:original_file) { Rack::Test::UploadedFile.new('spec/fixtures/test_word_document.docx') }
  let(:document) { FactoryGirl.create(:document) }

  describe '.create' do
    subject { Document.create(params) }

    context 'with valid inputs' do
      it { is_expected.to respond_to :provided_tags }
      it { is_expected.to respond_to :content }
      it { is_expected.to be_valid }
    end

    context 'without a tag list' do
      let(:params) { { content: 'The README of Active Record has more than one layer.' } }
      it { is_expected.to be_invalid }
    end

    context 'without content' do
      let(:params) { { provided_tags: 'layer, Active Record, README' } }
      it { is_expected.to be_invalid }
    end

    context 'with an old .doc file' do
      let(:original_file) { Rack::Test::UploadedFile.new('spec/fixtures/test_old_word_document.doc') }
      it { is_expected.to be_valid }
    end
  end

  describe '#tag_matches' do
    let(:tag_phrase) { 'README' }
    subject(:matches) { document.tag_matches(tag_phrase) }

    context 'when the provided tag is not present' do
      let(:tag_phrase) { 'potato' }
      it { is_expected.to eq [] }
    end

    context 'when the provided tag is present' do
      it { is_expected.to eq [{ label: tag_phrase, context: 'Sample README Content? Active Record has more than one layer.' }] }
    end

    context 'when the provided tag occurs multiple times' do
      let(:document) { FactoryGirl.create(:document, content: 'Sample README Content? The Active Record README has more than one layer. Some other words about README.') }

      describe '#count' do
        subject { matches.count }
        it { is_expected.to eq document.content.scan(tag_phrase).count }
      end
    end
  end

  describe '#populate_tags' do
    before(:each) { document.tags.destroy_all }

    it 'creates new tag objects' do
      expect { document.populate_tags }.to change(Tag, :count).by(3)
    end

    it 'creates tags that belong to the document' do
      expect(document.populate_tags.map(&:document).uniq).to contain_exactly(document)
    end
  end

  describe '#tag_list' do
    it 'returns an array of provided tags' do
      expect(document.tag_list).to be_an(Array)
      expect(document.tag_list.count).to eq(3)
    end
  end

  describe '#tag_frequency' do
    subject { document.tag_frequency }
    it { is_expected.to contain_exactly({ label: 'Active Record', count: 1 }, { label:'README', count: 1 }, { label: 'layer', count: 1 }) }
  end

  describe '#parse_original_document_content' do
    before(:each) { document.update_column :content, '' }

    it 'writes the file contents to Document#content' do
      document.parse_original_document_content
      expect(document.content).to eq('Sample README Content? Active Record has more than one layer. Some other words.')
    end

    context 'with an old .doc file' do
      let(:original_file) { Rack::Test::UploadedFile.new('spec/fixtures/test_old_word_document.doc') }

      it 'writes the file contents to Document#content' do
        document.parse_original_document_content
        expect(document.content).to eq('Sample README Content? Active Record has more than one layer. Some other words.')
      end
    end
  end
end
