module Admin
  class UsersController < AdminController

    def authorize_access
      super && current_user.is_super_admin?
    end

    def index

    end

    def show

    end

    def create

    end

    def new

    end

    def edit

    end

    def update

    end

    def update_settings(user, params)
      user.setting_set_permission AdminPermissions::PERMISSION_NEWS, !params[:permission_news].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_POLLS, !params[:permission_polls].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_FORUM, !params[:permission_forum].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_SUPPORT, !params[:permission_support].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_BONUS, !params[:permission_bonus].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_MODER, !params[:permission_moder].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_FAQ, !params[:permission_faq].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_EVENT, !params[:permission_event].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_REPORT, !params[:permission_report].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_PROD_REPORT, !params[:permission_prod_report].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_PAYMENTS, !params[:permission_payments].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_STAT_REPORTS, !params[:permission_stat_reports].blank?
      user.setting_set_permission AdminPermissions::PERMISSION_CHANGE_NAME, !params[:permission_change_name].blank?
    end

  end
end