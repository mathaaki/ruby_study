class Nabeatsu < Executor

  def self.default
    40
  end

  def try
    super do
      if @try_cnt % 3 == 0 || @try_cnt.to_s.include?("3")
        p "ピィヤ！"
      else
        p @try_cnt
      end
    end 
  end

  private

  def set_up
    super
    p "3の倍数と3が付く数字のときだけアホになります"
    sleep 1
  end

  def finish
    p "オモロー！"
  end
end
