class Wallet < ApplicationRecord
  belongs_to :user

  INITIAL_GEM = 1000
  INITIAL_MONEY = 1000

  def self.init(user_id)
    wallet = Wallet.create(user_id: user_id, gem: INITIAL_GEM, money: INITIAL_MONEY)
    
    return wallet
  end

  def sub_gem(num)
    subtracted_gem = gem() - num

    # コントローラでも検証を原則とするが、セーフティネットとして。
    if subtracted_gem < 0
      raise GeneralInconsistencyError.new(status: 412, message: "gem足りねえよ貧乏人")
    end

    assign_attributes(gem: subtracted_gem)
  end

end
