# Rails's cattr_ things. activesupport/lib/active_support/core_ext/class
# Really quite handy.
# Thanks Reve's Lisa Seelye
class Class #:nodoc:
  def cattr_reader(*syms) #:nodoc:
    syms.flatten.each do |sym|
      next if sym.is_a?(Hash)
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        unless defined? @@#{sym}
          @@#{sym} = nil
        end

        def self.#{sym}
          @@#{sym}
        end

        def #{sym}
          @@#{sym}
        end
      EOS
    end
  end

  def cattr_writer(*syms) #:nodoc:
    options = syms.last.is_a?(Hash) ? syms.pop : {}
    syms.flatten.each do |sym|
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        unless defined? @@#{sym}
          @@#{sym} = nil
        end

        def self.#{sym}=(obj)
          @@#{sym} = obj
        end
        #{"
        def #{sym}=(obj)
          @@#{sym} = obj
        end
        " unless options[:instance_writer] == false }
      EOS
    end
  end
  def cattr_accessor(*syms) #:nodoc:
    cattr_reader(*syms)
    cattr_writer(*syms)
  end
end
