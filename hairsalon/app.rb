require('sinatra')
require('sinatra/reloader')
require('./lib/stylists')
require('./lib/clients')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  erb(:index)
end


get('/:user') do
  @clients = Clients.all()
  @stylists = Stylists.all()
  @user = params.fetch('user')
end

get('/clients/new') do
  erb(:client_form)
end

post('/clients/new') do
  name = params.fetch("name")
  new_client = Clients.new({:name => name, :id => nil})
  new_client.save()
  redirect('/stylist')
end

get('/:user/clients/:id') do
  @client = Clients.find(params.fetch("id").to_i)
  @user = params.fetch("user")
end

patch('/clients/:id') do
  @client = Clients.find(params.fetch("id").to_i)
  new_client = params.fetch("new_client")
  @client.update({:line => new_client})
  redirect('/stylist')
end

delete('/clients/:id') do
  client = Clients.find(params.fetch("id").to_i)
  client.delete()
  redirect('/stylist')
end

post('/clients/:id') do
  stylist = Stylists.find(params.fetch("stylist_id").to_i)
  client = Clients.find(params.fetch("id").to_i)
  redirect("/stylist/clients/#{client.id}")
end

get('/clients/:id/edit') do
  @id = params.fetch('id').to_i
  @stylists = Stylists.all()
  erb(:client_edit)
end

get('/stylists/new') do
  erb(:stylist_form)
end

post('/stylists/new') do
  name = params.fetch("name")
  new_stylist = Stylists.new({:name => name, :id => nil})
  new_stylist.save()
  redirect('/stylist')
end

get('/:user/stylists/:id') do
  @stylist = Stylists.find(params.fetch("id").to_i)
  @user = params.fetch("user")
end

get('/stylists/:id/edit') do
  @id = params.fetch('id').to_i
  @clients = Clients.all()
  erb(:stylist_edit)
end

patch('/stylists/:id') do
  @stylist = Stylists.find(params.fetch("id").to_i)
  new_name = params.fetch("new_name")
  @city.update({:name => new_name})
  redirect('/stylist')
end

delete('/stylists/:id') do
  stylist = Stylists.find(params.fetch("id").to_i)
  stylist.delete()
  redirect('/stylist')
end

post('/stylists/:id') do
  client = Clients.find(params.fetch("client_id").to_i)
  stylist = Stylists.find(params.fetch("id").to_i)
  redirect("/stylist/stylists/#{stylist.id}")
end

get('/clients_stylists/all') do
  @stylists = Stylists.all
  @clients = Clients.all
  erb(:all)
end

get('/success/:stylist_id/:client_id') do
  stylist_id = params.fetch("stylist_id").to_i
  client_id = params.fetch("client_id").to_i
  @stylist = Stylists.find(stylist_id)
  @client = Clients.find(client_id)
  erb(:success)
end

get('/stylists') do
  erb(:stylist)
end

get('/clients') do

get('/stylist') do
  erb(:stylist)
end

get('/client') do
  erb(:client)
end

#get('/:user/')


#post('stylist')
