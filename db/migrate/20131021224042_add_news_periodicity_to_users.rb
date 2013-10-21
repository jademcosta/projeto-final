class AddNewsPeriodicityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :news_periodicity, :string
  end
end
