class WalletsController < ApplicationController
  def index
    wallet = Wallet.find_by(user_id: @session.variables[:user_id])
  
    wallet_json = {
      "gem" => wallet.gem,
      "money" => wallet.money
    }

    render :json => wallet_json, :status => OK
  end
end
