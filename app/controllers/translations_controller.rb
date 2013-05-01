class TranslationsController < ApplicationController
  layout 'moderator'

  before_filter :authorize

  def index
    @translations = TRANSLATION_STORE
  end

  def create
    I18n.backend.store_translations(params[:locale], {params[:key] => params[:value]}, :escape => false)
    redirect_to translations_url, :notice => "Added translation"
  end

  def authorize
    redirect_to_with_notice root_url, t('notices.must_be_moderator'), :error unless current_user.moderator?
  end

end
