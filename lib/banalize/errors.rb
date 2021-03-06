module Banalize
  ##
  # Errors class provides stograge of error messages while running policy checks. 
  class Errors

    def initialize klass
      @klass = klass
      @messages = []
    end

    attr_accessor :messages

    def add message, line=nil
      @messages << { :message => message, :line => line }
    end
    
    ##
    # Retrun true if there are no errors
    def empty?
      @messages.empty?
    end

    ##
    # Retrun true if there are any errors
    #
    def any?
      ! empty?
    end


    ##
    # Convert Array of Hashes of error messages into readable form
    #
    def self.to_s messages=[]
      return '' if messages.empty?

      messages.map do |err|
        "#{err[:message]}#{err[:line] ? ", on line #{err[:line]}" : ''}"
      end
    end
    
  end
end
