package Rude;

use strict;
use warnings;
use Sub::Identify ':all';
use v5.10;
no warnings 'experimental';

sub new {
    my $class = shift;
    my $self = {
        rules   => {},
        path    => []
    };
    bless $self, $class;
    return $self;
}

sub add_rule {
    my ($self, $condition, $yes, $no) = @_;
    my $rule_name;

    $rule_name = (ref($condition) eq 'ARRAY') ? @{ $condition }[1] : sub_name($condition);

    my $rule = {
        condition   => $condition,
        yes         => $yes,
        no          => $no
    };

    $self->{rules}{$rule_name} = $rule;
}

sub check {
    my ($self, $condition) = @_;
    my $rule;
    my $rule_name;
    my $result;
    my $obj;
    my $method;

    $self->{path} = [];

    while (1) {
        if (ref($condition) eq 'ARRAY') {
            $rule_name = @{ $condition }[1];
            $rule = $self->{rules}{$rule_name};
            die 'ERROR: Undefined rule' unless defined($rule);

            $method = $$rule{'condition'}[1];
            $obj = $$rule{'condition'}[0];
            die 'ERROR: Unknown method' unless $obj->can($method);

            $result = $obj->$method();
        }
        else {
            $rule_name = sub_name($condition);
            $rule = $self->{rules}{$rule_name};
            die 'ERROR: Unknown subroutine' unless defined($$rule{'condition'});

            $result = $$rule{'condition'}();
        }

        push @{ $self->{path} }, [$rule_name, $result];

        given ($result) {
            when ($_ == 1) {
                $condition = $$rule{'yes'};
            }
            when ($_ == 0) {
                $condition = $$rule{'no'};
            }
            default {
                last;
            }
        }
    }
};

sub get_path {
    my $self = shift;
    my $path = '';

    foreach my $p (@{ $self->{path} }) {
        if ($$p[1] == 0) { $path .= '!'; }
        $path .= $$p[0];
        if ($$p[1] != -1) { $path .= ' > '; }
    }

    return $path;
}

1;