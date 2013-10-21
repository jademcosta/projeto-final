class UserMailer < ActionMailer::Base
    default :from => "no-reply@jademcosta.com"
  
    def feed_news(user, subject, news)
        @user = user
        #attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
        @news = news
        mail(:to => "#{user.name} <#{user.email}>", :subject => subject)
    end
end
