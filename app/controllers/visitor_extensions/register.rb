module VisitorExtensions
  module Register

    def process_register
      register_user
      attr = params[:user]
      attr.merge!({:ip => request.remote_ip})
      redirect_to_with_notice root_path, t('notices.psswd_not_match'), :error if attr[:password_digest] != attr[:confirm_password]
      notice = @user.register(attr)
      if notice
        redirect_to_with_notice root_path, t(notice), :error
      else
        redirect_to_with_notice dd_index_path, t('notices.success_register'), :success
      end
    end

    def create_guest
      register_user
      if @user.new_guest
        redirect_to_with_notice dd_games_path, t('notices.created_guest_successfully') if login_user(@user)
      else
        redirect_to_with_notice root_path, t('notices.cant_create_guest'), :error
      end
    end
  end

end