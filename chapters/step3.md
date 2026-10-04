# Step 3: Variables (asking "who?")
**The problem it solves.** So far you can only ask yes/no questions: "does vincent love mia?" But usually you want Prolog to *find* something: "who loves mia?" or "who does pumpkin love?"

**What it does.** You put a **variable** in the spot you don't know. Prolog searches the facts and tells you what can go in that spot.

## Terms you need:
* **Variable**: a placeholder for "something I don't know yet." It must start with an **uppercase letter** (or an underscore). `X`, `Who`, `Person` are all variables.
* **Atom vs variable**: this is why step 1 said atoms must start lowercase. `mia` is a specific thing. `Mia` is a variable that can match *anything*.

A rough Python picture of `loves(Who, mia)`:
```python
[who for (who, whom) in loves if whom == "mia"]
```
**How answers come out.** Prolog shows **one answer at a time**, then waits. You decide what to do:
* Press `;` (semicolon) to ask for the next answer
* Press Enter to stop

When there are no more answers, Prolog ends with a full stop, or says `false`.

**Try it**. Load your `kb2.pl` again (`swipl kb2.pl`) and run these. After each answer, press `;` until it stops.
```prolog
?- loves(Who, mia).
?- loves(pumpkin, Who).
?- loves(X, Y).
?- loves(X, X).
?- loves(vincent, Mia).
```
**What to notice:**
1. The first gives `vincent`, then `marsellus`. Prolog goes through the facts **top to bottom**, in the order you wrote them.
2. The third, `loves(X, Y)`, lists every pair. Two different variables can take any values.
3. The fourth, `loves(X, X)`, is `false`. Using the **same variable twice** means "both spots must be the *same thing*", so it's asking "who loves themselves?" Nobody in our file does. This idea becomes very important when we write rules.
4. The last one is a trap on purpose. Because `Mia` is uppercase, it's a variable, so you're really asking "who does vincent love?" and you'll get `Mia = mia`. It's an easy bug to write.

What Prolog is doing here is trying to make your question and a fact look the same by filling in the variables. That process has a proper name, **unification**, and we'll look at it closely in a later step.