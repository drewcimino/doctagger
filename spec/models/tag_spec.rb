require 'rails_helper'

describe Tag do
  subject(:tag) { Tag.create(params) }
  let(:params) do
    {
      label: 'README',
      context: 'Sample README Content? Active Record has more than one layer.',
      document: FactoryGirl.create(:document)
    }
  end

  describe 'instance' do
    context 'with valid inputs' do
      it { is_expected.to respond_to :label }
      it { is_expected.to respond_to :context }
      it { is_expected.to be_valid }
    end

    context 'without a label' do
      let(:params) { { context: 'Sample README Content? Active Record has more than one layer.', document: FactoryGirl.create(:document) } }
      it { is_expected.to be_invalid }
    end

    context 'without a context' do
      let(:params) { { label: 'README', document: FactoryGirl.create(:document) } }
      it { is_expected.to be_invalid }
    end

    context 'without a Document' do
      let(:params) { { label: 'README', context: 'Sample README Content? Active Record has more than one layer.' } }
      it { is_expected.to be_invalid }
    end
  end
end
