Rails.application.configure do
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: Settings.smtp_host,
    port: Settings.smtp_port,
    user_name: Settings.smtp_user_name,
    password: Settings.smtp_password
  }
end
