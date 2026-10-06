# Step 7: unification (how "matching" really works)
**The problem it solves**. Since step 3, Prolog has been "matching" your query against facts and rule heads. But what exactly counts as a match? When does `X` get filled in? Once your data gets more structured (and a policy engine's data will), you need to know the exact rules, or Prolog's answers will surprise you.

**What it does**. **Unification** is Prolog's one and only way of matching. It takes two things and asks: "Can I make these two exactly the same by filling in variables?" If yes, it fills them in. If no, it fails.

## First, the building blocks
Everything in Prolog is a **term**. There are four kinds:
* **Atom**: a name, like `mia`, `legal`, `report1`.
* **Number**: like `42` or `3.14`.
* **Variable**: like `X` or `Who`.
* **Compound term**: a name followed by arguments in brackets, like `loves(vincent, mia)`. `request(user(alice), report1)`.

Every fact you've written is a compound term (or an atom, like party).

## The three rules of unification
1. **Two atoms or numbers** unify only if they're identical. `mia` and `mia`: yes. `mia` and `jody`: no.
2. **A variable** unifies with anything, and gets bound to (filled in with) that thing. Once bound, it stays that way for the rest of that attempt.
3. **Two compound terms** unify if they have the **same functor**, the **same number of arguments**, and **each pair of arguments unifies**, going left to right, keeping the bindings consistent.

## The tool: `=`
In Prolog, `=` means **"try to unify these two"**. It's not assignment like Python, and it's not "are these equal" either. It's purely "can these be made identical?"

**Try it**. You don't need any file for this. Just run `swipl` and try:
```prolog
?- mia = mia.
?- mia = jody.
?- X = mia.
?- loves(X, mia) = loves(vincent, Y).
?- loves(X, X) = loves(vincent, mia).
?- loves(vincent, mia) = loves(vincent, mia, extra).
?- request(user(alice), Doc) = request(user(Who), report1).
?- 2 + 3 = 5.
```

**What to notice.**
* `loves(X, mia) = loves(vincent, Y)` works in **both directions**. `X` gets `vincent` from the right side, and `Y` gets `mia` from the left. Variables can be on either side.
* `loves(X, X) = loves(vincent, mia)` fails. The first argument binds `X = vincent`. Then the second argument needs `vincent = mia`, which fails. This is rule 3's "keep bindings consistent", and it's exactly why `loves(X, X)` failed back in step 3.
* The one with `extra` fails: different number of arguments (that's the `loves/2` vs `loves/3` idea from step 2.)
* The `request(...)` example shows unification digging inside nested terms. That's how a policy engine could pull fields out of a structured request.
* `2 + 3 = 5` is **false**, which surprises everyone. To unification, `2 + 3` isn't a calculation. It's just a compound term with functor `+` and arguments `2` and `3`, and that's not the same shape as the number `5`. Prolog only does maths when you explicitly ask it to, which we'll cover in a later step.

Every time Prolog checked a fact or a rule head in steps 3 to 6, this is the exact process it was running. 