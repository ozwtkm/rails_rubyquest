class PartiesController < ApplicationController

def index
    user = User.find_by(id: @session.variables[:user_id])

    party = Party.get(user.id)

    party_json = []
    party.each do |k, v|
        hash = {
            "party_id" => v.id,
            "possession_monster_id" => v.user_monster_id,
            "monster_info" => {
                "name" => v.monster_model.name,
                "rarity" => v.monster_model.rarity,
                "hp" => v.monster_model.hp,
                "mp" => v.monster_model.mp,
                "speed" => v.monster_model.speed,
                "atk" => v.monster_model.atk,
                "def" => v.monster_model.def
            }
        }

        party_json << hash
    end

    render :json => party_json, :status => OK
end

end
