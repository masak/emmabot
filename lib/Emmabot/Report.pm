use v6;

class Emmabot::Report;

constant SUMMARIZE_AMOUNT = 5;

has @.failures;
has @.changed_repos;
has $.type;

method summarized {
    return +@.modules > SUMMARIZE_AMOUNT;
}

method Str {
    my %backend_groups;
    my @changed = @.changed_repos;

    for @.failures -> $failure {
        my $module = $failure<package>;
        my $backend_group = $failure<backend>.join(" ");
        if $failure<backend>.list > 1 {
            $backend_group = "<$backend_group>";
        }
        %backend_groups{$backend_group}.push($module);
        if $failure<changed> {
            push @changed, $module;
        }
    }

    my @backend_groups = %backend_groups.keys.sort;

    my $message = "";
    for @backend_groups.kv -> $i, $backend_group {
        my $first = $i == 0;
        my $last = $i == @backend_groups - 1;
        my $sep = $first ?? "" !! $last ?? ", and " !! ", ";
        my $modules = %backend_groups{$backend_group}.join(" ");
        if %backend_groups{$backend_group}.list > 1 {
            $modules = "<$modules>";
        }
        $message ~= $sep ~ "$modules just started failing on $backend_group";
    }
    $message ~= ".";

    if @changed {
        my $changed = @changed == 1 ?? @changed[0] !! "<@changed.join(' ')>";
        $message ~= " ($changed changed.)";
    }
    return $message;
}
