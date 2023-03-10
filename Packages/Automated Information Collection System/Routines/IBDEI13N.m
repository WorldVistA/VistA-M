IBDEI13N ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17847,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,17848,0)
 ;;=W00.9XXD^^61^794^31
 ;;^UTILITY(U,$J,358.3,17848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17848,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17848,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,17848,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,17849,0)
 ;;=W01.0XXA^^61^794^92
 ;;^UTILITY(U,$J,358.3,17849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17849,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,17849,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,17849,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,17850,0)
 ;;=W01.0XXD^^61^794^93
 ;;^UTILITY(U,$J,358.3,17850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17850,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17850,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,17850,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,17851,0)
 ;;=W03.XXXA^^61^794^90
 ;;^UTILITY(U,$J,358.3,17851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17851,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,17851,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,17851,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,17852,0)
 ;;=W03.XXXD^^61^794^91
 ;;^UTILITY(U,$J,358.3,17852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17852,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17852,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,17852,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,17853,0)
 ;;=W05.0XXA^^61^794^56
 ;;^UTILITY(U,$J,358.3,17853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17853,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,17853,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,17853,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,17854,0)
 ;;=W05.0XXD^^61^794^57
 ;;^UTILITY(U,$J,358.3,17854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17854,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17854,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,17854,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,17855,0)
 ;;=W05.1XXA^^61^794^54
 ;;^UTILITY(U,$J,358.3,17855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17855,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,17855,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,17855,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,17856,0)
 ;;=W05.1XXD^^61^794^55
 ;;^UTILITY(U,$J,358.3,17856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17856,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17856,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,17856,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,17857,0)
 ;;=W05.2XXA^^61^794^52
 ;;^UTILITY(U,$J,358.3,17857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17857,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,17857,1,4,0)
 ;;=4^W05.2XXA
 ;;^UTILITY(U,$J,358.3,17857,2)
 ;;=^5059556
 ;;^UTILITY(U,$J,358.3,17858,0)
 ;;=W05.2XXD^^61^794^53
 ;;^UTILITY(U,$J,358.3,17858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17858,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17858,1,4,0)
 ;;=4^W05.2XXD
 ;;^UTILITY(U,$J,358.3,17858,2)
 ;;=^5059557
 ;;^UTILITY(U,$J,358.3,17859,0)
 ;;=W06.XXXA^^61^794^34
