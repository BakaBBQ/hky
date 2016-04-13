module Hky
  def def_before sym, &block
    im = instance_method sym
    define_method sym do |*args|
      instance_exec *args, &block
      im.bind(self).call *args
    end
  end

  def def_after sym, &block
    im = instance_method sym
    define_method sym do |*args|
      im.bind(self).call *args
      instance_exec *args, &block
    end
  end

  def def_around sym, &block
    im = instance_method sym
    define_method sym do |*args|
      res = im.bind(self).call *args
      instance_exec *(args.concat(res)), &block
    end
  end
end
