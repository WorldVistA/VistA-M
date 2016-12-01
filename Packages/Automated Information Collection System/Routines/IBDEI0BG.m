IBDEI0BG ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14531,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Emerg Dept
 ;;^UTILITY(U,$J,358.3,14531,1,4,0)
 ;;=4^R40.2312
 ;;^UTILITY(U,$J,358.3,14531,2)
 ;;=^5019402
 ;;^UTILITY(U,$J,358.3,14532,0)
 ;;=R40.2311^^43^642^15
 ;;^UTILITY(U,$J,358.3,14532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14532,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,in the Field
 ;;^UTILITY(U,$J,358.3,14532,1,4,0)
 ;;=4^R40.2311
 ;;^UTILITY(U,$J,358.3,14532,2)
 ;;=^5019401
 ;;^UTILITY(U,$J,358.3,14533,0)
 ;;=R40.2310^^43^642^13
 ;;^UTILITY(U,$J,358.3,14533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14533,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Unspec Time
 ;;^UTILITY(U,$J,358.3,14533,1,4,0)
 ;;=4^R40.2310
 ;;^UTILITY(U,$J,358.3,14533,2)
 ;;=^5019400
 ;;^UTILITY(U,$J,358.3,14534,0)
 ;;=R40.4^^43^642^38
 ;;^UTILITY(U,$J,358.3,14534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14534,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,14534,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,14534,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,14535,0)
 ;;=V00.811A^^43^643^45
 ;;^UTILITY(U,$J,358.3,14535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14535,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Init Encntr
 ;;^UTILITY(U,$J,358.3,14535,1,4,0)
 ;;=4^V00.811A
 ;;^UTILITY(U,$J,358.3,14535,2)
 ;;=^5055937
 ;;^UTILITY(U,$J,358.3,14536,0)
 ;;=V00.811D^^43^643^46
 ;;^UTILITY(U,$J,358.3,14536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14536,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Subs Encntr
 ;;^UTILITY(U,$J,358.3,14536,1,4,0)
 ;;=4^V00.811D
 ;;^UTILITY(U,$J,358.3,14536,2)
 ;;=^5055938
 ;;^UTILITY(U,$J,358.3,14537,0)
 ;;=V00.812A^^43^643^133
 ;;^UTILITY(U,$J,358.3,14537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14537,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,14537,1,4,0)
 ;;=4^V00.812A
 ;;^UTILITY(U,$J,358.3,14537,2)
 ;;=^5055940
 ;;^UTILITY(U,$J,358.3,14538,0)
 ;;=V00.812D^^43^643^134
 ;;^UTILITY(U,$J,358.3,14538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14538,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14538,1,4,0)
 ;;=4^V00.812D
 ;;^UTILITY(U,$J,358.3,14538,2)
 ;;=^5055941
 ;;^UTILITY(U,$J,358.3,14539,0)
 ;;=V00.818A^^43^643^131
 ;;^UTILITY(U,$J,358.3,14539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14539,1,3,0)
 ;;=3^Wheelchair Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,14539,1,4,0)
 ;;=4^V00.818A
 ;;^UTILITY(U,$J,358.3,14539,2)
 ;;=^5055943
 ;;^UTILITY(U,$J,358.3,14540,0)
 ;;=V00.818D^^43^643^132
 ;;^UTILITY(U,$J,358.3,14540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14540,1,3,0)
 ;;=3^Wheelchair Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14540,1,4,0)
 ;;=4^V00.818D
 ;;^UTILITY(U,$J,358.3,14540,2)
 ;;=^5055944
 ;;^UTILITY(U,$J,358.3,14541,0)
 ;;=V00.831A^^43^643^43
 ;;^UTILITY(U,$J,358.3,14541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14541,1,3,0)
 ;;=3^Fall from Mobility Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,14541,1,4,0)
 ;;=4^V00.831A
 ;;^UTILITY(U,$J,358.3,14541,2)
 ;;=^5055955
 ;;^UTILITY(U,$J,358.3,14542,0)
 ;;=V00.831D^^43^643^44
 ;;^UTILITY(U,$J,358.3,14542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14542,1,3,0)
 ;;=3^Fall from Mobility Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14542,1,4,0)
 ;;=4^V00.831D
 ;;^UTILITY(U,$J,358.3,14542,2)
 ;;=^5055956
 ;;^UTILITY(U,$J,358.3,14543,0)
 ;;=V00.832A^^43^643^95
 ;;^UTILITY(U,$J,358.3,14543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14543,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,14543,1,4,0)
 ;;=4^V00.832A
 ;;^UTILITY(U,$J,358.3,14543,2)
 ;;=^5055958
 ;;^UTILITY(U,$J,358.3,14544,0)
 ;;=V00.832D^^43^643^96
 ;;^UTILITY(U,$J,358.3,14544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14544,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14544,1,4,0)
 ;;=4^V00.832D
 ;;^UTILITY(U,$J,358.3,14544,2)
 ;;=^5055959
 ;;^UTILITY(U,$J,358.3,14545,0)
 ;;=V00.838A^^43^643^93
 ;;^UTILITY(U,$J,358.3,14545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14545,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,14545,1,4,0)
 ;;=4^V00.838A
 ;;^UTILITY(U,$J,358.3,14545,2)
 ;;=^5055961
 ;;^UTILITY(U,$J,358.3,14546,0)
 ;;=V00.838D^^43^643^94
 ;;^UTILITY(U,$J,358.3,14546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14546,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14546,1,4,0)
 ;;=4^V00.838D
 ;;^UTILITY(U,$J,358.3,14546,2)
 ;;=^5055962
 ;;^UTILITY(U,$J,358.3,14547,0)
 ;;=V00.891A^^43^643^57
 ;;^UTILITY(U,$J,358.3,14547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14547,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Init Encntr
 ;;^UTILITY(U,$J,358.3,14547,1,4,0)
 ;;=4^V00.891A
 ;;^UTILITY(U,$J,358.3,14547,2)
 ;;=^5055964
 ;;^UTILITY(U,$J,358.3,14548,0)
 ;;=V00.891D^^43^643^58
 ;;^UTILITY(U,$J,358.3,14548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14548,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14548,1,4,0)
 ;;=4^V00.891D
 ;;^UTILITY(U,$J,358.3,14548,2)
 ;;=^5055965
 ;;^UTILITY(U,$J,358.3,14549,0)
 ;;=V00.892A^^43^643^99
 ;;^UTILITY(U,$J,358.3,14549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14549,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,14549,1,4,0)
 ;;=4^V00.892A
 ;;^UTILITY(U,$J,358.3,14549,2)
 ;;=^5055967
 ;;^UTILITY(U,$J,358.3,14550,0)
 ;;=V00.892D^^43^643^100
 ;;^UTILITY(U,$J,358.3,14550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14550,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14550,1,4,0)
 ;;=4^V00.892D
 ;;^UTILITY(U,$J,358.3,14550,2)
 ;;=^5055968
 ;;^UTILITY(U,$J,358.3,14551,0)
 ;;=V00.898A^^43^643^97
 ;;^UTILITY(U,$J,358.3,14551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14551,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,14551,1,4,0)
 ;;=4^V00.898A
 ;;^UTILITY(U,$J,358.3,14551,2)
 ;;=^5055970
 ;;^UTILITY(U,$J,358.3,14552,0)
 ;;=V00.898D^^43^643^98
 ;;^UTILITY(U,$J,358.3,14552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14552,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14552,1,4,0)
 ;;=4^V00.898D
 ;;^UTILITY(U,$J,358.3,14552,2)
 ;;=^5055971
 ;;^UTILITY(U,$J,358.3,14553,0)
 ;;=W00.0XXA^^43^643^79
 ;;^UTILITY(U,$J,358.3,14553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14553,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,14553,1,4,0)
 ;;=4^W00.0XXA
 ;;^UTILITY(U,$J,358.3,14553,2)
 ;;=^5059510
 ;;^UTILITY(U,$J,358.3,14554,0)
 ;;=W00.0XXD^^43^643^80
 ;;^UTILITY(U,$J,358.3,14554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14554,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14554,1,4,0)
 ;;=4^W00.0XXD
 ;;^UTILITY(U,$J,358.3,14554,2)
 ;;=^5059511
 ;;^UTILITY(U,$J,358.3,14555,0)
 ;;=W00.1XXA^^43^643^59
 ;;^UTILITY(U,$J,358.3,14555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14555,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,14555,1,4,0)
 ;;=4^W00.1XXA
 ;;^UTILITY(U,$J,358.3,14555,2)
 ;;=^5059513
 ;;^UTILITY(U,$J,358.3,14556,0)
 ;;=W00.1XXD^^43^643^60
 ;;^UTILITY(U,$J,358.3,14556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14556,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14556,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,14556,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,14557,0)
 ;;=W00.2XXA^^43^643^53
 ;;^UTILITY(U,$J,358.3,14557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14557,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,14557,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,14557,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,14558,0)
 ;;=W00.2XXD^^43^643^54
 ;;^UTILITY(U,$J,358.3,14558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14558,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14558,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,14558,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,14559,0)
 ;;=W00.9XXA^^43^643^25
 ;;^UTILITY(U,$J,358.3,14559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14559,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,14559,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,14559,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,14560,0)
 ;;=W00.9XXD^^43^643^26
 ;;^UTILITY(U,$J,358.3,14560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14560,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14560,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,14560,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,14561,0)
 ;;=W01.0XXA^^43^643^87
 ;;^UTILITY(U,$J,358.3,14561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14561,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,14561,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,14561,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,14562,0)
 ;;=W01.0XXD^^43^643^88
 ;;^UTILITY(U,$J,358.3,14562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14562,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14562,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,14562,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,14563,0)
 ;;=W03.XXXA^^43^643^85
 ;;^UTILITY(U,$J,358.3,14563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14563,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,14563,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,14563,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,14564,0)
 ;;=W03.XXXD^^43^643^86
 ;;^UTILITY(U,$J,358.3,14564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14564,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
