use v6;
use Emmabot::Report;

class Emmabot;

has $.modules;
has $.channel;

method do_daily_report {
    my @changed_repos = $.modules.changed_repos().list;

    if $.modules.new_failures().list -> @failures {
        $.channel.report(Emmabot::Report.new(:@failures, :@changed_repos, :type<new>));
    }

    if $.modules.ongoing_failures().list -> @failures {
        my $streak = max @failures»<streak>;
        $.channel.report(Emmabot::Report.new(:@failures, :type<ongoing>, :$streak));
    }
}
