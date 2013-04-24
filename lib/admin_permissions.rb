class AdminPermissions

  PERMISSION_SUPPORT = :support # Може тільки заходити в Поддержка пользователей/модераторов, в Пользователи не має доступу до Зайти под ним и Дать бонус, і може зайти в конфігурації та историю вопросов
  PERMISSION_BONUS = :bonus # mozhe davaty bonusy
  PERMISSION_MODER = :moder # може призначати модераторів як на дешборді(форумі) так і в грі
  PERMISSION_NEWS = :news # може створювати новини
  PERMISSION_FORUM = :forum # має доступ до модерації форума з адмінки
  PERMISSION_FAQ = :faq # може створювати новини

  PERMISSION_EVENT = :events # може запускати події
  PERMISSION_REPORT = :report # може переглядати звіти
  PERMISSION_POLLS = :poll
  PERMISSION_PROD_REPORT = :prod_report # може переглядати звіт продуктивності адмінів
  PERMISSION_PAYMENTS = :payments

  PERMISSION_GEO = :geo # може переглядати і добавляти міста/регіони/країни, може переміщати юзерів з міста в місто
  PERMISSION_STAT_REPORTS = :stats # статистичні звіти
  PERMISSION_CHANGE_NAME = :name # змінювати імя користувача
end

