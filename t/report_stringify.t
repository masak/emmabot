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
    is ~@reports[0], "<blip blop> just started failing on <X Y>. (<X blop> changed.)";
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

    is @reports.elems, 1;
    is ~@reports[0], "blip just started failing on X, and blop just started failing on Y. (<X blop> changed.)";
}

done;
