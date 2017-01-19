# WorkLogMailer



## 这个项目的作用是什么呢？

如果你的一个工作日常是写工作记录，并且天天发送邮件，那么这个项目可能就是适合你的。



## 工作流

1.  把每天的工作记录在dropbox上面的一个markdown文件里。
2.  使用qq邮箱发送邮件。



## 配置

需要使用dropbox的api来访问文件：<https://www.dropbox.com/developers/apps>

~~~bash
git@github.com:yanyingwang/work_log_mailer.git   # 克隆本项目到需要发送邮件的服务器或者本地：

cd work_log_mailer

mkdir logs

cat >> lib/config.rb <<EOF
class WorkLogMailer
  def test_env
  @recipients = %w{ test_env@qq.com }
  @cc_recipients = %w{ test_env@gmail.com }
  end

  def env
    @recipients = %w{ somebody1@gmail.com somebody2@gmail.com }
    @cc_recipients = %w{ somebody3@gmail.com somebody4@gmail.com somebody2@gmail.com }
    @worker_name = "你的名字"
    @username = "your QQ mailname"
    @password = "your QQ smtp password"
    @dropbox_access_token = "xxxxxxxxx"
    @dropbox_filepath = "/某某某的工作日志.md"   # dropbox上面可以通过api访问的文件的路径
    @dropbox_filelink = "https://www.dropbox.com/s/xxxxxxxxxxxx/xxxxxxxxxxxxx.md?dl=0"   # 此文件被共享了的url地址
  end
end
EOF
~~~



## 测试

上面配置文件中定义的`test_env`内容可以复写`env`已经定义的变量，然后使用`w = WorkLogMailer.test_new`代替`w = WorkLogMailer.new`来加载测试环境。



## 在ruby console发送邮件

    $ ./bin/console

~~~ruby

w = WorkLogMailer.new

w.file           # 查看参数，非必须执行
w.content        # 查看参数，非必须执行
w.content2sent   # 查看参数，非必须执行

w.sendmail       # 发送邮件
~~~



## 自动任务发送邮件

    $ rake sendmail

    $ rake test_sendmail



## crontab自动任务发送邮件

    $ whenever -i



## 另记：Dropbox上的`某某某的工作日志.md`的内容格式

请使用如下格式记录每天工作日志，请注意时间戳格式：
~~~raw

## 快速链接：
1，xxxxxxxxxxxxx
2，xxxxxxxxxxxxx
3，xxxxxxxxxxxxx

## 待讨论：
1，xxxxxxxxxxxxx
2，xxxxxxxxxxxxx
3，xxxxxxxxxxxxx


## 待做：
1，xxxxxxxxxxxxx
2，xxxxxxxxxxxxx
3，xxxxxxxxxxxxx



## 2017-01-19
1，xxxxxxxxxxxxx
2，xxxxxxxxxxxxx
3，xxxxxxxxxxxxx


## 2017-01-18
1，xxxxxxxxxxxxx
2，xxxxxxxxxxxxx
3，xxxxxxxxxxxxx

......
......
......
~~~



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/work_log_mailer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

