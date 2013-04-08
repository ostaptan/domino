class Domino::Market

  def initialize
    @bones = []
    (0..6).each do |num1|
      (0..6).each do |num2|
        @bones << Bone.new(num1, num2)
      end
    end
    @bones.shuffle!
  end

end