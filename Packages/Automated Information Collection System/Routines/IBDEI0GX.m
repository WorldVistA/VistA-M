IBDEI0GX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7824,0)
 ;;=X32.XXXD^^30^415^16
 ;;^UTILITY(U,$J,358.3,7824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7824,1,3,0)
 ;;=3^Exp to Sunlight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7824,1,4,0)
 ;;=4^X32.XXXD
 ;;^UTILITY(U,$J,358.3,7824,2)
 ;;=^5060848
 ;;^UTILITY(U,$J,358.3,7825,0)
 ;;=Y04.0XXA^^30^415^7
 ;;^UTILITY(U,$J,358.3,7825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7825,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,7825,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,7825,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,7826,0)
 ;;=Y04.0XXD^^30^415^8
 ;;^UTILITY(U,$J,358.3,7826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7826,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7826,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,7826,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,7827,0)
 ;;=Y04.1XXA^^30^415^1
 ;;^UTILITY(U,$J,358.3,7827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7827,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,7827,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,7827,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,7828,0)
 ;;=Y04.1XXD^^30^415^2
 ;;^UTILITY(U,$J,358.3,7828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7828,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7828,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,7828,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,7829,0)
 ;;=Y04.2XXA^^30^415^5
 ;;^UTILITY(U,$J,358.3,7829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7829,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,7829,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,7829,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,7830,0)
 ;;=Y04.8XXA^^30^415^3
 ;;^UTILITY(U,$J,358.3,7830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7830,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,7830,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,7830,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,7831,0)
 ;;=Y04.2XXD^^30^415^6
 ;;^UTILITY(U,$J,358.3,7831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7831,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7831,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,7831,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,7832,0)
 ;;=Y04.8XXD^^30^415^4
 ;;^UTILITY(U,$J,358.3,7832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7832,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7832,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,7832,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,7833,0)
 ;;=Y36.200A^^30^415^124
 ;;^UTILITY(U,$J,358.3,7833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7833,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7833,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,7833,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,7834,0)
 ;;=Y36.200D^^30^415^125
 ;;^UTILITY(U,$J,358.3,7834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7834,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7834,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,7834,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,7835,0)
 ;;=Y36.300A^^30^415^126
 ;;^UTILITY(U,$J,358.3,7835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7835,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7835,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,7835,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,7836,0)
 ;;=Y36.300D^^30^415^127
 ;;^UTILITY(U,$J,358.3,7836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7836,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
