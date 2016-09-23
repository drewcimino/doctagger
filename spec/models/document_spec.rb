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
end
