IBDEI178 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20031,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,20032,0)
 ;;=W00.9XXD^^94^935^26
 ;;^UTILITY(U,$J,358.3,20032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20032,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20032,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,20032,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,20033,0)
 ;;=W01.0XXA^^94^935^87
 ;;^UTILITY(U,$J,358.3,20033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20033,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,20033,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,20033,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,20034,0)
 ;;=W01.0XXD^^94^935^88
 ;;^UTILITY(U,$J,358.3,20034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20034,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20034,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,20034,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,20035,0)
 ;;=W03.XXXA^^94^935^85
 ;;^UTILITY(U,$J,358.3,20035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20035,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,20035,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,20035,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,20036,0)
 ;;=W03.XXXD^^94^935^86
 ;;^UTILITY(U,$J,358.3,20036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20036,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20036,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,20036,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,20037,0)
 ;;=W05.0XXA^^94^935^51
 ;;^UTILITY(U,$J,358.3,20037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20037,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,20037,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,20037,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,20038,0)
 ;;=W05.0XXD^^94^935^52
 ;;^UTILITY(U,$J,358.3,20038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20038,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20038,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,20038,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,20039,0)
 ;;=W05.1XXA^^94^935^49
 ;;^UTILITY(U,$J,358.3,20039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20039,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,20039,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,20039,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,20040,0)
 ;;=W05.1XXD^^94^935^50
 ;;^UTILITY(U,$J,358.3,20040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20040,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20040,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,20040,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,20041,0)
 ;;=W05.2XXA^^94^935^47
 ;;^UTILITY(U,$J,358.3,20041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20041,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,20041,1,4,0)
 ;;=4^W05.2XXA
 ;;^UTILITY(U,$J,358.3,20041,2)
 ;;=^5059556
 ;;^UTILITY(U,$J,358.3,20042,0)
 ;;=W05.2XXD^^94^935^48
 ;;^UTILITY(U,$J,358.3,20042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20042,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20042,1,4,0)
 ;;=4^W05.2XXD
 ;;^UTILITY(U,$J,358.3,20042,2)
 ;;=^5059557
 ;;^UTILITY(U,$J,358.3,20043,0)
 ;;=W06.XXXA^^94^935^29
 ;;^UTILITY(U,$J,358.3,20043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20043,1,3,0)
 ;;=3^Fall from Bed,Init Encntr
 ;;^UTILITY(U,$J,358.3,20043,1,4,0)
 ;;=4^W06.XXXA
