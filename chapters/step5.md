# Step 5: Variables in rules, and "and"
**The problem is solves.** In step 4 we wrote one rule for mia and an identical one for yolanda. With 1,000 people, you'd write 1,000 rules. Also, real conditions usually have several parts: "a person can approve a report if they are a manager **and** they are in the same team as the report."

**What it does.** Two things:
1. You can put **variables** in a rule, so one rule covers everyone.
2. You can join conditions with a **comma**, which means **"and"**.

## Part A: one rule for everyone
```prolog
playsAirGuitar(X) :- listens2music(X)
```
Read it as: "**for any** X, X plays air guitar if X listens to music." This single line replaces both rules from step 4.

One important detail: a variable only lives **inside its own clause**. The `X` in this rule has nothing to do with an `X` in any other rule, or in your query. Inside one clause, though, the same name always means the same value (just like `loves(X, X)` in step 3.) 

## Part B: "and" with a comma
Here's something closer to your policy-engine goal. Create `kb4.pl`:
```prolog
manager(alice).
manager(bob).

in_team(alice, legal).
in_team(bob, hr).
in_team(carol, legal).

report_team(report1, legal).
report_team(report2, hr).

can_approve(Person, Report) :-
    manager(Person),
    in_team(Person, Team),
    report_team(Report, Team).
```
(A rule can span several lines. Prolog only cares about the final full stop.)

Read the rule as: "Person can approve Report **if** Person is a manager,**and** Person is in some Team, **and** Report belongs to **that same** Team."

Look at `Team`. It doesn't appear in the head at all. It's only there to connect two conditions: whatever team the person is in must also be the report's team. If you know SQL, this is a **join**: `Team` plays the role of `ON in_team.team = report_team.team`.

Load it with `swipl kb4.pl` and run:
```prolog
?- can_approve(alice, report1).
?- can_approve(alice, report2).
?- can_approve(carol, report1).
?- can_approve(Who, report2).
?- can_approve(P, R).
```

**What to notice.**
* `alice` can approve `report1` (manager, same team), but not `report2` (wrong team).
* `carol` is in `legal`, but she isn't a manager, so `false`. All three conditions must be true.
* `can_approve(P, R)` lists every allowed pair. You wrote the policy **once**, and Prolog answers both "is this allowed?" and "who is allowed to do what?" from the same rule. That two-way use is one of the main reasons Prolog suits rule engines.

Prolog checks the conditions **left to right**. When one fails, it go backs to an earlier condition and tries another option. That "going back" is the heart of how Prolog searches, and it's what step 6 covers, including a tool that lets you watch it happen live.