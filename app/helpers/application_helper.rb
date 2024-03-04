module ApplicationHelper

  def locale
    I18n.locale == :en ? "Inglês Americano" : "Português do Brasil"
  end
  def date_br(date_us)
    date_us.strftime("%d/%m/%y")
  end
end
