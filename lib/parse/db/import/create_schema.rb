require "parse/db/import/utils"
require "parse/db/import/activerecord_helpers"

module Parse
  module Db
    class Import
      def create_schema(options)
        Dir["#{options.path}/#{options.entity}/data.json"].each do |file|
          missing_columns = {}
          klass = klass_from_file(file)
          puts "Scanning....#{klass.name}"
          process_parse_file(file) do |record|
            columns = get_missing_columns(klass, record.keys)
            unless columns.empty?
              columns.each do |k|
                missing_columns[k] = get_column_type(record[k], k)
              end
            end
            missing_columns.each do |k, v|
              next unless v.is_a? Fixnum
              len = record[k].to_s.length 
              missing_columns[k] = len if v < len
            end
          end
          if (missing_columns.length)
            puts "Creating....#{klass.name} columns #{missing_columns.map{|k,v| "#{k} varchar(#{v})"}.join(", ")}"
            create_missing_columns(klass, missing_columns)
          end
        end
      end
    end
  end
end

