require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("the index path", {:type => :feature}) do
  it("displays the add new stylist button and add new client button") do
    visit("/")
    expect(page).to have_content("Hello!")
  end
end

describe("the add a stylist path", {:type => :feature}) do
  it("adds a stylist to the database") do
    visit("/")
    click_link("View/Add Stylists")
    expect(page).to have_content("Add a stylist")
    fill_in("first_name", :with => "Test First Name")
    fill_in("last_name", :with => "Test Last Name")
    click_button("Add")
    expect(page).to have_content("Test First Name")
  end
end

describe("the update a stylist path", {:type => :feature}) do
  it("updates a stylist in the database") do
    visit("/stylists")
    fill_in("first_name", :with => "Test First Name")
    fill_in("last_name", :with => "Test Last Name")
    click_button("Add")
    expect(page).to have_content("Test First Name")
    click_link("Test First Name")
    expect(page).to have_content("Test First Name")
    click_link("Update")
    expect(page).to have_content("Update")
    fill_in("first_name", :with => "New First Name")
    fill_in("last_name", :with => "New Last Name")
    click_button("Update")
    expect(page).to have_content("New First Name")
  end
end

describe('the delete stylist path', {:type => :feature}) do
  it('deletes a stylist from the database') do
    visit("/stylists")
    fill_in("first_name", :with => "Test First Name")
    fill_in("last_name", :with => "Test Last Name")
    click_button("Add")
    expect(page).to have_content("Test First Name")
    click_link("Test First Name")
    expect(page).to have_content("Test First Name")
    click_button("Delete")
    expect(page).to have_content("Record deleted!")
  end
end

describe("the add a client path", {:type => :feature}) do
  it("adds a client to the database") do
    visit("/")
    click_link("View/Add Clients")
    expect(page).to have_content("Moxie's Clients")
    click_link("Add Clients")
    expect(page).to have_content("Add a client to the database:")
    fill_in("first_name", :with => "Test First Name")
    fill_in("last_name", :with => "Test Last Name")
    click_button("Add")
    expect(page).to have_content("Test First Name")
  end
end

describe('the delete client path', {:type => :feature}) do
  it('deletes a client from the database') do
    visit("/clients_add")
    fill_in("first_name", :with => "Test First Name")
    fill_in("last_name", :with => "Test Last Name")
    click_button("Add")
    expect(page).to have_content("Test First Name")
    click_link("Test First Name")
    expect(page).to have_content("Test First Name")
    click_button("Delete")
    expect(page).to have_content("Record deleted!")
  end
end
