class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.room_id :string
      t.integer :no_of_beds, :default => 0
      t.belongs_to :department, :index => true
      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
