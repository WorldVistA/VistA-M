IBDEI2KB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40904,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,40904,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,40904,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,40905,0)
 ;;=W00.2XXD^^152^2019^59
 ;;^UTILITY(U,$J,358.3,40905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40905,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40905,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,40905,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,40906,0)
 ;;=W00.9XXA^^152^2019^30
 ;;^UTILITY(U,$J,358.3,40906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40906,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,40906,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,40906,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,40907,0)
 ;;=W00.9XXD^^152^2019^31
 ;;^UTILITY(U,$J,358.3,40907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40907,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40907,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,40907,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,40908,0)
 ;;=W01.0XXA^^152^2019^92
 ;;^UTILITY(U,$J,358.3,40908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40908,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,40908,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,40908,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,40909,0)
 ;;=W01.0XXD^^152^2019^93
 ;;^UTILITY(U,$J,358.3,40909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40909,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40909,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,40909,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,40910,0)
 ;;=W03.XXXA^^152^2019^90
 ;;^UTILITY(U,$J,358.3,40910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40910,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,40910,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,40910,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,40911,0)
 ;;=W03.XXXD^^152^2019^91
 ;;^UTILITY(U,$J,358.3,40911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40911,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40911,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,40911,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,40912,0)
 ;;=W05.0XXA^^152^2019^56
 ;;^UTILITY(U,$J,358.3,40912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40912,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,40912,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,40912,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,40913,0)
 ;;=W05.0XXD^^152^2019^57
 ;;^UTILITY(U,$J,358.3,40913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40913,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40913,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,40913,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,40914,0)
 ;;=W05.1XXA^^152^2019^54
 ;;^UTILITY(U,$J,358.3,40914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40914,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,40914,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,40914,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,40915,0)
 ;;=W05.1XXD^^152^2019^55
 ;;^UTILITY(U,$J,358.3,40915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40915,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
