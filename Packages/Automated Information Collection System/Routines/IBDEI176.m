IBDEI176 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20007,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Init Encntr
 ;;^UTILITY(U,$J,358.3,20007,1,4,0)
 ;;=4^V00.811A
 ;;^UTILITY(U,$J,358.3,20007,2)
 ;;=^5055937
 ;;^UTILITY(U,$J,358.3,20008,0)
 ;;=V00.811D^^94^935^46
 ;;^UTILITY(U,$J,358.3,20008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20008,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Subs Encntr
 ;;^UTILITY(U,$J,358.3,20008,1,4,0)
 ;;=4^V00.811D
 ;;^UTILITY(U,$J,358.3,20008,2)
 ;;=^5055938
 ;;^UTILITY(U,$J,358.3,20009,0)
 ;;=V00.812A^^94^935^133
 ;;^UTILITY(U,$J,358.3,20009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20009,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,20009,1,4,0)
 ;;=4^V00.812A
 ;;^UTILITY(U,$J,358.3,20009,2)
 ;;=^5055940
 ;;^UTILITY(U,$J,358.3,20010,0)
 ;;=V00.812D^^94^935^134
 ;;^UTILITY(U,$J,358.3,20010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20010,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20010,1,4,0)
 ;;=4^V00.812D
 ;;^UTILITY(U,$J,358.3,20010,2)
 ;;=^5055941
 ;;^UTILITY(U,$J,358.3,20011,0)
 ;;=V00.818A^^94^935^131
 ;;^UTILITY(U,$J,358.3,20011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20011,1,3,0)
 ;;=3^Wheelchair Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,20011,1,4,0)
 ;;=4^V00.818A
 ;;^UTILITY(U,$J,358.3,20011,2)
 ;;=^5055943
 ;;^UTILITY(U,$J,358.3,20012,0)
 ;;=V00.818D^^94^935^132
 ;;^UTILITY(U,$J,358.3,20012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20012,1,3,0)
 ;;=3^Wheelchair Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20012,1,4,0)
 ;;=4^V00.818D
 ;;^UTILITY(U,$J,358.3,20012,2)
 ;;=^5055944
 ;;^UTILITY(U,$J,358.3,20013,0)
 ;;=V00.831A^^94^935^43
 ;;^UTILITY(U,$J,358.3,20013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20013,1,3,0)
 ;;=3^Fall from Mobility Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,20013,1,4,0)
 ;;=4^V00.831A
 ;;^UTILITY(U,$J,358.3,20013,2)
 ;;=^5055955
 ;;^UTILITY(U,$J,358.3,20014,0)
 ;;=V00.831D^^94^935^44
 ;;^UTILITY(U,$J,358.3,20014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20014,1,3,0)
 ;;=3^Fall from Mobility Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20014,1,4,0)
 ;;=4^V00.831D
 ;;^UTILITY(U,$J,358.3,20014,2)
 ;;=^5055956
 ;;^UTILITY(U,$J,358.3,20015,0)
 ;;=V00.832A^^94^935^95
 ;;^UTILITY(U,$J,358.3,20015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20015,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,20015,1,4,0)
 ;;=4^V00.832A
 ;;^UTILITY(U,$J,358.3,20015,2)
 ;;=^5055958
 ;;^UTILITY(U,$J,358.3,20016,0)
 ;;=V00.832D^^94^935^96
 ;;^UTILITY(U,$J,358.3,20016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20016,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20016,1,4,0)
 ;;=4^V00.832D
 ;;^UTILITY(U,$J,358.3,20016,2)
 ;;=^5055959
 ;;^UTILITY(U,$J,358.3,20017,0)
 ;;=V00.838A^^94^935^93
 ;;^UTILITY(U,$J,358.3,20017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20017,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,20017,1,4,0)
 ;;=4^V00.838A
 ;;^UTILITY(U,$J,358.3,20017,2)
 ;;=^5055961
 ;;^UTILITY(U,$J,358.3,20018,0)
 ;;=V00.838D^^94^935^94
 ;;^UTILITY(U,$J,358.3,20018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20018,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20018,1,4,0)
 ;;=4^V00.838D
 ;;^UTILITY(U,$J,358.3,20018,2)
 ;;=^5055962
 ;;^UTILITY(U,$J,358.3,20019,0)
 ;;=V00.891A^^94^935^57
 ;;^UTILITY(U,$J,358.3,20019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20019,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Init Encntr
