use v6;
use Emmabot::FailureReport;

class Emmabot;

has $.modules;

has $.channel;

method do_daily_report {
    for $.modules.new_failures() -> $failure {
        $.channel.report(Emmabot::FailureReport.new(module => $failure));
    }
}
