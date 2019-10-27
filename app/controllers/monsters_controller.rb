class MonstersController < ApplicationController
  
  # get 'monsters/:offset', to: 'monsters#index'
  def index
    monster = Monster.get_possessions(@session.variables[:user_id],offset: @input["offset"], limit: 10)
    

    # 本当はview機構を作ってそこでやるべきなんだろうが、
    # どうしても分離したいほどの量じゃないのと、
    # rails new --apiした時にviewが作成されない→それくらいはコントローラでやれよというrailsの意思を感じるのでここに記述
    monster_json = {}
    monster.each do |k, v|
      monster_json[k] = {
        "name" => v.name,
        "rairity" => v.rarity,
        "hp" => v.hp,
        "mp" => v.mp,
        "atk" => v.atk,
        "def" => v.def,
        "speed" => v.speed
      }
    end


    render :json => monster_json, :status => OK
  end

  def validate_input_GET()
    # to_iすると文字列が0に置換される。
    # offset=0になるだけなので実際的な問題にはならないが、意味論としては弾きたい
    @input = {
      "offset" => params[:offset].to_i
    }

    validate_not_Naturalnumber_and_not_0(@input)
  end
end
