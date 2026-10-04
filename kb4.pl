/**
    Introducing "Variables" in Rules
    and "and"(comma) in conditions
**/

manager(alice).
manager(bob).

in_team(alice, legal).
in_team(alice, hr).
in_team(bob, hr).
in_team(carol, legal).

report_team(report1, legal).
report_team(report2, hr).

can_approve(Person, Report) :-
    manager(Person),
    in_team(Person, Team),
    report_team(Report, Team).