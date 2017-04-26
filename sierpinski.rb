class Sierpinski < Pascal

  def self.default
    30
  end

  private

  def view
    @pascal.map { |attr| attr.even? ? "○" : "●" }
  end
end
