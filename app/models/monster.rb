class Monster < ApplicationRecord
    def self.get_possessions(user_id, offset:, limit: 10)
        master_monster_list = Monster.all()# todo redis

        user_monster = User_monster.where(user_id: user_id).offset(offset).limit(limit)
        
        posession_monster_list = {}
        user_monster.each do |row|
            posession_monster_list[row.id] = master_monster_list.find(row.monster_id)
        end

        return posession_monster_list
    end
end
