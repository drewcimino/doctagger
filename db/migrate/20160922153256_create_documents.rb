class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :provided_tags
      t.text :content

      t.timestamps null: false
    end
  end
end
