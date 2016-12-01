IBDEI0S6 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37222,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37222,1,2,0)
 ;;=2^Neuromuscular Junction Test
 ;;^UTILITY(U,$J,358.3,37222,1,3,0)
 ;;=3^95937
 ;;^UTILITY(U,$J,358.3,37223,0)
 ;;=95869^^105^1582^10^^^^1
 ;;^UTILITY(U,$J,358.3,37223,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37223,1,2,0)
 ;;=2^Muscle Test Thor Paraspinal
 ;;^UTILITY(U,$J,358.3,37223,1,3,0)
 ;;=3^95869
 ;;^UTILITY(U,$J,358.3,37224,0)
 ;;=99366^^105^1583^1^^^^1
 ;;^UTILITY(U,$J,358.3,37224,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37224,1,2,0)
 ;;=2^Interdisc Team Conf HCP w/pt-fam >30min
 ;;^UTILITY(U,$J,358.3,37224,1,3,0)
 ;;=3^99366
 ;;^UTILITY(U,$J,358.3,37225,0)
 ;;=99368^^105^1583^2^^^^1
 ;;^UTILITY(U,$J,358.3,37225,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37225,1,2,0)
 ;;=2^Interdis Team Conf HCP w/o pt/fam >30min
 ;;^UTILITY(U,$J,358.3,37225,1,3,0)
 ;;=3^99368
 ;;^UTILITY(U,$J,358.3,37226,0)
 ;;=96150^^105^1584^1^^^^1
 ;;^UTILITY(U,$J,358.3,37226,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37226,1,2,0)
 ;;=2^Init Assess Hlth/Behave,Ea 15min
 ;;^UTILITY(U,$J,358.3,37226,1,3,0)
 ;;=3^96150
 ;;^UTILITY(U,$J,358.3,37227,0)
 ;;=96151^^105^1584^2^^^^1
 ;;^UTILITY(U,$J,358.3,37227,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37227,1,2,0)
 ;;=2^Reassess Hlth/Behave,Ea 15min
 ;;^UTILITY(U,$J,358.3,37227,1,3,0)
 ;;=3^96151
 ;;^UTILITY(U,$J,358.3,37228,0)
 ;;=96152^^105^1584^3^^^^1
 ;;^UTILITY(U,$J,358.3,37228,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37228,1,2,0)
 ;;=2^Hlth/Behave Interven,Indiv,Ea 15min
 ;;^UTILITY(U,$J,358.3,37228,1,3,0)
 ;;=3^96152
 ;;^UTILITY(U,$J,358.3,37229,0)
 ;;=96153^^105^1584^4^^^^1
 ;;^UTILITY(U,$J,358.3,37229,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37229,1,2,0)
 ;;=2^Hlth/Behave Interven,Grp,Ea 15min
 ;;^UTILITY(U,$J,358.3,37229,1,3,0)
 ;;=3^96153
 ;;^UTILITY(U,$J,358.3,37230,0)
 ;;=96154^^105^1584^5^^^^1
 ;;^UTILITY(U,$J,358.3,37230,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37230,1,2,0)
 ;;=2^Hlth/Behave Interven,Fam w/ Pt,Ea 15min
 ;;^UTILITY(U,$J,358.3,37230,1,3,0)
 ;;=3^96154
 ;;^UTILITY(U,$J,358.3,37231,0)
 ;;=96155^^105^1584^6^^^^1
 ;;^UTILITY(U,$J,358.3,37231,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37231,1,2,0)
 ;;=2^Hlth/Behave Interven,Fam w/o Pt,Ea 15min
 ;;^UTILITY(U,$J,358.3,37231,1,3,0)
 ;;=3^96155
 ;;^UTILITY(U,$J,358.3,37232,0)
 ;;=S9445^^105^1585^3^^^^1
 ;;^UTILITY(U,$J,358.3,37232,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37232,1,2,0)
 ;;=2^Pt Education NOC Individual
 ;;^UTILITY(U,$J,358.3,37232,1,3,0)
 ;;=3^S9445
 ;;^UTILITY(U,$J,358.3,37233,0)
 ;;=S9446^^105^1585^2^^^^1
 ;;^UTILITY(U,$J,358.3,37233,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37233,1,2,0)
 ;;=2^Pt Education NOC Group
 ;;^UTILITY(U,$J,358.3,37233,1,3,0)
 ;;=3^S9446
 ;;^UTILITY(U,$J,358.3,37234,0)
 ;;=T2001^^105^1585^1^^^^1
 ;;^UTILITY(U,$J,358.3,37234,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37234,1,2,0)
 ;;=2^N-ET:Patient Attend/Escort
 ;;^UTILITY(U,$J,358.3,37234,1,3,0)
 ;;=3^T2001
 ;;^UTILITY(U,$J,358.3,37235,0)
 ;;=Z89.012^^106^1586^10
 ;;^UTILITY(U,$J,358.3,37235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37235,1,3,0)
 ;;=3^Acquired absence of left thumb
 ;;^UTILITY(U,$J,358.3,37235,1,4,0)
 ;;=4^Z89.012
 ;;^UTILITY(U,$J,358.3,37235,2)
 ;;=^5063532
 ;;^UTILITY(U,$J,358.3,37236,0)
 ;;=Z89.011^^106^1586^25
 ;;^UTILITY(U,$J,358.3,37236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37236,1,3,0)
 ;;=3^Acquired absence of right thumb
 ;;^UTILITY(U,$J,358.3,37236,1,4,0)
 ;;=4^Z89.011
 ;;^UTILITY(U,$J,358.3,37236,2)
 ;;=^5063531
 ;;^UTILITY(U,$J,358.3,37237,0)
 ;;=Z89.021^^106^1586^16
 ;;^UTILITY(U,$J,358.3,37237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37237,1,3,0)
 ;;=3^Acquired absence of right finger(s)
 ;;^UTILITY(U,$J,358.3,37237,1,4,0)
 ;;=4^Z89.021
 ;;^UTILITY(U,$J,358.3,37237,2)
 ;;=^5063534
 ;;^UTILITY(U,$J,358.3,37238,0)
 ;;=Z89.022^^106^1586^2
 ;;^UTILITY(U,$J,358.3,37238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37238,1,3,0)
 ;;=3^Acquired absence of left finger(s)
 ;;^UTILITY(U,$J,358.3,37238,1,4,0)
 ;;=4^Z89.022
 ;;^UTILITY(U,$J,358.3,37238,2)
 ;;=^5063535
 ;;^UTILITY(U,$J,358.3,37239,0)
 ;;=Z89.112^^106^1586^5
 ;;^UTILITY(U,$J,358.3,37239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37239,1,3,0)
 ;;=3^Acquired absence of left hand
 ;;^UTILITY(U,$J,358.3,37239,1,4,0)
 ;;=4^Z89.112
 ;;^UTILITY(U,$J,358.3,37239,2)
 ;;=^5063538
 ;;^UTILITY(U,$J,358.3,37240,0)
 ;;=Z89.111^^106^1586^19
 ;;^UTILITY(U,$J,358.3,37240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37240,1,3,0)
 ;;=3^Acquired absence of right hand
 ;;^UTILITY(U,$J,358.3,37240,1,4,0)
 ;;=4^Z89.111
 ;;^UTILITY(U,$J,358.3,37240,2)
 ;;=^5063537
 ;;^UTILITY(U,$J,358.3,37241,0)
 ;;=Z89.122^^106^1586^14
 ;;^UTILITY(U,$J,358.3,37241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37241,1,3,0)
 ;;=3^Acquired absence of left wrist
 ;;^UTILITY(U,$J,358.3,37241,1,4,0)
 ;;=4^Z89.122
 ;;^UTILITY(U,$J,358.3,37241,2)
 ;;=^5063541
 ;;^UTILITY(U,$J,358.3,37242,0)
 ;;=Z89.121^^106^1586^29
 ;;^UTILITY(U,$J,358.3,37242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37242,1,3,0)
 ;;=3^Acquired absence of right wrist
 ;;^UTILITY(U,$J,358.3,37242,1,4,0)
 ;;=4^Z89.121
 ;;^UTILITY(U,$J,358.3,37242,2)
 ;;=^5063540
 ;;^UTILITY(U,$J,358.3,37243,0)
 ;;=Z89.211^^106^1586^28
 ;;^UTILITY(U,$J,358.3,37243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37243,1,3,0)
 ;;=3^Acquired absence of right upper limb below elbow
 ;;^UTILITY(U,$J,358.3,37243,1,4,0)
 ;;=4^Z89.211
 ;;^UTILITY(U,$J,358.3,37243,2)
 ;;=^5063545
 ;;^UTILITY(U,$J,358.3,37244,0)
 ;;=Z89.212^^106^1586^13
 ;;^UTILITY(U,$J,358.3,37244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37244,1,3,0)
 ;;=3^Acquired absence of left upper limb below elbow
 ;;^UTILITY(U,$J,358.3,37244,1,4,0)
 ;;=4^Z89.212
 ;;^UTILITY(U,$J,358.3,37244,2)
 ;;=^5063546
 ;;^UTILITY(U,$J,358.3,37245,0)
 ;;=Z89.221^^106^1586^27
 ;;^UTILITY(U,$J,358.3,37245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37245,1,3,0)
 ;;=3^Acquired absence of right upper limb above elbow
 ;;^UTILITY(U,$J,358.3,37245,1,4,0)
 ;;=4^Z89.221
 ;;^UTILITY(U,$J,358.3,37245,2)
 ;;=^5063548
 ;;^UTILITY(U,$J,358.3,37246,0)
 ;;=Z89.222^^106^1586^12
 ;;^UTILITY(U,$J,358.3,37246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37246,1,3,0)
 ;;=3^Acquired absence of left upper limb above elbow
 ;;^UTILITY(U,$J,358.3,37246,1,4,0)
 ;;=4^Z89.222
 ;;^UTILITY(U,$J,358.3,37246,2)
 ;;=^5063549
 ;;^UTILITY(U,$J,358.3,37247,0)
 ;;=Z89.232^^106^1586^9
 ;;^UTILITY(U,$J,358.3,37247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37247,1,3,0)
 ;;=3^Acquired absence of left shoulder
 ;;^UTILITY(U,$J,358.3,37247,1,4,0)
 ;;=4^Z89.232
 ;;^UTILITY(U,$J,358.3,37247,2)
 ;;=^5063552
 ;;^UTILITY(U,$J,358.3,37248,0)
 ;;=Z89.231^^106^1586^24
 ;;^UTILITY(U,$J,358.3,37248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37248,1,3,0)
 ;;=3^Acquired absence of right shoulder
 ;;^UTILITY(U,$J,358.3,37248,1,4,0)
 ;;=4^Z89.231
 ;;^UTILITY(U,$J,358.3,37248,2)
 ;;=^5063551
 ;;^UTILITY(U,$J,358.3,37249,0)
 ;;=Z89.611^^106^1586^21
 ;;^UTILITY(U,$J,358.3,37249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37249,1,3,0)
 ;;=3^Acquired absence of right leg above knee
 ;;^UTILITY(U,$J,358.3,37249,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,37249,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,37250,0)
 ;;=Z89.411^^106^1586^18
 ;;^UTILITY(U,$J,358.3,37250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37250,1,3,0)
 ;;=3^Acquired absence of right great toe
 ;;^UTILITY(U,$J,358.3,37250,1,4,0)
 ;;=4^Z89.411
 ;;^UTILITY(U,$J,358.3,37250,2)
 ;;=^5063554
 ;;^UTILITY(U,$J,358.3,37251,0)
 ;;=Z89.412^^106^1586^4
 ;;^UTILITY(U,$J,358.3,37251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37251,1,3,0)
 ;;=3^Acquired absence of left great toe
 ;;^UTILITY(U,$J,358.3,37251,1,4,0)
 ;;=4^Z89.412
 ;;^UTILITY(U,$J,358.3,37251,2)
 ;;=^5063555
 ;;^UTILITY(U,$J,358.3,37252,0)
 ;;=Z89.422^^106^1586^11
 ;;^UTILITY(U,$J,358.3,37252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37252,1,3,0)
 ;;=3^Acquired absence of left toe(s)
 ;;^UTILITY(U,$J,358.3,37252,1,4,0)
 ;;=4^Z89.422
 ;;^UTILITY(U,$J,358.3,37252,2)
 ;;=^5063558
 ;;^UTILITY(U,$J,358.3,37253,0)
 ;;=Z89.421^^106^1586^26
 ;;^UTILITY(U,$J,358.3,37253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37253,1,3,0)
 ;;=3^Acquired absence of right toe(s)
 ;;^UTILITY(U,$J,358.3,37253,1,4,0)
 ;;=4^Z89.421
 ;;^UTILITY(U,$J,358.3,37253,2)
 ;;=^5063557
 ;;^UTILITY(U,$J,358.3,37254,0)
 ;;=Z89.431^^106^1586^17
 ;;^UTILITY(U,$J,358.3,37254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37254,1,3,0)
 ;;=3^Acquired absence of right foot
 ;;^UTILITY(U,$J,358.3,37254,1,4,0)
 ;;=4^Z89.431
 ;;^UTILITY(U,$J,358.3,37254,2)
 ;;=^5063560
 ;;^UTILITY(U,$J,358.3,37255,0)
 ;;=Z89.432^^106^1586^3
 ;;^UTILITY(U,$J,358.3,37255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37255,1,3,0)
 ;;=3^Acquired absence of left foot
 ;;^UTILITY(U,$J,358.3,37255,1,4,0)
 ;;=4^Z89.432
 ;;^UTILITY(U,$J,358.3,37255,2)
 ;;=^5063561
 ;;^UTILITY(U,$J,358.3,37256,0)
 ;;=Z89.442^^106^1586^1
 ;;^UTILITY(U,$J,358.3,37256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37256,1,3,0)
 ;;=3^Acquired absence of left ankle
 ;;^UTILITY(U,$J,358.3,37256,1,4,0)
 ;;=4^Z89.442
 ;;^UTILITY(U,$J,358.3,37256,2)
 ;;=^5063564
 ;;^UTILITY(U,$J,358.3,37257,0)
 ;;=Z89.441^^106^1586^15
 ;;^UTILITY(U,$J,358.3,37257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37257,1,3,0)
 ;;=3^Acquired absence of right ankle
 ;;^UTILITY(U,$J,358.3,37257,1,4,0)
 ;;=4^Z89.441
 ;;^UTILITY(U,$J,358.3,37257,2)
 ;;=^5063563
 ;;^UTILITY(U,$J,358.3,37258,0)
 ;;=Z89.511^^106^1586^23
 ;;^UTILITY(U,$J,358.3,37258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37258,1,3,0)
 ;;=3^Acquired absence of right leg below knee
 ;;^UTILITY(U,$J,358.3,37258,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,37258,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,37259,0)
 ;;=Z89.512^^106^1586^8
