class GeneralInconsistencyError < StandardError
    attr_reader :status, :message
    
    def initialize(status: 412, message: "不整合起きた")
        @status = status
        @message = message
    end
end