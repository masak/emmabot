use v6;
use Emmabot::FailureReport;

class Emmabot;

has $.modules;
has $.channel;
has $.log = class { method log($, $, *@) {} };

method do_daily_report {
    if $.modules.new_failures().list -> @modules {
        $.channel.report(Emmabot::FailureReport.new(:@modules, :type<new>));
        $.log.log(0, 0);
    }

    if $.modules.ongoing_failures().list -> @modules {
        $.channel.report(Emmabot::FailureReport.new(:@modules, :type<ongoing>));
        $.log.log(0, 0);
    }
}
