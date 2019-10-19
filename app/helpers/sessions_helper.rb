module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    # 未ログイン時はnilが返る
    def current_user()
        puts session[:user_id]
        if !session[:user_id].nil?
          @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def log_out()
        session.delete(:user_id)
        @current_user = nil
    end

    def logged_in?
        !current_user.nil?
    end

    # 丸っとsessionmodelに引っ越し予定なので現行色々雑

    def get_session()
        @session_id = request.headers["HTTP_COOKIE"][/XXX_rubyquest_session=([0-9a-f]{100})/,1]

        # ポートとか環境によって動的にする
        if !@session_id.nil?
            @cache = Redis.new(:host => "localhost", :port => 6379)
            session_key = "XXX_rubyquest_session:" + @session_id
            
            @session_variable ||= Marshal.load(@cache.get(session_key))
        
            return @session_variable[:id]
        end
    end


    def create_session(user_id)
        if exist_session?
            reset_session(user_id)
        else
            start_session(user_id)
    
        end
    end

    def exist_session?()
        if @session_id.nil?
            false
        end
        
        true
    end

    def start_session(user_id)
        @session_id = generate_session_id()
        @session_variable = {id: user_id}

        save_session()

        response.set_cookie("XXX_rubyquest_session", @session_id)
    end

    def set_session_variable(hash)
        hash.each do |k, v|
            @session_variable[k] = v
        end

        save_session()
    end

    def save_session()
        session_key = "XXX_rubyquest_session:" + @session_id

        @cache ||= Redis.new(:host => "localhost", :port => 6379)
        @cache.set(session_key, Marshal.dump(@session_variable))
    end

    # start_sessionとの実用上の違いってあるか？
    def reset_session(user_id)
        @session_id = generate_session_id()
        @session_variable = {id: user_id}

        save_session()

        response.set_cookie("XXX_rubyquest_session", @session_id)
    end

    def generate_session_id()
        SecureRandom.hex(50)
    end

    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end
end
