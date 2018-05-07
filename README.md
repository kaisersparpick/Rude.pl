# Rude.pl
Rude.pl is a Perl implementation of the *rule-based control-flow pattern* [Rude](https://github.com/kaisersparpick/Rude).

## Usage

#### Creating an instance
```php
use Rude;
my $rude = Rude->new();
```

#### Adding a rule

```php
$rude->add_rule(\&subroutine1, \&subroutine2, \&subroutine3);
```
`add_rule` accepts three arguments: the condition to check, the function to call when the result is true, and the function to call when it is false. Each argument can be a subroutine reference, a `rule array` or `undef`.

A `rule array` takes the form of `[$object, 'instance_method']` and Rude takes care of binding them together. Using rule arrays also makes it easy to load rules dynamically from a datasource or generating them on the fly.

A complex example:
```php
$rude->add_rule(\&mysub, [$myobj, 'mymethod'], undef);
```

The return value of conditions must be `1` for proceeding with the yes callback and `0` with the no branch. When a condition returns `-1`, Rude exits the condition chain. In this case, the yes and no callbacks are not necessary, therefore they can be left empty -- i.e. `undef`. These conditions are usually exit points.

#### Checking conditions

Checking conditions based on the applied rules is triggered by calling `rude.check()`.

```php
# with a subroutine reference
rude.check(\&mysub);
# with a rule array
rude.check([$myobj, 'mymethod']);
```

This specifies the entry point in the condition chain and can be set to any valid rule condition.

See the examples for more details.

## Benefits

  - Rude allows for an on-demand execution of a chain of `dynamic if-then-else` statements - hereinafter referred to as `rules`.
  - The control flow is easy to manage and the logic can be modified by simply changing the callbacks in the `rules`.
  - The chain of condition checking can be exited or paused at any given point.
  - The position in the `rule` hierarchy can be stored and the execution resumed at a later stage by setting the `entry point`. 
  - Each `rule` is seen as a separate and *independent logical unit*.
  - Individual `rules` and groups of rules can be easily moved around.
  - `Rules` can be generated dynamically or loaded from a datasource. 
  - The dispatcher makes it possible to ditch the rigid static conditional model in favour of a considerably more flexible one.
