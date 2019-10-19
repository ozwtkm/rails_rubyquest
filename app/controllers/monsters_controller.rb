class MonstersController < ApplicationController
  def index

#log_in()
    a = response.set_cookie "fff","fwa"
    render :json => {"a":2}
  end
end
