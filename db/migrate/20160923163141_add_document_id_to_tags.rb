class AddDocumentIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :document_id, :integer
  end
end
