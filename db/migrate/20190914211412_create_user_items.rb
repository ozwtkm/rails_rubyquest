class CreateUserItems < ActiveRecord::Migration[6.0]
  def change
    create_table :user_items do |t|
      t.references :user, foreign_key: true
      # ↓ 将来的にDBが別れることを想定し外部キー制約つけない
      t.integer :item_id, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
