module Domino::UsersHelper

  def avatar_tag(user, small = false)
    size = small ? "70x70" :"200x200"
    link_to image_tag("avatars/#{user.avatar}", :size => size), domino_user_path(user.id)
  end

end
