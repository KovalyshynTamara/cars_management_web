class EnableCitextForCars < ActiveRecord::Migration[8.1]
  def up
    enable_extension "citext"

    safety_assured do
      change_column :cars, :make, :citext
      change_column :cars, :model, :citext
    end
  end

  def down
    change_column :cars, :make, :string
    change_column :cars, :model, :string
  end
end
