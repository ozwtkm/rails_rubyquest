module SessionsHelper
    def set_session()
        if request.headers["HTTP_COOKIE"].nil?
            @session = Session.get()

            return
        end

        @session = Session.get(request.headers["HTTP_COOKIE"][/XXX_rubyquest_session=([0-9a-f]{100})/,1])
    end


    def set_cookie()
        response.set_cookie("XXX_rubyquest_session", @session.id)
    end
end
