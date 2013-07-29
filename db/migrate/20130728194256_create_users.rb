class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :title
      t.string :homepage
      t.string :institution
      t.string :job_title

      t.timestamps
    end
  end
end
