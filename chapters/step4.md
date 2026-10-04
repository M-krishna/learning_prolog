# Rules (facts that depend on other facts)
**The problem it solves.** So far, every true thing had to be written down directly. But a lot of knowledge is conditional: "yolanda listens to music **if** she is happy". Or, in a policy engine: "a user can approve a report **if** they are a manager." You don't want to write every result by hand. You want to write the *condition* once and let Prolog work out the result.

**What it does.** A **rule** says "this is true, if that is true."
```prolog
listens2music(yolanda) :- happy(yolanda).
```
Read `:-` as the word **"if"**. So this reads: "yolanda listens to music **if** yolanda is happy."

## Terms you need:
* **Head**: the part on the left of `:-`. It's the thing being concluded.
* **Body**: the part on the right of `:-`. It's the condition that must be true.
* **Clause**: either a fact or a rule. Your file is just a list of clauses. A fact is really a rule with no condition: it's simply true.
* **Goal**: something Prolog is currently trying to prove. Your query is the first goal.

**Notice the direction**: the conclusion comes **first**, and the condition after. It's the reverse of Python's `if happy: listens = True`. Takes a little getting used to.

**Try it.** This is exactly the knowledge base 2 from the page you were reading. Create `kb3.pl`:
```prolog
happy(yolanda).
listens2music(mia).
listens2music(yolanda) :- happy(yolanda).
playsAirGuitar(mia) :- listens2music(mia).
playsAirGuitar(yolanda) :- listens2music(yolanda).
```
So: two facts, and three rules. Load it with `swipl kb3.pl` and run:
```prolog
?- playsAirGuitar(mia).
?- playsAirGuitar(yolanda).
?- happy(mia).
?- playsAirGuitar(X).
```
**What to notice**. Here's how Prolog proves `playsAirGuitar(yolanda)`. It works **backwards** from your question:
1. Goal: `playsAirGuitar(yolanda)`. Is there a fact? No. Is there a rule whose head matches? Yes, the last line. So now it needs the body: `listens2music(yolanda)`.
2. Goal: `listens2music(yolanda)`. Is there a fact? No (the fact is about `mia`). Is there a rule? Yes, line 3. Now it needs: `happy(yolanda)`.
3. Goal: `happy(yolanda)`. There's a fact for that. Done.

Since step 3 succeeded, step 2 succeeds, so step 1 succeeds: `true`. This is called **chaining**: one rule leads to another, which leads to a fact.

`happy(mia)` is `false`: nothing says mia is happy, and no rule concludes it. And `playsAirGuitar(X)` gives both `mia` and `yolanda`, so variables work with rules too.

You might notice something annoying: we wrote a separate rule for mia and another one for yolanda, even though they say the same thing. Step 5 fixes that by putting variables inside rules, and adds "and" so a rule can have more than one condition.