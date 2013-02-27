module Banalize

  class Numbered < ::Mash

    ##
    # Return true if values of instance have specifid pattern,
    # returned by gerp.
    #
    def has? *params
      !grep(*params).empty?
    end
    

    def initialize *p
      @search = nil
      super *p
    end

    ##
    # Should always contain last result of grep
    #
    attr_accessor :search

    ##
    # Human readable form. Only lines without numbers.
    #
    def to_s
      if self.count == 1 
        self.values.first.to_s
      else
        self.values.to_s
      end
    end
    
    alias :inspect :to_s
    
    ##
    # Grep only values and return all lines with numbers that match
    #
    def grep pattern
      @search = self.select { |idx,line|  line =~ pattern }
      self.class.new(@search)
    end

    def add line, number=0
      self[number] = line.chomp
    end

  end


  class Parser

    def initialize path
      @shebang = Numbered.new
      @comments = Numbered.new 
      @code = Numbered.new

      @shebang.add lines.shift if lines.first =~ /^#!/

      lines.each_index do |idx|
        if lines[idx] =~ /^\s*\#/
          @comments.add lines[idx], idx
        else
          @code.add lines[idx], idx
        end
      end
    end


    attr_accessor :shebang, :comments, :code
  end
end