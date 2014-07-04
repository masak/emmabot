use v6;
use Test;

use Emmabot::Report;

# Two changes, same backends
{
    my $report = Emmabot::Report.new(
        :failures(
            { :module<blip>, :backend<X Y> },
            { :module<blop>, :backend<X Y>, :changed },
        ),
        :changed_repos<X>,
        :type<new>,
    );

    is ~$report,
        "<blip blop> just started failing on <X Y>. (<X blop> changed.)",
        "two changes, same backends";
}

# Two changes, different backends
{
    my $report = Emmabot::Report.new(
        :failures(
            { :module<blip>, :backend<X> },
            { :module<blop>, :backend<Y>, :changed },
        ),
        :changed_repos<X>,
        :type<new>,
    );

    is ~$report,
        "blip just started failing on X, and blop just started failing on Y. (<X blop> changed.)",
        "two changes, different backends";
}

{
    my $report = Emmabot::Report.new(
        :failures(
            { :module<blip>, :backend<X Y> },
            { :module<blop>, :backend<X Y>, :changed },
        ),
        :type<ongoing>,
    );

    is ~$report,
        "<blip blop> are still failing on <X Y>.",
        "two modules that still fail on two backends";
}

{
    my $report = Emmabot::Report.new(
        :failures(
            { :module<z01>, :backend<X Y> },
            { :module<z02>, :backend<X Y> },
            { :module<z03>, :backend<X Y> },
            { :module<z04>, :backend<X Y> },
            { :module<z05>, :backend<X Y> },
            { :module<z06>, :backend<X Y> },
        ),
        :type<ongoing>
    );

    is ~$report,
        "6 modules are still failing on <X Y>.",
        "enough modules failing for summarization to kick in";
}

done;
