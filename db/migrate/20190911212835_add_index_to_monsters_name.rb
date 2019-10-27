class AddIndexToMonstersName < ActiveRecord::Migration[6.0]
  def change
    add_index :monsters, :name, unique:true
  end
end
