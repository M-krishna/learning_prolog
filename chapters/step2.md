# Step 2: Facts that connect two things
**The problem it solves.** In step 1, every fact described *one* thing: "mia is a woman." But most real information is about *relationships* between things: "vincent loves mia", "this employee reports to that manager", "this user has this role". You need a way to say that.

**What it does.** A predicate can take more than one thing inside the brackets, separated by commas. Each thing inside the brackets is called an **argument**.
```prolog
loves(vincent, mia).
```
Read it as "vincent loves mia."

## Terms you need:
* **Argument:** one item inside the brackets. `loves(vincent, mia)` has two arguments: `vincent` and `mia`.
* **Arity:** how many arguments a predicate takes. `woman` has arity 1, `loves` has arity 2, and `party` has arity 0.
* **name/arity:** the way Prolog writes a predicate's full identity, like `loves/2` or `woman/1`. You'll see this in error messages, so it's worth knowing.

Two rules comes out of this:
1. **Order matters.** `loves(vincent, mia)` and `loves(mia, vincent)` are two completely different facts. Prolog doesn't know that "loves" might go both ways. You decide what first and second positions mean, and you stay consistent.
2. **Same name, different arity means a different predicate.** `loves/1` and `loves/2` have nothing to do with each other, as far as Prolog is concerned.

**Try it.** Create `kb2.pl`:
```prolog
loves(vincent, mia).
loves(marsellus, mia).
loves(pumpkin, honey_bunny).
loves(honey_bunny, pumpkin).
```
(**Atoms can contain letters, digits, and underscores, as long as they start with a lowercase letter. That's why `honey_bunny` works.**)

Load it with `swipl kb2.pl` and run:
```prolog
?- loves(vincent, mia).
?- loves(mia, vincent).
?- loves(pumpkin, honey_bunny).
?- loves(honey_bunny, pumpkin).
?- loves(vincent).
```

**What to notice.** The first one is `true`, the second `false` (order matters). The third and forth are both `true`, but only because we wrote *both* directions down. The last one gives an error. Read the error message carefully: it should mention `loves/1`, and it may also tell you that `loves/2` exists. That's Prolog treating them as two separate predicates.

Right now you can only ask yes/no questions. The obvious next question is "*who* does marsellus love?" or "who loves mia?", and that's what step 3 (variables) solves.