class CreateUserMonster < ActiveRecord::Migration[6.0]
  def change
    create_table :user_monsters do |t|
      t.references :user, foreign_key: true
      # ↓ 将来的にDBが別れることを想定し外部キー制約つけない
      t.integer :monster_id, null: false 
    end
  end
end
