IBDEI1V0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31125,0)
 ;;=W01.0XXA^^135^1391^87
 ;;^UTILITY(U,$J,358.3,31125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31125,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,31125,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,31125,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,31126,0)
 ;;=W01.0XXD^^135^1391^88
 ;;^UTILITY(U,$J,358.3,31126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31126,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31126,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,31126,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,31127,0)
 ;;=W03.XXXA^^135^1391^85
 ;;^UTILITY(U,$J,358.3,31127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31127,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,31127,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,31127,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,31128,0)
 ;;=W03.XXXD^^135^1391^86
 ;;^UTILITY(U,$J,358.3,31128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31128,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31128,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,31128,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,31129,0)
 ;;=W05.0XXA^^135^1391^51
 ;;^UTILITY(U,$J,358.3,31129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31129,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,31129,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,31129,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,31130,0)
 ;;=W05.0XXD^^135^1391^52
 ;;^UTILITY(U,$J,358.3,31130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31130,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31130,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,31130,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,31131,0)
 ;;=W05.1XXA^^135^1391^49
 ;;^UTILITY(U,$J,358.3,31131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31131,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,31131,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,31131,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,31132,0)
 ;;=W05.1XXD^^135^1391^50
 ;;^UTILITY(U,$J,358.3,31132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31132,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31132,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,31132,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,31133,0)
 ;;=W05.2XXA^^135^1391^47
 ;;^UTILITY(U,$J,358.3,31133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31133,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,31133,1,4,0)
 ;;=4^W05.2XXA
 ;;^UTILITY(U,$J,358.3,31133,2)
 ;;=^5059556
 ;;^UTILITY(U,$J,358.3,31134,0)
 ;;=W05.2XXD^^135^1391^48
 ;;^UTILITY(U,$J,358.3,31134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31134,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31134,1,4,0)
 ;;=4^W05.2XXD
 ;;^UTILITY(U,$J,358.3,31134,2)
 ;;=^5059557
 ;;^UTILITY(U,$J,358.3,31135,0)
 ;;=W06.XXXA^^135^1391^29
 ;;^UTILITY(U,$J,358.3,31135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31135,1,3,0)
 ;;=3^Fall from Bed,Init Encntr
 ;;^UTILITY(U,$J,358.3,31135,1,4,0)
 ;;=4^W06.XXXA
 ;;^UTILITY(U,$J,358.3,31135,2)
 ;;=^5059559
 ;;^UTILITY(U,$J,358.3,31136,0)
 ;;=W06.XXXD^^135^1391^30
 ;;^UTILITY(U,$J,358.3,31136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31136,1,3,0)
 ;;=3^Fall from Bed,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31136,1,4,0)
 ;;=4^W06.XXXD
 ;;^UTILITY(U,$J,358.3,31136,2)
 ;;=^5059560
