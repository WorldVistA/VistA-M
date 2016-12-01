IBDEI0R8 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35984,1,4,0)
 ;;=4^V00.811D
 ;;^UTILITY(U,$J,358.3,35984,2)
 ;;=^5055938
 ;;^UTILITY(U,$J,358.3,35985,0)
 ;;=V00.812A^^100^1526^133
 ;;^UTILITY(U,$J,358.3,35985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35985,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,35985,1,4,0)
 ;;=4^V00.812A
 ;;^UTILITY(U,$J,358.3,35985,2)
 ;;=^5055940
 ;;^UTILITY(U,$J,358.3,35986,0)
 ;;=V00.812D^^100^1526^134
 ;;^UTILITY(U,$J,358.3,35986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35986,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35986,1,4,0)
 ;;=4^V00.812D
 ;;^UTILITY(U,$J,358.3,35986,2)
 ;;=^5055941
 ;;^UTILITY(U,$J,358.3,35987,0)
 ;;=V00.818A^^100^1526^131
 ;;^UTILITY(U,$J,358.3,35987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35987,1,3,0)
 ;;=3^Wheelchair Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,35987,1,4,0)
 ;;=4^V00.818A
 ;;^UTILITY(U,$J,358.3,35987,2)
 ;;=^5055943
 ;;^UTILITY(U,$J,358.3,35988,0)
 ;;=V00.818D^^100^1526^132
 ;;^UTILITY(U,$J,358.3,35988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35988,1,3,0)
 ;;=3^Wheelchair Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35988,1,4,0)
 ;;=4^V00.818D
 ;;^UTILITY(U,$J,358.3,35988,2)
 ;;=^5055944
 ;;^UTILITY(U,$J,358.3,35989,0)
 ;;=V00.831A^^100^1526^43
 ;;^UTILITY(U,$J,358.3,35989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35989,1,3,0)
 ;;=3^Fall from Mobility Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,35989,1,4,0)
 ;;=4^V00.831A
 ;;^UTILITY(U,$J,358.3,35989,2)
 ;;=^5055955
 ;;^UTILITY(U,$J,358.3,35990,0)
 ;;=V00.831D^^100^1526^44
 ;;^UTILITY(U,$J,358.3,35990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35990,1,3,0)
 ;;=3^Fall from Mobility Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35990,1,4,0)
 ;;=4^V00.831D
 ;;^UTILITY(U,$J,358.3,35990,2)
 ;;=^5055956
 ;;^UTILITY(U,$J,358.3,35991,0)
 ;;=V00.832A^^100^1526^95
 ;;^UTILITY(U,$J,358.3,35991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35991,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,35991,1,4,0)
 ;;=4^V00.832A
 ;;^UTILITY(U,$J,358.3,35991,2)
 ;;=^5055958
 ;;^UTILITY(U,$J,358.3,35992,0)
 ;;=V00.832D^^100^1526^96
 ;;^UTILITY(U,$J,358.3,35992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35992,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35992,1,4,0)
 ;;=4^V00.832D
 ;;^UTILITY(U,$J,358.3,35992,2)
 ;;=^5055959
 ;;^UTILITY(U,$J,358.3,35993,0)
 ;;=V00.838A^^100^1526^93
 ;;^UTILITY(U,$J,358.3,35993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35993,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,35993,1,4,0)
 ;;=4^V00.838A
 ;;^UTILITY(U,$J,358.3,35993,2)
 ;;=^5055961
 ;;^UTILITY(U,$J,358.3,35994,0)
 ;;=V00.838D^^100^1526^94
 ;;^UTILITY(U,$J,358.3,35994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35994,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35994,1,4,0)
 ;;=4^V00.838D
 ;;^UTILITY(U,$J,358.3,35994,2)
 ;;=^5055962
 ;;^UTILITY(U,$J,358.3,35995,0)
 ;;=V00.891A^^100^1526^57
 ;;^UTILITY(U,$J,358.3,35995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35995,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Init Encntr
 ;;^UTILITY(U,$J,358.3,35995,1,4,0)
 ;;=4^V00.891A
 ;;^UTILITY(U,$J,358.3,35995,2)
 ;;=^5055964
 ;;^UTILITY(U,$J,358.3,35996,0)
 ;;=V00.891D^^100^1526^58
 ;;^UTILITY(U,$J,358.3,35996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35996,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35996,1,4,0)
 ;;=4^V00.891D
 ;;^UTILITY(U,$J,358.3,35996,2)
 ;;=^5055965
 ;;^UTILITY(U,$J,358.3,35997,0)
 ;;=V00.892A^^100^1526^99
 ;;^UTILITY(U,$J,358.3,35997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35997,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,35997,1,4,0)
 ;;=4^V00.892A
 ;;^UTILITY(U,$J,358.3,35997,2)
 ;;=^5055967
 ;;^UTILITY(U,$J,358.3,35998,0)
 ;;=V00.892D^^100^1526^100
 ;;^UTILITY(U,$J,358.3,35998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35998,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35998,1,4,0)
 ;;=4^V00.892D
 ;;^UTILITY(U,$J,358.3,35998,2)
 ;;=^5055968
 ;;^UTILITY(U,$J,358.3,35999,0)
 ;;=V00.898A^^100^1526^97
 ;;^UTILITY(U,$J,358.3,35999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35999,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,35999,1,4,0)
 ;;=4^V00.898A
 ;;^UTILITY(U,$J,358.3,35999,2)
 ;;=^5055970
 ;;^UTILITY(U,$J,358.3,36000,0)
 ;;=V00.898D^^100^1526^98
 ;;^UTILITY(U,$J,358.3,36000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36000,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36000,1,4,0)
 ;;=4^V00.898D
 ;;^UTILITY(U,$J,358.3,36000,2)
 ;;=^5055971
 ;;^UTILITY(U,$J,358.3,36001,0)
 ;;=W00.0XXA^^100^1526^79
 ;;^UTILITY(U,$J,358.3,36001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36001,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,36001,1,4,0)
 ;;=4^W00.0XXA
 ;;^UTILITY(U,$J,358.3,36001,2)
 ;;=^5059510
 ;;^UTILITY(U,$J,358.3,36002,0)
 ;;=W00.0XXD^^100^1526^80
 ;;^UTILITY(U,$J,358.3,36002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36002,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36002,1,4,0)
 ;;=4^W00.0XXD
 ;;^UTILITY(U,$J,358.3,36002,2)
 ;;=^5059511
 ;;^UTILITY(U,$J,358.3,36003,0)
 ;;=W00.1XXA^^100^1526^59
 ;;^UTILITY(U,$J,358.3,36003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36003,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,36003,1,4,0)
 ;;=4^W00.1XXA
 ;;^UTILITY(U,$J,358.3,36003,2)
 ;;=^5059513
 ;;^UTILITY(U,$J,358.3,36004,0)
 ;;=W00.1XXD^^100^1526^60
 ;;^UTILITY(U,$J,358.3,36004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36004,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36004,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,36004,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,36005,0)
 ;;=W00.2XXA^^100^1526^53
 ;;^UTILITY(U,$J,358.3,36005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36005,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,36005,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,36005,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,36006,0)
 ;;=W00.2XXD^^100^1526^54
 ;;^UTILITY(U,$J,358.3,36006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36006,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36006,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,36006,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,36007,0)
 ;;=W00.9XXA^^100^1526^25
 ;;^UTILITY(U,$J,358.3,36007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36007,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,36007,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,36007,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,36008,0)
 ;;=W00.9XXD^^100^1526^26
 ;;^UTILITY(U,$J,358.3,36008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36008,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36008,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,36008,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,36009,0)
 ;;=W01.0XXA^^100^1526^87
 ;;^UTILITY(U,$J,358.3,36009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36009,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,36009,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,36009,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,36010,0)
 ;;=W01.0XXD^^100^1526^88
 ;;^UTILITY(U,$J,358.3,36010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36010,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36010,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,36010,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,36011,0)
 ;;=W03.XXXA^^100^1526^85
 ;;^UTILITY(U,$J,358.3,36011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36011,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,36011,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,36011,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,36012,0)
 ;;=W03.XXXD^^100^1526^86
 ;;^UTILITY(U,$J,358.3,36012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36012,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36012,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,36012,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,36013,0)
 ;;=W05.0XXA^^100^1526^51
 ;;^UTILITY(U,$J,358.3,36013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36013,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,36013,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,36013,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,36014,0)
 ;;=W05.0XXD^^100^1526^52
 ;;^UTILITY(U,$J,358.3,36014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36014,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36014,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,36014,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,36015,0)
 ;;=W05.1XXA^^100^1526^49
 ;;^UTILITY(U,$J,358.3,36015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36015,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,36015,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,36015,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,36016,0)
 ;;=W05.1XXD^^100^1526^50
 ;;^UTILITY(U,$J,358.3,36016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36016,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36016,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,36016,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,36017,0)
 ;;=W05.2XXA^^100^1526^47
 ;;^UTILITY(U,$J,358.3,36017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36017,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Init Encntr
