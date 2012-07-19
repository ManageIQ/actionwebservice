# encoding: UTF-8
class Class # :nodoc:
  def class_inheritable_option(sym, default_value=nil)
    class_attribute "#{sym}_attr"
    self.send("#{sym}_attr=", default_value) if default_value
    class_eval <<-EOS
      def self.#{sym}(value=nil)
        if !value.nil?
          self.#{sym}_attr = value
        else
          self.#{sym}_attr
        end
      end
      
      def self.#{sym}=(value)
        self.#{sym}_attr = value
      end

      def #{sym}
        self.class.#{sym}_attr
      end

      def #{sym}=(value)
        self.class.#{sym}_attr = value
      end
    EOS
  end
end
