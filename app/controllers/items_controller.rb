class ItemsController < ApplicationController
  
    def index
      item = Item.get_possessions(@session.variables[:user_id],offset: @input["offset"], limit: 10)
      item_json = {}

      item.each do |k, v|
        item_json[k] = {
          "object" => {
            "id" => v["object"]["id"],
            "name" => v["object"]["name"],
            "value" => v["object"]["value"]
          },
          "quantity" => v["quantity"]
        }
      end
  
  
      render :json => item_json, :status => OK
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
  