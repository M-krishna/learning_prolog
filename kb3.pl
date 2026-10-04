/** 
    Introducing "rules"
    :- is called as "if"    
    left hand side of :- is called as head
    right hand side of :- is called as body
    head is the conclusion
    body is the condition


    For example, listens2music(yolanda) :- happy(yolanda).
    Read it as: yolanda listens to music is she is happy.

    playsAirGuitar(mia) :- listens2music(mia).
    Read it as: mia plays air guitar if she listens to music

**/

happy(yolanda).
listens2music(mia).
listens2music(yolanda) :- happy(yolanda).
playsAirGuitar(mia) :- listens2music(mia).
playsAirGuitar(yolanda) :- listens2music(yolanda).