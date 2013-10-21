class AddAbstractToInputs < ActiveRecord::Migration
  def change
    add_column :inputs, :abstract, :text
  end
end
