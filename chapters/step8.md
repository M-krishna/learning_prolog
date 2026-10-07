# Step 8: Recursion (rules that use themselves)
**The problem it solves**. Say you want: "Is alice **above** dave in the reporting chain, at any level?" Dave reports to carol, carol to bob, bob to alice. With the tools so far, you'd need one rule for "direct boss", another for "boss's boss", another for "boss's boss's boss", and so on. You can't know how deep a real org chart goes. In a policy engine this comes up constantly: "a manager can see reports from **anyone** below them."

**What it does.** A rule can use **itself** in its own body. That's called **recursion**. You describe one step, and "keep going", and Prolog follows the chain as far as it goes. 

## One new idea first: two clauses mean "or"
So far, multiple **facts** with the same name were alternatives: Prolog tried them one by one. The same is true for **rules**. If you write two rules with the same head, Prolog tries the first, and if that fails (or you press `;`), it tries the second. So two clauses for the same predicate mean **"this OR that"**.

## The recursive rule
Create `kb5.pl`:
```prolog
reports_to(dave, carol).
reports_to(carol, bob).
reports_to(bob, alice).

above(Boss, Person) :-
    reports_to(Person, Boss)

above(Boss, Person) :-
    reports_to(Person, Middle),
    above(Boss, Middle).
```

Read the two clauses as:
1. Boss is above Person **if** Person reports directly to Boss.
2. **OR**: Boss is above Person **if** Person reports to someone (Middle), **and** Boss is above that Middle.

## Terms you need:
* **Base case:** the clause that **doesn't** call itself (clause 1). It's where the chain stops.
* **Recursive case:** the clause that **does** call itself (clause 2). It takes one step up the chain, then asks the same question again.

Python picture:
```python
def above(boss, person):
    middle = reports_to.get(person)
    if middle is None:
        return False
    return middle == boss or above(boss, middle)
```

Try it. Load `kb5.pl` and run (press `;` for more answers):
```prolog
?- above(alice, dave).
?- above(Who, dave).
?- above(alice, Who).
?- above(dave, alice).
```

If you're curious, run `above(alice, dave)` with `trace.` on. You'll see the depth number in brackets grow as it goes up the chain.

**What to notice.** For `above(alice, dave)`, Prolog does this:
1. Clause 1: does dave report directly to alice? No. Try clause 2: dave reports to carol, so now ask `above(alice, carol)`.
2. Clause 1: does carol report directly to alice? No. Clause 2: carol reports to bob, so ask `above(alice, bob)`
3. Clause 1: does bob report directly to alice? Yes. Done, `true`.

And again, one definition answers in every direction: "who is above dave?", "who is below alice?", "is X above Y?"

The order of the goals inside clause 2 matters a lot here. If you swap them, Prolog can get stuck in an endless loop. That's step 9: you'll break it on purpose and see why it happens.

# What do you mean by Predicate and Clause?
**Clause**: one complete statement in your file, ending with a full stop. It's either a fact or a rule. Count the full stops and you've counted the clauses.

**Predicate**: the **group** of all clauses that share the same name and the same number of arguments. It's the "thing" you're defining, and it's written as `name/arity`.

Using your `kb5.pl`:
```prolog
reports_to(dave, carol).          % clause 1 of reports_to/2
reports_to(carol, bob).           % clause 2 of reports_to/2
reports_to(bob, alice).           % clause 3 of reports_to/2

above(Boss, Person) :-            % clause 1 of above/2
    reports_to(Person, Boss).

above(Boss, Person) :-            % clause 2 of above/2
    reports_to(Person, Middle),
    above(Boss, Middle).
```
(Anything after `%` is a **comment**, and Prolog ignores it, like `#` in Python.)

So this file has **5 clauses** but only **2 predicates**: `reports_to/2` (made of 3 facts) and `above/2` (made of 2 rules).

Two ways to picture it:
* **Like a function in Python**: the predicate is the function name, and the clauses are the different cases it can handle. When you call it, Prolog tries the cases top to bottom.
* **Like a database table (for facts)**: the predicate `reports_to/2` is the table, and each fact is a row.

**Check it yourself**. SWI-Prolog has a built-in called `listing`, which prints every clause belonging to a predicate. Load `kb5.pl` and run:
```prolog
?- listing(above).
?- listing(reports_to).
```
You'll see the 2 clauses for `above` and the 3 clauses of `reports_to` printed back. Prolog may rename the variables to things like `A` and `B`; that's normal and means the same thing.

# The difference between "OR" and "AND" (comma)
* **Comma inside one rule** means **AND**. All conditions in that body must be true.
* **Separate clauses with the same head** mean **OR**. Prolog tries the first clause; if it fails, it tries the next one.

So AND lives *inside* a clause, and OR lives *between* clauses.

(small wording fix: the things separated by commas in a body are **goals** and not conditions, meaning calls to predicates. `manager(Person)` is a goal that calls the predicate `manager/1`.)

**A simpler example than `above`**. Policy: "A user can view a report if they are an admin, **OR** if they own the report."
```prolog
admin(alice).

report(report1).
report(report2).

owns(bob, report1).
owns(carol, report2).

can_view(User, Report) :-       % option 1: admin AND it's a real report
    admin(User),
    report(Report).

can_view(User, Report) :-       % option 2: owner of this report
    owns(User, Report).
```

In Python, it would be:
```python
def can_view(user, report):
    return (admin(user) and report_exists(report)) or owns(user, report)
```
Each clause is one bracket of the `or`. The commas inside a clause are the `and`s.

Try it. Save that as `kb6.pl`, load it, and run it:
```prolog
?- can_view(alice, report2).
?- can_view(bob, report1).
?- can_view(bob, report2).
?- can_view(Who, report1).
```
* alice gets in through option 1 (admin).
* bob gets into report1 through option 2 (owner).
* bob and report2: option 1 fails (not admin), option 2 fails (doesn't own it), so `false.`
* `Who` for report1 gives `alice` (from clause 1), then after `;`, `bob` (from clause 2). You can see Prolog trying clauses in order.