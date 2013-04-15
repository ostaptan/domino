module DominoHelper

  def bone_v_class(bone)
    "bone-v bone-v-#{bone.to_s.downcase}"
  end

  def bone_h_class(bone)
    "bone-h bone-h-#{bone.to_s.downcase}"
  end

end
