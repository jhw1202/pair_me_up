class Usermailer < ActionMailer::Base
  default from: "pairmeup@notarealaddress.com"

  def notify_pair_email(pair = nil)
    if pair == nil
      mail(:to => "jhw1202@gmail.com", :subject => "Testing!")
    else
      @member_1 = Member.find(pair[0])
      @member_2 = Member.find(pair[1])
      mail(:to => [@member_1.email, @member_2.email], :subject => "Time for some bonding!")
    end
  end
end
