module Domino::UsersHelper

  def avatar_tag(user, small = false)
    size = small ? "70x70" :"200x200"
    if user.from_facebook?
      link_to image_tag(user.avatar), domino_user_path(user.id)
    else
      link_to image_tag("avatars/#{user.avatar}", :size => size), domino_user_path(user.id)
    end
  end

end
