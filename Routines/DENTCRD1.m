DENTCRD1 ;ISC2/HCD,SAW-PROCESS DENTAL CARDS (CON'T) ;9/24/99  09:26
 ;;1.2;DENTAL;**3,11,13,16,19,21,24,28**;JAN 26, 1989
C S:X=" " X="" I X=""&($P(^DD(221,F,0),"^",2)'["R") G A
 X $P(^DD(221,F,0),"^",5,99) I '$D(X) S E1=1 G E
A Q:E  S D2=D2_X_"^" Q
E S E=1 W !,"ERROR--",$P(^DD(221,F,0),"^",1)," entry is incorrect." Q
F S X=$S(X=8:10,X=9:20,1:""),X=$S(X1=" ":X,1:X+X1) Q
CC ;;.01;1;.5;3;4;5;6;7;8;.4;10;11;12;38;14;15;16;17;4.5;19;39;21;22;23;24;25;6.7;27;28;29;30;31;32;33;34;35;36;37;2;.3;7.1;6.2;6.4;6.6;6.8
DATE ;;31;28;31;30;31;30;31;31;30;31;30;31
YN Q:$D(E1)  W !,"Okay to accept this value" S %=2 D YN^DICN G YN:%=0 K:%'=1 X Q
EN W !,D S E=0,D2="" F I=1:1:45 S F=$P($T(CC),";",I+2) D @I
 K:E D2 G ^DENTCRD2
1 ;
 S L1=$E(D,14),L2=$E(D,15),L3=$E(D,16),L4=$E(D,17),L5=$E(D,18)
 I L1'=" " G:L2 ERR S Z=L1+1 G DAY
 G:L2=" " ERR S Z=L2+3
DAY G:Z<1!(Z>12) ERR S ZZ=$P($T(DATE),";",Z+2)
 I Z=2 S ZZ=ZZ+$$LEAP^DENTE1(1700+$E(DT,1,3))
 I $L(Z)=1 S Z=0_Z
 S L3=$S(L3=7:10,L3=8:20,L3=9:30,1:0),L4=$S(L4=" "!(L4>8):0,1:L4+1),L4=L3+L4 G:L4<1!(L4>ZZ) ERR I $L(L4)=1 S L4=0_L4
 S L5=$E(DT,2,3),L6=$E(DT,1)_L5_"01" S:DENTY XX1=$$YR(L6),L5=$E(XX1,2,3) S:$L(L5)=1 L5=0_L5 S (D1,Z)=$S(DENTY:$E(XX1,1),1:$E(DT,1))_L5_Z_L4
 I Z'>DT D NOW^%DTC S Z=Z_"."_$P(%,".",2),Z=+Z,Z=$$CHECK^DENTE1(221,Z),(DINUM,D1)=Z G OK
ERR S D2("B")="" G E
OK S X=D1 D A S D2("B")=X,D2("B1")=X Q
YR(DENTX1) ; Get last Year
 S X1=DENTX1_"01",X2=-1 D C^%DTC S ZZ=$E(X,1,3)_$E(DENTX1,4,7)
 Q ZZ
2 S X=$E(D,5,13) I X'?9N G E
 I +X=1 D A S D2("D")=X,D1(39)="GROUP" Q
 S Z=$O(^DPT("SSN",X,0)) S:Z="" X=X_"P",Z=$O(^DPT("SSN",X,0))
 D:Z="" E Q:E  D A S DFN=Z,DENTI=I,DENTX=X D DEM^VADPT S I=DENTI,X=DENTX,D1(39)=VADM(1),D2("D")=X,(D2("E"),D39)=Z K DENTI,DENTX Q
 ;D A S D2("D")=X Q
3 S X=$E(D,1,4),Z=X,X=$O(^DENT(220.5,"C",X,0))
 I $D(^DENT(220.5,+X,0)),$P(^(0),"^",3)="" D A S (D1(10),D2("C"))=Z,(D2("AC"),D2("AC1"))=DENTSTA_","_D2("B")_","_Z Q
 G E
 ;S X=$E(D,1,4) D:X'?4N E Q:E  D A S (D1(10),D2("C"))=X,(D2("AC"),D2("AC1"))=DENTSTA_","_D2("B")_","_X Q
4 S X=$S($D(D39):D39,1:"") G A
5 S X="" G A
6 S Z1=$E(D,22),Z2=$E(D,23) I Z1=" "&(Z2=" ") S X="" G A
 S X=$S(Z1'=" "&(Z2'=" "):"",Z1'=" ":Z1+1,Z2'=" ":Z2+8) I X<1!(X>15) S X="" G E
 G A
7 S X=$E(D,24),X=$S(X=0:"S",X=1:"C",1:"") G A
8 S X=$E(D,31),X=$S(X=4:1,1:"") G A
9 S X=$E(D,32) G C
10 S X=$S($D(D1(10)):D1(10),1:"") G A
11 S X=$E(D,33),X1=$E(D,34) D F G C
12 S X=$E(D,35),X=$S(X=1:1,1:"") G A
13 S X=$E(D,36),X=$S(X=1:1,1:"") G A
14 S X=$E(D,67),X=$S(X=1:1,1:"") G A
15 S X=$E(D,37) G C
16 S X=$E(D,38) G C
17 S X=$E(D,39) G C
18 S X=$E(D,40) G C
19 S X1=0 F I(1)=19,20,21 I $E(D,I(1))'=" " S X1=X1+1,X=$E(D,I(1)),Z=I(1)
 I X1>1 S E=1 W !,"ERROR-- More than one patient category has been marked." Q
 I X1=0 S E=1 W !,"ERROR-- Patient category is missing." Q
 S X=$S(Z=19:X+1,Z=20:X+8,1:X+13) D:Z=19&((X>8)!(X<1)) E D:Z=20&((X>17)!(X<9)) E D:Z=21&((X>22)!(X<18)) E Q:E  G A
20 S X=$E(D,41),X1=$E(D,42),X=$S(X=" ":"",1:X*10),X=$S(X1=" ":X,1:X+X1) G C
21 S X="" G A
22 S X=$E(D,43),X1=$E(D,44),X=$S(X=7:10,X=8:20,X=9:30,1:""),X=$S(X1=" ":X,1:X+X1) G C
23 S X=$E(D,45) G C
24 S X=$E(D,46) G C
25 S X=$E(D,47) G C
26 S X=$E(D,48),X=$S(X=1&(+$E(D,5,13)=1):4,X=1&(+$E(D,5,13)'=1):3,1:"") G A
27 S X=$E(D,28),X=$S(X=7:1,X=8:3,1:"") G A
28 S X=$E(D,49),X1=$E(D,50) D F G C
29 S X=$E(D,51),X1=$E(D,52) D F G C
30 S X=$E(D,53),X1=$E(D,54) D F G C
31 S X=$E(D,55),X1=$E(D,56),X=$S(X=7:0,X=8:10,X=9:20,1:""),X=$S(X1=" ":X,1:X+X1) G C
32 S X=$E(D,57) G C
33 S X=$E(D,58) G C
34 S X=$E(D,59) G C
35 S X=$E(D,60),X1=$E(D,61),X=$S(X=" ":"",1:X*10),X=$S(X1=" ":X,1:X+X1) G C
36 S X=$E(D,62),X1=$E(D,63) D F G C
37 S X=$E(D,64) G C
38 S X=$E(D,65),X1=$E(D,66),X=$S(X=7:10,X=8:20,X=9:30,1:""),X=$S(X1=" ":X,1:X+X1) G C
39 S X=$S($D(D1(39)):D1(39),1:"") G A
40 S X=DENTSTA D A Q:E  S (D2("A"),D2("A1"))=DENTSTA_","_D2("B") Q
41 S X=$E(D,30),X=$S(X=1:3,X=2:2,1:"") G C
42 S X=$E(D,25),X=$S(X=2:1,1:"") G A
43 S X=$E(D,26),X=$S(X=3:1,1:"") G A
44 S X=$E(D,27),X=$S(X=4:2,1:"") G A
45 S X=$E(D,29),X=$S(X>5:X-6,1:X) G C
