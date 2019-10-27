#require_relative '../exceptions/Error_general_inconsistency'


# module、helperと言いつつ、application_controllerに依存した形になってるのはいいのだろうか（実運用上どうせそこからしか呼ばないからこうしてるけど
module ValidationHelper
    # ステータスコード管理.validationhelperが持ってるのはキモいのでいつか引っ越したい
    OK = 200
    CREATED = 201
    RESET_CONTENT = 205
    UNAUTHNAUTHORIZED = 401
    NOT_FOUND = 404
    CONFLICT = 409
    PRECONDITION_FAILED = 412

    def validate_login()
        unless @session.is_logined?()
            render :json => {"ErrorMessage":"ログインしろボケ"}, status: UNAUTHNAUTHORIZED
        end
    end


    def prehandle_input()
        @json = {}

        begin
            validate_input()
        rescue => e
            render :json => {"ErrorMessage":e.message}, status: e.status
        end
    end


    def validate_input()
        case request.method
        when "GET"
            validate_input_GET()
        when "POST"
            validate_input_POST()
        when "PUT"
            validate_input_PUT()
        when "PATCH"
            validate_input_PATCH()
        when "DELETE"
            validate_input_DELETE()
        end
    end



    def validate_input_GET()
        # GETメソッド時の入力値検証処理。
        # オーバーライドして使う
    end

    def validate_input_POST()
        # POSTメソッド時の入力値検証処理。
        # オーバーライドして使う
    end

    def validate_input_PUT()
        # PUTメソッド時の入力値検証処理。
        # オーバーライドして使う
    end

    def validate_input_PATCH()
        # PATCHメソッド時の入力値検証処理。
        # オーバーライドして使う
    end

    def validate_input_DELETE()
        # DELETEメソッド時の入力値検証処理。
        # オーバーライドして使う
    end

    # ↓　validaterhelperにあとで引っ越し
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
            # Integer型はver2.4~で、それ以前はfixnumとbignumに分離することに注意
            if value.class != Integer || Integer(value.to_s, base) <= 0
                raise GeneralInconsistencyError.new(status: PRECONDITION_FAILED, message: key + "は自然数でよろ")
            end
        end
    end


    def validate_not_Naturalnumber_and_not_0(hash)
        base = 10
        hash.each do |key, value|
            # Integer型はver2.4~で、それ以前はfixnumとbignumに分離することに注意
            if value.class != Integer || Integer(value.to_s, base) < 0
                raise GeneralInconsistencyError.new(status: PRECONDITION_FAILED, message: key + "は0か自然数でよろ")
            end
        end
    end

end
