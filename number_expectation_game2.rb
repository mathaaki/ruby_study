class NumberExpectationGame2 < Executor
  def self.default
    infinity
  end

  def try
    super do
      clear
      print "正解は？: "
      answer = gets.chomp.split("")

      if answer == @correct
        success
        break
      end

      hit_num = []
      answer.length.times do |i|
        if answer[i] == @correct[i]
          @hit += 1
          hit_num << i
        end
      end

      correct = remainder_num(hit_num).inject([]) { |arr, i| arr << @correct[i] }
      remainder_num(hit_num).each { |i| @blow += 1 if correct.include? answer[i] }

      p "#{@hit}hit #{@blow}blow"
    end
  end

  private

  def set_up
    super
    @correct = create_correct
    clear
  end

  def clear
    @hit  = 0
    @blow = 0
  end

  def create_correct
    correct = Array.new 1, rand(1..9).to_s
    until correct.length == 4
      random = rand(10).to_s
      correct << random if correct[-1] != random
    end
    correct
  end

  def remainder_num(hit_num)
    Array.new(@correct.length) { |i| i } - hit_num
  end

  def success
    p "正解！！"
    p "try count: #{@try_cnt}"
  end

  def failed
    p "残念。。。！(´・ω ・｀)"
    p "try count: #{@try_cnt}"
  end
  alias_method :finish, :failed
end
