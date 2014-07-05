require 'active_record'

module Parse
  module Db
    class Import
      def init_active_record(options)
        ActiveRecord::Base.establish_connection({
          adapter: options.adapter,
          host: options.host,
          username: options.dbuser,
          password: options.dbpassword,
          database: options.dbname
        })
      end
      def get_class(class_name)
        return self.class.const_get(class_name, false) if self.class.const_defined?(class_name, false)
        klass = self.class.const_set(class_name, Class.new(ActiveRecord::Base) do
          @inheritance_column = "ar_type"
        end)
        create_table_if_missing(klass)
        klass
      end

      def create_table_if_missing klass
        dbconnection = klass.connection
        dbconnection = klass.connection
        dbconnection.create_table(klass.table_name) unless dbconnection.table_exists? klass.table_name
      end
      def get_missing_columns(klass, columns)
        @seen_columns ||= {}
        missing_columns = []
        # Get the list of columns that we've already checked.
        seen_columns = @seen_columns[klass.table_name] || []

        # We don't need to check columns that we've already checked.
        columns -= seen_columns
        return columns if columns.empty?


        dbconnection = klass.connection

        #Get a listing of all the columns that don't exist in the entity
        columns.each { |k| missing_columns.push(k) unless dbconnection.column_exists?(klass.table_name, k) }


        #Mark that we've seen all these columns so we don't need to search the database again.
        @seen_columns[klass.table_name] = seen_columns | columns
        missing_columns
      end

      def get_column_type(val, column)
        return :timestamp if column =~ /date$/
        case val
          when String
            val.length
          when Fixnum
            :integer
        end
      end

      def create_missing_columns(klass, missing_columns)
        return if missing_columns.length == 0

        #Create any columns that are missing.
        dbconnection = klass.connection
        dbconnection.change_table(klass.table_name) do |t|
          missing_columns.each do |k,v|
            if v.is_a? Fixnum
              t.column k, :string, { limit: v }
            else
              t.column k, v
            end
          end
        end
        klass.reset_column_information
        klass.inheritance_column = "ar_type"
      end
    end
  end
end

