IBDEI08Q ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8678,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8678,1,4,0)
 ;;=4^V00.812D
 ;;^UTILITY(U,$J,358.3,8678,2)
 ;;=^5055941
 ;;^UTILITY(U,$J,358.3,8679,0)
 ;;=V00.818A^^42^517^131
 ;;^UTILITY(U,$J,358.3,8679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8679,1,3,0)
 ;;=3^Wheelchair Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,8679,1,4,0)
 ;;=4^V00.818A
 ;;^UTILITY(U,$J,358.3,8679,2)
 ;;=^5055943
 ;;^UTILITY(U,$J,358.3,8680,0)
 ;;=V00.818D^^42^517^132
 ;;^UTILITY(U,$J,358.3,8680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8680,1,3,0)
 ;;=3^Wheelchair Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8680,1,4,0)
 ;;=4^V00.818D
 ;;^UTILITY(U,$J,358.3,8680,2)
 ;;=^5055944
 ;;^UTILITY(U,$J,358.3,8681,0)
 ;;=V00.831A^^42^517^43
 ;;^UTILITY(U,$J,358.3,8681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8681,1,3,0)
 ;;=3^Fall from Mobility Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,8681,1,4,0)
 ;;=4^V00.831A
 ;;^UTILITY(U,$J,358.3,8681,2)
 ;;=^5055955
 ;;^UTILITY(U,$J,358.3,8682,0)
 ;;=V00.831D^^42^517^44
 ;;^UTILITY(U,$J,358.3,8682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8682,1,3,0)
 ;;=3^Fall from Mobility Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8682,1,4,0)
 ;;=4^V00.831D
 ;;^UTILITY(U,$J,358.3,8682,2)
 ;;=^5055956
 ;;^UTILITY(U,$J,358.3,8683,0)
 ;;=V00.832A^^42^517^95
 ;;^UTILITY(U,$J,358.3,8683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8683,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,8683,1,4,0)
 ;;=4^V00.832A
 ;;^UTILITY(U,$J,358.3,8683,2)
 ;;=^5055958
 ;;^UTILITY(U,$J,358.3,8684,0)
 ;;=V00.832D^^42^517^96
 ;;^UTILITY(U,$J,358.3,8684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8684,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8684,1,4,0)
 ;;=4^V00.832D
 ;;^UTILITY(U,$J,358.3,8684,2)
 ;;=^5055959
 ;;^UTILITY(U,$J,358.3,8685,0)
 ;;=V00.838A^^42^517^93
 ;;^UTILITY(U,$J,358.3,8685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8685,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,8685,1,4,0)
 ;;=4^V00.838A
 ;;^UTILITY(U,$J,358.3,8685,2)
 ;;=^5055961
 ;;^UTILITY(U,$J,358.3,8686,0)
 ;;=V00.838D^^42^517^94
 ;;^UTILITY(U,$J,358.3,8686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8686,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8686,1,4,0)
 ;;=4^V00.838D
 ;;^UTILITY(U,$J,358.3,8686,2)
 ;;=^5055962
 ;;^UTILITY(U,$J,358.3,8687,0)
 ;;=V00.891A^^42^517^57
 ;;^UTILITY(U,$J,358.3,8687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8687,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Init Encntr
 ;;^UTILITY(U,$J,358.3,8687,1,4,0)
 ;;=4^V00.891A
 ;;^UTILITY(U,$J,358.3,8687,2)
 ;;=^5055964
 ;;^UTILITY(U,$J,358.3,8688,0)
 ;;=V00.891D^^42^517^58
 ;;^UTILITY(U,$J,358.3,8688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8688,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8688,1,4,0)
 ;;=4^V00.891D
 ;;^UTILITY(U,$J,358.3,8688,2)
 ;;=^5055965
 ;;^UTILITY(U,$J,358.3,8689,0)
 ;;=V00.892A^^42^517^99
 ;;^UTILITY(U,$J,358.3,8689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8689,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,8689,1,4,0)
 ;;=4^V00.892A
 ;;^UTILITY(U,$J,358.3,8689,2)
 ;;=^5055967
 ;;^UTILITY(U,$J,358.3,8690,0)
 ;;=V00.892D^^42^517^100
 ;;^UTILITY(U,$J,358.3,8690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8690,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8690,1,4,0)
 ;;=4^V00.892D
 ;;^UTILITY(U,$J,358.3,8690,2)
 ;;=^5055968
 ;;^UTILITY(U,$J,358.3,8691,0)
 ;;=V00.898A^^42^517^97
 ;;^UTILITY(U,$J,358.3,8691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8691,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,8691,1,4,0)
 ;;=4^V00.898A
 ;;^UTILITY(U,$J,358.3,8691,2)
 ;;=^5055970
 ;;^UTILITY(U,$J,358.3,8692,0)
 ;;=V00.898D^^42^517^98
 ;;^UTILITY(U,$J,358.3,8692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8692,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8692,1,4,0)
 ;;=4^V00.898D
 ;;^UTILITY(U,$J,358.3,8692,2)
 ;;=^5055971
 ;;^UTILITY(U,$J,358.3,8693,0)
 ;;=W00.0XXA^^42^517^79
 ;;^UTILITY(U,$J,358.3,8693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8693,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,8693,1,4,0)
 ;;=4^W00.0XXA
 ;;^UTILITY(U,$J,358.3,8693,2)
 ;;=^5059510
 ;;^UTILITY(U,$J,358.3,8694,0)
 ;;=W00.0XXD^^42^517^80
 ;;^UTILITY(U,$J,358.3,8694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8694,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8694,1,4,0)
 ;;=4^W00.0XXD
 ;;^UTILITY(U,$J,358.3,8694,2)
 ;;=^5059511
 ;;^UTILITY(U,$J,358.3,8695,0)
 ;;=W00.1XXA^^42^517^59
 ;;^UTILITY(U,$J,358.3,8695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8695,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,8695,1,4,0)
 ;;=4^W00.1XXA
 ;;^UTILITY(U,$J,358.3,8695,2)
 ;;=^5059513
 ;;^UTILITY(U,$J,358.3,8696,0)
 ;;=W00.1XXD^^42^517^60
 ;;^UTILITY(U,$J,358.3,8696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8696,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8696,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,8696,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,8697,0)
 ;;=W00.2XXA^^42^517^53
 ;;^UTILITY(U,$J,358.3,8697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8697,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,8697,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,8697,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,8698,0)
 ;;=W00.2XXD^^42^517^54
 ;;^UTILITY(U,$J,358.3,8698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8698,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8698,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,8698,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,8699,0)
 ;;=W00.9XXA^^42^517^25
 ;;^UTILITY(U,$J,358.3,8699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8699,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,8699,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,8699,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,8700,0)
 ;;=W00.9XXD^^42^517^26
 ;;^UTILITY(U,$J,358.3,8700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8700,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8700,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,8700,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,8701,0)
 ;;=W01.0XXA^^42^517^87
 ;;^UTILITY(U,$J,358.3,8701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8701,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,8701,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,8701,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,8702,0)
 ;;=W01.0XXD^^42^517^88
 ;;^UTILITY(U,$J,358.3,8702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8702,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8702,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,8702,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,8703,0)
 ;;=W03.XXXA^^42^517^85
 ;;^UTILITY(U,$J,358.3,8703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8703,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,8703,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,8703,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,8704,0)
 ;;=W03.XXXD^^42^517^86
 ;;^UTILITY(U,$J,358.3,8704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8704,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8704,1,4,0)
 ;;=4^W03.XXXD
