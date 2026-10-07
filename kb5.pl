reports_to(dave, carol).
reports_to(carol, bob).
reports_to(bob, alice).

above(Boss, Person) :-
    reports_to(Person, Boss).

above(Boss, Person) :-
    reports_to(Person, Middle),
    above(Boss, Middle).