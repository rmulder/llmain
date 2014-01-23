if defined?(AppConf).nil?
  require File.dirname(__FILE__) + '/lib/app_config'

  c = AppConfig.new
  c.use_file!("#{Rails.root.to_s}/config/config.yml")
  c.use_file!("#{Rails.root.to_s}/config/config.local.yml")
  c.use_section!(Rails.env)
  ::AppConf = c
end