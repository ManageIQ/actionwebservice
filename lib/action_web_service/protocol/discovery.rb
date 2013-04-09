# encoding: UTF-8
module ActionWebService # :nodoc:
  module Protocol # :nodoc:
    module Discovery # :nodoc:
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, ActionWebService::Protocol::Discovery::InstanceMethods)
        base.class_attribute :web_service_protocols
        base.web_service_protocols = []
      end

      module ClassMethods # :nodoc:
        def register_protocol(klass)
          self.web_service_protocols = self.web_service_protocols + [klass]
        end
      end

      module InstanceMethods # :nodoc:
        private
          def discover_web_service_request(action_pack_request)
            self.class.web_service_protocols.each do |protocol|
              protocol = protocol.create(self)
              request = protocol.decode_action_pack_request(action_pack_request)
              return request unless request.nil?
            end
            nil
          end

          def create_web_service_client(api, protocol_name, endpoint_uri, options)
            self.class.web_service_protocols.each do |protocol|
              protocol = protocol.create(self)
              client = protocol.protocol_client(api, protocol_name, endpoint_uri, options)
              return client unless client.nil?
            end
            nil
          end
      end
    end
  end
end
