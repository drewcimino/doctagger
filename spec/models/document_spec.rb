require 'rails_helper'

describe Document do
  let(:params) { { provided_tags: 'layer, Active Record, README', content: 'Sample README Content? Active Record has more than one layer. Some other words.' } }
  let(:document) { Document.create(params) }

  describe 'instance' do
    subject { document }

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
      let(:params) do
        {
          provided_tags: 'layer, Active Record, README',
          content: 'Sample README Content? The Active Record README has more than one layer. Some other words about README.'
        }
      end

      describe '#count' do
        subject(:match_count) { matches.count }
        it { is_expected.to eq params[:content].scan(tag_phrase).count }
      end
    end
  end
end
