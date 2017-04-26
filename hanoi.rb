class Hanoi < Executor
  Towers = %i(left_tower center_tower right_tower)

  class << self
    def default
      5
    end

    def limit
      64
    end
  end

  def initialize(c)
    super 1
    @height = c
  end

  def try
    super do
      hanoi_viewer
      until success
        odd_move
        hanoi_viewer
        unless success
          even_move
          hanoi_viewer
        end
      end
    end
  end

  private

  def set_up
    super
    @left_tower   = Array.new(convert @height) { |i| i + 1 }.sort { |a, b| b <=> a }
    @center_tower = []
    @right_tower  = []
    @odd_count    = 1
    @completed    = @left_tower.clone
  end

  def odd_move
    case @odd_count
    when 1
      @right_tower << instance_variable_get("@#{minimum_tower}").pop
      @odd_count += 1
    when 2
      @center_tower << instance_variable_get("@#{minimum_tower}").pop
      @odd_count += 1
    when 3
      @left_tower << instance_variable_get("@#{minimum_tower}").pop
      @odd_count = 1
    end
  end

  def even_move
    target = Towers.clone.reject!{ |tower| tower == minimum_tower }.
                          map { |tower| [tower, instance_variable_get("@#{tower}").last] }.
                          sort do |a, b|
                            a[1] = a[1].nil? ? nil_val : a[1]
                            b[1] = b[1].nil? ? nil_val : b[1]
                            b[1] <=> a[1]
                          end.
                          flatten.
                          select { |attr| attr if attr.is_a? Symbol }

  	instance_variable_get("@#{target[0]}") << instance_variable_get("@#{target[1]}").pop
  end

  def minimum_tower
    Towers.find { |tower| instance_variable_get("@#{tower}").last == 1 }
  end

  def hanoi_viewer
     p "L #{@left_tower}"
     p "C #{@center_tower}"
     p "R #{@right_tower}"
     puts "\n"
=begin
    ([@left_tower, @center_tower, @right_tower].max_by(&:size).size - 1).downto(0) do |i|
      puts "#{'●' * @left_tower[i].to_i}　#{'●' * @center_tower[i].to_i}　#{'●' * @right_tower[i].to_i}\n"
    end
    puts "\n"
=end
  end

  def success
    @center_tower == @completed || @right_tower == @completed
  end

  def nil_val
    self.class.limit + 1
  end

end
