require "parse/db/import/activerecord_helpers"
require "parse/db/import/create_schema"
require "parse/db/import/import_data"


module Parse
  module Db
    class Import
      def run(options)
        options.default({ host: "localhost", adapter: "postgresql", entity: "**" })
        init_active_record options
        create_schema options
        import_data options
      end
    end
  end
end
