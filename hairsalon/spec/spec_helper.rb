require ("clients")
require("stylists")
require("pg")
require("pry")

DB = PG.connect({:dbname => 'hairsalon_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM clients *;")
    DB.exec("DELETE FROM stylists *;")
  end
end
