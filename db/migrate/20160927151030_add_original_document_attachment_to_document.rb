class AddOriginalDocumentAttachmentToDocument < ActiveRecord::Migration
  def change
    add_attachment :documents, :original_document
  end
end
