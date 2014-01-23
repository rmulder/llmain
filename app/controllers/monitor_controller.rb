class MonitorController < ApplicationController

  def ruby
    version = `ruby -v`
    render :text => version
  end
  
  def rails
    version = Rails::version
    render :text => version
  end
  
  def mysql
    version = ActiveRecord::Base.connection.select_rows("select version()").to_s
    render :text => version
  end
  
  def redis
    version = RedisModel::search_connection.info['redis_version']
    render :text => version
  end

  def hello
    render :text => 'hello world'
  end
  
end
