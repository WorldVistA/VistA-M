IBDEI2PS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45547,1,4,0)
 ;;=4^W00.1XXA
 ;;^UTILITY(U,$J,358.3,45547,2)
 ;;=^5059513
 ;;^UTILITY(U,$J,358.3,45548,0)
 ;;=W00.1XXD^^200^2247^60
 ;;^UTILITY(U,$J,358.3,45548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45548,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45548,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,45548,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,45549,0)
 ;;=W00.2XXA^^200^2247^53
 ;;^UTILITY(U,$J,358.3,45549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45549,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,45549,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,45549,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,45550,0)
 ;;=W00.2XXD^^200^2247^54
 ;;^UTILITY(U,$J,358.3,45550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45550,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45550,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,45550,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,45551,0)
 ;;=W00.9XXA^^200^2247^25
 ;;^UTILITY(U,$J,358.3,45551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45551,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,45551,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,45551,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,45552,0)
 ;;=W00.9XXD^^200^2247^26
 ;;^UTILITY(U,$J,358.3,45552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45552,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45552,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,45552,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,45553,0)
 ;;=W01.0XXA^^200^2247^87
 ;;^UTILITY(U,$J,358.3,45553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45553,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,45553,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,45553,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,45554,0)
 ;;=W01.0XXD^^200^2247^88
 ;;^UTILITY(U,$J,358.3,45554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45554,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45554,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,45554,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,45555,0)
 ;;=W03.XXXA^^200^2247^85
 ;;^UTILITY(U,$J,358.3,45555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45555,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,45555,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,45555,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,45556,0)
 ;;=W03.XXXD^^200^2247^86
 ;;^UTILITY(U,$J,358.3,45556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45556,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45556,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,45556,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,45557,0)
 ;;=W05.0XXA^^200^2247^51
 ;;^UTILITY(U,$J,358.3,45557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45557,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,45557,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,45557,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,45558,0)
 ;;=W05.0XXD^^200^2247^52
 ;;^UTILITY(U,$J,358.3,45558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45558,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45558,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,45558,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,45559,0)
 ;;=W05.1XXA^^200^2247^49
 ;;^UTILITY(U,$J,358.3,45559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45559,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
