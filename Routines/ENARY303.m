ENARX303 ;(WIRMFO)/SAW/DH/SAB-EQUIPMENT INV. ARCHIVE ;1/10/2001
 ;;7.0;ENGINEERING;**40,68**;Aug 17, 1993
 F I=1:1 S X=$T(Q+I) Q:X=""  S Y=$P(X,"=",2,99),X=$P($E(X,4,99),"=",1) S:X="" X=$P(Y,"=",1),Y=%_$P(Y,"=",2,99) X NO E  S @X=Y
Q Q
 ;;^DD(6919.31,2.7,3)=Type a Number between 1 and 10, 0 Decimal Digits
 ;;^DD(6919.31,3,0)=FREQUENCY^6919.313S^^2;0
 ;;^DD(6919.313,0)=FREQUENCY SUB-FIELD^^5^6
 ;;^DD(6919.313,0,"NM","FREQUENCY")=
 ;;^DD(6919.313,0,"UP")=6919.31
 ;;^DD(6919.313,.01,0)=FREQUENCY^MS^A:ANNUAL;S:SEMI-ANNUAL;Q:QUARTERLY;M:MONTHLY;BM:BI-MONTHLY;W:WEEKLY;BW:BI-WEEKLY;N:NONE;BA:BI-ANNUAL;TA:TRI-ANNUAL;^0;1^Q
 ;;^DD(6919.313,1,0)=HOURS (Estimated)^NJ5,1^^0;2^K:+X'=X!(X>200)!(X<.1)!(X?.E1"."2N.N) X
 ;;^DD(6919.313,1,3)=Type a Number between .1 and 200, 1 Decimal Digit
 ;;^DD(6919.313,2,0)=MATERIAL COST (Estimated)^NJ5,0^^0;3^K:+X'=X!(X>20000)!(X<0)!(X?.E1"."1N.N) X
 ;;^DD(6919.313,2,3)=Type a Number between 0 and 20000, 0 Decimal Digits
 ;;^DD(6919.313,3,0)=LEVEL^F^^0;4^K:$L(X)>12!($L(X)<1) X
 ;;^DD(6919.313,3,3)=Answer must be 1-12 characters in length.
 ;;^DD(6919.313,4,0)=PROCEDURE^F^^0;5^K:$L(X)>20!($L(X)<2) X
 ;;^DD(6919.313,4,3)=Answer must be 2-20 characters in length.
 ;;^DD(6919.313,5,0)=STARTING YEAR^NJ4,0^^0;6^K:+X'=X!(X>2100)!(X<1900)!(X?.E1"."1N.N) X
 ;;^DD(6919.313,5,3)=Type a Number between 1900 and 2100, 0 Decimal Digits
 ;;^DD(6919.32,0)=COMMENTS SUB-FIELD^^.01^1
 ;;^DD(6919.32,0,"NM","COMMENTS")=
 ;;^DD(6919.32,0,"UP")=6919.3
 ;;^DD(6919.32,.01,0)=COMMENTS^W^^0;1^Q
 ;;^DD(6919.33,0)=EQUIPMENT HISTORY SUB-FIELD^^9^10
 ;;^DD(6919.33,0,"NM","EQUIPMENT HISTORY")=
 ;;^DD(6919.33,0,"UP")=6919.3
 ;;^DD(6919.33,.01,0)=HISTORY REFERENCE^F^^0;1^K:$L(X)>12!($L(X)<5) X
 ;;^DD(6919.33,.01,3)=Answer must be 5-12 characters in length.
 ;;^DD(6919.33,1,0)=W.O. REFERENCE^F^^0;2^K:$L(X)>17!($L(X)<5) X
 ;;^DD(6919.33,1,3)=Answer must be 5-17 characters in length.
 ;;^DD(6919.33,2,0)=PM STATUS^S^P:PASS;C:CORRECTIVE ACTION TAKEN/REQUESTED;D0:DEFERRED;D1:DEFERRED, COULD NOT LOCATE;D2:DEFERRED, IN USE;D3:DEFERRED, OUT OF SERVICE OR LOANED OUT;^0;3^Q
 ;;^DD(6919.33,3,0)=HOURS SPENT^NJ7,2^^0;4^K:+X'=X!(X>2080)!(X<0)!(X?.E1"."3N.N) X
 ;;^DD(6919.33,3,3)=Type a Number between 0 and 2080, 2 Decimal Digits
 ;;^DD(6919.33,4,0)=LABOR $^NJ9,2^^0;5^S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>999999)!(X<0) X
 ;;^DD(6919.33,4,3)=Type a Dollar Amount between 0 and 999999, 2 Decimal Digits
 ;;^DD(6919.33,5,0)=MATERIAL $^NJ9,2^^0;6^S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>999999)!(X<0) X
 ;;^DD(6919.33,5,3)=Type a Dollar Amount between 0 and 999999, 2 Decimal Digits
 ;;^DD(6919.33,6,0)=VENDOR $^NJ9,2^^0;7^S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>999999)!(X<0) X
 ;;^DD(6919.33,6,3)=Type a Dollar Amount between 0 and 999999, 2 Decimal Digits
 ;;^DD(6919.33,7,0)=WORKER^F^^0;8^K:$L(X)>15!($L(X)<3) X
 ;;^DD(6919.33,7,3)=Answer must be 3-15 characters in length.
 ;;^DD(6919.33,8,0)=TOTAL COST^CJ8,2^^ ; ^S Y(6919.33,8,1)=$S($D(^ENAR(6919.3,D0,6,D1,0)):^(0),1:"") S X=$P(Y(6919.33,8,1),U,5)+$P(Y(6919.33,8,1),U,6)+$P(Y(6919.33,8,1),U,7) S X=$J(X,0,2)
 ;;^DD(6919.33,8,9)=^
 ;;^DD(6919.33,8,9.01)=6919.33^6;6919.33^5;6919.33^4
 ;;^DD(6919.33,8,9.1)=LABOR $+MATERIAL $+VENDOR $
 ;;^DD(6919.33,9,0)=WORK PERFORMED^F^^0;9^K:$L(X)>140!($L(X)<3) X
 ;;^DD(6919.33,9,3)=Answer must be 3-140 characters in length.
 ;;^DD(6919.34,0)=SPEX SUB-FIELD^^.01^1
 ;;^DD(6919.34,0,"NM","SPEX")=
 ;;^DD(6919.34,0,"UP")=6919.3
 ;;^DD(6919.34,.01,0)=SPEX^W^^0;1^Q
 ;;^DD(6919.35,0)=ORIGINAL BAR CODE ID SUB-FIELD^^.01^1
 ;;^DD(6919.35,0,"DT")=3010110
 ;;^DD(6919.35,0,"IX","B",6919.35,.01)=
 ;;^DD(6919.35,0,"NM","ORIGINAL BAR CODE ID")=
 ;;^DD(6919.35,0,"UP")=6919.3
 ;;^DD(6919.35,.01,0)=ORIGINAL BAR CODE ID^F^^0;1^K:$L(X)>15!($L(X)<3) X
 ;;^DD(6919.35,.01,1,0)=^.1
 ;;^DD(6919.35,.01,1,1,0)=6919.35^B
 ;;^DD(6919.35,.01,1,1,1)=S ^ENAR(6919.3,DA(1),12,"B",$E(X,1,30),DA)=""
 ;;^DD(6919.35,.01,1,1,2)=K ^ENAR(6919.3,DA(1),12,"B",$E(X,1,30),DA)
 ;;^DD(6919.35,.01,3)=Answer must be 3-15 characters in length.
 ;;^DD(6919.35,.01,"DT")=3010110
