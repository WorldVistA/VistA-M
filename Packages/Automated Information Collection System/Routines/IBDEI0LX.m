IBDEI0LX ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9864,0)
 ;;=V00.811D^^39^420^51
 ;;^UTILITY(U,$J,358.3,9864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9864,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Subs Encntr
 ;;^UTILITY(U,$J,358.3,9864,1,4,0)
 ;;=4^V00.811D
 ;;^UTILITY(U,$J,358.3,9864,2)
 ;;=^5055938
 ;;^UTILITY(U,$J,358.3,9865,0)
 ;;=V00.812A^^39^420^142
 ;;^UTILITY(U,$J,358.3,9865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9865,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,9865,1,4,0)
 ;;=4^V00.812A
 ;;^UTILITY(U,$J,358.3,9865,2)
 ;;=^5055940
 ;;^UTILITY(U,$J,358.3,9866,0)
 ;;=V00.812D^^39^420^143
 ;;^UTILITY(U,$J,358.3,9866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9866,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9866,1,4,0)
 ;;=4^V00.812D
 ;;^UTILITY(U,$J,358.3,9866,2)
 ;;=^5055941
 ;;^UTILITY(U,$J,358.3,9867,0)
 ;;=V00.818A^^39^420^140
 ;;^UTILITY(U,$J,358.3,9867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9867,1,3,0)
 ;;=3^Wheelchair Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,9867,1,4,0)
 ;;=4^V00.818A
 ;;^UTILITY(U,$J,358.3,9867,2)
 ;;=^5055943
 ;;^UTILITY(U,$J,358.3,9868,0)
 ;;=V00.818D^^39^420^141
 ;;^UTILITY(U,$J,358.3,9868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9868,1,3,0)
 ;;=3^Wheelchair Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9868,1,4,0)
 ;;=4^V00.818D
 ;;^UTILITY(U,$J,358.3,9868,2)
 ;;=^5055944
 ;;^UTILITY(U,$J,358.3,9869,0)
 ;;=V00.831A^^39^420^48
 ;;^UTILITY(U,$J,358.3,9869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9869,1,3,0)
 ;;=3^Fall from Mobility Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,9869,1,4,0)
 ;;=4^V00.831A
 ;;^UTILITY(U,$J,358.3,9869,2)
 ;;=^5055955
 ;;^UTILITY(U,$J,358.3,9870,0)
 ;;=V00.831D^^39^420^49
 ;;^UTILITY(U,$J,358.3,9870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9870,1,3,0)
 ;;=3^Fall from Mobility Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9870,1,4,0)
 ;;=4^V00.831D
 ;;^UTILITY(U,$J,358.3,9870,2)
 ;;=^5055956
 ;;^UTILITY(U,$J,358.3,9871,0)
 ;;=V00.832A^^39^420^100
 ;;^UTILITY(U,$J,358.3,9871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9871,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,9871,1,4,0)
 ;;=4^V00.832A
 ;;^UTILITY(U,$J,358.3,9871,2)
 ;;=^5055958
 ;;^UTILITY(U,$J,358.3,9872,0)
 ;;=V00.832D^^39^420^101
 ;;^UTILITY(U,$J,358.3,9872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9872,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9872,1,4,0)
 ;;=4^V00.832D
 ;;^UTILITY(U,$J,358.3,9872,2)
 ;;=^5055959
 ;;^UTILITY(U,$J,358.3,9873,0)
 ;;=V00.838A^^39^420^98
 ;;^UTILITY(U,$J,358.3,9873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9873,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,9873,1,4,0)
 ;;=4^V00.838A
 ;;^UTILITY(U,$J,358.3,9873,2)
 ;;=^5055961
 ;;^UTILITY(U,$J,358.3,9874,0)
 ;;=V00.838D^^39^420^99
 ;;^UTILITY(U,$J,358.3,9874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9874,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9874,1,4,0)
 ;;=4^V00.838D
 ;;^UTILITY(U,$J,358.3,9874,2)
 ;;=^5055962
 ;;^UTILITY(U,$J,358.3,9875,0)
 ;;=V00.891A^^39^420^62
 ;;^UTILITY(U,$J,358.3,9875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9875,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Init Encntr
 ;;^UTILITY(U,$J,358.3,9875,1,4,0)
 ;;=4^V00.891A
