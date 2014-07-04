use v6;
use Test;

use Emmabot::FailureReport;

# Two changes, same backends
{
    my $report = Emmabot::FailureReport.new(
        :failures(
            { :package<blip>, :backend<X Y> },
            { :package<blop>, :backend<X Y>, :changed }
        ),
        :changed_repos<X>,
        :type<new>
    );

    is ~$report, "<blip blop> just started failing on <X Y>. (<X blop> changed.)";
}

# Two changes, different backends
{
    my $report = Emmabot::FailureReport.new(
        :failures(
            { :package<blip>, :backend<X> },
            { :package<blop>, :backend<Y>, :changed }
        ),
        :changed_repos<X>,
        :type<new>
    );

    is ~$report, "blip just started failing on X, and blop just started failing on Y. (<X blop> changed.)";
}

done;
