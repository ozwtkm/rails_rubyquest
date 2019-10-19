class UsersController < ApplicationController
  def index
    user_id = get_session()

    user = User.find_by(id: user_id)
    if user.nil?
      return render :json => {"ErrorMessage":"ログインしろボケ"}, status: NOT_FOUND
    end

    render :json => {"username": user.name}, :status => OK
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
      # ↓　キモい　todo
      begin
        user = User.create(name: json_request["name"], passwd: json_request["passwd"])
      rescue
        raise GeneralInconsistencyError.new(status: PRECONDITION_FAILED, message:  "キャラ被ってんで")
      end
    rescue => e
      errorjson = {"ErrorMessage" => e.message}
      return render :json => errorjson, :status => e.status      
    end



    render :json => user, :status => CREATED
  end

  private

end
