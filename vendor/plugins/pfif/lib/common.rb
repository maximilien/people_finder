module Common
  module Creatable
    def self.included receiver
      receiver.extend ClassMethods
    end
    
    module ClassMethods
      def create options
        obj = self.new
        options.each { |k, v| obj.send "#{k}=", v }
        obj
      end
    end
  end
end