IBDEI399 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51964,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,51964,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,51964,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,51965,0)
 ;;=W00.2XXD^^193^2516^59
 ;;^UTILITY(U,$J,358.3,51965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51965,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,51965,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,51965,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,51966,0)
 ;;=W00.9XXA^^193^2516^30
 ;;^UTILITY(U,$J,358.3,51966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51966,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,51966,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,51966,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,51967,0)
 ;;=W00.9XXD^^193^2516^31
 ;;^UTILITY(U,$J,358.3,51967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51967,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,51967,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,51967,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,51968,0)
 ;;=W01.0XXA^^193^2516^92
 ;;^UTILITY(U,$J,358.3,51968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51968,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,51968,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,51968,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,51969,0)
 ;;=W01.0XXD^^193^2516^93
 ;;^UTILITY(U,$J,358.3,51969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51969,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,51969,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,51969,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,51970,0)
 ;;=W03.XXXA^^193^2516^90
 ;;^UTILITY(U,$J,358.3,51970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51970,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,51970,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,51970,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,51971,0)
 ;;=W03.XXXD^^193^2516^91
 ;;^UTILITY(U,$J,358.3,51971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51971,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,51971,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,51971,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,51972,0)
 ;;=W05.0XXA^^193^2516^56
 ;;^UTILITY(U,$J,358.3,51972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51972,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,51972,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,51972,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,51973,0)
 ;;=W05.0XXD^^193^2516^57
 ;;^UTILITY(U,$J,358.3,51973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51973,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,51973,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,51973,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,51974,0)
 ;;=W05.1XXA^^193^2516^54
 ;;^UTILITY(U,$J,358.3,51974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51974,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,51974,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,51974,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,51975,0)
 ;;=W05.1XXD^^193^2516^55
 ;;^UTILITY(U,$J,358.3,51975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51975,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
