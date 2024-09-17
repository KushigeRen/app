RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :remote_chrome
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 4444
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
end

# Chrome
Capybara.register_driver :remote_chrome do |app|
  url = ENV['SELENIUM_DRIVER_URL'] || 'http://selenium_chrome:4444/wd/hub'
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('no-sandbox')
  options.add_argument('headless')
  options.add_argument('disable-gpu')
  options.add_argument('window-size=1680,1050')

  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, options: options)
end

Capybara.default_max_wait_time = 5 # 5秒待機
