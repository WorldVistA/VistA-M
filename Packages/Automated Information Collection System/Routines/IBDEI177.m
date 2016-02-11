IBDEI177 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20019,1,4,0)
 ;;=4^V00.891A
 ;;^UTILITY(U,$J,358.3,20019,2)
 ;;=^5055964
 ;;^UTILITY(U,$J,358.3,20020,0)
 ;;=V00.891D^^94^935^58
 ;;^UTILITY(U,$J,358.3,20020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20020,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20020,1,4,0)
 ;;=4^V00.891D
 ;;^UTILITY(U,$J,358.3,20020,2)
 ;;=^5055965
 ;;^UTILITY(U,$J,358.3,20021,0)
 ;;=V00.892A^^94^935^99
 ;;^UTILITY(U,$J,358.3,20021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20021,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,20021,1,4,0)
 ;;=4^V00.892A
 ;;^UTILITY(U,$J,358.3,20021,2)
 ;;=^5055967
 ;;^UTILITY(U,$J,358.3,20022,0)
 ;;=V00.892D^^94^935^100
 ;;^UTILITY(U,$J,358.3,20022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20022,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20022,1,4,0)
 ;;=4^V00.892D
 ;;^UTILITY(U,$J,358.3,20022,2)
 ;;=^5055968
 ;;^UTILITY(U,$J,358.3,20023,0)
 ;;=V00.898A^^94^935^97
 ;;^UTILITY(U,$J,358.3,20023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20023,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,20023,1,4,0)
 ;;=4^V00.898A
 ;;^UTILITY(U,$J,358.3,20023,2)
 ;;=^5055970
 ;;^UTILITY(U,$J,358.3,20024,0)
 ;;=V00.898D^^94^935^98
 ;;^UTILITY(U,$J,358.3,20024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20024,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20024,1,4,0)
 ;;=4^V00.898D
 ;;^UTILITY(U,$J,358.3,20024,2)
 ;;=^5055971
 ;;^UTILITY(U,$J,358.3,20025,0)
 ;;=W00.0XXA^^94^935^79
 ;;^UTILITY(U,$J,358.3,20025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20025,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,20025,1,4,0)
 ;;=4^W00.0XXA
 ;;^UTILITY(U,$J,358.3,20025,2)
 ;;=^5059510
 ;;^UTILITY(U,$J,358.3,20026,0)
 ;;=W00.0XXD^^94^935^80
 ;;^UTILITY(U,$J,358.3,20026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20026,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20026,1,4,0)
 ;;=4^W00.0XXD
 ;;^UTILITY(U,$J,358.3,20026,2)
 ;;=^5059511
 ;;^UTILITY(U,$J,358.3,20027,0)
 ;;=W00.1XXA^^94^935^59
 ;;^UTILITY(U,$J,358.3,20027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20027,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,20027,1,4,0)
 ;;=4^W00.1XXA
 ;;^UTILITY(U,$J,358.3,20027,2)
 ;;=^5059513
 ;;^UTILITY(U,$J,358.3,20028,0)
 ;;=W00.1XXD^^94^935^60
 ;;^UTILITY(U,$J,358.3,20028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20028,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20028,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,20028,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,20029,0)
 ;;=W00.2XXA^^94^935^53
 ;;^UTILITY(U,$J,358.3,20029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20029,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,20029,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,20029,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,20030,0)
 ;;=W00.2XXD^^94^935^54
 ;;^UTILITY(U,$J,358.3,20030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20030,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20030,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,20030,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,20031,0)
 ;;=W00.9XXA^^94^935^25
 ;;^UTILITY(U,$J,358.3,20031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20031,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,20031,1,4,0)
 ;;=4^W00.9XXA
