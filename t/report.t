use v6;
use Test;

use Emmabot;

{
    my $modules = class {
        method new_failures {
            return "blip", "blop";
        }
    };

    my @reports;

    my $channel = class {
        method report($r) {
            push @reports, $r;
        }
    };

    my $bot = Emmabot.new(:$modules, :$channel);
    $bot.do_daily_report();

    is @reports.elems, 2;
    is @reports[0].module, "blip";
    is @reports[1].module, "blop";
}

done;
