require 'securerandom'

class User < ApplicationRecord
    def self.create(name:, passwd:)
        salt = SecureRandom.hex(10) + "aaaaburiburi"

        pw_hash = Digest::SHA1.hexdigest(passwd+salt)

        user = User.new(name: name, salt: salt, passwd: pw_hash)
        user.save!() #nameの重複はここでエラー吐かれる

        return user
    end


end



