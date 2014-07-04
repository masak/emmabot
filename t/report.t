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

    is @reports.elems, 1, "one report:";
    is @reports[0].modules, <blip blop>, "  ...with the right modules";
    is @reports[0].type, "new", "  ...of the right type";
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

    is @reports.elems, 1, "one report:";
    is @reports[0].modules, "foo", "  ...with the right modules";
    is @reports[0].type, "ongoing", "  ...of the right type";
}

{
    my $modules = class {
        method new_failures {
            return "ohnoes01" .. "ohnoes20";
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

    is @reports.elems, 1, "one report:";
    is +@reports[0].modules, 20, "  ...with the right number of modules";
    is @reports[0].type, "new", "  ...of the right type";
    ok @reports[0].summarized, "  ...and it's summarized";
}

{
    my $modules = class {
        method new_failures {
            return "ohnoes01" .. "ohnoes04";
        }
        method ongoing_failures {
            return "æsj01";
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

    is @reports.elems, 2, "two reports:";
    is @reports[0].type, "new", "  ...one about new failures";
    is @reports[1].type, "ongoing", "  ...one about ongoing failures";
}

{
    my $modules = class {
        method new_failures {
            return "macedonian_consultants";
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

    is @reports.elems, 1, "one report:";
    nok @reports[0].summarized, "  ...and it's not summarized";
}

done;
