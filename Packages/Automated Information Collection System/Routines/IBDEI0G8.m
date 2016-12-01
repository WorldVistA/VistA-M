IBDEI0G8 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20529,0)
 ;;=W18.2XXD^^55^807^74
 ;;^UTILITY(U,$J,358.3,20529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20529,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20529,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,20529,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,20530,0)
 ;;=W18.40XA^^55^807^105
 ;;^UTILITY(U,$J,358.3,20530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20530,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,20530,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,20530,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,20531,0)
 ;;=W18.40XD^^55^807^106
 ;;^UTILITY(U,$J,358.3,20531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20531,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20531,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,20531,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,20532,0)
 ;;=W18.41XA^^55^807^107
 ;;^UTILITY(U,$J,358.3,20532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20532,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,20532,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,20532,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,20533,0)
 ;;=W18.41XD^^55^807^108
 ;;^UTILITY(U,$J,358.3,20533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20533,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20533,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,20533,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,20534,0)
 ;;=W18.42XA^^55^807^109
 ;;^UTILITY(U,$J,358.3,20534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20534,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,20534,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,20534,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,20535,0)
 ;;=W18.42XD^^55^807^110
 ;;^UTILITY(U,$J,358.3,20535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20535,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20535,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,20535,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,20536,0)
 ;;=W18.43XA^^55^807^103
 ;;^UTILITY(U,$J,358.3,20536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20536,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,20536,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,20536,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,20537,0)
 ;;=W18.43XD^^55^807^104
 ;;^UTILITY(U,$J,358.3,20537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20537,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20537,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,20537,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,20538,0)
 ;;=W18.49XA^^55^807^111
 ;;^UTILITY(U,$J,358.3,20538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20538,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,20538,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,20538,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,20539,0)
 ;;=W18.49XD^^55^807^112
 ;;^UTILITY(U,$J,358.3,20539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20539,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20539,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,20539,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,20540,0)
 ;;=W19.XXXA^^55^807^89
 ;;^UTILITY(U,$J,358.3,20540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20540,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,20540,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,20540,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,20541,0)
 ;;=W19.XXXD^^55^807^90
 ;;^UTILITY(U,$J,358.3,20541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20541,1,3,0)
 ;;=3^Fall,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20541,1,4,0)
 ;;=4^W19.XXXD
 ;;^UTILITY(U,$J,358.3,20541,2)
 ;;=^5059834
 ;;^UTILITY(U,$J,358.3,20542,0)
 ;;=W54.0XXA^^55^807^11
 ;;^UTILITY(U,$J,358.3,20542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20542,1,3,0)
 ;;=3^Bitten by Dog,Init Encntr
 ;;^UTILITY(U,$J,358.3,20542,1,4,0)
 ;;=4^W54.0XXA
 ;;^UTILITY(U,$J,358.3,20542,2)
 ;;=^5060256
 ;;^UTILITY(U,$J,358.3,20543,0)
 ;;=W54.0XXD^^55^807^12
 ;;^UTILITY(U,$J,358.3,20543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20543,1,3,0)
 ;;=3^Bitten by Dog,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20543,1,4,0)
 ;;=4^W54.0XXD
 ;;^UTILITY(U,$J,358.3,20543,2)
 ;;=^5060257
 ;;^UTILITY(U,$J,358.3,20544,0)
 ;;=W55.01XA^^55^807^9
 ;;^UTILITY(U,$J,358.3,20544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20544,1,3,0)
 ;;=3^Bitten by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,20544,1,4,0)
 ;;=4^W55.01XA
 ;;^UTILITY(U,$J,358.3,20544,2)
 ;;=^5060265
 ;;^UTILITY(U,$J,358.3,20545,0)
 ;;=W55.01XD^^55^807^10
 ;;^UTILITY(U,$J,358.3,20545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20545,1,3,0)
 ;;=3^Bitten by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20545,1,4,0)
 ;;=4^W55.01XD
 ;;^UTILITY(U,$J,358.3,20545,2)
 ;;=^5060266
 ;;^UTILITY(U,$J,358.3,20546,0)
 ;;=W55.03XA^^55^807^101
 ;;^UTILITY(U,$J,358.3,20546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20546,1,3,0)
 ;;=3^Scratched by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,20546,1,4,0)
 ;;=4^W55.03XA
 ;;^UTILITY(U,$J,358.3,20546,2)
 ;;=^5060268
 ;;^UTILITY(U,$J,358.3,20547,0)
 ;;=W55.03XD^^55^807^102
 ;;^UTILITY(U,$J,358.3,20547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20547,1,3,0)
 ;;=3^Scratched by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20547,1,4,0)
 ;;=4^W55.03XD
 ;;^UTILITY(U,$J,358.3,20547,2)
 ;;=^5060269
 ;;^UTILITY(U,$J,358.3,20548,0)
 ;;=X00.8XXA^^55^807^17
 ;;^UTILITY(U,$J,358.3,20548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20548,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,20548,1,4,0)
 ;;=4^X00.8XXA
 ;;^UTILITY(U,$J,358.3,20548,2)
 ;;=^5060679
 ;;^UTILITY(U,$J,358.3,20549,0)
 ;;=X00.8XXD^^55^807^18
 ;;^UTILITY(U,$J,358.3,20549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20549,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20549,1,4,0)
 ;;=4^X00.8XXD
 ;;^UTILITY(U,$J,358.3,20549,2)
 ;;=^5060680
 ;;^UTILITY(U,$J,358.3,20550,0)
 ;;=X32.XXXA^^55^807^15
 ;;^UTILITY(U,$J,358.3,20550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20550,1,3,0)
 ;;=3^Exp to Sunlight,Init Encntr
 ;;^UTILITY(U,$J,358.3,20550,1,4,0)
 ;;=4^X32.XXXA
 ;;^UTILITY(U,$J,358.3,20550,2)
 ;;=^5060847
 ;;^UTILITY(U,$J,358.3,20551,0)
 ;;=X32.XXXD^^55^807^16
 ;;^UTILITY(U,$J,358.3,20551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20551,1,3,0)
 ;;=3^Exp to Sunlight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20551,1,4,0)
 ;;=4^X32.XXXD
 ;;^UTILITY(U,$J,358.3,20551,2)
 ;;=^5060848
 ;;^UTILITY(U,$J,358.3,20552,0)
 ;;=Y04.0XXA^^55^807^7
 ;;^UTILITY(U,$J,358.3,20552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20552,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,20552,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,20552,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,20553,0)
 ;;=Y04.0XXD^^55^807^8
 ;;^UTILITY(U,$J,358.3,20553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20553,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20553,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,20553,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,20554,0)
 ;;=Y04.1XXA^^55^807^1
 ;;^UTILITY(U,$J,358.3,20554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20554,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,20554,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,20554,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,20555,0)
 ;;=Y04.1XXD^^55^807^2
 ;;^UTILITY(U,$J,358.3,20555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20555,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20555,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,20555,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,20556,0)
 ;;=Y04.2XXA^^55^807^5
 ;;^UTILITY(U,$J,358.3,20556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20556,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,20556,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,20556,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,20557,0)
 ;;=Y04.8XXA^^55^807^3
 ;;^UTILITY(U,$J,358.3,20557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20557,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,20557,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,20557,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,20558,0)
 ;;=Y04.2XXD^^55^807^6
 ;;^UTILITY(U,$J,358.3,20558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20558,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20558,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,20558,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,20559,0)
 ;;=Y04.8XXD^^55^807^4
 ;;^UTILITY(U,$J,358.3,20559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20559,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20559,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,20559,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,20560,0)
 ;;=Y36.200A^^55^807^124
 ;;^UTILITY(U,$J,358.3,20560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20560,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,20560,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,20560,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,20561,0)
 ;;=Y36.200D^^55^807^125
 ;;^UTILITY(U,$J,358.3,20561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20561,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20561,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,20561,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,20562,0)
 ;;=Y36.300A^^55^807^126
 ;;^UTILITY(U,$J,358.3,20562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20562,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
