require 'date'

module Parse
  module Db
    class Import

      def map_data_types(record)
        #Convert arrays to strings, since we're not supporting them yet.
        record.each { |k, v| record[k] = v.join(', ') if v.is_a? Array }
        #Convert epoch to datetime
        record.each { |k, v| record[k] =  DateTime.strptime(v.to_s, "%Q") if k =~ /date$/ }
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

