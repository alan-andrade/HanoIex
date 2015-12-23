# TODO

## Use Strems instead of Enum

Every single list related operation in the program uses Enum (eager)
list creation instead of Streams (lazy). Its a nice to have just for
the sake of the use of Streams. Performance isn't an issue, but
computing the whole game before presenting it is wasteful.

This todo is done when solver, sequencer and player use Streams instead
of Enums or Lists.
