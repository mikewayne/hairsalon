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

get('/stylist') do
  erb(:stylist)
end

get('/client') do
  erb(:client)
end

#get('/:user/')


#post('stylist')
