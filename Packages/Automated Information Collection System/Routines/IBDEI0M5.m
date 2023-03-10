IBDEI0M5 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9959,1,4,0)
 ;;=4^X32.XXXA
 ;;^UTILITY(U,$J,358.3,9959,2)
 ;;=^5060847
 ;;^UTILITY(U,$J,358.3,9960,0)
 ;;=X32.XXXD^^39^420^21
 ;;^UTILITY(U,$J,358.3,9960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9960,1,3,0)
 ;;=3^Exp to Sunlight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9960,1,4,0)
 ;;=4^X32.XXXD
 ;;^UTILITY(U,$J,358.3,9960,2)
 ;;=^5060848
 ;;^UTILITY(U,$J,358.3,9961,0)
 ;;=Y04.0XXA^^39^420^7
 ;;^UTILITY(U,$J,358.3,9961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9961,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,9961,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,9961,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,9962,0)
 ;;=Y04.0XXD^^39^420^8
 ;;^UTILITY(U,$J,358.3,9962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9962,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9962,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,9962,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,9963,0)
 ;;=Y04.1XXA^^39^420^1
 ;;^UTILITY(U,$J,358.3,9963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9963,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,9963,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,9963,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,9964,0)
 ;;=Y04.1XXD^^39^420^2
 ;;^UTILITY(U,$J,358.3,9964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9964,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9964,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,9964,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,9965,0)
 ;;=Y04.2XXA^^39^420^5
 ;;^UTILITY(U,$J,358.3,9965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9965,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,9965,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,9965,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,9966,0)
 ;;=Y04.8XXA^^39^420^3
 ;;^UTILITY(U,$J,358.3,9966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9966,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,9966,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,9966,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,9967,0)
 ;;=Y04.2XXD^^39^420^6
 ;;^UTILITY(U,$J,358.3,9967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9967,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9967,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,9967,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,9968,0)
 ;;=Y04.8XXD^^39^420^4
 ;;^UTILITY(U,$J,358.3,9968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9968,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9968,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,9968,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,9969,0)
 ;;=Y36.200A^^39^420^133
 ;;^UTILITY(U,$J,358.3,9969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9969,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,9969,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,9969,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,9970,0)
 ;;=Y36.200D^^39^420^134
 ;;^UTILITY(U,$J,358.3,9970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9970,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9970,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,9970,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,9971,0)
 ;;=Y36.300A^^39^420^135
 ;;^UTILITY(U,$J,358.3,9971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9971,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
