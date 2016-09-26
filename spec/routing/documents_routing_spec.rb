require 'rails_helper'

RSpec.describe DocumentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/documents').to route_to('documents#index')
    end

    it 'routes to #create' do
      expect(post: '/documents').to route_to('documents#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/documents/1').to route_to('documents#destroy', id: '1')
    end
  end
end
