IBDEI2I8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42463,0)
 ;;=W01.0XXA^^159^2023^87
 ;;^UTILITY(U,$J,358.3,42463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42463,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,42463,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,42463,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,42464,0)
 ;;=W01.0XXD^^159^2023^88
 ;;^UTILITY(U,$J,358.3,42464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42464,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42464,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,42464,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,42465,0)
 ;;=W03.XXXA^^159^2023^85
 ;;^UTILITY(U,$J,358.3,42465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42465,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,42465,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,42465,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,42466,0)
 ;;=W03.XXXD^^159^2023^86
 ;;^UTILITY(U,$J,358.3,42466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42466,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42466,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,42466,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,42467,0)
 ;;=W05.0XXA^^159^2023^51
 ;;^UTILITY(U,$J,358.3,42467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42467,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,42467,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,42467,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,42468,0)
 ;;=W05.0XXD^^159^2023^52
 ;;^UTILITY(U,$J,358.3,42468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42468,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42468,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,42468,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,42469,0)
 ;;=W05.1XXA^^159^2023^49
 ;;^UTILITY(U,$J,358.3,42469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42469,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,42469,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,42469,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,42470,0)
 ;;=W05.1XXD^^159^2023^50
 ;;^UTILITY(U,$J,358.3,42470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42470,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42470,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,42470,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,42471,0)
 ;;=W05.2XXA^^159^2023^47
 ;;^UTILITY(U,$J,358.3,42471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42471,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,42471,1,4,0)
 ;;=4^W05.2XXA
 ;;^UTILITY(U,$J,358.3,42471,2)
 ;;=^5059556
 ;;^UTILITY(U,$J,358.3,42472,0)
 ;;=W05.2XXD^^159^2023^48
 ;;^UTILITY(U,$J,358.3,42472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42472,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42472,1,4,0)
 ;;=4^W05.2XXD
 ;;^UTILITY(U,$J,358.3,42472,2)
 ;;=^5059557
 ;;^UTILITY(U,$J,358.3,42473,0)
 ;;=W06.XXXA^^159^2023^29
 ;;^UTILITY(U,$J,358.3,42473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42473,1,3,0)
 ;;=3^Fall from Bed,Init Encntr
 ;;^UTILITY(U,$J,358.3,42473,1,4,0)
 ;;=4^W06.XXXA
 ;;^UTILITY(U,$J,358.3,42473,2)
 ;;=^5059559
 ;;^UTILITY(U,$J,358.3,42474,0)
 ;;=W06.XXXD^^159^2023^30
 ;;^UTILITY(U,$J,358.3,42474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42474,1,3,0)
 ;;=3^Fall from Bed,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42474,1,4,0)
 ;;=4^W06.XXXD
 ;;^UTILITY(U,$J,358.3,42474,2)
 ;;=^5059560
