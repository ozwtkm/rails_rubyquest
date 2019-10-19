require 'securerandom'

class SessionsController < ApplicationController

  # 要するにログイン
  def create
    json_request = JSON.parse(request.body.read)

    json = {
      "name" => json_request["name"],
      "passwd" => json_request["passwd"]
    }

    begin
      validate_special_or_nil(json)

      user = User.find_by(name: json_request["name"])

      if user.nil?
        raise GeneralInconsistencyError.new(status: PRECONDITION_FAILED, message: "IDかパスワードが違う")
      end

      pw_hash = Digest::SHA1.hexdigest(json_request["passwd"] + user.salt)

      if pw_hash != user.passwd
        raise GeneralInconsistencyError.new(status: PRECONDITION_FAILED, message: "IDかパスワードが違う")
      end
    rescue => e
      errorjson = {"ErrorMessage" => e.message}
      return render :json => errorjson, :status => e.status      
    end

    create_session(user.id)
    
    set_session_variable({name: user.name})



    json = {
      "name" => user.name
    }

    render :json => json, :status => CREATED
  end
end
