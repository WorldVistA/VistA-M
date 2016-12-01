IBDEI068 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7759,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,7759,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,7760,0)
 ;;=W18.43XD^^26^421^104
 ;;^UTILITY(U,$J,358.3,7760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7760,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7760,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,7760,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,7761,0)
 ;;=W18.49XA^^26^421^111
 ;;^UTILITY(U,$J,358.3,7761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7761,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,7761,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,7761,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,7762,0)
 ;;=W18.49XD^^26^421^112
 ;;^UTILITY(U,$J,358.3,7762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7762,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7762,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,7762,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,7763,0)
 ;;=W19.XXXA^^26^421^89
 ;;^UTILITY(U,$J,358.3,7763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7763,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,7763,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,7763,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,7764,0)
 ;;=W19.XXXD^^26^421^90
 ;;^UTILITY(U,$J,358.3,7764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7764,1,3,0)
 ;;=3^Fall,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7764,1,4,0)
 ;;=4^W19.XXXD
 ;;^UTILITY(U,$J,358.3,7764,2)
 ;;=^5059834
 ;;^UTILITY(U,$J,358.3,7765,0)
 ;;=W54.0XXA^^26^421^11
 ;;^UTILITY(U,$J,358.3,7765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7765,1,3,0)
 ;;=3^Bitten by Dog,Init Encntr
 ;;^UTILITY(U,$J,358.3,7765,1,4,0)
 ;;=4^W54.0XXA
 ;;^UTILITY(U,$J,358.3,7765,2)
 ;;=^5060256
 ;;^UTILITY(U,$J,358.3,7766,0)
 ;;=W54.0XXD^^26^421^12
 ;;^UTILITY(U,$J,358.3,7766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7766,1,3,0)
 ;;=3^Bitten by Dog,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7766,1,4,0)
 ;;=4^W54.0XXD
 ;;^UTILITY(U,$J,358.3,7766,2)
 ;;=^5060257
 ;;^UTILITY(U,$J,358.3,7767,0)
 ;;=W55.01XA^^26^421^9
 ;;^UTILITY(U,$J,358.3,7767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7767,1,3,0)
 ;;=3^Bitten by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,7767,1,4,0)
 ;;=4^W55.01XA
 ;;^UTILITY(U,$J,358.3,7767,2)
 ;;=^5060265
 ;;^UTILITY(U,$J,358.3,7768,0)
 ;;=W55.01XD^^26^421^10
 ;;^UTILITY(U,$J,358.3,7768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7768,1,3,0)
 ;;=3^Bitten by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7768,1,4,0)
 ;;=4^W55.01XD
 ;;^UTILITY(U,$J,358.3,7768,2)
 ;;=^5060266
 ;;^UTILITY(U,$J,358.3,7769,0)
 ;;=W55.03XA^^26^421^101
 ;;^UTILITY(U,$J,358.3,7769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7769,1,3,0)
 ;;=3^Scratched by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,7769,1,4,0)
 ;;=4^W55.03XA
 ;;^UTILITY(U,$J,358.3,7769,2)
 ;;=^5060268
 ;;^UTILITY(U,$J,358.3,7770,0)
 ;;=W55.03XD^^26^421^102
 ;;^UTILITY(U,$J,358.3,7770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7770,1,3,0)
 ;;=3^Scratched by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7770,1,4,0)
 ;;=4^W55.03XD
 ;;^UTILITY(U,$J,358.3,7770,2)
 ;;=^5060269
 ;;^UTILITY(U,$J,358.3,7771,0)
 ;;=X00.8XXA^^26^421^17
 ;;^UTILITY(U,$J,358.3,7771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7771,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,7771,1,4,0)
 ;;=4^X00.8XXA
 ;;^UTILITY(U,$J,358.3,7771,2)
 ;;=^5060679
 ;;^UTILITY(U,$J,358.3,7772,0)
 ;;=X00.8XXD^^26^421^18
 ;;^UTILITY(U,$J,358.3,7772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7772,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7772,1,4,0)
 ;;=4^X00.8XXD
 ;;^UTILITY(U,$J,358.3,7772,2)
 ;;=^5060680
 ;;^UTILITY(U,$J,358.3,7773,0)
 ;;=X32.XXXA^^26^421^15
 ;;^UTILITY(U,$J,358.3,7773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7773,1,3,0)
 ;;=3^Exp to Sunlight,Init Encntr
 ;;^UTILITY(U,$J,358.3,7773,1,4,0)
 ;;=4^X32.XXXA
 ;;^UTILITY(U,$J,358.3,7773,2)
 ;;=^5060847
 ;;^UTILITY(U,$J,358.3,7774,0)
 ;;=X32.XXXD^^26^421^16
 ;;^UTILITY(U,$J,358.3,7774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7774,1,3,0)
 ;;=3^Exp to Sunlight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7774,1,4,0)
 ;;=4^X32.XXXD
 ;;^UTILITY(U,$J,358.3,7774,2)
 ;;=^5060848
 ;;^UTILITY(U,$J,358.3,7775,0)
 ;;=Y04.0XXA^^26^421^7
 ;;^UTILITY(U,$J,358.3,7775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7775,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,7775,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,7775,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,7776,0)
 ;;=Y04.0XXD^^26^421^8
 ;;^UTILITY(U,$J,358.3,7776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7776,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7776,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,7776,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,7777,0)
 ;;=Y04.1XXA^^26^421^1
 ;;^UTILITY(U,$J,358.3,7777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7777,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,7777,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,7777,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,7778,0)
 ;;=Y04.1XXD^^26^421^2
 ;;^UTILITY(U,$J,358.3,7778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7778,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7778,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,7778,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,7779,0)
 ;;=Y04.2XXA^^26^421^5
 ;;^UTILITY(U,$J,358.3,7779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7779,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,7779,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,7779,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,7780,0)
 ;;=Y04.8XXA^^26^421^3
 ;;^UTILITY(U,$J,358.3,7780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7780,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,7780,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,7780,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,7781,0)
 ;;=Y04.2XXD^^26^421^6
 ;;^UTILITY(U,$J,358.3,7781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7781,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7781,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,7781,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,7782,0)
 ;;=Y04.8XXD^^26^421^4
 ;;^UTILITY(U,$J,358.3,7782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7782,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7782,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,7782,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,7783,0)
 ;;=Y36.200A^^26^421^124
 ;;^UTILITY(U,$J,358.3,7783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7783,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7783,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,7783,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,7784,0)
 ;;=Y36.200D^^26^421^125
 ;;^UTILITY(U,$J,358.3,7784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7784,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7784,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,7784,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,7785,0)
 ;;=Y36.300A^^26^421^126
 ;;^UTILITY(U,$J,358.3,7785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7785,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7785,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,7785,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,7786,0)
 ;;=Y36.300D^^26^421^127
 ;;^UTILITY(U,$J,358.3,7786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7786,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7786,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,7786,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,7787,0)
 ;;=Y36.410A^^26^421^121
 ;;^UTILITY(U,$J,358.3,7787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7787,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7787,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,7787,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,7788,0)
 ;;=Y36.410D^^26^421^123
 ;;^UTILITY(U,$J,358.3,7788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7788,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7788,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,7788,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,7789,0)
 ;;=Y36.6X0A^^26^421^113
 ;;^UTILITY(U,$J,358.3,7789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7789,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7789,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,7789,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,7790,0)
 ;;=Y36.6X0D^^26^421^115
 ;;^UTILITY(U,$J,358.3,7790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7790,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7790,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,7790,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,7791,0)
 ;;=Y36.7X0A^^26^421^128
 ;;^UTILITY(U,$J,358.3,7791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7791,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7791,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,7791,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,7792,0)
 ;;=Y36.7X0D^^26^421^129
 ;;^UTILITY(U,$J,358.3,7792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7792,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7792,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,7792,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,7793,0)
 ;;=Y36.810A^^26^421^22
 ;;^UTILITY(U,$J,358.3,7793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7793,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7793,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,7793,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,7794,0)
 ;;=Y36.810D^^26^421^23
