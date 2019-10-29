class Item < ApplicationRecord
    INITIAL_ITEM_ID = 1
    INITIAL_ITEM_QUAMTITY = 1

    def self.get_possessions(user_id, offset:, limit: 10)
        master_item_list = Item.all()# todo redis

        user_item = UserItem.where(user_id: user_id).offset(offset).limit(limit)

        possession_item_list = {}
        user_item.each do |row|
            possession_item_list[row.item_id] = {}
            possession_item_list[row.item_id]["object"] = master_item_list.find(row.item_id)
            possession_item_list[row.item_id]["quantity"] = row.quantity
        end

        return possession_item_list
    end

    # これはuser_itemモデルが持つべき説ある
    def self.init(user_id)
        UserItem.create(user_id: user_id, item_id: INITIAL_ITEM_ID, quantity: INITIAL_ITEM_QUAMTITY)
    end
end
