YTNEOPI ;ALB/ASF-NEO PI-R TEST REPORT ;7/28/95  13:01 ;
 ;;5.01;MENTAL HEALTH;**10**;Dec 30, 1994
MAIN ;control
 K S,R  S R="",S="",YSXK="",YSMX=5,YSLFT=0,YSNOITEM="DONE^YTNEOPI"
 D RD G OUT:$L($E(X,1,240),"X")>42
 D SCOR,STND
 D ^YTNEOPI1 ;profile
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
 G:YSLFT DONE D REPT
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
 G DONE:YSLFT D ^YTNEOPI2
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
OUT G DONE:YSLFT D VALD^YTNEOPI1 ;VALIDITY
 G DONE:YSLFT D IR^YTNEOPI1
 Q
RD S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)_^YTD(601.2,YSDFN,1,YSET,1,YSED,2) Q
SCOR ;
 F YSKK=1:1:30 S Y=^YTT(601,YSTEST,"S",YSKK,"K",1,0),YSTL=0,YSTX=0 D KK S R=R_YSTL_U,YSXK=YSXK_YSTX_U
 Q
KK F I=1:2:15 S YSIT=$P(Y,U,I),A=$P(Y,U,I+1),B=$E(X,YSIT),YSTL=YSTL+$S(B="X":2,A="D":B-1,1:YSMX-B) S:B="X" YSTX=YSTX+1
 Q
STND ;stanard T scores
 F J=1:1:30 S A=$P(R,U,J) S X=^YTT(601,YSTEST,"S",J,YSSX),S(J)=$J((A-$P(X,U)/$P(X,U,2)*10+50),0,0),S=S_S(J)_U
NF ;neorotic factor
 S A=(.26*S(1))+(.18*S(2))+(.23*S(3))+(.22*S(4))+(.11*S(5))+(.18*S(6))
 S A=A+(.01*S(7))-(.06*S(8))-(.07*S(9))+(.08*S(10))-(.02*S(11))+(.02*S(12))
 S A=A+(.02*S(13))+(.09*S(14))+(.16*S(15))-(.06*S(16))-(.02*S(17))-(.06*S(18))
 S A=A-(.09*S(19))+(.05*S(20))+(.05*S(21))-(.02*S(22))+(.07*S(23))+(.05*S(24))
 S A=A-(.03*S(25))+(.10*S(26))+(.05*S(27))+(.09*S(28))+(.01*S(29))+(.02*S(30))
 S A=A-31,S=S_A_U
EF ;extraversion factor
 S A=(.02*S(1))+(.00*S(2))-(.02*S(3))-(.04*S(4))+(.16*S(5))-(.01*S(6))
 S A=A+(.21*S(7))+(.24*S(8))+(.10*S(9))+(.15*S(10))+(.21*S(11))+(.24*S(12))
 S A=A-(.01*S(13))-(.12*S(14))+(.07*S(15))-(.01*S(16))-(.14*S(17))-(.05*S(18))
 S A=A+(.05*S(19))-(.05*S(20))+(.19*S(21))-(.03*S(22))-(.01*S(23))+(.08*S(24))
 S A=A-(.01*S(25))+(.01*S(26))-(.07*S(27))+(.01*S(28))+(.02*S(29))-(.14*S(30))
 S A=A-2.50,S=S_A_U
OF ;openness
 S A=(.00*S(1))+(.00*S(2))+(.03*S(3))+(.00*S(4))-(.06*S(5))-(.01*S(6))
 S A=A-(.02*S(7))-(.09*S(8))+(.02*S(9))-(.02*S(10))-(.06*S(11))-(.03*S(12))
 S A=A+(.23*S(13))+(.34*S(14))+(.17*S(15))+(.22*S(16))+(.35*S(17))+(.21*S(18))
 S A=A+(.05*S(19))+(.00*S(20))-(.09*S(21))+(.03*S(22))-(.04*S(23))+(.03*S(24))
 S A=A+(.04*S(25))-(.09*S(26))+(.03*S(27))+(.04*S(28))-(.05*S(29))+(.04*S(30))
 S A=A-13.50,S=S_A_U
AF ;ageeableness
 S A=(.03*S(1))-(.12*S(2))+(.03*S(3))+(.05*S(4))-(.04*S(5))+(.05*S(6))
 S A=A+(.12*S(7))+(.02*S(8))-(.12*S(9))-(.09*S(10))-(.11*S(11))+(.03*S(12))
 S A=A-(.01*S(13))+(.08*S(14))+(.02*S(15))+(.02*S(16))-(.02*S(17))-(.01*S(18))
 S A=A+(.16*S(19))+(.20*S(20))+(.16*S(21))+(.23*S(22))+(.19*S(23))+(.20*S(24))
 S A=A-(.02*S(25))-(.03*S(26))+(.06*S(27))-(.06*S(28))-(.02*S(29))+(.04*S(30))
 S A=A-2.00,S=S_A_U
CF ;conscientiousness factor
 S A=(.09*S(1))+(.09*S(2))+(.04*S(3))+(.07*S(4))-(.05*S(5))-(.02*S(6))
 S A=A-(.03*S(7))-(.09*S(8))+(.05*S(9))+(.13*S(10))-(.05*S(11))-(.02*S(12))
 S A=A-(.08*S(13))+(.08*S(14))+(.08*S(15))-(.05*S(16))+(.05*S(17))-(.07*S(18))
 S A=A-(.08*S(19))+(.07*S(20))+(.03*S(21))-(.04*S(22))-(.01*S(23))-(.03*S(24))
 S A=A+(.16*S(25))+(.24*S(26))+(.21*S(27))+(.25*S(28))+(.21*S(29))+(.18*S(30))
 S A=A-20.50,S=S_A_U
 Q
REPT ;
 S X=$P(^YTT(601,YSTEST,"P"),U),A=$P(^("P"),U,2),B=$P(^("P"),U,3),L1=3,L2=L1+A+4 S:A<9 A=9
 D DTA^YTREPT W !!?(72-$L(X)\2),X,!!!?(A-9\2+L1),"S C A L E",?(L2+1),"RAW  ","T Score",?50,"Range",!
 F J=31,32,33,34,35,1:1:30 S R1=$P(R,U,J),S1=$P(S,U,J) D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT  D REPT1
 Q
REPT1 ;
 I J=1!(J=31)!(J=7)!(J=13)!(J=19)!(J=25) W !!?3,$S(J=31:"Factors",1:$E($P(^YTT(601,YSTEST,"S",(J\6+31),0),U,2),5,99)_" Facets"),!
 W !?L1,$P(^YTT(601,YSTEST,"S",J,0),U,2),?L2,$S(R1="":"   -",1:$J(R1,4,0)),?(L2+6),$J(S1,4,0)
 S S1=$J(S1,0,0) W ?50,$S(S1>65:"VERY HIGH",S1>55:"HIGH",S1>44:"AVERAGE",S1>34:"LOW",1:"VERY LOW")
 Q
DONE ;
 K V1,V2,V3,V4,Z1,Z2,Z3,Z4,YSLN,YSLV,YSVFLAG,YSTX,YSXK,YSTY,X,Y,A,B,K,YSKK,L,L1,L2,M,R,R1,S,S1,J,YSIT,YSRS,I,P,YSMX,YSTL,YSTTL Q
