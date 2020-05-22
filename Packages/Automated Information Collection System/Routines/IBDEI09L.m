IBDEI09L ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23465,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Init Encntr
 ;;^UTILITY(U,$J,358.3,23465,1,4,0)
 ;;=4^W18.2XXA
 ;;^UTILITY(U,$J,358.3,23465,2)
 ;;=^5059806
 ;;^UTILITY(U,$J,358.3,23466,0)
 ;;=W18.2XXD^^73^959^79
 ;;^UTILITY(U,$J,358.3,23466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23466,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23466,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,23466,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,23467,0)
 ;;=W18.40XA^^73^959^114
 ;;^UTILITY(U,$J,358.3,23467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23467,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,23467,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,23467,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,23468,0)
 ;;=W18.40XD^^73^959^115
 ;;^UTILITY(U,$J,358.3,23468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23468,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23468,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,23468,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,23469,0)
 ;;=W18.41XA^^73^959^116
 ;;^UTILITY(U,$J,358.3,23469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23469,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,23469,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,23469,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,23470,0)
 ;;=W18.41XD^^73^959^117
 ;;^UTILITY(U,$J,358.3,23470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23470,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23470,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,23470,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,23471,0)
 ;;=W18.42XA^^73^959^118
 ;;^UTILITY(U,$J,358.3,23471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23471,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,23471,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,23471,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,23472,0)
 ;;=W18.42XD^^73^959^119
 ;;^UTILITY(U,$J,358.3,23472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23472,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23472,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,23472,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,23473,0)
 ;;=W18.43XA^^73^959^112
 ;;^UTILITY(U,$J,358.3,23473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23473,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,23473,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,23473,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,23474,0)
 ;;=W18.43XD^^73^959^113
 ;;^UTILITY(U,$J,358.3,23474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23474,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23474,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,23474,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,23475,0)
 ;;=W18.49XA^^73^959^120
 ;;^UTILITY(U,$J,358.3,23475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23475,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,23475,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,23475,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,23476,0)
 ;;=W18.49XD^^73^959^121
 ;;^UTILITY(U,$J,358.3,23476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23476,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23476,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,23476,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,23477,0)
 ;;=W19.XXXA^^73^959^94
 ;;^UTILITY(U,$J,358.3,23477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23477,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,23477,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,23477,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,23478,0)
 ;;=W19.XXXD^^73^959^95
 ;;^UTILITY(U,$J,358.3,23478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23478,1,3,0)
 ;;=3^Fall,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23478,1,4,0)
 ;;=4^W19.XXXD
 ;;^UTILITY(U,$J,358.3,23478,2)
 ;;=^5059834
 ;;^UTILITY(U,$J,358.3,23479,0)
 ;;=W54.0XXA^^73^959^11
 ;;^UTILITY(U,$J,358.3,23479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23479,1,3,0)
 ;;=3^Bitten by Dog,Init Encntr
 ;;^UTILITY(U,$J,358.3,23479,1,4,0)
 ;;=4^W54.0XXA
 ;;^UTILITY(U,$J,358.3,23479,2)
 ;;=^5060256
 ;;^UTILITY(U,$J,358.3,23480,0)
 ;;=W54.0XXD^^73^959^12
 ;;^UTILITY(U,$J,358.3,23480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23480,1,3,0)
 ;;=3^Bitten by Dog,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23480,1,4,0)
 ;;=4^W54.0XXD
 ;;^UTILITY(U,$J,358.3,23480,2)
 ;;=^5060257
 ;;^UTILITY(U,$J,358.3,23481,0)
 ;;=W55.01XA^^73^959^9
 ;;^UTILITY(U,$J,358.3,23481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23481,1,3,0)
 ;;=3^Bitten by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,23481,1,4,0)
 ;;=4^W55.01XA
 ;;^UTILITY(U,$J,358.3,23481,2)
 ;;=^5060265
 ;;^UTILITY(U,$J,358.3,23482,0)
 ;;=W55.01XD^^73^959^10
 ;;^UTILITY(U,$J,358.3,23482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23482,1,3,0)
 ;;=3^Bitten by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23482,1,4,0)
 ;;=4^W55.01XD
 ;;^UTILITY(U,$J,358.3,23482,2)
 ;;=^5060266
 ;;^UTILITY(U,$J,358.3,23483,0)
 ;;=W55.03XA^^73^959^110
 ;;^UTILITY(U,$J,358.3,23483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23483,1,3,0)
 ;;=3^Scratched by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,23483,1,4,0)
 ;;=4^W55.03XA
 ;;^UTILITY(U,$J,358.3,23483,2)
 ;;=^5060268
 ;;^UTILITY(U,$J,358.3,23484,0)
 ;;=W55.03XD^^73^959^111
 ;;^UTILITY(U,$J,358.3,23484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23484,1,3,0)
 ;;=3^Scratched by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23484,1,4,0)
 ;;=4^W55.03XD
 ;;^UTILITY(U,$J,358.3,23484,2)
 ;;=^5060269
 ;;^UTILITY(U,$J,358.3,23485,0)
 ;;=X00.8XXA^^73^959^22
 ;;^UTILITY(U,$J,358.3,23485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23485,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,23485,1,4,0)
 ;;=4^X00.8XXA
 ;;^UTILITY(U,$J,358.3,23485,2)
 ;;=^5060679
 ;;^UTILITY(U,$J,358.3,23486,0)
 ;;=X00.8XXD^^73^959^23
 ;;^UTILITY(U,$J,358.3,23486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23486,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23486,1,4,0)
 ;;=4^X00.8XXD
 ;;^UTILITY(U,$J,358.3,23486,2)
 ;;=^5060680
 ;;^UTILITY(U,$J,358.3,23487,0)
 ;;=X32.XXXA^^73^959^20
 ;;^UTILITY(U,$J,358.3,23487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23487,1,3,0)
 ;;=3^Exp to Sunlight,Init Encntr
 ;;^UTILITY(U,$J,358.3,23487,1,4,0)
 ;;=4^X32.XXXA
 ;;^UTILITY(U,$J,358.3,23487,2)
 ;;=^5060847
 ;;^UTILITY(U,$J,358.3,23488,0)
 ;;=X32.XXXD^^73^959^21
 ;;^UTILITY(U,$J,358.3,23488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23488,1,3,0)
 ;;=3^Exp to Sunlight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23488,1,4,0)
 ;;=4^X32.XXXD
 ;;^UTILITY(U,$J,358.3,23488,2)
 ;;=^5060848
 ;;^UTILITY(U,$J,358.3,23489,0)
 ;;=Y04.0XXA^^73^959^7
 ;;^UTILITY(U,$J,358.3,23489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23489,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,23489,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,23489,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,23490,0)
 ;;=Y04.0XXD^^73^959^8
 ;;^UTILITY(U,$J,358.3,23490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23490,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23490,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,23490,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,23491,0)
 ;;=Y04.1XXA^^73^959^1
 ;;^UTILITY(U,$J,358.3,23491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23491,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,23491,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,23491,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,23492,0)
 ;;=Y04.1XXD^^73^959^2
 ;;^UTILITY(U,$J,358.3,23492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23492,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23492,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,23492,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,23493,0)
 ;;=Y04.2XXA^^73^959^5
 ;;^UTILITY(U,$J,358.3,23493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23493,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,23493,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,23493,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,23494,0)
 ;;=Y04.8XXA^^73^959^3
 ;;^UTILITY(U,$J,358.3,23494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23494,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,23494,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,23494,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,23495,0)
 ;;=Y04.2XXD^^73^959^6
 ;;^UTILITY(U,$J,358.3,23495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23495,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23495,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,23495,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,23496,0)
 ;;=Y04.8XXD^^73^959^4
 ;;^UTILITY(U,$J,358.3,23496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23496,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23496,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,23496,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,23497,0)
 ;;=Y36.200A^^73^959^133
 ;;^UTILITY(U,$J,358.3,23497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23497,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23497,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,23497,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,23498,0)
 ;;=Y36.200D^^73^959^134
 ;;^UTILITY(U,$J,358.3,23498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23498,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23498,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,23498,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,23499,0)
 ;;=Y36.300A^^73^959^135
 ;;^UTILITY(U,$J,358.3,23499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23499,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23499,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,23499,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,23500,0)
 ;;=Y36.300D^^73^959^136
 ;;^UTILITY(U,$J,358.3,23500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23500,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23500,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,23500,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,23501,0)
 ;;=Y36.410A^^73^959^130
 ;;^UTILITY(U,$J,358.3,23501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23501,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23501,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,23501,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,23502,0)
 ;;=Y36.410D^^73^959^132
 ;;^UTILITY(U,$J,358.3,23502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23502,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23502,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,23502,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,23503,0)
 ;;=Y36.6X0A^^73^959^122
 ;;^UTILITY(U,$J,358.3,23503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23503,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23503,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,23503,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,23504,0)
 ;;=Y36.6X0D^^73^959^124
 ;;^UTILITY(U,$J,358.3,23504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23504,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23504,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,23504,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,23505,0)
 ;;=Y36.7X0A^^73^959^137
 ;;^UTILITY(U,$J,358.3,23505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23505,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23505,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,23505,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,23506,0)
 ;;=Y36.7X0D^^73^959^138
 ;;^UTILITY(U,$J,358.3,23506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23506,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23506,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,23506,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,23507,0)
 ;;=Y36.810A^^73^959^27
 ;;^UTILITY(U,$J,358.3,23507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23507,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23507,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,23507,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,23508,0)
 ;;=Y36.810D^^73^959^28
 ;;^UTILITY(U,$J,358.3,23508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23508,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23508,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,23508,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,23509,0)
 ;;=Y36.820A^^73^959^24
 ;;^UTILITY(U,$J,358.3,23509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23509,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23509,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,23509,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,23510,0)
 ;;=Y36.820D^^73^959^25
 ;;^UTILITY(U,$J,358.3,23510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23510,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23510,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,23510,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,23511,0)
 ;;=Y37.200A^^73^959^96
 ;;^UTILITY(U,$J,358.3,23511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23511,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23511,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,23511,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,23512,0)
 ;;=Y37.200D^^73^959^97
 ;;^UTILITY(U,$J,358.3,23512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23512,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23512,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,23512,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,23513,0)
 ;;=X00.1XXA^^73^959^18
 ;;^UTILITY(U,$J,358.3,23513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23513,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,23513,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,23513,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,23514,0)
 ;;=X00.1XXD^^73^959^19
 ;;^UTILITY(U,$J,358.3,23514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23514,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23514,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,23514,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,23515,0)
 ;;=Y36.820S^^73^959^26
 ;;^UTILITY(U,$J,358.3,23515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23515,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23515,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,23515,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,23516,0)
 ;;=Y36.810S^^73^959^29
 ;;^UTILITY(U,$J,358.3,23516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23516,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23516,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,23516,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,23517,0)
 ;;=Y36.6X0S^^73^959^123
 ;;^UTILITY(U,$J,358.3,23517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23517,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23517,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,23517,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,23518,0)
 ;;=Y36.410S^^73^959^131
 ;;^UTILITY(U,$J,358.3,23518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23518,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23518,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,23518,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,23519,0)
 ;;=Y36.200S^^73^959^128
 ;;^UTILITY(U,$J,358.3,23519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23519,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23519,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,23519,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,23520,0)
 ;;=Y36.300S^^73^959^129
 ;;^UTILITY(U,$J,358.3,23520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23520,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23520,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,23520,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,23521,0)
 ;;=Y36.230A^^73^959^125
 ;;^UTILITY(U,$J,358.3,23521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23521,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,23521,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,23521,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,23522,0)
 ;;=Y36.230D^^73^959^126
 ;;^UTILITY(U,$J,358.3,23522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23522,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23522,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,23522,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,23523,0)
 ;;=Y36.230S^^73^959^127
 ;;^UTILITY(U,$J,358.3,23523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23523,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
 ;;^UTILITY(U,$J,358.3,23523,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,23523,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,23524,0)
 ;;=Y36.7X0S^^73^959^139
 ;;^UTILITY(U,$J,358.3,23524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23524,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23524,1,4,0)
 ;;=4^Y36.7X0S
 ;;^UTILITY(U,$J,358.3,23524,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,23525,0)
 ;;=V47.6XXA^^73^959^14
 ;;^UTILITY(U,$J,358.3,23525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23525,1,3,0)
 ;;=3^Car Pasngr Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,23525,1,4,0)
 ;;=4^V47.6XXA
 ;;^UTILITY(U,$J,358.3,23525,2)
 ;;=^5140366
 ;;^UTILITY(U,$J,358.3,23526,0)
 ;;=V47.9XXA^^73^959^13
 ;;^UTILITY(U,$J,358.3,23526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23526,1,3,0)
 ;;=3^Car Occpnt,Unspec,Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,23526,1,4,0)
 ;;=4^V47.9XXA
 ;;^UTILITY(U,$J,358.3,23526,2)
 ;;=^5140369
 ;;^UTILITY(U,$J,358.3,23527,0)
 ;;=W26.2XXA^^73^959^15
 ;;^UTILITY(U,$J,358.3,23527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23527,1,3,0)
 ;;=3^Contact w/ Edge of Stiff Paper,Init Encntr
 ;;^UTILITY(U,$J,358.3,23527,1,4,0)
 ;;=4^W26.2XXA
 ;;^UTILITY(U,$J,358.3,23527,2)
 ;;=^5140372
 ;;^UTILITY(U,$J,358.3,23528,0)
 ;;=W26.8XXA^^73^959^16
 ;;^UTILITY(U,$J,358.3,23528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23528,1,3,0)
 ;;=3^Contact w/ Other Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,23528,1,4,0)
 ;;=4^W26.8XXA
 ;;^UTILITY(U,$J,358.3,23528,2)
 ;;=^5140375
