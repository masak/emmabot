use v6;
use Test;

use Emmabot;

sub modules(@new, @ongoing) {
    return class {
        method new_failures { map { hash('module', $_, 'backend', <X>).item }, @new }
        method ongoing_failures { map { hash('module', $_).item }, @ongoing }
        method changed_repos { <X> }
    };
}

{
    my $modules = modules([<blip blop>],
                          [<X>]);
    my @reports;

    my $channel = class {
        method report($r) {
            push @reports, $r;
        }
    };

    my $bot = Emmabot.new(:$modules, :$channel);
    $bot.do_daily_report();

    is @reports.elems, 2, "one report:";
    is @reports[0].modules, <blip blop>, "  ...with the right modules";
    is @reports[0].type, "new", "  ...of the right type";
}

{
    my $modules = modules([],
                          [<foo>]);

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
    my $modules = modules(["ohnoes01" .. "ohnoes20" ],
                          []);

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
    my $modules = modules([ "ohnoes01" .. "ohnoes04" ],
                          [ <æsj01> ]);

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
    my $modules = modules([ :module<macedonian_consultants>, :backend<X> ],
                          []);

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
