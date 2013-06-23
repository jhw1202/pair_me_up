desc "Simulate a few weeks worth of pairing"

task :simulate_pairs => :environment do
  Pairing.destroy_all  # clean state for simulating environment
  $blacklist = []

  puts "#" * 20
  puts "Week 1 pairs"

  Team.all.shuffle.each do |team|
    pairs = team.pick_pairs
    puts "Pair for team #{team.name}"
    p pairs
  end

  Pairing.all.each do |pair|
    pair.update_attribute(:created_at, (DateTime.now - 1.week).beginning_of_day)
  end
  puts "#" * 20
  puts ""


  puts "#" * 20
  puts "Week 2 pairs"

  $blacklist = []

  Team.all.shuffle.each do |team|
    pairs = team.pick_pairs
    puts "Pair for team #{team.name}"
    p pairs
  end

  Pairing.all.each do |pair|
    if pair.created_at.beginning_of_day == DateTime.now.beginning_of_day
      pair.update_attribute(:created_at, (DateTime.now - 1.week))
    else
      pair.update_attribute(:created_at, (DateTime.now - 4.week))
    end
  end
  puts "#" * 20
  puts ""

  puts "#" * 20
  puts "Week 3 Pairs"

  $blacklist = []

  Team.all.shuffle.each do |team|
    pairs = team.pick_pairs
    puts "Pair for team #{team.name}"
    p pairs
  end

  Pairing.all.each do |pair|
    if pair.created_at.beginning_of_day == DateTime.now.beginning_of_day
      pair.update_attribute(:created_at, (DateTime.now - 1.week))
    else
      pair.update_attribute(:created_at, (DateTime.now - 4.week))
    end
  end
  puts "#" * 20
  puts ""

  puts "#" * 20
  puts "Week 4 Pairs"

  $blacklist = []

  Team.all.shuffle.each do |team|
    pairs = team.pick_pairs
    puts "Pair for team #{team.name}"
    p pairs
  end

  Pairing.all.each do |pair|
    if pair.created_at.beginning_of_day == DateTime.now.beginning_of_day
      pair.update_attribute(:created_at, (DateTime.now - 1.week))
    else
      pair.update_attribute(:created_at, (DateTime.now - 4.week))
    end
  end
  puts "#" * 20

end
