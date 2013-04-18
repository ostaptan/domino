# -*- encoding : utf-8 -*-

class DominoGame::AbstractBone

  attr_accessor :n1, :n2

  def initialize(n1, n2)
    @n1, @n2 = n1, n2
    [@n1, @n2]
  end

  def to_s
    "#{@n1}-#{@n2}"
  end

  def doublebone?
    @n1 == @n2 && not_empty?
  end

  def not_empty?
    @n1 != @n2 || @n1 != 0
  end

  def <=>(other)
    @n1 <=> other.n1
  end

  def match?(other)
    @n1 == other.n1 || @n1 == other.n2 || @n2 == other.n1 || @n2 == other.n2
  end

end