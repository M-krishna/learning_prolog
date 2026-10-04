Since I'm using "Learn Prolog Now" book to learn Prolog, the recommended interpreter is **SWI-prolog** and we can install it through `brew` on mac.

### Open your terminal and run:
```bash
brew install swi-prolog
```

### Verify the installation:
```bash
swipl --version
```
To start the interactive Prolog interpreter:
```
swipl
```
You should see a prompt simiar to:
```prolog
Welcome to SWI-Prolog ...
?-
```

> `?-` means "ask Prolog a question".

When you see `?-`, you're in the **query prompt**.

### Try your first program
At the ?- prompt, enter:
```prolog
likes(alice, pizza).
```

You're effectively asking:
> "Prolog, is `likes(alice, pizza)` true?"

Prolog looks through its current knowledge base for something that establishes that fact. But you haven't told Prolog anything about `likes`. Therefore:
```
ERROR: Unknown procedure: likes/2 (DWIM could not correct goal)
```
The `/2` means:
> `likes` is a predicate that takes **2 arguments**.

To exit the interpreter, enter:
```
halt.
```

### Create a prolog file
Create a file named `family.pl`:
```prolog
parent(alice, bob).
parent(bob, charlie).

grandparent(X, Z) :-
    parent(X, Y),
    parent(Y, Z).
```
Run it:
```bash
swipl -s family.pl
```
Then query:
```prolog
?- grandparent(alice, Who).
```
Expected result:
```
Who = charlie
```