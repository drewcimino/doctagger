class Document < ActiveRecord::Base
  validates :provided_tags, :content, presence: true
end
