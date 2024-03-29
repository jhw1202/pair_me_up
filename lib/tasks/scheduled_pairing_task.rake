desc "Send Emails to team members notifying them of this week's pairs"

task :pick_pairs_send_emails => :environment do
  if DateTime.now.strftime('%A') == "Saturday"
    $blacklist = []

    Team.all.shuffle.each do |team|
      pairs = team.pick_pairs

      pairs.each do |pair|
        Usermailer.notify_pair_email(pair).deliver
      end
    end
  end
end
