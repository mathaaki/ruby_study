module Refinements
  module Pascal
    refine Array.singleton_class do
      def pascal_base
        self.new 1,1
      end
    end
  end
  module Bowling
    refine Array.singleton_class do
      def bowling_base
        self.new 1,0
      end
    end
    refine String do
      alias_method :old_to_i, :to_i
      def to_i
        if self =~ /\A\d+\z/
          self.old_to_i
        else
          self
        end
      end
    end
    refine Fixnum do
      def strike?
        self == 10
      end
      alias_method :spare?, :strike?
    end
  end
end