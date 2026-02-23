class CreateSearches < ActiveRecord::Migration[8.1]
  def change
    create_table :searches do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :rules
      t.integer :total_quantity
      t.integer :requests_quantity

      t.timestamps
    end
  end
end
