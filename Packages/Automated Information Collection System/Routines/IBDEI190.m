IBDEI190 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21216,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,in the Field
 ;;^UTILITY(U,$J,358.3,21216,1,4,0)
 ;;=4^R40.2311
 ;;^UTILITY(U,$J,358.3,21216,2)
 ;;=^5019401
 ;;^UTILITY(U,$J,358.3,21217,0)
 ;;=R40.2310^^84^947^13
 ;;^UTILITY(U,$J,358.3,21217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21217,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Unspec Time
 ;;^UTILITY(U,$J,358.3,21217,1,4,0)
 ;;=4^R40.2310
 ;;^UTILITY(U,$J,358.3,21217,2)
 ;;=^5019400
 ;;^UTILITY(U,$J,358.3,21218,0)
 ;;=R40.4^^84^947^38
 ;;^UTILITY(U,$J,358.3,21218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21218,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,21218,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,21218,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,21219,0)
 ;;=V00.811A^^84^948^45
 ;;^UTILITY(U,$J,358.3,21219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21219,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Init Encntr
 ;;^UTILITY(U,$J,358.3,21219,1,4,0)
 ;;=4^V00.811A
 ;;^UTILITY(U,$J,358.3,21219,2)
 ;;=^5055937
 ;;^UTILITY(U,$J,358.3,21220,0)
 ;;=V00.811D^^84^948^46
 ;;^UTILITY(U,$J,358.3,21220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21220,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Subs Encntr
 ;;^UTILITY(U,$J,358.3,21220,1,4,0)
 ;;=4^V00.811D
 ;;^UTILITY(U,$J,358.3,21220,2)
 ;;=^5055938
 ;;^UTILITY(U,$J,358.3,21221,0)
 ;;=V00.812A^^84^948^133
 ;;^UTILITY(U,$J,358.3,21221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21221,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,21221,1,4,0)
 ;;=4^V00.812A
 ;;^UTILITY(U,$J,358.3,21221,2)
 ;;=^5055940
 ;;^UTILITY(U,$J,358.3,21222,0)
 ;;=V00.812D^^84^948^134
 ;;^UTILITY(U,$J,358.3,21222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21222,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21222,1,4,0)
 ;;=4^V00.812D
 ;;^UTILITY(U,$J,358.3,21222,2)
 ;;=^5055941
 ;;^UTILITY(U,$J,358.3,21223,0)
 ;;=V00.818A^^84^948^131
 ;;^UTILITY(U,$J,358.3,21223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21223,1,3,0)
 ;;=3^Wheelchair Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,21223,1,4,0)
 ;;=4^V00.818A
 ;;^UTILITY(U,$J,358.3,21223,2)
 ;;=^5055943
 ;;^UTILITY(U,$J,358.3,21224,0)
 ;;=V00.818D^^84^948^132
 ;;^UTILITY(U,$J,358.3,21224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21224,1,3,0)
 ;;=3^Wheelchair Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21224,1,4,0)
 ;;=4^V00.818D
 ;;^UTILITY(U,$J,358.3,21224,2)
 ;;=^5055944
 ;;^UTILITY(U,$J,358.3,21225,0)
 ;;=V00.831A^^84^948^43
 ;;^UTILITY(U,$J,358.3,21225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21225,1,3,0)
 ;;=3^Fall from Mobility Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,21225,1,4,0)
 ;;=4^V00.831A
 ;;^UTILITY(U,$J,358.3,21225,2)
 ;;=^5055955
 ;;^UTILITY(U,$J,358.3,21226,0)
 ;;=V00.831D^^84^948^44
 ;;^UTILITY(U,$J,358.3,21226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21226,1,3,0)
 ;;=3^Fall from Mobility Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21226,1,4,0)
 ;;=4^V00.831D
 ;;^UTILITY(U,$J,358.3,21226,2)
 ;;=^5055956
 ;;^UTILITY(U,$J,358.3,21227,0)
 ;;=V00.832A^^84^948^95
 ;;^UTILITY(U,$J,358.3,21227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21227,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,21227,1,4,0)
 ;;=4^V00.832A
 ;;^UTILITY(U,$J,358.3,21227,2)
 ;;=^5055958
 ;;^UTILITY(U,$J,358.3,21228,0)
 ;;=V00.832D^^84^948^96
 ;;^UTILITY(U,$J,358.3,21228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21228,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Subs Encntr
