class CreateEventParticipations < ActiveRecord::Migration
  def change
    add_column :inputs, :event_type, :string
  end
end
