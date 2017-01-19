require 'dropbox'
require 'open-uri'
require 'pony'
require 'active_support/all'
require "work_log_mailer/version"
require 'config' if File.exist?(File.expand_path(File.dirname(File.dirname(__FILE__))) + '/lib/config.rb')


class WorkLogMailer
  def initialize
    ins_var
    @dropbox ||= Dropbox::Client.new(@dropbox_access_token)
  end

  def subject
    "工作日志_#{@worker_name}_#{Date.today.to_s}"
  end

  def pull
    @file, @body = @dropbox.download("#{@dropbox_filepath}")
  end

  def file
    @file ||= pull.first
  end
  def body
    @body ||= pull.second
  end

  def today_string
    Date.today.to_s
  end

  def has_written_today?
    content.match today_string
  end

  def content
    body.to_s.force_encoding('UTF-8')
  end

  def footer_lines
    [ "......\n",
      "......\n",
      "......\n",
      "更多内容请查看以下链接：\n",
      "#{@dropbox_filelink} \n",
      "\n",
      "\n" ]
  end

  def content2sent
    return nil unless has_written_today?
    new_content = content.gsub(today_string, today_string + "（今日）")
    (new_content.lines.take(50) + footer_lines).join("")
  end

  def sendmail
    return "no need to sendmail, scince nothing has changed" unless content2sent
    Pony.mail({ :from => @username + "@qq.com",
                :to => @recipients,
                :cc => @cc_recipients,
                :via => :smtp,
                :subject => subject,
                :body => content2sent,
                :via_options => { :address        => 'smtp.qq.com',
                                  :port           => '25',
                                  :user_name      => @username,
                                  :password       => @password,
                                  :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
                                  :domain         => "localhost.localdomain" } })
  end
end
