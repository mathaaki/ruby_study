class Bowling < Executor
  using Refinements::Bowling
  class InvalidScore < StandardError; end
  class InvalidScore2 < StandardError; end

  def self.default
    1
  end

  def initialize(c)
    super
    begin
      print "参加者名を空白区切りで入力してね: "
      @members = gets.chomp.split(/\s|　/).delete_if(&:blank?)
      @members.each do |name|
        raise TypeError, "名前は半角英数字で入力してね。数字は先頭につけないでね。\n" unless name =~ /\A([a-z]|[A-Z])+([a-z]|[A-Z]|[0-9])*\z/
      end
    rescue
      print $!
      retry
    end
  end

  def try
    super do
      10.times do |frame|
        @frame += 1
        @members.each do |name|
          score = instance_variable_get :"@#{name}_score"
          score[frame] = score[frame -1] unless frame == 0
          begin
            print "第#{@frame}フレーム: #{name}の１投目: "
            first_p = gets.chomp.to_i
            first_validate first_p

            # 前投球がスペア時の処理
            if spare?(name)
              score[frame -1] += first_p
              score[frame] = score[frame -1]
              instance_variable_set :"@#{name}_spare_flag", false
            end

            # 前投球がストライク時の処理（ダブル、ターキーを含む）
            if strike?(name)
              if instance_variable_get :"@#{name}_stack1"
                instance_variable_set :"@#{name}_stack2", first_p
              else
                instance_variable_set :"@#{name}_stack1", first_p
              end
            end

            # 現投球がストライクだった時ストライクフラグを立てる
            if first_p.strike?
              instance_variable_set :"@#{name}_strike_flag", true
            end

            # ダブル、ターキー時の処理
            if instance_variable_get :"@#{name}_stack2"
              score[frame -2] += instance_variable_get :"@#{name}_stack1"
              score[frame -2] += instance_variable_get :"@#{name}_stack2"
              score[frame -1] += instance_variable_get :"@#{name}_stack1"
              score[frame -1] += instance_variable_get :"@#{name}_stack2"
              score[frame]    += instance_variable_get :"@#{name}_stack1"
              score[frame]    += instance_variable_get :"@#{name}_stack2"
              instance_variable_set :"@#{name}_stack1", instance_variable_get(:"@#{name}_stack2")
              instance_variable_set :"@#{name}_stack2", nil
            end

            score[frame] += first_p
          rescue
            print $!
            retry
          end
          if !first_p.strike? || last_frame?
            begin
              print "第#{@frame}フレーム: #{name}の２投目: "
              second_p = gets.chomp.to_i
              second_validate first_p, second_p

              # 前投球がストライクかつ現投球がストライクでない時の処理
              if strike?(name)
                score[frame -1] += first_p + second_p
                score[frame]    += first_p + second_p
                instance_variable_set :"@#{name}_stack1", nil
                instance_variable_set :"@#{name}_stack2", nil
                instance_variable_set :"@#{name}_strike_flag", false
              end

              # 現投球がスペアだった時スペアフラグを立てる
              if (first_p + second_p).spare?
                instance_variable_set :"@#{name}_spare_flag", true
              end

              score[frame] += second_p
            rescue
              print $!
              retry
            end
            if last_frame? && (first_p.strike? || (first_p + second_p).spare?)
              begin
                print "第#{@frame}フレーム: #{name}の３投目: "
                third_p = gets.chomp.to_i
                first_validate third_p
                score[frame] += third_p
              rescue
                print $!
                retry
              end
            end
          end
        end
      end
    end
  end

  private

  def set_up
    super
    @members.each { |name| instance_variable_set :"@#{name}_score", Array.bowling_base }
    @frame = 0
  end

  def first_validate(point)
    raise TypeError, "数字で入力してね。\n" if point.is_a? String
    raise InvalidScore, "点数が大きすぎるよ。ズルすんなハゲ！\n" if point > 10
  end

  def second_validate(first_p, second_p)
    first_validate second_p
    unless last_frame? && (first_p.strike? || second_p.spare?)
      raise InvalidScore2, "１投目との合計値が大きすぎるよ。 １投目: #{first_p}\n" if first_p + second_p > 10
    end
  end

  def strike?(name)
    instance_variable_get :"@#{name}_strike_flag"
  end

  def spare?(name)
    instance_variable_get :"@#{name}_spare_flag"
  end

  def last_frame?
    @frame == 10
  end

  def finish
    @members.each do |name|
      p "#{name}のスコア: #{instance_variable_get :"@#{name}_score"}"
    end
  end
end
