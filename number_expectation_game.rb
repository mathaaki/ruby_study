class NumberExpectationGame < Executor
  def self.default
    infinity
  end

  def try
    super do
      print "正解は？: "
      answer = gets.chomp.to_i
      if answer == @correct
        success
        break
      elsif answer > @correct
        p "もっと小さいよ"
      else
        p "もっと大きいよ"
      end
    end
  end

  private

  def set_up
    super
    @correct = rand 100
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