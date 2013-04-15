module VisitorExtensions
  module Register

    def self.included(c)
      c.before_filter :register_user, :only => [:register, :process_register]
    end

    def register
      @user = User.new
    end

    def process_register
      attr = params[:user]
      attr.add({:ip => request.remote_ip})
      redirect_to_with_notice :register, t(:psswd_not_match), :error if attr[:password_digest] != attr[:confirm_password]
      notice = @user.register(attr)
      if notice
        redirect_to_with_notice root_path, t(notice), :error
      else
        redirect_to_with_notice domino_index_path, t(:success_register), :success
      end

    end

    protected

    def register_user
      @user = User.new
    end
  end
end