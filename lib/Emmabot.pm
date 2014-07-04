use v6;
use Emmabot::FailureReport;

class Emmabot;

has $.modules;
has $.channel;

method do_daily_report {
    for $.modules.new_failures() -> $module {
        $.channel.report(Emmabot::FailureReport.new(:$module, :type<new>));
    }

    for $.modules.ongoing_failures() -> $module {
        $.channel.report(Emmabot::FailureReport.new(:$module, :type<ongoing>));
    }
}
