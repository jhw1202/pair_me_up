PairMeUp
========

A. Instructions
------------
1 clone this repository to your machine; open up a terminal, paste this code in:

    `git clone https://github.com/jhw1202/pair_me_up.git`
(from searching around, this should work for private repos too, as long as you're added as a collaborator.)

2. Run `bundle install`

3. Run `rake db:migrate` to setup the database.

4. `rake db:seed` to seed the database with sample data (you'll need some data to simulate the pairing).

5. To see the pairing in action, run `rake simulate_pairs`. This will print out 4 weeks worth of pairing (displays id of each member for easy comparison between previous weeks).

B. Design Decisions
-------------------
* My current pairing logic is this:
    1. Generate an array of all possible pairing combinations in a given team.
    2. Remove pairs that occured last week.
    3. Randomly sample pairs, checking everytime to make sure there's no overlap with people that                  have already been picked.
    4. If any of the people picked belong to other teams, blacklist them. Subsequent teams will not consider blacklisted members in their pair picking.

It's probably not the most ideal and I'm sure that there must be a more efficient method to this. But this is what I came up with given my current constraints. I could aid the 'randomness' by looking back more than one week, although I think that could introduce some edge cases, like running out of possible pairs if a team is small and I look too many weeks back (especially if there are a lot of blacklisted members in that team). Teams are always shuffled so that they don't go in the same order to try and offset the blacklisting ie. so a member that belongs to team 1 and 2 doesn't always get paired up in team 1 because 1 always picks pairs first.

* To get things up quickly, I used the heroku scheduler addon. It only has options for daily,hourly or every 10 minutes. The task I'm running is scheduled to run every day at 00:00 utc and my rake task checks if the day is saturday (I believe that converts to Friday, 5pm pdt). If so, it goes through the pairing process and sends out an email notifying the pairs.

* I wasn't sure how much weight you put on styling. I didn't spend a lot of time on styling (borrowed from flat-ui just to get it at an acceptable appearance). Ideally I would have liked to if I had more time.
* I skipped authentication. It probably wouldn't take long, although that would probably depend on how the constraints for

C. Testing
-----------
* `rake db:test:prepare` and then rspec to run tests.

* I'm still very amateur in terms of tdd'ing. I started out testing first, then regressed into bad habits, then went back briefly to tdd'ing. And testing in general still seems difficult. Beyond the basics, I find that it's not an easy call to make to decide what to test and to what extent (sometimes overtesting seems to be frowned upon just as much as underdoing it). By no means is my code fully covered, but I tried to cover my tracks the best I can. RSpec to test my pairing code (which is pretty much all in the models) and  a little bit of Capybara to test that the user can see text and buttons and such.
