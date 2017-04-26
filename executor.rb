class Executor
  class << self
    def start(c)
      e = self.new c
      e.try
    end

    def infinity
      100 ** 100
    end

    def default
      raise NotImplementedError
    end
  end

  def initialize(c)
    @end_cnt = convert c
  end

  def try
    set_up
    @end_cnt.times do
      count_up
      yield
    end
    finish
  end

  private

  def set_up
    puts "\nLet's try #{self.class}!"
    @try_cnt = 0
  end

  def convert(c)
    c.blank? ? self.class.default : c.to_i
  end

  def count_up
    @try_cnt += 1
  end

  def finish; end
end
