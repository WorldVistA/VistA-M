LBRYET3 ;ISC2/DJM-ROUTINES USED IN FILEMAN FOR 680.5 ;[ 09/05/97  5:40 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
IT1 ;INPUT TRANSFORM FOR FILE 680.5, FIELD .01.
 ;Capitalize the title and removed leading & trailing blanks
 S X=$$UP^XLFSTR(X)
E1 I $E(X,1,1)=" " S X=$E(X,2,999)
 I $E(X,$L(X),$L(X))=" " S X=$E(X,1,$L(X)-1)
 I $E(X,1,1)=" "!($E(X,$L(X),$L(X))=" ") G E1
E2 K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>160!($L(X)<1)!'(X'?1P.E) X
 I $E(X,1,4)="THE " S X=$E(X,5,999)
 Q
