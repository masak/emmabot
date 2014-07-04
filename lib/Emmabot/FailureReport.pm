use v6;

class Emmabot::FailureReport;

has @.modules;
has $.type;

method summarized {
  return @.modules > 2 ??
    "{+@.modules} failed" !!
    "@.modules failed";
}
