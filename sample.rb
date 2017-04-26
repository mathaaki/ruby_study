module DateConvert
  def convert(date)
    "#{date[0, 4]}年#{date[4, 2]}月#{date[6, 2]}日"
  end
end

class Cat
  attr_accessor :birthday
  include DateConvert

  def initialize(birthday)
    @birthday = convert birthday
  end

  def action
    "ニャー"
  end
end

class Machine
  attr_accessor :production_date
  include DateConvert

  def initialize(production_date)
    @production_date = convert production_date
  end

  def action
    "うぃーん"
  end
end

tama = Cat.new("20100809")
p tama.birthday

pc = Machine.new("20160101")
p pc.production_date
