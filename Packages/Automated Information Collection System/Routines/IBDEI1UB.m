IBDEI1UB ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32815,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32815,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,32815,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,32816,0)
 ;;=W00.2XXA^^190^1962^51
 ;;^UTILITY(U,$J,358.3,32816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32816,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,32816,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,32816,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,32817,0)
 ;;=W00.2XXD^^190^1962^52
 ;;^UTILITY(U,$J,358.3,32817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32817,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32817,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,32817,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,32818,0)
 ;;=W00.9XXA^^190^1962^21
 ;;^UTILITY(U,$J,358.3,32818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32818,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,32818,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,32818,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,32819,0)
 ;;=W00.9XXD^^190^1962^22
 ;;^UTILITY(U,$J,358.3,32819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32819,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32819,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,32819,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,32820,0)
 ;;=W01.0XXA^^190^1962^83
 ;;^UTILITY(U,$J,358.3,32820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32820,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,32820,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,32820,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,32821,0)
 ;;=W01.0XXD^^190^1962^84
 ;;^UTILITY(U,$J,358.3,32821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32821,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32821,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,32821,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,32822,0)
 ;;=W03.XXXA^^190^1962^81
 ;;^UTILITY(U,$J,358.3,32822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32822,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,32822,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,32822,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,32823,0)
 ;;=W03.XXXD^^190^1962^82
 ;;^UTILITY(U,$J,358.3,32823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32823,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32823,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,32823,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,32824,0)
 ;;=W05.0XXA^^190^1962^49
 ;;^UTILITY(U,$J,358.3,32824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32824,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,32824,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,32824,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,32825,0)
 ;;=W05.0XXD^^190^1962^50
 ;;^UTILITY(U,$J,358.3,32825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32825,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32825,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,32825,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,32826,0)
 ;;=W05.1XXA^^190^1962^47
 ;;^UTILITY(U,$J,358.3,32826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32826,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,32826,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,32826,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,32827,0)
 ;;=W05.1XXD^^190^1962^48
 ;;^UTILITY(U,$J,358.3,32827,1,0)
 ;;=^358.31IA^4^2
