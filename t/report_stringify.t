use v6;
use Test;

use Emmabot;


# Two changes, same backends
{
    my $modules = class {
        method new_failures {
            return { :package<blip>, :backend<X Y> }, { :package<blop>, :backend<X Y>, :changed };
        }
        method ongoing_failures {
        }
        method changed_repos {
            return <X>;
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
    is ~ @reports[1], "blib and blop have started failing on <X Y>, (<X blop> have changed)";
}

# Two changes, different backends
{
    my $modules = class {
        method new_failures {
            return { :package<blip>, :backend<X> }, { :package<blop>, :backend<Y>, :changed };
        }
        method ongoing_failures {
        }
        method changed_repos {
            return <X>;
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
    is ~ @reports[1], "blib has started failing on <X>, (<X> have changed)";
    is ~ @reports[2], "blop have started failing on <Y>, (<blop> have changed)";
}

done;
