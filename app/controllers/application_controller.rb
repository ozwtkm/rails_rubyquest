require_relative '../exceptions/Error_general_inconsistency'

class ApplicationController < ActionController::Base
    include SessionsHelper
    include ValidationHelper
    before_action :set_session
    before_action :validate_login 
    before_action :prehandle_input # 中で呼んでる入力値検証はオーバーライド前提
    before_action :begin_transaction

    def begin_transaction
        ApplicationRecord.transaction do
            
        end
    end


    protect_from_forgery with: :null_session
end