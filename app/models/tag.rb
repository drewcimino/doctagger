class Tag < ActiveRecord::Base
  belongs_to :document, required: true
  validates :label, :context, presence: true
end
