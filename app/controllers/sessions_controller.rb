require 'securerandom'

class SessionsController < ApplicationController
  include Common

  # 要するにログイン
  def create
    json_request = JSON.parse(request.body.read)

    {
      "name" => json_request["name"],
      "passwd" => json_request["passwd"]
    }.each do |key, value|
      validate_special_or_nil(key, value)
    end

    user = User.where(name: json_request["name"]).limit(1)

    if user.count === 0
      raise "IDかパスワードが違う"
    end

    pw_hash = Digest::SHA1.hexdigest(json_request["passwd"] + user.first.salt)

    if pw_hash != user.first.passwd
      raise "IDかパスワードが違う"
    end

    session[:id] = user.first.id

    json = {
      "name" => user.first.name
    }

    render :json => json, :status => CREATED
  end
end
