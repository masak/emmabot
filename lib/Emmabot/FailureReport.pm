use v6;

class Emmabot::FailureReport;

constant SUMMARIZE_AMOUNT = 5;

has @.modules;
has $.type;

method summarized {
    return +@.modules > SUMMARIZE_AMOUNT;
}
