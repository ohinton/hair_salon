require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/stylist')
require('./lib/client')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'hair_salon'})

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

get('/stylists/:id/update') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:update_stylist_form)
end

patch('/stylists/:id/update') do
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  @stylist = Stylist.find(params.fetch('id').to_i())
  @stylist.update({:first_name => first_name, :last_name => last_name})
  @stylists = Stylist.all()
  erb(:stylists)
end
