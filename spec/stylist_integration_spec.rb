require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("the index path", {:type => :feature}) do
  it("displays the add new stylist button and add new client button") do
    visit('/')
    expect(page).to have_content("Hello!")
  end
end
