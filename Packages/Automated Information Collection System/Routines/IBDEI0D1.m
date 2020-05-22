IBDEI0D1 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31905,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,31905,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,31905,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,31906,0)
 ;;=W18.40XD^^92^1224^115
 ;;^UTILITY(U,$J,358.3,31906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31906,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31906,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,31906,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,31907,0)
 ;;=W18.41XA^^92^1224^116
 ;;^UTILITY(U,$J,358.3,31907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31907,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,31907,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,31907,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,31908,0)
 ;;=W18.41XD^^92^1224^117
 ;;^UTILITY(U,$J,358.3,31908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31908,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31908,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,31908,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,31909,0)
 ;;=W18.42XA^^92^1224^118
 ;;^UTILITY(U,$J,358.3,31909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31909,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,31909,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,31909,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,31910,0)
 ;;=W18.42XD^^92^1224^119
 ;;^UTILITY(U,$J,358.3,31910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31910,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31910,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,31910,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,31911,0)
 ;;=W18.43XA^^92^1224^112
 ;;^UTILITY(U,$J,358.3,31911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31911,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,31911,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,31911,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,31912,0)
 ;;=W18.43XD^^92^1224^113
 ;;^UTILITY(U,$J,358.3,31912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31912,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31912,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,31912,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,31913,0)
 ;;=W18.49XA^^92^1224^120
 ;;^UTILITY(U,$J,358.3,31913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31913,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,31913,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,31913,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,31914,0)
 ;;=W18.49XD^^92^1224^121
 ;;^UTILITY(U,$J,358.3,31914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31914,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31914,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,31914,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,31915,0)
 ;;=W19.XXXA^^92^1224^94
 ;;^UTILITY(U,$J,358.3,31915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31915,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,31915,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,31915,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,31916,0)
 ;;=W19.XXXD^^92^1224^95
 ;;^UTILITY(U,$J,358.3,31916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31916,1,3,0)
 ;;=3^Fall,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31916,1,4,0)
 ;;=4^W19.XXXD
 ;;^UTILITY(U,$J,358.3,31916,2)
 ;;=^5059834
 ;;^UTILITY(U,$J,358.3,31917,0)
 ;;=W54.0XXA^^92^1224^11
 ;;^UTILITY(U,$J,358.3,31917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31917,1,3,0)
 ;;=3^Bitten by Dog,Init Encntr
 ;;^UTILITY(U,$J,358.3,31917,1,4,0)
 ;;=4^W54.0XXA
 ;;^UTILITY(U,$J,358.3,31917,2)
 ;;=^5060256
 ;;^UTILITY(U,$J,358.3,31918,0)
 ;;=W54.0XXD^^92^1224^12
 ;;^UTILITY(U,$J,358.3,31918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31918,1,3,0)
 ;;=3^Bitten by Dog,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31918,1,4,0)
 ;;=4^W54.0XXD
 ;;^UTILITY(U,$J,358.3,31918,2)
 ;;=^5060257
 ;;^UTILITY(U,$J,358.3,31919,0)
 ;;=W55.01XA^^92^1224^9
 ;;^UTILITY(U,$J,358.3,31919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31919,1,3,0)
 ;;=3^Bitten by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,31919,1,4,0)
 ;;=4^W55.01XA
 ;;^UTILITY(U,$J,358.3,31919,2)
 ;;=^5060265
 ;;^UTILITY(U,$J,358.3,31920,0)
 ;;=W55.01XD^^92^1224^10
 ;;^UTILITY(U,$J,358.3,31920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31920,1,3,0)
 ;;=3^Bitten by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31920,1,4,0)
 ;;=4^W55.01XD
 ;;^UTILITY(U,$J,358.3,31920,2)
 ;;=^5060266
 ;;^UTILITY(U,$J,358.3,31921,0)
 ;;=W55.03XA^^92^1224^110
 ;;^UTILITY(U,$J,358.3,31921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31921,1,3,0)
 ;;=3^Scratched by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,31921,1,4,0)
 ;;=4^W55.03XA
 ;;^UTILITY(U,$J,358.3,31921,2)
 ;;=^5060268
 ;;^UTILITY(U,$J,358.3,31922,0)
 ;;=W55.03XD^^92^1224^111
 ;;^UTILITY(U,$J,358.3,31922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31922,1,3,0)
 ;;=3^Scratched by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31922,1,4,0)
 ;;=4^W55.03XD
 ;;^UTILITY(U,$J,358.3,31922,2)
 ;;=^5060269
 ;;^UTILITY(U,$J,358.3,31923,0)
 ;;=X00.8XXA^^92^1224^22
 ;;^UTILITY(U,$J,358.3,31923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31923,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,31923,1,4,0)
 ;;=4^X00.8XXA
 ;;^UTILITY(U,$J,358.3,31923,2)
 ;;=^5060679
 ;;^UTILITY(U,$J,358.3,31924,0)
 ;;=X00.8XXD^^92^1224^23
 ;;^UTILITY(U,$J,358.3,31924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31924,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31924,1,4,0)
 ;;=4^X00.8XXD
 ;;^UTILITY(U,$J,358.3,31924,2)
 ;;=^5060680
 ;;^UTILITY(U,$J,358.3,31925,0)
 ;;=X32.XXXA^^92^1224^20
 ;;^UTILITY(U,$J,358.3,31925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31925,1,3,0)
 ;;=3^Exp to Sunlight,Init Encntr
 ;;^UTILITY(U,$J,358.3,31925,1,4,0)
 ;;=4^X32.XXXA
 ;;^UTILITY(U,$J,358.3,31925,2)
 ;;=^5060847
 ;;^UTILITY(U,$J,358.3,31926,0)
 ;;=X32.XXXD^^92^1224^21
 ;;^UTILITY(U,$J,358.3,31926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31926,1,3,0)
 ;;=3^Exp to Sunlight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31926,1,4,0)
 ;;=4^X32.XXXD
 ;;^UTILITY(U,$J,358.3,31926,2)
 ;;=^5060848
 ;;^UTILITY(U,$J,358.3,31927,0)
 ;;=Y04.0XXA^^92^1224^7
 ;;^UTILITY(U,$J,358.3,31927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31927,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,31927,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,31927,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,31928,0)
 ;;=Y04.0XXD^^92^1224^8
 ;;^UTILITY(U,$J,358.3,31928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31928,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31928,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,31928,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,31929,0)
 ;;=Y04.1XXA^^92^1224^1
 ;;^UTILITY(U,$J,358.3,31929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31929,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,31929,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,31929,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,31930,0)
 ;;=Y04.1XXD^^92^1224^2
 ;;^UTILITY(U,$J,358.3,31930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31930,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31930,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,31930,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,31931,0)
 ;;=Y04.2XXA^^92^1224^5
 ;;^UTILITY(U,$J,358.3,31931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31931,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,31931,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,31931,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,31932,0)
 ;;=Y04.8XXA^^92^1224^3
 ;;^UTILITY(U,$J,358.3,31932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31932,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,31932,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,31932,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,31933,0)
 ;;=Y04.2XXD^^92^1224^6
 ;;^UTILITY(U,$J,358.3,31933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31933,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31933,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,31933,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,31934,0)
 ;;=Y04.8XXD^^92^1224^4
 ;;^UTILITY(U,$J,358.3,31934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31934,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31934,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,31934,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,31935,0)
 ;;=Y36.200A^^92^1224^133
 ;;^UTILITY(U,$J,358.3,31935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31935,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,31935,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,31935,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,31936,0)
 ;;=Y36.200D^^92^1224^134
 ;;^UTILITY(U,$J,358.3,31936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31936,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31936,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,31936,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,31937,0)
 ;;=Y36.300A^^92^1224^135
 ;;^UTILITY(U,$J,358.3,31937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31937,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,31937,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,31937,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,31938,0)
 ;;=Y36.300D^^92^1224^136
 ;;^UTILITY(U,$J,358.3,31938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31938,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31938,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,31938,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,31939,0)
 ;;=Y36.410A^^92^1224^130
 ;;^UTILITY(U,$J,358.3,31939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31939,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,31939,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,31939,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,31940,0)
 ;;=Y36.410D^^92^1224^132
 ;;^UTILITY(U,$J,358.3,31940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31940,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31940,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,31940,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,31941,0)
 ;;=Y36.6X0A^^92^1224^122
 ;;^UTILITY(U,$J,358.3,31941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31941,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,31941,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,31941,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,31942,0)
 ;;=Y36.6X0D^^92^1224^124
 ;;^UTILITY(U,$J,358.3,31942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31942,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31942,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,31942,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,31943,0)
 ;;=Y36.7X0A^^92^1224^137
 ;;^UTILITY(U,$J,358.3,31943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31943,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,31943,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,31943,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,31944,0)
 ;;=Y36.7X0D^^92^1224^138
 ;;^UTILITY(U,$J,358.3,31944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31944,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31944,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,31944,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,31945,0)
 ;;=Y36.810A^^92^1224^27
 ;;^UTILITY(U,$J,358.3,31945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31945,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,31945,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,31945,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,31946,0)
 ;;=Y36.810D^^92^1224^28
 ;;^UTILITY(U,$J,358.3,31946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31946,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31946,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,31946,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,31947,0)
 ;;=Y36.820A^^92^1224^24
 ;;^UTILITY(U,$J,358.3,31947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31947,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,31947,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,31947,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,31948,0)
 ;;=Y36.820D^^92^1224^25
 ;;^UTILITY(U,$J,358.3,31948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31948,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31948,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,31948,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,31949,0)
 ;;=Y37.200A^^92^1224^96
 ;;^UTILITY(U,$J,358.3,31949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31949,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,31949,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,31949,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,31950,0)
 ;;=Y37.200D^^92^1224^97
 ;;^UTILITY(U,$J,358.3,31950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31950,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31950,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,31950,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,31951,0)
 ;;=X00.1XXA^^92^1224^18
 ;;^UTILITY(U,$J,358.3,31951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31951,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,31951,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,31951,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,31952,0)
 ;;=X00.1XXD^^92^1224^19
 ;;^UTILITY(U,$J,358.3,31952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31952,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31952,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,31952,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,31953,0)
 ;;=Y36.820S^^92^1224^26
 ;;^UTILITY(U,$J,358.3,31953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31953,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,31953,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,31953,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,31954,0)
 ;;=Y36.810S^^92^1224^29
 ;;^UTILITY(U,$J,358.3,31954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31954,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,31954,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,31954,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,31955,0)
 ;;=Y36.6X0S^^92^1224^123
 ;;^UTILITY(U,$J,358.3,31955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31955,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,31955,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,31955,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,31956,0)
 ;;=Y36.410S^^92^1224^131
 ;;^UTILITY(U,$J,358.3,31956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31956,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,31956,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,31956,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,31957,0)
 ;;=Y36.200S^^92^1224^128
 ;;^UTILITY(U,$J,358.3,31957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31957,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,31957,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,31957,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,31958,0)
 ;;=Y36.300S^^92^1224^129
 ;;^UTILITY(U,$J,358.3,31958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31958,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,31958,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,31958,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,31959,0)
 ;;=Y36.230A^^92^1224^125
 ;;^UTILITY(U,$J,358.3,31959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31959,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,31959,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,31959,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,31960,0)
 ;;=Y36.230D^^92^1224^126
 ;;^UTILITY(U,$J,358.3,31960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31960,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31960,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,31960,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,31961,0)
 ;;=Y36.230S^^92^1224^127
 ;;^UTILITY(U,$J,358.3,31961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31961,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
 ;;^UTILITY(U,$J,358.3,31961,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,31961,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,31962,0)
 ;;=Y36.7X0S^^92^1224^139
 ;;^UTILITY(U,$J,358.3,31962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31962,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,31962,1,4,0)
 ;;=4^Y36.7X0S
 ;;^UTILITY(U,$J,358.3,31962,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,31963,0)
 ;;=V47.6XXA^^92^1224^14
 ;;^UTILITY(U,$J,358.3,31963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31963,1,3,0)
 ;;=3^Car Pasngr Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,31963,1,4,0)
 ;;=4^V47.6XXA
 ;;^UTILITY(U,$J,358.3,31963,2)
 ;;=^5140366
 ;;^UTILITY(U,$J,358.3,31964,0)
 ;;=V47.9XXA^^92^1224^13
 ;;^UTILITY(U,$J,358.3,31964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31964,1,3,0)
 ;;=3^Car Occpnt,Unspec,Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,31964,1,4,0)
 ;;=4^V47.9XXA
 ;;^UTILITY(U,$J,358.3,31964,2)
 ;;=^5140369
 ;;^UTILITY(U,$J,358.3,31965,0)
 ;;=W26.2XXA^^92^1224^15
 ;;^UTILITY(U,$J,358.3,31965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31965,1,3,0)
 ;;=3^Contact w/ Edge of Stiff Paper,Init Encntr
 ;;^UTILITY(U,$J,358.3,31965,1,4,0)
 ;;=4^W26.2XXA
 ;;^UTILITY(U,$J,358.3,31965,2)
 ;;=^5140372
 ;;^UTILITY(U,$J,358.3,31966,0)
 ;;=W26.8XXA^^92^1224^16
 ;;^UTILITY(U,$J,358.3,31966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31966,1,3,0)
 ;;=3^Contact w/ Other Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,31966,1,4,0)
 ;;=4^W26.8XXA
 ;;^UTILITY(U,$J,358.3,31966,2)
 ;;=^5140375
 ;;^UTILITY(U,$J,358.3,31967,0)
 ;;=W26.9XXA^^92^1224^17
 ;;^UTILITY(U,$J,358.3,31967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31967,1,3,0)
 ;;=3^Contact w/ Unspec Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,31967,1,4,0)
 ;;=4^W26.9XXA
 ;;^UTILITY(U,$J,358.3,31967,2)
 ;;=^5140378
 ;;^UTILITY(U,$J,358.3,31968,0)
 ;;=X50.0XXA^^92^1224^103
 ;;^UTILITY(U,$J,358.3,31968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31968,1,3,0)
 ;;=3^Overexertion from Strenuous Movement/Load,Init Encntr
 ;;^UTILITY(U,$J,358.3,31968,1,4,0)
 ;;=4^X50.0XXA
