class CreatePropertyTags < ActiveRecord::Migration[8.0]
  def change
    create_table :property_tags do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
    add_index :property_tags, [ :property_id, :tag_id ], unique: true
  end
end
