IBDEI1MU ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26080,0)
 ;;=W00.2XXD^^107^1230^59
 ;;^UTILITY(U,$J,358.3,26080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26080,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26080,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,26080,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,26081,0)
 ;;=W00.9XXA^^107^1230^30
 ;;^UTILITY(U,$J,358.3,26081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26081,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,26081,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,26081,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,26082,0)
 ;;=W00.9XXD^^107^1230^31
 ;;^UTILITY(U,$J,358.3,26082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26082,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26082,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,26082,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,26083,0)
 ;;=W01.0XXA^^107^1230^92
 ;;^UTILITY(U,$J,358.3,26083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26083,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,26083,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,26083,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,26084,0)
 ;;=W01.0XXD^^107^1230^93
 ;;^UTILITY(U,$J,358.3,26084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26084,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26084,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,26084,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,26085,0)
 ;;=W03.XXXA^^107^1230^90
 ;;^UTILITY(U,$J,358.3,26085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26085,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,26085,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,26085,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,26086,0)
 ;;=W03.XXXD^^107^1230^91
 ;;^UTILITY(U,$J,358.3,26086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26086,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26086,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,26086,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,26087,0)
 ;;=W05.0XXA^^107^1230^56
 ;;^UTILITY(U,$J,358.3,26087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26087,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,26087,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,26087,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,26088,0)
 ;;=W05.0XXD^^107^1230^57
 ;;^UTILITY(U,$J,358.3,26088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26088,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26088,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,26088,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,26089,0)
 ;;=W05.1XXA^^107^1230^54
 ;;^UTILITY(U,$J,358.3,26089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26089,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,26089,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,26089,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,26090,0)
 ;;=W05.1XXD^^107^1230^55
 ;;^UTILITY(U,$J,358.3,26090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26090,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26090,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,26090,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,26091,0)
 ;;=W05.2XXA^^107^1230^52
 ;;^UTILITY(U,$J,358.3,26091,1,0)
 ;;=^358.31IA^4^2
