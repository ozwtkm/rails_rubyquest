class UsersController < ApplicationController
  skip_before_action :validate_login, only: :create

  def index
    user = User.find_by(id: @session.variables[:user_id])

    render :json => {"username": user.name}, :status => OK
  end


  def create
    begin
      user = User.create(name: @json["name"], passwd: @json["passwd"])
    rescue
      errorjson = {"ErrorMessage" => "キャラ被ってんで"}
      return render :json => errorjson, :status => CONFLICT
    end

    Wallet.init(user.id)
    Item.init(user.id)

    render :status => CREATED
  end


  def validate_input_POST()
    json_request = JSON.parse(request.body.read)

    @json ={
      "name" => json_request["name"],
      "passwd" => json_request["passwd"]
    }

    validate_special_or_nil(@json)

  end


end
