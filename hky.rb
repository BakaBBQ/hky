module Hky
  def def_before sym, &block
    im = instance_method sym
    define_method sym do
      instance_exec &block
      im.bind(self).call
    end
  end

  def def_after sym, &block
    im = instance_method sym
    define_method sym do
      im.bind(self).call
      instance_exec &block
    end
  end

  def def_around sym, &block
    im = instance_method sym
    define_method sym do
      res = im.bind(self).call
      instance_exec(res) &block
    end
  end
end
