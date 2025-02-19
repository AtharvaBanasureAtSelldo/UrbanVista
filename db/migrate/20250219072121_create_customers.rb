class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phoneno
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
