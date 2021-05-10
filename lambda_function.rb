require 'nokogiri'
require 'selenium-webdriver'
require 'capybara'

def lambda_handler(event:, context:)
  Capybara.register_driver :chrome_headless do
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--window-size=1400,1400')
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-extensions')
    options.add_argument('--ignore-certificate-errors')
    Capybara::Selenium::Driver.new(nil, browser: :chrome, options: options)
  end
  Capybara.javascript_driver = :chrome_headless
  Capybara.configure do |config|
    config.default_max_wait_time = 10 # seconds
    config.default_driver = :chrome_headless
  end

  # Visit
  browser = Capybara.current_session
  browser.visit "https://flag.dol.gov/auth/auth/login-gov/login/loa-1"
  browser.find('#user_email').set("alvarezhamilton@gmail.com")
  browser.find('#user_password').set("BASS-inflow-roadway")
  browser.click_button('Sign in')
  browser.find('#backup_code_verification_form_backup_code').set('2F8V7RFRH6D8')
  browser.click_button('Submit')

  {
    nokogiri_version: Nokogiri::VERSION
  }
end
