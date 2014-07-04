use v6;
use Emmabot::FailureReport;

class Emmabot;

has $.modules;
has $.channel;

method do_daily_report {
    if $.modules.new_failures().list -> @modules {
        $.channel.report(Emmabot::FailureReport.new(:@modules, :type<new>));
    }

    if $.modules.ongoing_failures().list -> @modules {
        $.channel.report(Emmabot::FailureReport.new(:@modules, :type<ongoing>));
    }
}
