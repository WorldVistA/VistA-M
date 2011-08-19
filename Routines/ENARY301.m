ENARX301 ;(WIRMFO)/SAW/DH/SAB-EQUIPMENT INV. ARCHIVE ;2.14.97
 ;;7.0;ENGINEERING;**40**;Aug 17, 1993
 F I=1:1 S X=$T(Q+I) Q:X=""  S Y=$P(X,"=",2,99),X=$P($E(X,4,99),"=",1) S:X="" X=$P(Y,"=",1),Y=%_$P(Y,"=",2,99) X NO E  S @X=Y
Q Q
 ;;^DIC(6919.3,0,"DD")=@
 ;;^DIC(6919.3,0,"GL")=^ENAR(6919.3,
 ;;^DIC(6919.3,0,"WR")=@
 ;;^DIC("B","EQUIPMENT INV. ARCHIVE",6919.3)=
 ;;^DD(6919.3,0)=FIELD^^70^62
 ;;^DD(6919.3,0,"IX","B",6919.3,.01)=
 ;;^DD(6919.3,0,"NM","EQUIPMENT INV. ARCHIVE")=
 ;;^DD(6919.3,.01,0)=ENTRY NUMBER^RF^^0;1^K:$L(X)>14!($L(X)<5) X
 ;;^DD(6919.3,.01,1,0)=^.1
 ;;^DD(6919.3,.01,1,1,0)=6919.3^B
 ;;^DD(6919.3,.01,1,1,1)=S ^ENAR(6919.3,"B",$E(X,1,30),DA)=""
 ;;^DD(6919.3,.01,1,1,2)=K ^ENAR(6919.3,"B",$E(X,1,30),DA)
 ;;^DD(6919.3,.01,3)=Answer must be 5-14 characters in length.
 ;;^DD(6919.3,.5,0)=ENTERED BY^F^^0;6^K:$L(X)>30!($L(X)<1) X
 ;;^DD(6919.3,.5,3)=Answer must be 1-30 characters in length.
 ;;^DD(6919.3,.6,0)=DATE ENTERED^D^^0;7^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(6919.3,1,0)=MANUFACTURER^F^^1;4^K:$L(X)>60!($L(X)<1) X
 ;;^DD(6919.3,1,3)=Answer must be 1-60 characters in length.
 ;;^DD(6919.3,2,0)=PARENT SYSTEM^NJ10,0^^0;3^K:+X'=X!(X>9999999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(6919.3,2,3)=Type a Number between 1 and 9999999999, 0 Decimal Digits
 ;;^DD(6919.3,3,0)=MFGR. EQUIPMENT NAME^F^^0;2^K:$L(X)>80!($L(X)<1) X
 ;;^DD(6919.3,3,3)=Answer must be 1-80 characters in length.
 ;;^DD(6919.3,4,0)=MODEL^F^^1;2^K:$L(X)>30!($L(X)<1) X
 ;;^DD(6919.3,4,3)=Answer must be 1-30 characters in length.
 ;;^DD(6919.3,5,0)=SERIAL #^F^^1;3^K:$L(X)>30!($L(X)<1) X
 ;;^DD(6919.3,5,3)=Answer must be 1-30 characters in length.
 ;;^DD(6919.3,6,0)=EQUIPMENT CATEGORY^F^^1;1^K:$L(X)>50!($L(X)<1) X
 ;;^DD(6919.3,6,3)=Answer must be 1-50 characters in length.
 ;;^DD(6919.3,7,0)=TYPE OF ENTRY^S^NX:NON-EXPENDABLE EQPT;BSE:BUILDING SERVICE EQPT;EXP:EXPENDABLE EQPT;^0;4^Q
 ;;^DD(6919.3,9,0)=LOCKOUT REQUIRED?^S^0:NO;1:YES;^0;5^Q
 ;;^DD(6919.3,10,0)=VENDOR^F^^2;1^K:$L(X)>36!($L(X)<1) X
 ;;^DD(6919.3,10,3)=Answer must be 1-36 characters in length.
 ;;^DD(6919.3,11,0)=PURCHASE ORDER #^F^^2;2^K:$L(X)>12!($L(X)<1) X
 ;;^DD(6919.3,11,3)=Answer must be 1-12 characters in length.
 ;;^DD(6919.3,12,0)=TOTAL ASSET VALUE^NJ11,2^^2;3^S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>99999999)!(X<0) X
 ;;^DD(6919.3,12,3)=Type a Dollar Amount between 0 and 99999999, 2 Decimal Digits
 ;;^DD(6919.3,12.5,0)=LEASE COST^NJ10,2^^2;12^S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 ;;^DD(6919.3,12.5,3)=Type a Dollar Amount between 0 and 9999999, 2 Decimal Digits
 ;;^DD(6919.3,13,0)=ACQUISITION DATE^D^^2;4^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(6919.3,13.5,0)=ACQUISITION SOURCE^F^^2;14^K:$L(X)>1!($L(X)<1) X
 ;;^DD(6919.3,13.5,3)=Answer must be 1 character in length.
 ;;^DD(6919.3,14,0)=WARRANTY EXP. DATE^D^^2;5^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(6919.3,15,0)=LIFE EXPECTANCY^NJ2,0^^2;6^K:+X'=X!(X>99)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(6919.3,15,3)=Type a Number between 1 and 99, 0 Decimal Digits
 ;;^DD(6919.3,16,0)=REPLACEMENT DATE^D^^2;10^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(6919.3,17,0)=NXRN #^NJ8,0^^2;7^K:+X'=X!(X>99999999)!(X<0)!(X?.E1"."1N.N) X
 ;;^DD(6919.3,17,3)=Type a Number between 0 and 99999999, 0 Decimal Digits
 ;;^DD(6919.3,18,0)=CATEGORY STOCK NUMBER^F^^2;8^K:$L(X)>11!($L(X)<11) X
 ;;^DD(6919.3,18,3)=Answer must be 11 characters in length.
 ;;^DD(6919.3,19,0)=CMR^F^^2;9^K:$L(X)>5!($L(X)<2) X
 ;;^DD(6919.3,19,3)=Answer must be 2-5 characters in length.
 ;;^DD(6919.3,19.5,0)=SERVICE CONTRACT^S^Y:YES;N:NO;^7;1^Q
 ;;^DD(6919.3,19.6,0)=SERVICE CONTRACT COST^NJ9,2^^7;2^S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>500000)!(X<0) X
 ;;^DD(6919.3,19.6,3)=Type a Dollar Amount between 0 and 500000, 2 Decimal Digits
 ;;^DD(6919.3,20,0)=USE STATUS^S^1:IN USE;2:OUT OF SERVICE;3:LOANED OUT;4:TURNED IN;5:LOST OR STOLEN;^3;1^Q
 ;;^DD(6919.3,20.1,0)=ACQUISITION METHOD^S^C:CONSTRUCTED;G:GIFT/BEQUEST/DONATION;L:LEASED;M:LEASED/PURCHASED;O:OTHER;P:PURCHASED;R:TRANSFERRED;T:TRADED;X:EXCESS;1:ON LOAN TO VAMC;^3;4^Q
 ;;^DD(6919.3,20.5,0)=TURN-IN DATE^D^^3;3^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(6919.3,21,0)=SERVICE^F^^3;2^K:$L(X)>30!($L(X)<3) X
 ;;^DD(6919.3,21,3)=Answer must be 3-30 characters in length.
 ;;^DD(6919.3,22,0)=DISPOSITION DATE^D^^3;11^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(6919.3,23,0)=PHYSICAL INVENTORY DATE^D^^2;13^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(6919.3,24,0)=LOCATION^F^^3;5^K:$L(X)>20!($L(X)<3) X
 ;;^DD(6919.3,24,3)=Answer must be 3-20 characters in length.
