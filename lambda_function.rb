require 'nokogiri'
require 'selenium-webdriver'
require 'capybara'

def lambda_handler(event:, context:)
  Capybara.javascript_driver = :chrome
  Capybara.configure do |config|
    config.default_max_wait_time = 10 # seconds
    config.default_driver = :selenium_chrome_headless
  end

  # Visit
  browser = Capybara.current_session
  driver = browser.driver.browser
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
