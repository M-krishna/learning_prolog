# Step 6: How Prolog searches (backtracking)
**The problem it solves**. In step 5, Prolog found the right answers, but *how?* When a condition fails halfway through a rule, Prolog doesn't just give up. Understanding exactly what it does next is the key to reading, writing, and debugging any Prolog program. Later, when your policy engine gives a surprising answer, this is how you'll find out why.

**What it does.** When a goal fails, Prolog goes **back** to the most recent choice point (the saved spot from the `false` question earlier) and tries the next option from there. This is called **backtracking**.

If you think in Python, it behaves like nested loops, where a failure inside means "move on to the next item of the loop above":
```python
for person in managers:                 # manager(Person)
    for team in teams_of(person):       # in_team(Person, Team)
        if report_team[report] == team: # report_team(Report, Team)
            yield person
```
**The tool:** `trace`. SWI-Prolog can show you every move it makes. Typing `trace.` turns on step-by-step mode. Your next query then pauses at every step, and you press **Enter** to move forward one step. Each line starts with one of four words, called **ports**:
* **Call:** "I'm starting to try this goal."
* **Exit:** "This goal succeeded."
* **Fail:** "This goal has no (more) answers."
* **Redo:** "I'm coming back to this goal to try its next option." (This is backtracking.)

You'll also see things like `_12345`. That's just Prolog's internal name for a variable that hasn't been filled in yet. The number in brackets, like `(11)`, shows how deep in the chain it is.

Try it. Load `kb4.pl` and run:
```prolog
?- trace.
true.
[trace] 46 ?- can_approve(Who, report2).
```
Keep pressing Enter. When it's done, type `nodebug.` to go back to normal mode.

**What you should see** (roughly; exact lines may differ a little):
1. **Call** `manager(_)` then **Exit** `manager(alice)`. It picked the first manager. `bob` is still untried, so a choice point is saved.
2. **Call** `in_team(alice, _)` then **Exit** `in_team(alice, legal)`.
3. **Call** `report_team(report2, legal)` then **Fail**. `report2` belongs to `hr`, not `legal`.
4. **Redo** `manager(_)`. This is the backtrack. Alice didn't work out, so it goes back to the saved choice point...
5. **Exit** `manager(bob)`, then `in_team(bob, hr)`, then `report_team(report2, hr)` succeeds.
6. Answer: `Who = bob`.

**What to notice.** Prolog never "knew" the answer was bob. It tried alice first (top-to-bottom order), hit a dead end, went back, and tried the next option. Every Prolog program works this way: try in order, and on failure go back to the latest choice and try the next one.

This also means **the order of your facts and conditions affects how much work Prolog does**, and sometimes, as you'll see later, whether it finishes at all.