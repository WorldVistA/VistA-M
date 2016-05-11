IBDEI0GP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7722,2)
 ;;=^5019403
 ;;^UTILITY(U,$J,358.3,7723,0)
 ;;=R40.2312^^30^414^12
 ;;^UTILITY(U,$J,358.3,7723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7723,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Emerg Dept
 ;;^UTILITY(U,$J,358.3,7723,1,4,0)
 ;;=4^R40.2312
 ;;^UTILITY(U,$J,358.3,7723,2)
 ;;=^5019402
 ;;^UTILITY(U,$J,358.3,7724,0)
 ;;=R40.2311^^30^414^15
 ;;^UTILITY(U,$J,358.3,7724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7724,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,in the Field
 ;;^UTILITY(U,$J,358.3,7724,1,4,0)
 ;;=4^R40.2311
 ;;^UTILITY(U,$J,358.3,7724,2)
 ;;=^5019401
 ;;^UTILITY(U,$J,358.3,7725,0)
 ;;=R40.2310^^30^414^13
 ;;^UTILITY(U,$J,358.3,7725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7725,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Unspec Time
 ;;^UTILITY(U,$J,358.3,7725,1,4,0)
 ;;=4^R40.2310
 ;;^UTILITY(U,$J,358.3,7725,2)
 ;;=^5019400
 ;;^UTILITY(U,$J,358.3,7726,0)
 ;;=R40.4^^30^414^38
 ;;^UTILITY(U,$J,358.3,7726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7726,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,7726,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,7726,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,7727,0)
 ;;=V00.811A^^30^415^45
 ;;^UTILITY(U,$J,358.3,7727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7727,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Init Encntr
 ;;^UTILITY(U,$J,358.3,7727,1,4,0)
 ;;=4^V00.811A
 ;;^UTILITY(U,$J,358.3,7727,2)
 ;;=^5055937
 ;;^UTILITY(U,$J,358.3,7728,0)
 ;;=V00.811D^^30^415^46
 ;;^UTILITY(U,$J,358.3,7728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7728,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Subs Encntr
 ;;^UTILITY(U,$J,358.3,7728,1,4,0)
 ;;=4^V00.811D
 ;;^UTILITY(U,$J,358.3,7728,2)
 ;;=^5055938
 ;;^UTILITY(U,$J,358.3,7729,0)
 ;;=V00.812A^^30^415^133
 ;;^UTILITY(U,$J,358.3,7729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7729,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,7729,1,4,0)
 ;;=4^V00.812A
 ;;^UTILITY(U,$J,358.3,7729,2)
 ;;=^5055940
 ;;^UTILITY(U,$J,358.3,7730,0)
 ;;=V00.812D^^30^415^134
 ;;^UTILITY(U,$J,358.3,7730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7730,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7730,1,4,0)
 ;;=4^V00.812D
 ;;^UTILITY(U,$J,358.3,7730,2)
 ;;=^5055941
 ;;^UTILITY(U,$J,358.3,7731,0)
 ;;=V00.818A^^30^415^131
 ;;^UTILITY(U,$J,358.3,7731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7731,1,3,0)
 ;;=3^Wheelchair Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,7731,1,4,0)
 ;;=4^V00.818A
 ;;^UTILITY(U,$J,358.3,7731,2)
 ;;=^5055943
 ;;^UTILITY(U,$J,358.3,7732,0)
 ;;=V00.818D^^30^415^132
 ;;^UTILITY(U,$J,358.3,7732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7732,1,3,0)
 ;;=3^Wheelchair Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7732,1,4,0)
 ;;=4^V00.818D
 ;;^UTILITY(U,$J,358.3,7732,2)
 ;;=^5055944
 ;;^UTILITY(U,$J,358.3,7733,0)
 ;;=V00.831A^^30^415^43
 ;;^UTILITY(U,$J,358.3,7733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7733,1,3,0)
 ;;=3^Fall from Mobility Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,7733,1,4,0)
 ;;=4^V00.831A
 ;;^UTILITY(U,$J,358.3,7733,2)
 ;;=^5055955
 ;;^UTILITY(U,$J,358.3,7734,0)
 ;;=V00.831D^^30^415^44
 ;;^UTILITY(U,$J,358.3,7734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7734,1,3,0)
 ;;=3^Fall from Mobility Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7734,1,4,0)
 ;;=4^V00.831D
 ;;^UTILITY(U,$J,358.3,7734,2)
 ;;=^5055956
 ;;^UTILITY(U,$J,358.3,7735,0)
 ;;=V00.832A^^30^415^95
 ;;^UTILITY(U,$J,358.3,7735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7735,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Init Encntr
