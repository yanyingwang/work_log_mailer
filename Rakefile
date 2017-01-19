#!/usr/bin/env ruby


require_relative 'lib/work_log_mailer'


# usage example: $ rake deliver_today

task :sendmail do
  w = WorkLogMailer.new
  w.sendmail
end

task :test_sendmail do
  w = WorkLogMailer.test_new
  w.sendmail
end
