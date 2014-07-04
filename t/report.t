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

    is @reports.elems, 1;
    is @reports[0].modules, <blip blop>;
    is @reports[0].type, "new";
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
    is @reports[0].modules, "foo";
    is @reports[0].type, "ongoing";
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

    my @log;
    my $log = class {
        method log($level,$fmt,*@rest) {
            @log.push(sprintf("$level> $fmt",@rest));
        }
    };

    my $bot = Emmabot.new(:$modules, :$channel, :$log);
    $bot.do_daily_report();

    is @log.elems, 2;
}

done;
