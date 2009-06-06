class ClearanceMailer < ActionMailer::Base

  def self.config_file
    File.join(RAILS_ROOT, 'config', 'clearance.yml')
  end

  def self.config
    YAML.load(File.read(config_file)).with_indifferent_access[RAILS_ENV]
  end

  def config
    self.class.config
  end

  default_url_options[:host] = config[:host]

  def change_password(user)
    from       config[:do_not_reply]
    recipients user.email
    subject    I18n.t(:change_password,
                      :scope   => [:clearance, :models, :clearance_mailer],
                      :default => "Change your password")
    body       :user => user
  end

  def confirmation(user)
    from       config[:do_not_reply]
    recipients user.email
    subject    I18n.t(:confirmation,
                      :scope   => [:clearance, :models, :clearance_mailer],
                      :default => "Account confirmation")
    body      :user => user
  end

end
