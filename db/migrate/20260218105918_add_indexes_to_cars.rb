class AddIndexesToCars < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    add_index :cars, :make, algorithm: :concurrently
    add_index :cars, :model, algorithm: :concurrently
    add_index :cars, :price, algorithm: :concurrently
    add_index :cars, :date_added, algorithm: :concurrently
  end
end
