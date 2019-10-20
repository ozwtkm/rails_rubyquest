RedisRailsSample::Application.config.session_store :redis_store, {
  
=begin
  servers: [
    {
      host: "localhost",
      port: 6379,
      db: 0,
      namespace: "session"
    },
  ],
  key: "XXX_rubyquest_session",
  expire_after: 1.week
=end

}