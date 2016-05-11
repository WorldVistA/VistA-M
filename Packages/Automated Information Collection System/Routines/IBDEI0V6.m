IBDEI0V6 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14614,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,14615,0)
 ;;=W00.2XXA^^53^612^53
 ;;^UTILITY(U,$J,358.3,14615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14615,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,14615,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,14615,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,14616,0)
 ;;=W00.2XXD^^53^612^54
 ;;^UTILITY(U,$J,358.3,14616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14616,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14616,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,14616,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,14617,0)
 ;;=W00.9XXA^^53^612^25
 ;;^UTILITY(U,$J,358.3,14617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14617,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,14617,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,14617,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,14618,0)
 ;;=W00.9XXD^^53^612^26
 ;;^UTILITY(U,$J,358.3,14618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14618,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14618,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,14618,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,14619,0)
 ;;=W01.0XXA^^53^612^87
 ;;^UTILITY(U,$J,358.3,14619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14619,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,14619,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,14619,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,14620,0)
 ;;=W01.0XXD^^53^612^88
 ;;^UTILITY(U,$J,358.3,14620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14620,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14620,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,14620,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,14621,0)
 ;;=W03.XXXA^^53^612^85
 ;;^UTILITY(U,$J,358.3,14621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14621,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,14621,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,14621,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,14622,0)
 ;;=W03.XXXD^^53^612^86
 ;;^UTILITY(U,$J,358.3,14622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14622,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14622,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,14622,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,14623,0)
 ;;=W05.0XXA^^53^612^51
 ;;^UTILITY(U,$J,358.3,14623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14623,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,14623,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,14623,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,14624,0)
 ;;=W05.0XXD^^53^612^52
 ;;^UTILITY(U,$J,358.3,14624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14624,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14624,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,14624,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,14625,0)
 ;;=W05.1XXA^^53^612^49
 ;;^UTILITY(U,$J,358.3,14625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14625,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,14625,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,14625,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,14626,0)
 ;;=W05.1XXD^^53^612^50
 ;;^UTILITY(U,$J,358.3,14626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14626,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14626,1,4,0)
 ;;=4^W05.1XXD
