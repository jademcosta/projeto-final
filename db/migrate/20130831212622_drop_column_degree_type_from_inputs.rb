class DropColumnDegreeTypeFromInputs < ActiveRecord::Migration
  def up
      remove_column :inputs, :degree_type
  end

  def down
      add_column :inputs, :degree_type, :string
  end
end
