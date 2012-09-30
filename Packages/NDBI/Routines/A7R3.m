S ;
 S RTN="A" F  S RTN=$O(^ROUTINE(RTN)) Q:'$L(RTN)  D
 .S R="^"_RTN
 .S FL=$T(@R)
 .S FL=$TR(FL,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .S QUIT=1
 .I (FL["PRE"),(FL["INIT") S QUIT=0
 .I (FL["POST"),(FL["INIT") S QUIT=0
 .I (FL["PRE"),(FL["INSTALL") S QUIT=0
 .I (FL["POST"),(FL["INSTALL") S QUIT=0
 .I (FL?.E1"ENV".E1"CHECK".E) S QUIT=0
 .;I ($L(FL,"*")=3),(FL?.E2.4U1"*"1.N1"."1.N.E) S QUIT=0
 .Q:QUIT
 .W !,R," ",FL
