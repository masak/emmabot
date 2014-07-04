# emmabot

Checks if modules failed and notifies the community.

## Stories

Just thinking out loud here.

* A module turns out to fail today. It didn't fail yesterday. The bot reacts
  by telling the channel.

* Many modules fail today that didn't fail yesterday. The bot tells the
  channel, but without flooding the channel; it links to a text file with a
  list of failing modules.

* A single module or a group of modules that *still* fail for the Nth day in
  a row should also be flagged up, but with separate messages.

* Optionally, the bot might want to keep track of a module's previous failure
  history, at least (say) 100 days back, and (if there was a previous period of
  failures for that module) also report the number of previous failures.

* Important: the bot shouldn't feel spammy. It's OK for IRC lines to be
  longish, but there shouldn't be more than two spontaneous utterances per day,
  and preferably only one.

* When asked directly, the bot can give full information about the current
  status of a module.
