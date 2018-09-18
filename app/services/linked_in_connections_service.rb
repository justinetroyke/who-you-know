class LinkedInConnectionsService

  def initialize(username, password, user_id)
    @username = username
    @password = password
    @user = User.find_by(id: user_id)
  end

  def import_connections
    browser_set_up
    login_user
    navigate_to_connections_page
    load_browser
    load_page
    create_cards
  end

  def browser_set_up
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
    Capybara.javascript_driver = :chrome
    Capybara.configure do |config|
      config.default_max_wait_time = 10 # seconds
      config.default_driver = :selenium
    end
    # Visit
    @browser = Capybara.current_session
    @driver = @browser.driver.browser
  end

  def login_user
    @browser.visit "https://www.linkedin.com/"
    #log in
    @browser.fill_in('login-email', with: @username)
    @browser.fill_in('login-password', with: @password)
    @browser.find("#login-submit").click
  end

  def navigate_to_connections_page
    #navigate to connections
    @browser.find("#mynetwork-tab-icon").click
    @browser.find(".js-mn-origami-rail-card__connection-count").click
  end

  def load_browser
    loop do
      sleep(2)
      if @driver.execute_script('return document.readyState') == "complete"
        break
      end
    end
  end

  def load_page
    # Load page
    doc = Nokogiri::HTML(@driver.page_source);
    section = doc.css("div.ember-view > div.application-outlet > div.authentication-outlet > div.self-focused > div.extended > div.body > div.self-focused > div.neptune-grid > div.core-rail > div.self-focused > div.ember-view > section.mn-connections");
    @connections = section.css("div.mn-connection-card")
  end

  def create_cards
    if @connections.count > 0
    # Print companies
      @connections.each do |connection|
        if connection.css("span.mn-connection-card__name") == nil || connection.css("div.presence-entity__image") == nil || connection.css("div.presence-entity__image").attr("style") == nil
          name = nil
          image_url = nil
        else
          name = connection.css("span.mn-connection-card__name").text.split.join(" ")
          image_url = connection.css("div.presence-entity__image").attr("style").value.split[1].split('"')[1]
          @user.cards.create!(first_last_name: name, image_url: image_url)
        end
      end
    end
  end
end
