class Kiyoshi < Executor
  ATTR = ["ズン！", "ドコ！", "キ・ヨ・シ！"].freeze

  def self.default
    infinity
  end

  def try
    super do
      break if @success
      while true
        random_select
        case
        when @text =~ /\A(ズン！){4}ドコ！\z/
          success
          break
        when !(@text =~ /\A(ズン！){1,4}\z/)
          failure
          break
        end
      end
    end 
  end

  private

  def set_up
    super
    clear
    @success = false
  end

  def clear
    @text = ""
  end

  def random_select
    @text << ATTR[rand 2]
  end

  def success
    @text << ATTR[2]
    p @text
    puts <<AA
　＊　 　　　+　　　　巛 ヽ\n
　　　　　　　　　　　　〒　!　　　+　　　　。　　　　　+　　　　。　　　　　＊　 　　　。\n
　 　　　　+　　　　。　 | 　|
　　　＊　 　　　+　　 /　/　　　イヤッッホォォォオオォオウ！\n
　　　　　　 ∧＿∧ /　/
　　　　　　（´∀｀　/　/　+　　　　。　　　　　+　　　　。　　　＊　 　　　。\n
　　　　　　,-　　　　　ｆ
　　　　　 / ｭﾍ　　　　| ＊　 　　　+　　　　。　　　　　+　　　。　+\n
　　　　　〈＿｝ ）　　　|
　　　　　　　 /　　　　! +　　　　。　　　　　+　　　　+　　　　　＊\n
　　　　　　 ./　　,ﾍ　 |
　ｶﾞﾀﾝ　||| j　　/　|　 | |||\n
――――――――――――\n
AA
    p "try count: #{@try_cnt}"
    @success = true
  end

  def failure
    p @text
    clear
  end

  def failed
    unless @success
      p "Kiyoshi Failed...(´・ω ・｀)"
      p "try count: #{@try_cnt}"
    end
  end
  alias_method :finish, :failed
end
