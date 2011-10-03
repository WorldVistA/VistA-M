LBRYET1 ;ISC2/DJM-INPUT TRANSFORMS FOR 680.9 FILE ;[ 09/02/94  10:20 AM ]
 ;;2.5;Library;;Mar 11, 1996
 ;INPUT TRANSFORM FOR MONTH FIELD
 I $E(X)'="," S X=","_X
E2 K:$P(X,",",14)]""!($L(X)>28) X Q:'$D(X)
 F I=2:1 S X2=$P(X,",",I) G:X2="" ORDER K:X2'=+X2!(X2<1)!(X2>12)!(X2?.E1"."1N.N) X Q:'$D(X)
 Q
EN1 ;INPUT TRANSFORM FOR VOLUME INCREMENT, ISSUE CHANGE AND ISSUE INCREMENT FIELDS
 G:$E(X,1)="+" E3 K:+X'=X!(X<1)!(X>99999)!(X?.E1"."1N.N) X Q
E3 S X2=$E(X,2,99) K:X2'=+X2!(X2<1)!(X2>9999)!(X2?.E1"."1N.N) X Q
EN2 ;INPUT TRANSFORM FOR CHANGE MONTH FIELD
 I $E(X)'="," S X=","_X
 G E2
EN3 ;INPUT TRANSFORM FOR WEEK-OF-MONTH/DAY-OF-WEEK (WOM/DOW) FIELD
 I $E(X)'="," S X=","_X
E5 K:$P(X,",",33)]""!($L(X)<5)!($L(X)>125) X Q:'$D(X)
 F I=2:1 S XP=$P(X,",",I) G:XP="" ORDER K:XP'?1N1"/"1N X Q:'$D(X)  S X1=$P(XP,"/",1),X2=$P(XP,"/",2) K:X1<1!(X1>5)!(X2<0)!(X2>6) X Q:'$D(X)
 Q
EN5 ;INPUT TRANSFORM FOR DAY-OF-MONTH FIELD
 I $E(X)'="," S X=","_X
E8 K:$P(X,",",33)]""!($L(X)<1)!($L(X)>85) X Q:'$D(X)
 F I=2:1 S X2=$P(X,",",I) G:X2="" ORDER K:X2'=+X2!(X2<1)!(X2>31)!(X2?.E1"."1N.N) X Q:'$D(X)
 Q
EN6 ;HELP PROMPT FOR WOM/DOW FIELD
 W !!,"If the pattern states that copies will have a date based on a week"
 W !,"of the month and a day of the week enter separate entries for each"
 W !,"combination separated with a ',' between entries.  Each entry will"
 W !,"consist of two parts. The first part will be the week-of-the-month from"
 W !,"1 to 5.  The second part will be the day-of the-week from 0 for Sunday"
 W !,"to 6 for Saturday.  The two parts will be separated with a '/'."
 W !!,"For example the pattern states that copies will arrive on the"
 W !,"1st and 3rd Fridays of the month.  This should be expanded and entered as"
 W !,"week 1-Friday = 1/5 and week 3-Friday = 3/5 so the complete"
 W !,"entry would be '1/5,3/5'.",!!
 Q
ORDER K LBX S C="," F I=2:1 S X1=$P(X,C,I) G:X1="" S2 S LBX(X1)=""
S2 S LBY=0,XZ="" F  S LBY=$O(LBX(LBY)) G:LBY="" S3 S XZ=XZ_C_LBY
S3 S X=XZ_C Q
