use v6;
use Test;

use Emmabot;
use Emmabot::History;

sub modules(@new, @ongoing) {
    return class {
        method new_failures { map { hash('module' => $_, 'backend' => <X>).item }, @new }
        method ongoing_failures { map { hash('module' => $_).item }, @ongoing }
        method changed_repos { <X> }
    };
}

{
    my $hist = Emmabot::History.new();

    my $channel = class {method report($r) {}};
    my $modules = modules([<blip blop>], [<X>]);
    my $bot = Emmabot.new(:$modules,:$channel);
    $bot.do_daily_report();
    $hist.add($bot);

    is $hist.streak('blop'), 1, "streak after one run";
}

done;
