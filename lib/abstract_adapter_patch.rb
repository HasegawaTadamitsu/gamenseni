module ActiveRecord
  module ConnectionAdapters
    class AbstractAdapter
      protected

        def log(sql, name)
          name ||= "SQL"
          @instrumenter.instrument("sql.active_record",
            :sql => sql, :name => name, :connection_id => object_id) do
            yield
          end
        rescue Exception => e
          e.message.force_encoding('utf-8')
          message = "#{e.class.name}: #{e.message}: #{sql}"
          @logger.debug message if @logger
          raise translate_exception(e, message)
        end
      end
    end
  end
