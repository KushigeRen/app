require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  if Rails.env.production?
    config.redis = { url: ENV['REDIS_URL'], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
  else
    config.redis = { url: ENV.fetch("REDIS_URL") { 'redis://localhost:6379' } }
  end
end

Sidekiq.configure_client do |config|
  if Rails.env.production?
    config.redis = { url: ENV['REDIS_URL'], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
  else
    config.redis = { url: ENV.fetch("REDIS_URL") { 'redis://localhost:6379' } }
  end
end
