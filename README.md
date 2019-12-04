matlab-strings-howfast
======================

Benchmarks for Matlab string arrays vs. cellstrs and MCOS.

This project is a set of benchmarks to measure how fast the new (R2018a-ish) Matlab
`string` array type is compared to cellstrs and naive MCOS (user-level classes)
implementations are. Its purpose is to provide feedback to MathWorks so they can
improve the performance of the `string` type. (Because I think `string` arrays are
Good and that's what everyone should be using, so it'd be nice if they were fast,
too.)

This project may also be expanded to include benchmarks for `categorical` arrays,
too, since they're closely related to `string` arrays.

##  Licensing note

You should not use this project to benchmark any product that is a competitor to
Matlab (like, say, GNU Octave). That could be a violation of the Non-Compete clause
of the Matlab license, and you could lose your Matlab license because of it.

If you have a problem with this, contact your MathWorks account rep, and/or your
lawyer. Definitely do not contact me about it.

##  Usage

Download the source tree, unzip it somewhere on your disk, and stick its `Mcode/`
directory on your Matlab path. Then see the doco for the individual classes for 
how to use them.

Sorry I don't have a better tutorial here.

##  Contributing

Contributions of all forms, including just comments and feature requests like "I wish it tested such-and-such" are very welcome. Post them as Issues on the project [Issue
tracker page on GitHub](https://github.com/apjanke/matlab-strings-howfast/issues).

##  Authors and contact

matlab-strings-howfast is written and maintained by [Andrew Janke](https://github.com/apjanke) <janke@pobox.com>.

The project home page is <https://github.com/apjanke/matlab-strings-howfast>.
