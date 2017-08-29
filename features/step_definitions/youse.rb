require_relative 'methods'

include YouseMethods

Given(/^The user is on the youse site$/) do
  goto_youse_site
  validate_homepage
end

When(/^The user goes to the registration page$/) do
  goto_login_page
  sleep 5
  @browser.a(class: %w(button button--secondary), index: 0).click
  sleep 2
end

And(/^Enters the user information$/) do
  @name="test"
  @email="test_#{Time.now.strftime("%d_%H_%M_%S")}@hotmail.com"
  @pass="test1234"
  @browser.input(id: "user_name").send_keys @name
  @browser.input(id: "user_email").send_keys @email
  @browser.input(id: "user_password").send_keys @pass
  @browser.input(id: "user_password_confirmation").send_keys @pass
end

And(/^Submits the form$/) do
  click_submit
  sleep 5
end

Then(/^The user should get a success registration message$/) do
  @sign_msg="Bem vindo! Você realizou seu registro com sucesso."
  validate_msg
end

When(/^The user goes to the login page$/) do
  goto_login_page
end


And(/^Enters the credential$/) do
  @email="test@hotmail.com"
  @pass="test1234"
  @sign_msg="Login efetuado com sucesso."
  @browser.input(id: "email").send_keys @email
  click_submit
  @browser.input(id: "user_password").send_keys @pass
  click_submit
end

Then(/^The user should see a success login message$/) do
  validate_msg
end

And(/^Is logged on the site$/) do
  goto_login_page
  @email="test@hotmail.com"
  @pass="test1234"
  @sign_msg="Login efetuado com sucesso."
  @browser.input(id: "email").send_keys @email
  click_submit
  @browser.input(id: "user_password").send_keys @pass
  click_submit
  validate_msg
end

When(/^The user logs out$/) do
  @browser.a(class: %w(account-header__account-link account-header__account-with-sub-menu)).hover
  @browser.a(id: "track_logout").click
end


Then(/^The user should be on the home page$/) do
  validate_homepage
end

When(/^The user selects contact online for car insurance$/) do
  @sign_msg="Oi, a gente quer conhecer você melhor, é rapidinho"
  @browser.a(class: %w(button-rounded button-rounded__orange bt-quotation)).click
  expect(@browser.h2(class: %w(h2 section-vertical-spacing)).text).to include @sign_msg
end

And(/^Enters the name "([^"]*)"$/) do |name|
  @browser.input(id: "auto_order_flow_lead_person_data_lead_person_attributes_name").send_keys name
end

And(/^Enters the phone "([^"]*)"$/) do |phone|
  @browser.input(id: "auto_order_flow_lead_person_data_lead_person_attributes_phone").send_keys phone
end

And(/^Enters the email "([^"]*)"$/) do |email|
  @browser.input(id: "auto_order_flow_lead_person_data_lead_person_attributes_email").send_keys email
end

And(/^Submits the information$/) do
  @browser.input(class: %w(button button--primary)).click
end


And(/^Sets the car information$/) do
  @brand_size= @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_make").options.size
  @rand_brand= rand(1..@brand_size-1)
  @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_make").option(index: @rand_brand).select
  form_sleep

  @model_size= @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_model").options.size
  @rand_model= rand(1..@model_size-1)
  @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_model").option(index: @rand_model).select
  form_sleep

  @year_size= @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_year").options.size
  @rand_year= rand(1..@model_size-1)
  @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_year").option(index: @rand_year).select
  form_sleep

  @version_size= @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_version").options.size
  @rand_version= rand(1..@model_size-1)
  @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_version").option(index: @rand_version).select
  form_sleep
  if @browser.h4(class: %w(modal__title--error message)).exists?
    puts "No insurance for the selected car"
    @result= "No insurance"
  else
    @km_size= @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_brand_new").options.size
    @rand_km= rand(1..@model_size-1)
    @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_brand_new").option(index: @rand_km).select
    form_sleep
    @use_size= @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_usage").options.size
    @rand_use= rand(1..@model_size-1)
    @browser.select(id: "auto_order_flow_pricing_requirements_vehicle_attributes_usage").option(index: @rand_use).select
    form_sleep
    # @zip= rand(10000000..99999999)
    @zip= "01001-000"
    @browser.input(id: "auto_order_flow_pricing_requirements_vehicle_attributes_address_attributes_zipcode").send_keys @zip
    form_sleep
    @gender_size= @browser.select(id: "auto_order_flow_pricing_requirements_insured_person_attributes_gender").options.size
    @rand_gender= rand(1..@model_size-1)
    @browser.select(id: "auto_order_flow_pricing_requirements_insured_person_attributes_gender").option(index: @rand_gender).select
    form_sleep
    @day= rand(01..30)
    @month= rand(01..12)
    @year= rand(1930..1999)
    @browser.input(id:"auto_order_flow_pricing_requirements_insured_person_attributes_date_of_birth").send_keys @day+@month+@year
    form_sleep
    @status_size= @browser.select(id: "auto_order_flow_pricing_requirements_insured_person_attributes_marital_status").options.size
    @rand_status= rand(1..@model_size-1)
    @browser.select(id: "auto_order_flow_pricing_requirements_insured_person_attributes_marital_status").option(index: @rand_status).select
    form_sleep
    @person_size= @browser.select(id: "auto_order_flow_pricing_requirements_driver_attributes_same_as_insured_person").options.size
    @rand_person= rand(1..@model_size-1)
    @browser.select(id: "auto_order_flow_pricing_requirements_driver_attributes_same_as_insured_person").option(index: @rand_person).select
    form_sleep
    @driver_size= @browser.select(id: "auto_order_flow_pricing_requirements_driver_attributes_young_driver").options.size
    @rand_driver= rand(1..@model_size-1)
    @browser.select(id: "auto_order_flow_pricing_requirements_driver_attributes_young_driver").option(index: @rand_driver).select
    form_sleep
    @claim_size= @browser.select(id: "auto_order_flow_pricing_requirements_driver_attributes_years_since_last_claim").options.size
    @rand_claim= rand(1..@model_size-1)
    @browser.select(id: "auto_order_flow_pricing_requirements_driver_attributes_years_since_last_claim").option(index: @rand_claim).select
    form_sleep
    @browser.input(class: %w(button button--primary)).click
    expect(@browser.h2(class: %w(h2)).text).to include "A medida certa é você quem escolhe."
  end

end

Then(/^The user selects the wanted plan$/) do
  if @result == "No insurance"
    puts "No insurance for the selected car"
  else
    @rand_plan= rand(0..2)
    @success_msg="Essa é a parte mais legal:"
    @browser.a(class: %w(button button-highlight button--full-width preformatted-coverages__button), index: @rand_plan).click
    puts @browser.p(class: %w(t1)).text
    expect(@browser.p(class: %w(h2)).text).to include @success_msg
  end
end

And(/^Selects additional insurance$/) do
  if @result == "No insurance"
    puts "No insurance for the selected car"
  else
    @brower.input(class: %w(button button--primary button--centered)).click
    @brower.input(class: %w(button button--primary button--centered)).click
  end
end