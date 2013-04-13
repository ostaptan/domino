# -*- encoding : utf-8 -*-

class DominoGame::Bone

  attr_accessor :n1, :n2

  def initialize(n1, n2)
    @n1, @n2 = n1, n2
    [@n1, @n2]
  end

  def to_s
    "#{@n1}-#{@n2}"
  end

end