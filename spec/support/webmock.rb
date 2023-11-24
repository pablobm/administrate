require "webmock/rspec"

# Avoid conflict with Selenium (localhost)
WebMock.disable_net_connect!(allow_localhost: true)
