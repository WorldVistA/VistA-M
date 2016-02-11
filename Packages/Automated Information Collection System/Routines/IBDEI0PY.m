IBDEI0PY ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11887,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,in the Field
 ;;^UTILITY(U,$J,358.3,11887,1,4,0)
 ;;=4^R40.2311
 ;;^UTILITY(U,$J,358.3,11887,2)
 ;;=^5019401
 ;;^UTILITY(U,$J,358.3,11888,0)
 ;;=R40.2310^^68^693^13
 ;;^UTILITY(U,$J,358.3,11888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11888,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Unspec Time
 ;;^UTILITY(U,$J,358.3,11888,1,4,0)
 ;;=4^R40.2310
 ;;^UTILITY(U,$J,358.3,11888,2)
 ;;=^5019400
 ;;^UTILITY(U,$J,358.3,11889,0)
 ;;=R40.4^^68^693^38
 ;;^UTILITY(U,$J,358.3,11889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11889,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,11889,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,11889,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,11890,0)
 ;;=V00.811A^^68^694^45
 ;;^UTILITY(U,$J,358.3,11890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11890,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Init Encntr
 ;;^UTILITY(U,$J,358.3,11890,1,4,0)
 ;;=4^V00.811A
 ;;^UTILITY(U,$J,358.3,11890,2)
 ;;=^5055937
 ;;^UTILITY(U,$J,358.3,11891,0)
 ;;=V00.811D^^68^694^46
 ;;^UTILITY(U,$J,358.3,11891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11891,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Subs Encntr
 ;;^UTILITY(U,$J,358.3,11891,1,4,0)
 ;;=4^V00.811D
 ;;^UTILITY(U,$J,358.3,11891,2)
 ;;=^5055938
 ;;^UTILITY(U,$J,358.3,11892,0)
 ;;=V00.812A^^68^694^133
 ;;^UTILITY(U,$J,358.3,11892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11892,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,11892,1,4,0)
 ;;=4^V00.812A
 ;;^UTILITY(U,$J,358.3,11892,2)
 ;;=^5055940
 ;;^UTILITY(U,$J,358.3,11893,0)
 ;;=V00.812D^^68^694^134
 ;;^UTILITY(U,$J,358.3,11893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11893,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11893,1,4,0)
 ;;=4^V00.812D
 ;;^UTILITY(U,$J,358.3,11893,2)
 ;;=^5055941
 ;;^UTILITY(U,$J,358.3,11894,0)
 ;;=V00.818A^^68^694^131
 ;;^UTILITY(U,$J,358.3,11894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11894,1,3,0)
 ;;=3^Wheelchair Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,11894,1,4,0)
 ;;=4^V00.818A
 ;;^UTILITY(U,$J,358.3,11894,2)
 ;;=^5055943
 ;;^UTILITY(U,$J,358.3,11895,0)
 ;;=V00.818D^^68^694^132
 ;;^UTILITY(U,$J,358.3,11895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11895,1,3,0)
 ;;=3^Wheelchair Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11895,1,4,0)
 ;;=4^V00.818D
 ;;^UTILITY(U,$J,358.3,11895,2)
 ;;=^5055944
 ;;^UTILITY(U,$J,358.3,11896,0)
 ;;=V00.831A^^68^694^43
 ;;^UTILITY(U,$J,358.3,11896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11896,1,3,0)
 ;;=3^Fall from Mobility Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,11896,1,4,0)
 ;;=4^V00.831A
 ;;^UTILITY(U,$J,358.3,11896,2)
 ;;=^5055955
 ;;^UTILITY(U,$J,358.3,11897,0)
 ;;=V00.831D^^68^694^44
 ;;^UTILITY(U,$J,358.3,11897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11897,1,3,0)
 ;;=3^Fall from Mobility Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11897,1,4,0)
 ;;=4^V00.831D
 ;;^UTILITY(U,$J,358.3,11897,2)
 ;;=^5055956
 ;;^UTILITY(U,$J,358.3,11898,0)
 ;;=V00.832A^^68^694^95
 ;;^UTILITY(U,$J,358.3,11898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11898,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,11898,1,4,0)
 ;;=4^V00.832A
 ;;^UTILITY(U,$J,358.3,11898,2)
 ;;=^5055958
 ;;^UTILITY(U,$J,358.3,11899,0)
 ;;=V00.832D^^68^694^96
 ;;^UTILITY(U,$J,358.3,11899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11899,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Subs Encntr
