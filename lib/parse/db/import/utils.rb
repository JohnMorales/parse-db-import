module Parse
  module Db
    class Import

      def map_arrays_to_strings(record)
        record.each { |k, v| record[k] = v.join(', ') if v.is_a? Array }
      end

      def klass_from_file(file)
        class_name = File.basename(File.dirname(file))
        get_class(class_name)
      end

      def process_parse_file(file, &block)
        IO.foreach(file) do |record|
          record = JSON.parse(record)
          record = map_arrays_to_strings(record)
          next if record["delete"]
          yield(record)
        end
      end

    end
  end
end

