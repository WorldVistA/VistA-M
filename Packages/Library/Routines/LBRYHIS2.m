LBRYHIS2 ;ISC2/DJM-CHECK-IN NOTES ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
START S E=0,DIWL=1,DIWR=79,DIWF="N" K ^UTILITY($J,"W")
 S XX=$P(^LBRY(680,DA,16,0),U,3)
 F I=1:1:XX S X=^LBRY(680,DA,16,I,0) D ^DIWP
 S X=^UTILITY($J,"W",DIWL)-1,X1=0,X2=0
LOOP W @IOF,?5,"VA Library History of Check-In ** NOTES **",?60,YDT
 W !!,LA0 W:$D(LA00) !,LA00 W !! S X1=X1+X2,X2=X2+16 I X2>X S X2=X
 I X1'<X G EXIT
 F I=X1+1:1:X2 S O=^UTILITY($J,"W",DIWL,I,0) W O,!
QUERY W !!,$S(I<X:"Continue// ",1:"Exit// ")
 S DTOUT="" R Z:DTIME E  S DTOUT=1 W $C(7) G EXIT
 I I'=X,Z="" G LOOP
 I I=X,Z="" G EXIT
 I Z="^" G EXIT
 W !!,$S(I'=X:"Enter '^' to exit or <CR> to continue",1:"Enter <CR> to exit") G QUERY
EXIT K XX,^UTILITY($J,"W") Q
