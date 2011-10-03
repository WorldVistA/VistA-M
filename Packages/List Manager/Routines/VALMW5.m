VALMW5 ; alb/mjk - Help for export tool ;02:30 PM  16 Dec 1992;
 ;;1;List Manager;;Aug 13, 1993
 ;
NS ; HELP FOR PREFIX
 W !?5,"Enter a unique 2 to 4 character prefix beginning with an uppercase",!?5,"letter and followed only by uppercase letters or numbers." Q:X'?1"??".E
 W !?5,"If this is an established package, you may enter one of the prefixes",!?5,"listed in the right column below."
 S DIC=9.4,DIC(0)="QE",DIC("W")="W ?35,$P(^(0),U,2)",DIZ=15 D ^DIC K DIC,DIZ Q
 ;
ROU ; HELP FOR RTN NAME
 W !?5,"Answer YES if you want to create a program called "_X W:$D(Q) !?5,"even though there already is one on file.  (It will be overwritten.)" W !?5,"Answer NO if you don't want to do this." Q
 ;
MAX ; HELP FOR MAX RTN SIZE
 W !?5,"Enter the maximum number of characters you would like each routine",!?5,"contain.  This number must be between 2000 and 10000." Q
 ;
