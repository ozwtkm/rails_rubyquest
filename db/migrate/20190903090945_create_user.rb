class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
t.string :name, null: false, limit: 190
t.string :salt, null: false
t.string :passwd, null: false

    end
  end
end
