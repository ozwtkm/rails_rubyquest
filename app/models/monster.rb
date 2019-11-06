class Monster < ApplicationRecord
    INITIAL_MONSTER_ID = 5

    def self.get_possessions(user_id, offset:, limit: 10)
        master_monster_list = Monster.all()# todo redis

        user_monster = User_monster.where(user_id: user_id).offset(offset).limit(limit)
        
        posession_monster_list = {}
        user_monster.each do |row|
            posession_monster_list[row.id] = master_monster_list.find(row.monster_id)
        end

        return posession_monster_list
    end

    # これはuser_monsterのinitなのでは？という説ある
    def self.init(user_id)
        User_monster.create(user_id: user_id, monster_id: INITIAL_MONSTER_ID)
    end
end
