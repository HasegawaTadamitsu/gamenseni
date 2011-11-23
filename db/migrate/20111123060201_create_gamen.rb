class CreateGamen < ActiveRecord::Migration
  def self.up
    create_table :gamen do |t|
      t.string :title
      t.string :body

      t.timestamps
    end
  end

  def self.down
    drop_table :gamen
  end
end
