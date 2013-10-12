class CreateKudos < ActiveRecord::Migration
  def change
    create_table :kudos do |t|
      t.references :input
      t.references :user

      t.timestamps
    end
    add_index :kudos, :input_id
    add_index :kudos, :user_id
  end
end
