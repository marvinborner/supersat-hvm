# SuperSAT

> Boolean satisfiability by superposition in HVM

Basic idea in pseudocode:

```
x1 = {true, false}
x2 = {true, false}
x3 = {true, false}
(x1 || x2) && (x2 || !x3) && (!x1 || x3)
```

reduces to:

```
{{{false, false}, {true, true}}, {{false, false}, {false, true}}}
```

with some state being (co-)shared. By pruning branches via short-circuiting operators:

```
{{false, true}, {{false, false}, {false, true}}}
```

then, installing a custom collapser on `true` that also traces the path to this `true` will result in a general SAT solver.

## Instructions

Currently uses [DIMACS CNF](https://jix.github.io/varisat/manual/0.2.0/formats/dimacs.html) files (as used in SAT competitions).

- install [HVM4](https://github.com/HigherOrderCO/HVM4/) as `hvm4`
- run `./run.sh <file>.cnf`, `./test.sh` or `./full.sh`
- output is in DIMACS solution format, or none if UNSAT

## Results

[Cadical testsuite](https://github.com/arminbiere/cadical/tree/master/test/cnf) (MIT) with 5s timeout:

```
[SKIP] test/add128.cnf
[SKIP] test/add16.cnf
[SKIP] test/add32.cnf
[PASS] test/add4.cnf steps=1151485 time=0.017s
[SKIP] test/add64.cnf
[SKIP] test/add8.cnf
[PASS] test/empty.cnf steps=2 time=0.000s
[SKIP] test/factor2708413neg.cnf
[SKIP] test/factor2708413pos.cnf
[PASS] test/false.cnf steps=3 time=0.000s
[PASS] test/full1.cnf steps=19 time=0.000s
[PASS] test/full10.cnf steps=155633 time=0.007s
[PASS] test/full2.cnf steps=83 time=0.000s
[PASS] test/full3.cnf steps=244 time=0.000s
[PASS] test/full4.cnf steps=687 time=0.000s
[PASS] test/full5.cnf steps=1814 time=0.000s
[PASS] test/full6.cnf steps=4629 time=0.000s
[PASS] test/full7.cnf steps=11444 time=0.001s
[PASS] test/full8.cnf steps=28275 time=0.001s
[PASS] test/full9.cnf steps=66802 time=0.003s
[PASS] test/ph2.cnf steps=370 time=0.000s
[PASS] test/ph3.cnf steps=3095 time=0.000s
[PASS] test/ph4.cnf steps=37938 time=0.003s
[PASS] test/ph5.cnf steps=638920 time=0.028s
[PASS] test/ph6.cnf steps=13360108 time=0.654s
[SKIP] test/prime121.cnf
[SKIP] test/prime1369.cnf
[SKIP] test/prime1681.cnf
[SKIP] test/prime169.cnf
[SKIP] test/prime1849.cnf
[SKIP] test/prime2209.cnf
[PASS] test/prime25.cnf steps=3331281 time=0.041s
[SKIP] test/prime289.cnf
[SKIP] test/prime361.cnf
[PASS] test/prime4.cnf steps=6748 time=0.000s
[SKIP] test/prime4294967297.cnf
[PASS] test/prime49.cnf steps=81812184 time=1.062s
[SKIP] test/prime529.cnf
[SKIP] test/prime65537.cnf
[SKIP] test/prime841.cnf
[PASS] test/prime9.cnf steps=143593 time=0.002s
[SKIP] test/prime961.cnf
[PASS] test/regr000.cnf steps=17793 time=0.001s
[PASS] test/sat0.cnf steps=77 time=0.000s
[PASS] test/sat1.cnf steps=125 time=0.000s
[PASS] test/sat10.cnf steps=300 time=0.000s
[PASS] test/sat11.cnf steps=306 time=0.000s
[PASS] test/sat12.cnf steps=292 time=0.000s
[PASS] test/sat13.cnf steps=294 time=0.000s
[PASS] test/sat2.cnf steps=130 time=0.000s
[PASS] test/sat3.cnf steps=120 time=0.000s
[PASS] test/sat4.cnf steps=122 time=0.000s
[PASS] test/sat5.cnf steps=244 time=0.000s
[PASS] test/sat6.cnf steps=334 time=0.000s
[PASS] test/sat7.cnf steps=341 time=0.000s
[PASS] test/sat8.cnf steps=329 time=0.000s
[PASS] test/sat9.cnf steps=333 time=0.000s
[PASS] test/sqrt10201.cnf steps=8483229 time=0.087s
[SKIP] test/sqrt1042441.cnf
[PASS] test/sqrt10609.cnf steps=13995109 time=0.153s
[PASS] test/sqrt11449.cnf steps=11815387 time=0.119s
[PASS] test/sqrt11881.cnf steps=12244951 time=0.125s
[PASS] test/sqrt12769.cnf steps=4940277 time=0.047s
[PASS] test/sqrt16129.cnf steps=2329663 time=0.022s
[PASS] test/sqrt259081.cnf steps=226191578 time=2.883s
[PASS] test/sqrt2809.cnf steps=2197813 time=0.020s
[PASS] test/sqrt3481.cnf steps=3068451 time=0.033s
[PASS] test/sqrt3721.cnf steps=3050110 time=0.032s
[PASS] test/sqrt4489.cnf steps=9305742 time=0.090s
[PASS] test/sqrt5041.cnf steps=13124959 time=0.142s
[PASS] test/sqrt5329.cnf steps=13071428 time=0.144s
[PASS] test/sqrt6241.cnf steps=15722752 time=0.173s
[PASS] test/sqrt63001.cnf steps=58767378 time=0.654s
[PASS] test/sqrt6889.cnf steps=12275687 time=0.129s
[PASS] test/sqrt7921.cnf steps=10391869 time=0.109s
[PASS] test/sqrt9409.cnf steps=5012592 time=0.045s
[PASS] test/unit0.cnf steps=36 time=0.000s
[PASS] test/unit1.cnf steps=39 time=0.000s
[PASS] test/unit2.cnf steps=100 time=0.000s
[PASS] test/unit3.cnf steps=109 time=0.000s
[PASS] test/unit4.cnf steps=49 time=0.000s
[PASS] test/unit5.cnf steps=268 time=0.000s
[PASS] test/unit6.cnf steps=82 time=0.000s
[PASS] test/unit7.cnf steps=127 time=0.000s
checked=63 skipped_timeout=21 total_steps=526766282 total_time=6.827000s
```

Worst-case (`full/fullN.cnf`): Collapse the superpositions of all $2^n$ possible clauses over $n$ variables (always UNSAT). Results show step counts roughly exponential in `n`, as expected, therefore being roughly linear in the explicit full-CNF size.

```
full/full01.cnf steps=19 time=0.000s
full/full02.cnf steps=83 time=0.000s
full/full03.cnf steps=244 time=0.000s
full/full04.cnf steps=687 time=0.000s
full/full05.cnf steps=1814 time=0.000s
full/full06.cnf steps=4629 time=0.000s
full/full07.cnf steps=11444 time=0.000s
full/full08.cnf steps=28275 time=0.001s
full/full09.cnf steps=66802 time=0.001s
full/full10.cnf steps=155633 time=0.006s
full/full11.cnf steps=358384 time=0.008s
full/full12.cnf steps=817135 time=0.016s
full/full13.cnf steps=1847278 time=0.037s
full/full14.cnf steps=4145133 time=0.084s
full/full15.cnf steps=9240556 time=0.182s
checked=15 skipped_timeout=0 total_steps=16678116 total_time=0.335000s
```

This implementation is incredibly minimalistic: Common SAT solvers are heavily optimized to certain patterns occurring in propositions. Of course, this solver is not competitive with them.

Yet, it is one of the many programs benefitting from incremental superpositions without requiring a bookkeeping oracle to manage their levels: There are no abstractions/applications, but only builtin operations, therefore being _optimally_ (co-)shared incrementally.
