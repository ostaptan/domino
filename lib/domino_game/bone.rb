class Domino::Bone

  def initialise(n1, n2)
    @n1, @n2 = n1, n2
    [@n1, @n2]
  end

  def to_s
    "#{self.n1}_#{self.n2}.png"
  end

end