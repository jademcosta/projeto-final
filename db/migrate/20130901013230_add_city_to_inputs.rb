class AddCityToInputs < ActiveRecord::Migration
  def change
      add_column :inputs, :city, :string
      add_column :inputs, :country, :string
  end
end
