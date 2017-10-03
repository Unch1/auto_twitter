# execute `$ watch -n 1800 ruby path/to/this/project/auto_favo_RT_with_selenium.rb` to run every 30 minutes
require "selenium-webdriver"
user_names = [
  "account1",
  "account2",
  "account3"
]


for user_name in user_names do
  driver = Selenium::WebDriver.for :firefox

  driver.get "https://twitter.com/login"

  # ログインする
  sleep 1
  begin
      driver.find_element(:xpath, '//*[@id="page-container"]/div/div[1]/form/fieldset/div[1]/input').send_key "#{user_name}"
      driver.find_element(:xpath, '//*[@id="page-container"]/div/div[1]/form/fieldset/div[2]/input').send_key "password"
      driver.find_element(:xpath, '//*[@id="page-container"]/div/div[1]/form/div[2]/button').click

  rescue
    driver.quit
    puts "login error"
    next
  end
  puts "login with #{user_name}"

  # 検索してファボ&RT
  driver.get "https://twitter.com/search?f=tweets&vertical=default&q=ANYWORD&src=typd"
  for i in 0..10 do
    begin
      driver.find_elements(:class, "js-actionFavorite")[i*2].click
      driver.find_elements(:class, "js-actionRetweet")[i*2].click
      driver.find_element(:class, "RetweetDialog-retweetActionLabel").click
    rescue
      puts "Error: in #{i}"
      break
    end
    sleep 2
  end
driver.quit
end
