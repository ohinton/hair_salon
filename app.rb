require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/stylist')
require('./lib/client')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  erb(:index)
end

get('/stylists') do
  @stylists = Stylist.all
  erb(:stylists)
end

post('/stylists') do
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  stylist = Stylist.new({:first_name => first_name, :last_name => last_name, :id => nil})
  stylist.save()
  @stylists = Stylist.all
  erb(:stylists)
end

get("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @clients = Client.all()
  erb(:stylist_info)
end

patch("/stylists/:id") do
  stylist_id = params.fetch("id").to_i()
  @stylist = Stylist.find(stylist_id)
  client_ids = params.fetch("client_ids")
  @stylist.update({:client_ids => client_ids})
  @clients = clients.all()
  erb(:stylist_info)
end

get('/stylists/:id/update') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:update_stylist_form)
end

patch('/stylists/:id/update') do
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  @stylist = Stylist.find(params.fetch('id').to_i())
  @stylist.update({:first_name => first_name, :last_name => last_name})
  @stylists = Stylist.all
  erb(:stylists)
end

delete("/stylists/:id/delete") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.delete
  @stylists = Stylist.all
  erb(:success)
end


get('/clients') do
  @clients = Client.all
  erb(:clients)
end

post('/clients') do
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  client = Client.new({:first_name => first_name, :last_name => last_name})
  client.save()
  @clients = Client.all
  erb(:clients)
end

get("/clients/:id") do
  @client = Client.find(params.fetch("id").to_i())
  @clients = Client.all()
  erb(:client_info)
end

get('/clients/:id/update') do
  @client = Client.find(params.fetch("id").to_i())
  erb(:update_client_form)
end

patch('/clients/:id/update') do
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  @client = Client.find(params.fetch('id').to_i())
  @client.update({:first_name => first_name, :last_name => last_name})
  @clients = Client.all
  erb(:clients)
end

delete("/clients/:id/delete") do
  @client = Client.find(params.fetch("id").to_i())
  @client.delete
  @clients = Client.all
  erb(:success)
end
