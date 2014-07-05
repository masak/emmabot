use v6;
use Test;

use Emmabot;

sub modules(@new, @ongoing) {
    return class {
        method new_failures { @new }
        method ongoing_failures { @ongoing }
        method changed_repos { <X> }
    };
}

{
    my $modules = modules([
        { :module<blip>, :backend<X> },
        { :module<blop>, :backend<Y> },
    ], []);

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
    my $modules = modules([
    ], [
        { :module<foo> },
    ]);

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
    my $modules = modules([
        map { hash("module" => $_, "backend" => "X").item },
            "ohnoes01" .. "ohnoes20"
    ], []);

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
    my $modules = modules([
        map { hash("module" => $_, "backend" => "X").item },
            "ohnoes01" .. "ohnoes20"
    ], [
        { :module<æsj01> },
    ]);

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
    my $modules = modules([
        { :module<macedonian_consultants>, :backend<X> },
    ], []);

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
