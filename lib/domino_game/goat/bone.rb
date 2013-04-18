class DominoGame::Goat::Bone < DominoGame::AbstractBone

  attr_accessor :next
  attr_reader :previous

  def initialize(n1, n2)
    super n1, n2
    @previous = nil
    @next = nil
  end

  def get_next_bone
    @next
  end

  def set_next_bone(bone)
    @next = bone
  end

  def get_previous_bone
    @previous
  end


  def self.from_s s
    nums = s.split('-')
    DominoGame::Goat::Bone.new(nums.first, nums.last)
  end

end
