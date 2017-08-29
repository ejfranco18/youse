module YouseMethods
  def goto_youse_site
    @browser = Watir::Browser.new :chrome
    @browser.goto 'http://www.youse.com.br'
  end
  def validate_homepage
    if not @browser.section(class: "video-banner").exist?
      fail
    end
  end
  def goto_login_page
    @browser.a(id: "header-link__minha-conta").click
    expect(@browser.h2(class: %w(hl2)).text).to include "Faça seu login para acessar sua conta Youse."
  end
  def click_submit
    @browser.input(class: %w(button button-highlight button--centered)).click
  end
  def validate_msg
    expect(@browser.div(class: %w(flash-message__text)).text).to include @sign_msg
  end
  def form_sleep
    sleep 3
  end
end