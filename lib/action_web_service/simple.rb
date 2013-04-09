# encoding: UTF-8
module ActionWebService
  # To send simple types across the wire, derive from ActionWebService::Simple,
  # and use +base+ to declare the base type for it restriction and,
  # use +restriction+ to declare valid W3C restriction element for SimpleType.
  #
  # ActionWebService::Simple should be used when you want to declare valid custom simple type
  # to be used inside expects, returns and structured types
  #
  #
  # There plenty documentation available at W3C Archives
  # http://www.w3.org/TR/xmlschema-2/
  #
  # === Example
  #
  #   class Gender < ActionWebService::Simple
  #     base :string
  #     restriction :enumeration, "male|female"
  #   end
  #
  #
  class Simple

    def initialize(value)
      @value = value
    end
    
    class_attribute :simple_restrictions, :xml_base
    self.simple_restrictions = {}
    self.xml_base = ""

    class << self
      def base(type)
        type = type.to_s.camelize(:lower)
        self.xml_base = type
      end
      
      def restriction_base
        self.xml_base
      end
      
      def restriction(type, value)
        type = type.to_s.camelize(:lower)
        self.simple_restrictions = self.simple_restrictions.merge({ type => value })
      end
      
      def restrictions
        self.simple_restrictions
      end
      
    end

  end

end
