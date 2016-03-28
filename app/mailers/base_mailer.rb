require 'mandrill'

class BaseMailer < ActionMailer::Base

  def mandrill_send_email(template_name, message)
    template_content = {}
    message[:from_email] = ENV["NO_REPLY_EMAIL"]
    message[:from_name] = "MovieRama"
    message[:subject] = "[MovieRama] #{message[:subject]}"
    message[:subaccount] = "movierama"

    begin
      mandrill_client ||= Mandrill::API.new(ENV["MANDRILL_API_KEY"])
      mandrill_client.messages.send_template(template_name, template_content, message)
    rescue Mandrill::Error => e
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
      raise
    end
  end

end
