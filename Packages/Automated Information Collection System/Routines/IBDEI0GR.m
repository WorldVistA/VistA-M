IBDEI0GR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7748,0)
 ;;=W00.1XXD^^30^415^60
 ;;^UTILITY(U,$J,358.3,7748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7748,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7748,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,7748,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,7749,0)
 ;;=W00.2XXA^^30^415^53
 ;;^UTILITY(U,$J,358.3,7749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7749,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,7749,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,7749,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,7750,0)
 ;;=W00.2XXD^^30^415^54
 ;;^UTILITY(U,$J,358.3,7750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7750,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7750,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,7750,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,7751,0)
 ;;=W00.9XXA^^30^415^25
 ;;^UTILITY(U,$J,358.3,7751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7751,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,7751,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,7751,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,7752,0)
 ;;=W00.9XXD^^30^415^26
 ;;^UTILITY(U,$J,358.3,7752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7752,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7752,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,7752,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,7753,0)
 ;;=W01.0XXA^^30^415^87
 ;;^UTILITY(U,$J,358.3,7753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7753,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,7753,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,7753,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,7754,0)
 ;;=W01.0XXD^^30^415^88
 ;;^UTILITY(U,$J,358.3,7754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7754,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7754,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,7754,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,7755,0)
 ;;=W03.XXXA^^30^415^85
 ;;^UTILITY(U,$J,358.3,7755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7755,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,7755,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,7755,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,7756,0)
 ;;=W03.XXXD^^30^415^86
 ;;^UTILITY(U,$J,358.3,7756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7756,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7756,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,7756,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,7757,0)
 ;;=W05.0XXA^^30^415^51
 ;;^UTILITY(U,$J,358.3,7757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7757,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,7757,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,7757,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,7758,0)
 ;;=W05.0XXD^^30^415^52
 ;;^UTILITY(U,$J,358.3,7758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7758,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7758,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,7758,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,7759,0)
 ;;=W05.1XXA^^30^415^49
 ;;^UTILITY(U,$J,358.3,7759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7759,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,7759,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,7759,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,7760,0)
 ;;=W05.1XXD^^30^415^50
