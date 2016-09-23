class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :label
      t.text :context

      t.timestamps null: false
    end
  end
end
