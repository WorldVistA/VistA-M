IBDEI08T ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8759,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,8759,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,8759,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,8760,0)
 ;;=W18.49XD^^42^517^112
 ;;^UTILITY(U,$J,358.3,8760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8760,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8760,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,8760,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,8761,0)
 ;;=W19.XXXA^^42^517^89
 ;;^UTILITY(U,$J,358.3,8761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8761,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,8761,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,8761,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,8762,0)
 ;;=W19.XXXD^^42^517^90
 ;;^UTILITY(U,$J,358.3,8762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8762,1,3,0)
 ;;=3^Fall,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8762,1,4,0)
 ;;=4^W19.XXXD
 ;;^UTILITY(U,$J,358.3,8762,2)
 ;;=^5059834
 ;;^UTILITY(U,$J,358.3,8763,0)
 ;;=W54.0XXA^^42^517^11
 ;;^UTILITY(U,$J,358.3,8763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8763,1,3,0)
 ;;=3^Bitten by Dog,Init Encntr
 ;;^UTILITY(U,$J,358.3,8763,1,4,0)
 ;;=4^W54.0XXA
 ;;^UTILITY(U,$J,358.3,8763,2)
 ;;=^5060256
 ;;^UTILITY(U,$J,358.3,8764,0)
 ;;=W54.0XXD^^42^517^12
 ;;^UTILITY(U,$J,358.3,8764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8764,1,3,0)
 ;;=3^Bitten by Dog,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8764,1,4,0)
 ;;=4^W54.0XXD
 ;;^UTILITY(U,$J,358.3,8764,2)
 ;;=^5060257
 ;;^UTILITY(U,$J,358.3,8765,0)
 ;;=W55.01XA^^42^517^9
 ;;^UTILITY(U,$J,358.3,8765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8765,1,3,0)
 ;;=3^Bitten by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,8765,1,4,0)
 ;;=4^W55.01XA
 ;;^UTILITY(U,$J,358.3,8765,2)
 ;;=^5060265
 ;;^UTILITY(U,$J,358.3,8766,0)
 ;;=W55.01XD^^42^517^10
 ;;^UTILITY(U,$J,358.3,8766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8766,1,3,0)
 ;;=3^Bitten by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8766,1,4,0)
 ;;=4^W55.01XD
 ;;^UTILITY(U,$J,358.3,8766,2)
 ;;=^5060266
 ;;^UTILITY(U,$J,358.3,8767,0)
 ;;=W55.03XA^^42^517^101
 ;;^UTILITY(U,$J,358.3,8767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8767,1,3,0)
 ;;=3^Scratched by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,8767,1,4,0)
 ;;=4^W55.03XA
 ;;^UTILITY(U,$J,358.3,8767,2)
 ;;=^5060268
 ;;^UTILITY(U,$J,358.3,8768,0)
 ;;=W55.03XD^^42^517^102
 ;;^UTILITY(U,$J,358.3,8768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8768,1,3,0)
 ;;=3^Scratched by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8768,1,4,0)
 ;;=4^W55.03XD
 ;;^UTILITY(U,$J,358.3,8768,2)
 ;;=^5060269
 ;;^UTILITY(U,$J,358.3,8769,0)
 ;;=X00.8XXA^^42^517^17
 ;;^UTILITY(U,$J,358.3,8769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8769,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,8769,1,4,0)
 ;;=4^X00.8XXA
 ;;^UTILITY(U,$J,358.3,8769,2)
 ;;=^5060679
 ;;^UTILITY(U,$J,358.3,8770,0)
 ;;=X00.8XXD^^42^517^18
 ;;^UTILITY(U,$J,358.3,8770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8770,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8770,1,4,0)
 ;;=4^X00.8XXD
 ;;^UTILITY(U,$J,358.3,8770,2)
 ;;=^5060680
 ;;^UTILITY(U,$J,358.3,8771,0)
 ;;=X32.XXXA^^42^517^15
 ;;^UTILITY(U,$J,358.3,8771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8771,1,3,0)
 ;;=3^Exp to Sunlight,Init Encntr
 ;;^UTILITY(U,$J,358.3,8771,1,4,0)
 ;;=4^X32.XXXA
 ;;^UTILITY(U,$J,358.3,8771,2)
 ;;=^5060847
 ;;^UTILITY(U,$J,358.3,8772,0)
 ;;=X32.XXXD^^42^517^16
 ;;^UTILITY(U,$J,358.3,8772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8772,1,3,0)
 ;;=3^Exp to Sunlight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8772,1,4,0)
 ;;=4^X32.XXXD
 ;;^UTILITY(U,$J,358.3,8772,2)
 ;;=^5060848
 ;;^UTILITY(U,$J,358.3,8773,0)
 ;;=Y04.0XXA^^42^517^7
 ;;^UTILITY(U,$J,358.3,8773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8773,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,8773,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,8773,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,8774,0)
 ;;=Y04.0XXD^^42^517^8
 ;;^UTILITY(U,$J,358.3,8774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8774,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8774,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,8774,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,8775,0)
 ;;=Y04.1XXA^^42^517^1
 ;;^UTILITY(U,$J,358.3,8775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8775,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,8775,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,8775,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,8776,0)
 ;;=Y04.1XXD^^42^517^2
 ;;^UTILITY(U,$J,358.3,8776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8776,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8776,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,8776,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,8777,0)
 ;;=Y04.2XXA^^42^517^5
 ;;^UTILITY(U,$J,358.3,8777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8777,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,8777,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,8777,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,8778,0)
 ;;=Y04.8XXA^^42^517^3
 ;;^UTILITY(U,$J,358.3,8778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8778,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,8778,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,8778,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,8779,0)
 ;;=Y04.2XXD^^42^517^6
 ;;^UTILITY(U,$J,358.3,8779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8779,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8779,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,8779,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,8780,0)
 ;;=Y04.8XXD^^42^517^4
 ;;^UTILITY(U,$J,358.3,8780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8780,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8780,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,8780,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,8781,0)
 ;;=Y36.200A^^42^517^124
 ;;^UTILITY(U,$J,358.3,8781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8781,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,8781,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,8781,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,8782,0)
 ;;=Y36.200D^^42^517^125
 ;;^UTILITY(U,$J,358.3,8782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8782,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8782,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,8782,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,8783,0)
 ;;=Y36.300A^^42^517^126
 ;;^UTILITY(U,$J,358.3,8783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8783,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,8783,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,8783,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,8784,0)
 ;;=Y36.300D^^42^517^127
 ;;^UTILITY(U,$J,358.3,8784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8784,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8784,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,8784,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,8785,0)
 ;;=Y36.410A^^42^517^121
 ;;^UTILITY(U,$J,358.3,8785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8785,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,8785,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,8785,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,8786,0)
 ;;=Y36.410D^^42^517^123
 ;;^UTILITY(U,$J,358.3,8786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8786,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8786,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,8786,2)
 ;;=^5061692
