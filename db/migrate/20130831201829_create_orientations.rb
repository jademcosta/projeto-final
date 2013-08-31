class CreateOrientations < ActiveRecord::Migration
  def change
    add_column :inputs, :end_date, :date
    add_column :inputs, :subtype, :string
    add_column :inputs, :title, :string
    add_column :inputs, :student, :string
  end
end
