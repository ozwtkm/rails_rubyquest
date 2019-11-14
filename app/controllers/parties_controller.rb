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


# ストロングパラメータ使おうとすると
#  {"{\"users\":{\"hoge\":333}"=>nil, "id"=>"1"}みたいになってうまくjsonが取れない。。
def update
    user = User.find_by(id: @session.variables[:user_id])

    party = Party.get(user.id)

    if party[params[:id]].nil?
        raise GeneralInconsistencyError.new(status: 412, message: "不整合起きた")
    end

    party[params[:id]].set(@json["user_monster_id"])

    render :status => CREATED
end


def validate_input_PUT()
    json_request = JSON.parse(request.body.read)

    @json = {
      "user_monster_id" => json_request["user_monster_id"]
    }

    validate_not_Naturalnumber(@json)
end


def hoges_params
    JSON.parse(params).require(:hoge).permit(:name,:content)
end


end
