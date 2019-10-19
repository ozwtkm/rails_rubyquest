require_relative '../exceptions/Error_general_inconsistency'

class ApplicationController < ActionController::Base
    include SessionsHelper

    # ステータスコード管理
    OK = 200
    CREATED = 201
    RESET_CONTENT = 205
    NOT_FOUND = 404
    PRECONDITION_FAILED = 412

    def validate_special_or_nil(hash)
        validate_nil(hash)
        validate_special_character(hash)
    end


    def validate_nil(hash)
        hash.each do |key, value|
            if value.nil?
                raise GeneralInconsistencyError.new(status: PRECONDITION_FAILED, message: key + "がnilだよ")
            end
        end
    end

    def validate_special_character(hash)
        hash.each do |key, value|
            if value.match(/\A[a-zA-Z0-9_@]+\z/).nil?
                raise GeneralInconsistencyError.new(status: PRECONDITION_FAILED, message: key + "は/\A[a-zA-Z0-9_@]+\z/でよろ")
            end
        end
    end

    def validate_not_Naturalnumber(hash)
        base = 10
        hash.each do |key, value|
            if Integer(value.to_s, base) <= 0
                raise GeneralInconsistencyError.new(status: PRECONDITION_FAILED, message: key + "は自然数でよろ")
            end
        end
    end

    protect_from_forgery with: :null_session
end