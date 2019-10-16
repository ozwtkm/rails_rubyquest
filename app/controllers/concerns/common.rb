module Common
    extend ActiveSupport::Concern
  
    included do
      # ここにcallback等
    end
  
    private
  
    def validate_nil(key, value)
		if value.nil?
			raise key + "がnil"
		end
    end

    def validate_special_or_nil(key, value)
        validate_nil(key, value)
        validate_special_character(key, value)
    end

    def validate_special_character(key, value)
		if value.match(/\A[a-zA-Z0-9_@]+\z/).nil?
            raise key + "に特殊記号含めるな"
		end
    end

    def validate_not_Naturalnumber(key, value)
        base = 10
        if Integer(value.to_s, base) <= 0
            raise key + "は自然数でよろ"
        end
    end

  end