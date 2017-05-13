use strict;
use warnings;
use v5.10;
use FindBin;
use lib "$FindBin::Bin/../lib";

use CharacterIdentifier;
use Rude;

my $ci = CharacterIdentifier->new();
my $rude = Rude->new();

$rude->add_rule([$ci, 'is_rebel'], [$ci, 'is_prisoner'], \&found);
$rude->add_rule([$ci, 'is_prisoner'], [$ci, 'leia'], [$ci, 'is_pilot']);
$rude->add_rule([$ci, 'is_pilot'], [$ci, 'is_hairy'], [$ci, 'is_from_tatooine']);
$rude->add_rule([$ci, 'is_hairy'], \&found, \&found);
$rude->add_rule([$ci, 'is_from_tatooine'], [$ci, 'is_old'], \&found);
$rude->add_rule([$ci, 'is_old'], \&found, \&found);
$rude->add_rule([$ci, 'leia'], \&found, \&found);
$rude->add_rule(\&found, undef, undef);

sub found { return -1; }

say '======================================';
say 'Rude.pl example';
say '======================================';
say 'Generating random results...';

my $counter = 0;
while (1) {
    $counter++;
    if ($counter == 11) { last; }
    say "--- $counter ----------";

    $rude->check([$ci, 'is_rebel']);
    say 'The result is: ' . $ci->{'result'};
    say 'And the path was: ' . $rude->get_path();
}

say '======================================';
say 'Finished';
