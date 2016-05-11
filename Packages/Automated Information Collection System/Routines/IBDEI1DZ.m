IBDEI1DZ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23557,1,4,0)
 ;;=4^V00.892A
 ;;^UTILITY(U,$J,358.3,23557,2)
 ;;=^5055967
 ;;^UTILITY(U,$J,358.3,23558,0)
 ;;=V00.892D^^87^1000^100
 ;;^UTILITY(U,$J,358.3,23558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23558,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23558,1,4,0)
 ;;=4^V00.892D
 ;;^UTILITY(U,$J,358.3,23558,2)
 ;;=^5055968
 ;;^UTILITY(U,$J,358.3,23559,0)
 ;;=V00.898A^^87^1000^97
 ;;^UTILITY(U,$J,358.3,23559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23559,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,23559,1,4,0)
 ;;=4^V00.898A
 ;;^UTILITY(U,$J,358.3,23559,2)
 ;;=^5055970
 ;;^UTILITY(U,$J,358.3,23560,0)
 ;;=V00.898D^^87^1000^98
 ;;^UTILITY(U,$J,358.3,23560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23560,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23560,1,4,0)
 ;;=4^V00.898D
 ;;^UTILITY(U,$J,358.3,23560,2)
 ;;=^5055971
 ;;^UTILITY(U,$J,358.3,23561,0)
 ;;=W00.0XXA^^87^1000^79
 ;;^UTILITY(U,$J,358.3,23561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23561,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,23561,1,4,0)
 ;;=4^W00.0XXA
 ;;^UTILITY(U,$J,358.3,23561,2)
 ;;=^5059510
 ;;^UTILITY(U,$J,358.3,23562,0)
 ;;=W00.0XXD^^87^1000^80
 ;;^UTILITY(U,$J,358.3,23562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23562,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23562,1,4,0)
 ;;=4^W00.0XXD
 ;;^UTILITY(U,$J,358.3,23562,2)
 ;;=^5059511
 ;;^UTILITY(U,$J,358.3,23563,0)
 ;;=W00.1XXA^^87^1000^59
 ;;^UTILITY(U,$J,358.3,23563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23563,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,23563,1,4,0)
 ;;=4^W00.1XXA
 ;;^UTILITY(U,$J,358.3,23563,2)
 ;;=^5059513
 ;;^UTILITY(U,$J,358.3,23564,0)
 ;;=W00.1XXD^^87^1000^60
 ;;^UTILITY(U,$J,358.3,23564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23564,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23564,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,23564,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,23565,0)
 ;;=W00.2XXA^^87^1000^53
 ;;^UTILITY(U,$J,358.3,23565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23565,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,23565,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,23565,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,23566,0)
 ;;=W00.2XXD^^87^1000^54
 ;;^UTILITY(U,$J,358.3,23566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23566,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23566,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,23566,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,23567,0)
 ;;=W00.9XXA^^87^1000^25
 ;;^UTILITY(U,$J,358.3,23567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23567,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,23567,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,23567,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,23568,0)
 ;;=W00.9XXD^^87^1000^26
 ;;^UTILITY(U,$J,358.3,23568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23568,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23568,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,23568,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,23569,0)
 ;;=W01.0XXA^^87^1000^87
 ;;^UTILITY(U,$J,358.3,23569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23569,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
