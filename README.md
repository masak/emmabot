# emmabot

Checks if modules failed and notifies the community.

## Stories

Just thinking out loud here.

* A module turns out to fail today. It didn't fail yesterday. The bot reacts
  by **telling the channel**.

* For each such new failure, as part of the failure message, the bot should
  also **report what** since yesterday **has changed**: the module, Rakudo,
  NQP, the underlying VM, or any combination of these.

* Also as part of the failure message, the backend(s) should be reported.

* Many modules fail today that didn't fail yesterday. The bot tells the
  channel, but without flooding the channel; it **links to a text file** with a
  list of failing modules.

* A single module or a group of modules that *still* fail for the Nth day in
  a row should also be flagged up, but with **separate messages**.

* Optionally, the bot might want to keep track of a module's previous failure
  history, at least (say) 100 days back, and (if there was a previous period of
  failures for that module) also **report the number of previous failures**.

* Important: the bot **shouldn't feel spammy**. It's OK for IRC lines to be
  longish, but there shouldn't be more than two spontaneous utterances per day,
  and preferably only one.

* When asked directly, the bot can **give full information** about the current
  status of a module.

* Very low-priority, but still possibly relevant in the future: if/when we
  expand beyond just Rakudo Star modules, the bot should also include
  information about whether or not the module is a Rakudo Star module.
