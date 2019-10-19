class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
      binding.pry
        redis_namespace = "session"
        cookie_key = cookies[Rails.application.config.session_options[:key]]
    
        session_key = "session:631d8f7ab419af3fcf9058bb33454780"
    
        redis = Redis.new(:host => "localhost", :port => 6379)
        #puts Marshal.load(redis.get(session_key))
    
        
    
        @tasks = Task.all
  end
end
