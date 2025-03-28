class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :role
      t.string :phone
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
