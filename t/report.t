use v6;
use Test;

use Emmabot;

{
    my $modules = class {
        method new_failures {
            return "blip", "blop";
        }
        method ongoing_failures {
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

    is @reports.elems, 3;
    is @reports[0].module, "blip";
    is @reports[0].type, "new";
    is @reports[1].module, "blop";
    is @reports[1].type, "new";
}

{
    my $modules = class {
        method new_failures {
        }
        method ongoing_failures {
            return "foo";
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

    is @reports.elems, 1;
    is @reports[0].module, "foo";
    is @reports[0].type, "ongoing";
}

done;
