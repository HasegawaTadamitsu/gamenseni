class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :zip
      t.string :ken_kanzi
      t.string :sikugun_kanji
      t.string :machi_kanji

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
