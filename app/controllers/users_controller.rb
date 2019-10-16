require 'securerandom'

class UsersController < ApplicationController
  attr_accessor :aaa

  def index

  end

  def create
    json_request = JSON.parse(request.body.read)

    json ={
      "name" => json_request["name"],
      "passwd" => json_request["passwd"]
    }

    # 本当はrescueせず入力値検証内の例外処理でrenderとreturnを終えたいがやり方がわからない
    begin
      validate_special_or_nil(json)
    rescue => e
      errorjson = {"ErrorMessage" => e.message}
      return render :json => errorjson, :status => e.status      
    end

    user = User.create(name: json_request["name"], passwd: json_request["passwd"])

    render :json => user, :status => CREATED
  end


  private

end
