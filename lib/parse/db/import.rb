require 'commander'
require 'active_record'
require "parse/db/import/version"
require "parse/db/import/activerecord"
require "parse/db/import/create_schema"
require "parse/db/import/import_data"

module Parse
  module Db
    class Import
        include Commander::Methods
      def run
        program :version, '0.0.1'
        program :description, 'Simple app to import parse db'
        default_command :import

        command :import do |c|
          c.syntax = 'parse-db-import import [options]'
          c.summary = ''
          c.description = ''
          c.example 'description', 'command example'
          c.option '--path String', String, 'The location of where the json files exist'
          c.option '--entity String', String, 'The entity to load, all if missing'
          c.option '--dbname String', String, 'db name'
          c.option '--adapter String', String, 'mysql, mysql2, postgresql or sqlite3'
          c.option '--dbuser String', String, 'db user name'
          c.option '--dbpassword String', String, 'db password'
          c.option '--host String', String, 'db password'
          c.action do |args, options|
            options.default({ host: "localhost", adapter: "postgresql", entity: "**" })
            options.path = ask("Path? ") unless options.path
            init_active_record options
            create_schema options
            import_data options
          end
        end
        run!
      end
    end
  end
end

