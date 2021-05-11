require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = {
    host: ENV['REDIS_HOST'],
    port: '6379'
  }
end

Sidekiq.configure_server do |config|
  config.redis = {
    host: ENV['REDIS_HOST'],
    port: '6379'
  }
end

class OurWorker
  include Sidekiq::Worker

  def perform(complexity)
    case complexity
    when 'hard'
      sleep 5
      puts("Working #{complexity}")
    else
      sleep 1
      puts("Working #{complexity}")
    end
  end
end