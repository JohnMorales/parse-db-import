require 'date'

module Parse
  module Db
    class Import

      DATE_CONVENTIONS = [ /At$/, /date$/, /^last/ ]

      def map_data_types(record)
        #Convert arrays to strings, since we're not supporting them yet.
        record.each { |k, v| record[k] = v.join(', ') if v.is_a? Array }
        #Convert epoch to datetime
        record.each { |k, v| record[k] =  DateTime.strptime(v.to_s, "%Q") if is_date_by_naming_convention(k) }
      end

      def is_date_by_naming_convention column_name
        DATE_CONVENTIONS.any? { |regx| column_name =~ regx }
      end

      def klass_from_file(file)
        class_name = File.basename(File.dirname(file))
        get_class(class_name)
      end

      def process_parse_file(file, &block)
        IO.foreach(file) do |record|
          record = JSON.parse(record)
          record = map_data_types(record)
          next if record["delete"]
          yield(record)
        end
      end

    end
  end
end

