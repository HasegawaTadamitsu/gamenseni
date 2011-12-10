class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :ken_code,:null => false
      t.string :sikugun_code
      t.string :machi_code
      t.string :zip1
      t.string :zip2
      t.string :ken_kanji
      t.string :sikugun_kanji
      t.string :machi_kanji
    end
    add_index :addresses,[:zip1,:zip2]
  end

  def self.down
    drop_table :addresses
  end
end
