class CreateMonsters < ActiveRecord::Migration[6.0]
  def change
    create_table :monsters do |t|
      t.string :name, null: false, limit: 190
      t.integer :hp, null: false
      t.integer :atk, null: false
      t.integer :def, null: false
      t.integer :exp, null: false
      t.integer :money, null: falses
      t.integer :img_id
      t.integer :rarity, null: false
      t.integer :speed, null: false
      t.integer :mp, null: false

      t.timestamps
    end
  end
end


