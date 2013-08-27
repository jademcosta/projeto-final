class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.text :text
      t.string :type
      t.date :date
      t.string :institution
      t.string :degree_type
      t.string :status
      t.references :user

      t.timestamps
    end

  end
end
