package CharacterIdentifier;

use strict;
use warnings;
use v5.10;
use Time::HiRes qw/gettimeofday/;

sub new {
    my $class = shift;
    my $self = {
        'result' => '',
        'secret' => '132456'
    };
    bless $self, $class;
    return $self;
}

sub is_rebel {
    my $self = shift;
    my $return_val = get_random_value();
    if (!$return_val) {
        $self->{'result'} = 'Darth Vader';
    }
    return $return_val;
}
sub is_prisoner {
    my $self = shift;
    return 0;
}
sub is_pilot {
    my $self = shift;
    my $return_val = get_random_value();
    return $return_val;
}
sub is_hairy {
    my $self = shift;
    my $return_val = get_random_value();
    $self->{'result'} = $return_val ? 'Chewbacca' : 'Han Solo';
    return $return_val;
}
sub is_from_tatooine {
    my $self = shift;
    my $return_val = get_random_value();
    if (!$return_val) {
        $self->{'result'} = 'R2D2';
    }
    return $return_val;
}
sub is_old {
    my $self = shift;
    my $return_val = get_random_value();
    $self->{'result'} = $return_val ? 'Obi-Wan Kenobi' : 'Luke Skywalker';
    return $return_val;
}
sub leia {
    my $self = shift;
    $self->{'result'} = 'Princess Leia Organa';
    return -1;
}

sub get_random_value {
    my $rand = int(rand(31));
    return int(($rand % 2 == 0));
}

1;