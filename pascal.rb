class Pascal < Executor
  using Refinements::Pascal

  def self.default
    10
  end

  def try
    super do
      p view.join(" ")
      new_arr = Array.pascal_base
      @pascal.size.times do |i|
        new_arr << @pascal[i].to_i + @pascal[i + 1].to_i
      end
      @pascal = new_arr
    end
  end

  private

  def set_up
    super
    @pascal = Array.pascal_base
  end

  def view
    @pascal
  end
end
