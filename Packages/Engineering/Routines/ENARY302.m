ENARX302 ;(WCIOFO)/SAW/DH/SAB-EQUIPMENT INV. ARCHIVE ;1/10/2001
 ;;7.0;ENGINEERING;**40,63,68**;Aug 17, 1993
 F I=1:1 S X=$T(Q+I) Q:X=""  S Y=$P(X,"=",2,99),X=$P($E(X,4,99),"=",1) S:X="" X=$P(Y,"=",1),Y=%_$P(Y,"=",2,99) X NO E  S @X=Y
Q Q
 ;;^DD(6919.3,24.5,0)=PREVIOUS LOCATION^F^^3;8^K:$L(X)>20!($L(X)<3) X
 ;;^DD(6919.3,24.5,3)=Answer must be 3-20 characters in length.
 ;;^DD(6919.3,25,0)=VA PM NUMBER^F^^3;6^K:$L(X)>10!($L(X)<9) X
 ;;^DD(6919.3,25,3)=Answer must be 9-10 characters in length.
 ;;^DD(6919.3,26,0)=LOCAL IDENTIFIER^F^^3;7^K:$L(X)>15!($L(X)<3) X
 ;;^DD(6919.3,26,3)=Answer must be 3-15 characters in length.
 ;;^DD(6919.3,27,0)=JCAHO^S^Y:YES;N:NO;^3;9^Q
 ;;^DD(6919.3,28,0)=BAR CODE LABEL DATE^D^^3;10^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(6919.3,28.2,0)=ORIGINAL BAR CODE ID^6919.35^^12;0
 ;;^DD(6919.3,29,0)=SECOND PREVIOUS LOCATION^F^^9;1^K:$L(X)>30!($L(X)<1) X
 ;;^DD(6919.3,29,3)=Answer must be 1-30 characters in length.
 ;;^DD(6919.3,29.1,0)=THIRD PREVIOUS LOCATION^F^^9;2^K:$L(X)>30!($L(X)<1) X
 ;;^DD(6919.3,29.1,3)=Answer must be 1-30 characters in length.
 ;;^DD(6919.3,29.2,0)=FOURTH PREVIOUS LOCATION^F^^9;3^K:$L(X)>30!($L(X)<1) X
 ;;^DD(6919.3,29.2,3)=Answer must be 1-30 characters in length.
 ;;^DD(6919.3,29.3,0)=FIFTH PREVIOUS LOCATION^F^^9;4^K:$L(X)>30!($L(X)<1) X
 ;;^DD(6919.3,29.3,3)=Answer must be 1-30 characters in length.
 ;;^DD(6919.3,30,0)=RESPONSIBLE SHOP^6919.31^^4;0
 ;;^DD(6919.3,31,0)=DISPOSITION METHOD^F^^3;12^K:$L(X)>30!($L(X)<3) X
 ;;^DD(6919.3,31,3)=Answer must be 3-30 characters in length.
 ;;^DD(6919.3,31.5,0)=ORIGINAL ASSET VALUE^NJ11,2^^3;15^S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>99999999)!(X<0) X
 ;;^DD(6919.3,31.5,3)=Type a Dollar Amount between 0 and 99999999, 2 Decimal Digits
 ;;^DD(6919.3,32,0)=DISPOSITION VALUE^NJ10,2^^3;13^S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 ;;^DD(6919.3,32,3)=Type a Dollar Amount between 0 and 9999999, 2 Decimal Digits
 ;;^DD(6919.3,33,0)=CONTROLLED ITEM?^S^0:NO;1:YES;^8;1^Q
 ;;^DD(6919.3,34,0)=CAPITALIZED?^S^1:CAPITALIZED/ACCOUNTABLE;A:NOT CAPITALIZED/ACCOUNTABLE;0:EXPENSED/OPTIONALLY ACCOUNTABLE;^8;2^Q
 ;;^DD(6919.3,35,0)=FUND CONTROL POINT^F^^8;3^K:$L(X)>30!($L(X)<3) X
 ;;^DD(6919.3,35,3)=Answer must be 3-30 characters in length.
 ;;^DD(6919.3,36,0)=COST CENTER^F^^8;4^K:$L(X)>79!($L(X)<4) X
 ;;^DD(6919.3,36,3)=Answer must be 4-79 characters in length.
 ;;^DD(6919.3,38,0)=STANDARD GENERAL LEDGER^F^^8;6^K:$L(X)>4!($L(X)<4) X
 ;;^DD(6919.3,38,3)=Answer must be 4 characters in length.
 ;;^DD(6919.3,40,0)=COMMENTS^6919.32^^5;0
 ;;^DD(6919.3,50,0)=EQUIPMENT HISTORY^6919.33A^^6;0
 ;;^DD(6919.3,51,0)=REPLACING (ENTRY NUMBER)^NJ15,0^^8;8^K:+X'=X!(X>999999999999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(6919.3,51,3)=Type a Number between 1 and 999999999999999, 0 Decimal Digits
 ;;^DD(6919.3,52,0)=REPLACEMENT UPDATE CODE^S^4:NO TO BE REPLACED;5:TO BE REPLACED UNDER ACTIVATION PROJECT;6:ON ORDER;^8;9^Q
 ;;^DD(6919.3,53,0)=CONDITION CODE^S^1:LIKE NEW;2:GOOD;3:POOR;^3;16^Q
 ;;^DD(6919.3,60,0)=STATION NUMBER^F^^9;5^K:$L(X)>5!($L(X)<3) X
 ;;^DD(6919.3,60,3)=Answer must be 3-5 characters in length.
 ;;^DD(6919.3,61,0)=BUDGET OBJECT CODE^F^^9;6^K:$L(X)>4!($L(X)<4) X
 ;;^DD(6919.3,61,3)=Answer must be 4 characters in length.
 ;;^DD(6919.3,62,0)=FUND^F^^9;7^K:$L(X)>6!($L(X)<4) X
 ;;^DD(6919.3,62,3)=Answer must be 4-6 characters in length.
 ;;^DD(6919.3,63,0)=ADMINISTRATIVE/OFFICE^F^^9;8^K:$L(X)>4!($L(X)<2) X
 ;;^DD(6919.3,63,3)=Answer must be 2-4 characters in length.
 ;;^DD(6919.3,64,0)=EQUITY ACCOUNT^S^3299:MEDICAL;3210:NON-MEDICAL;3402:DONATED;^9;9^Q
 ;;^DD(6919.3,70,0)=SPEX^6919.34^^10;0
 ;;^DD(6919.31,0)=RESPONSIBLE SHOP SUB-FIELD^^3^6
 ;;^DD(6919.31,0,"IX","B",6919.31,.01)=
 ;;^DD(6919.31,0,"NM","RESPONSIBLE SHOP")=
 ;;^DD(6919.31,0,"UP")=6919.3
 ;;^DD(6919.31,.01,0)=RESPONSIBLE SHOP^MF^^0;1^K:$L(X)>21!($L(X)<3) X
 ;;^DD(6919.31,.01,1,0)=^.1
 ;;^DD(6919.31,.01,1,1,0)=6919.31^B
 ;;^DD(6919.31,.01,1,1,1)=S ^ENAR(6919.3,DA(1),4,"B",$E(X,1,30),DA)=""
 ;;^DD(6919.31,.01,1,1,2)=K ^ENAR(6919.3,DA(1),4,"B",$E(X,1,30),DA)
 ;;^DD(6919.31,.01,3)=Answer must be 3-21 characters in length.
 ;;^DD(6919.31,1,0)=TECHNICIAN^F^^0;2^K:$L(X)>30!($L(X)<3) X
 ;;^DD(6919.31,1,3)=Answer must be 3-30 characters in length.
 ;;^DD(6919.31,2,0)=STARTING MONTH^S^1:JAN;2:FEB;3:MAR;4:APR;5:MAY;6:JUN;7:JUL;8:AUG;9:SEP;10:OCT;11:NOV;12:DEC;^1;1^Q
 ;;^DD(6919.31,2.6,0)=SKIP MONTHS^F^^0;3^K:$L(X)>7!($L(X)<7) X
 ;;^DD(6919.31,2.6,3)=Answer must be 7 characters in length.
 ;;^DD(6919.31,2.7,0)=CRITICALITY^NJ2,0^^0;4^K:+X'=X!(X>10)!(X<1)!(X?.E1"."1N.N) X
