module DominoHelper

  def bone_v_class(bone)
    "bone-v bone-v-#{bone.to_s.downcase}"
  end

  def bone_h_class(bone)
    "bone-h bone-h-#{bone.to_s.downcase}"
  end

  def bone_v_class_hidden
    "bone-v bone-v-hidden"
  end

  def bone_h_class_hidden
    "bone-h bone-h-hidden"
  end

  def battle_bone_v_class(bone)
    "battle bone-v bone-v-#{bone.to_s.downcase}"
  end

  def battle_bone_h_class(bone)
    "battle bone-h bone-h-#{bone.to_s.downcase}"
  end

end
