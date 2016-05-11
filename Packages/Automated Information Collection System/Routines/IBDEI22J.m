IBDEI22J ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35079,0)
 ;;=W01.0XXA^^131^1699^87
 ;;^UTILITY(U,$J,358.3,35079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35079,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,35079,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,35079,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,35080,0)
 ;;=W01.0XXD^^131^1699^88
 ;;^UTILITY(U,$J,358.3,35080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35080,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35080,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,35080,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,35081,0)
 ;;=W03.XXXA^^131^1699^85
 ;;^UTILITY(U,$J,358.3,35081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35081,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,35081,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,35081,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,35082,0)
 ;;=W03.XXXD^^131^1699^86
 ;;^UTILITY(U,$J,358.3,35082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35082,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35082,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,35082,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,35083,0)
 ;;=W05.0XXA^^131^1699^51
 ;;^UTILITY(U,$J,358.3,35083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35083,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,35083,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,35083,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,35084,0)
 ;;=W05.0XXD^^131^1699^52
 ;;^UTILITY(U,$J,358.3,35084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35084,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35084,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,35084,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,35085,0)
 ;;=W05.1XXA^^131^1699^49
 ;;^UTILITY(U,$J,358.3,35085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35085,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,35085,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,35085,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,35086,0)
 ;;=W05.1XXD^^131^1699^50
 ;;^UTILITY(U,$J,358.3,35086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35086,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35086,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,35086,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,35087,0)
 ;;=W05.2XXA^^131^1699^47
 ;;^UTILITY(U,$J,358.3,35087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35087,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,35087,1,4,0)
 ;;=4^W05.2XXA
 ;;^UTILITY(U,$J,358.3,35087,2)
 ;;=^5059556
 ;;^UTILITY(U,$J,358.3,35088,0)
 ;;=W05.2XXD^^131^1699^48
 ;;^UTILITY(U,$J,358.3,35088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35088,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35088,1,4,0)
 ;;=4^W05.2XXD
 ;;^UTILITY(U,$J,358.3,35088,2)
 ;;=^5059557
 ;;^UTILITY(U,$J,358.3,35089,0)
 ;;=W06.XXXA^^131^1699^29
 ;;^UTILITY(U,$J,358.3,35089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35089,1,3,0)
 ;;=3^Fall from Bed,Init Encntr
 ;;^UTILITY(U,$J,358.3,35089,1,4,0)
 ;;=4^W06.XXXA
 ;;^UTILITY(U,$J,358.3,35089,2)
 ;;=^5059559
 ;;^UTILITY(U,$J,358.3,35090,0)
 ;;=W06.XXXD^^131^1699^30
 ;;^UTILITY(U,$J,358.3,35090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35090,1,3,0)
 ;;=3^Fall from Bed,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35090,1,4,0)
 ;;=4^W06.XXXD
 ;;^UTILITY(U,$J,358.3,35090,2)
 ;;=^5059560
