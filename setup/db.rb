require 'sequel'

DB = Sequel.postgres 'rack_api'

DB.run 'CREATE EXTENSION IF NOT EXISTS citext;'
DB.run 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'

DB.create_table :users do
  column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
  citext :email, unique: true
end
