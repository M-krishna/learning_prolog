# Step 1: Facts and questions
**The problem it solves.** In Python or JS you write *how* to get an answer: loops, ifs, return values. In Prolog you write down *what is true*, then ask questions. Prolog figures out the answer by itself.

**What it does.** A Prolog program is just a list of true statements. That list is called a **knowledge base**. You load it, then ask it questions.

A rough Python picture:
```python
facts = {("woman", "mia"), ("woman", "jody"), ("plays_air_guitar", "jody")}
("woman", "mia") in facts   # True
```
Prolog is like that `in` check, but much smarter, as you'll see in later steps.

## Terms you need:
* **Fact:** one true statement, like `woman(mia)`. Read it as "mia is a woman."
* **Predicate:** the name before the brackets (`woman`). Think of it as a property or a relationship.
* **Atom:** a plain name like `mia` or `jody`. It must start with a **lowercase** letter. (Uppercase means something else, which we'll cover in step 3.)
* **The full stop `.`:** every fact ends with one. It's like `;` in JS, but required.
* **Query:** a question you type at the `?-` prompt.

**Try it**. Inside `learning_prolog`, create `kb1.pl`:
```prolog
woman(mia).
woman(jody).
woman(yolanda).
playsAirGuitar(jody).
party.
```
The last line `party` is a fact with no brackets. It just means "there is a party." It's true, full stop.

Now in the terminal, from inside `learning_prolog`:
```bash
swipl kb1.pl
```
`swipl` is the SWI-Prolog program you installed. Giving it a file name loads that file. You'll see the `?-` prompt. Type each of these and press Enter (keep the full stop):
```prolog
?- woman(mia).
?- playsAirGuitar(jody).
?- party.
?- woman(vincent).
?- playsAirGuitar(mia).
?- tattooed(jody).
```
Two useful commands: `make.` reloads your file after you edit it, and `halt.` quits.

**What to notice.** The first three say `true`. The next two say `false`, because Prolog only knows what you told it. If it isn't written down, it's treated as not true. The last one gives an **error**, not `false`, because `tattooed` doesn't exist in the file at all. So "false" means "I know this predicate, but this case isn't in my facts", and "error" means "I've never heard of this predicate." 