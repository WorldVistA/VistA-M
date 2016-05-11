IBDEI0V4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14590,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,in the Field
 ;;^UTILITY(U,$J,358.3,14590,1,4,0)
 ;;=4^R40.2311
 ;;^UTILITY(U,$J,358.3,14590,2)
 ;;=^5019401
 ;;^UTILITY(U,$J,358.3,14591,0)
 ;;=R40.2310^^53^611^13
 ;;^UTILITY(U,$J,358.3,14591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14591,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Unspec Time
 ;;^UTILITY(U,$J,358.3,14591,1,4,0)
 ;;=4^R40.2310
 ;;^UTILITY(U,$J,358.3,14591,2)
 ;;=^5019400
 ;;^UTILITY(U,$J,358.3,14592,0)
 ;;=R40.4^^53^611^38
 ;;^UTILITY(U,$J,358.3,14592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14592,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,14592,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,14592,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,14593,0)
 ;;=V00.811A^^53^612^45
 ;;^UTILITY(U,$J,358.3,14593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14593,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Init Encntr
 ;;^UTILITY(U,$J,358.3,14593,1,4,0)
 ;;=4^V00.811A
 ;;^UTILITY(U,$J,358.3,14593,2)
 ;;=^5055937
 ;;^UTILITY(U,$J,358.3,14594,0)
 ;;=V00.811D^^53^612^46
 ;;^UTILITY(U,$J,358.3,14594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14594,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Subs Encntr
 ;;^UTILITY(U,$J,358.3,14594,1,4,0)
 ;;=4^V00.811D
 ;;^UTILITY(U,$J,358.3,14594,2)
 ;;=^5055938
 ;;^UTILITY(U,$J,358.3,14595,0)
 ;;=V00.812A^^53^612^133
 ;;^UTILITY(U,$J,358.3,14595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14595,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,14595,1,4,0)
 ;;=4^V00.812A
 ;;^UTILITY(U,$J,358.3,14595,2)
 ;;=^5055940
 ;;^UTILITY(U,$J,358.3,14596,0)
 ;;=V00.812D^^53^612^134
 ;;^UTILITY(U,$J,358.3,14596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14596,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14596,1,4,0)
 ;;=4^V00.812D
 ;;^UTILITY(U,$J,358.3,14596,2)
 ;;=^5055941
 ;;^UTILITY(U,$J,358.3,14597,0)
 ;;=V00.818A^^53^612^131
 ;;^UTILITY(U,$J,358.3,14597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14597,1,3,0)
 ;;=3^Wheelchair Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,14597,1,4,0)
 ;;=4^V00.818A
 ;;^UTILITY(U,$J,358.3,14597,2)
 ;;=^5055943
 ;;^UTILITY(U,$J,358.3,14598,0)
 ;;=V00.818D^^53^612^132
 ;;^UTILITY(U,$J,358.3,14598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14598,1,3,0)
 ;;=3^Wheelchair Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14598,1,4,0)
 ;;=4^V00.818D
 ;;^UTILITY(U,$J,358.3,14598,2)
 ;;=^5055944
 ;;^UTILITY(U,$J,358.3,14599,0)
 ;;=V00.831A^^53^612^43
 ;;^UTILITY(U,$J,358.3,14599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14599,1,3,0)
 ;;=3^Fall from Mobility Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,14599,1,4,0)
 ;;=4^V00.831A
 ;;^UTILITY(U,$J,358.3,14599,2)
 ;;=^5055955
 ;;^UTILITY(U,$J,358.3,14600,0)
 ;;=V00.831D^^53^612^44
 ;;^UTILITY(U,$J,358.3,14600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14600,1,3,0)
 ;;=3^Fall from Mobility Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14600,1,4,0)
 ;;=4^V00.831D
 ;;^UTILITY(U,$J,358.3,14600,2)
 ;;=^5055956
 ;;^UTILITY(U,$J,358.3,14601,0)
 ;;=V00.832A^^53^612^95
 ;;^UTILITY(U,$J,358.3,14601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14601,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,14601,1,4,0)
 ;;=4^V00.832A
 ;;^UTILITY(U,$J,358.3,14601,2)
 ;;=^5055958
 ;;^UTILITY(U,$J,358.3,14602,0)
 ;;=V00.832D^^53^612^96
 ;;^UTILITY(U,$J,358.3,14602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14602,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Subs Encntr
