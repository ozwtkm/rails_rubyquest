# 他のmodelとは異なり、
# SQL操作しないし実態が異なるが、
# コントローラからsessionへの操作インターフェースがmodelと類似するため、sessionhelperではなくmodelとして実装。
class Session
    @@cache = nil

    attr_accessor :id, :variables, :is_logined
    
    def self.get(sessionid=nil)
        if sessionid.nil?
            session = Session.new()
        else
            cache = Session.cache_client()
            session_key = "XXX_rubyquest_session:" + sessionid

            begin
                session_variables = Marshal.load(cache.get(session_key))
                if session_variables[:user_id].nil?
                    tmp_session = Session.new(sessionid, session_variables, is_logined: false)
                else
                    tmp_session = Session.new(sessionid, session_variables, is_logined: true)
                end
            rescue
                tmp_session = Session.new() #sessionが無いとbeginの1行目でエラーになる
            end

            session = tmp_session
        end

        session
    end


    # 擬似シングルトン。そのうち専用クラスつくる
    def self.cache_client()
        @@cache ||= Redis.new(:host => "localhost", :port => 6379)

        @@cache
    end



    def is_logined?()
        @is_logined
    end

    # restartも包含してる
    def start()
        logout()

        @id = generate_session_id()

        save()
    end


    # 意味論的にも実装問題的にもset-cookieはcontrollerで。
    def login(user_id)
        @id = generate_session_id()
        @variables[:user_id] = user_id
        @is_logined = true

        save()
    end


    def logout()
        unless @id.nil?
            session_key = "XXX_rubyquest_session:" + @id
        
            cache = Session.cache_client()
            cache.del(session_key)

            @id = nil
        end

       @variables = {}
       @is_logined = false
    end



private

    def initialize(sessionid=nil, variables={}, is_logined: false)
        @id = sessionid #cookieの値のことね。
        @variables = variables
        @is_logined = is_logined
    end



    def save()
        cache = Session.cache_client()
        session_key = "XXX_rubyquest_session:" + @id

        cache.set(session_key, Marshal.dump(@variables))
    end



    def generate_session_id()
        SecureRandom.hex(50)
    end
end