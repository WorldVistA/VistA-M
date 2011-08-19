FHMASE1A ; HISC/AAC - Multidiv Encounter Stats (cont.) ;10/14/03  13:13 
 ;;5.5;DIETETICS;;Jan 28, 2005
Q1 ; Calculate the Encounters
 K ^TMP($J)
 S YX1=SDT\1-.0001,YX2=EDT\1+.3
 S TIT=";"_$P(^DD(115.6,10,0),"^",3)
 S D1XX="FHMASE1A"
 S XX1=YX1
 S (XXX,XX2,XX3,X3,XY,YY1)="",(COUNT,LL,L,D1F,D1CNTX,NUMBER)=0
 S ZZCOUNT=0 F ZZCOUNT=0:0 S ZZCOUNT=$O(^FH(119.73,ZZCOUNT)) Q:ZZCOUNT'>0  S ZOUT=ZZCOUNT
 F K=1:1:11 S II(K)=0,JJ(K)=0
 ;
Q2 ;Get Communications Offices
 D DEL S (SS1,DD1,DD2,DD3,DD4,E1,COXX1,D1X,DIF,D1CNTX)=0,(NX,WW1)=""
 I ZCO'="Y" S CONUMX=CONUMX-1 G:CONUMX<1 ALLTOT S COXX=$P(CO,"^",CONUMX),NAME=$P(CONAME,"^",CONUMX)
 I ZCO="Y" S COUNT=COUNT+1 G:COUNT>ZOUT ALLTOT S REC=$G(^FH(119.73,COUNT,0)),NAME=$P(REC,"^",1)
 ;
R2 ;Find Patient records within parameters
 I ZCO'="Y" G:$D(^FH(119.73,COXX,"I")) Q2 G:'$D(^FH(119.73,COXX,0)) Q2
 I ZCO="Y" G:$D(^FH(119.73,COUNT,"I")) Q2 G:'$D(^FH(119.73,COUNT,0)) Q2
 ;
 S YX1=SDT\1-.0001,YX2=EDT\1+.3,XX1=YX1
 ;
R1 F  S XX1=$O(^FHEN("AT",XX1)) G:XX1'>0 P1 G:XX1>YX2 P1  D 
R11 .S XXX=XX1 F E1=0:0 S E1=$O(^FHEN("AT",XXX,E1)) Q:E1'>0  D 
 ..I XX1>YX2 Q
 ..S XX2=$G(^FHEN(E1,0))
 ..I ZCO'="Y" S XY=$P(XX2,"^",6) Q:COXX'=XY
 ..I ZCO="Y" S XY=$P(XX2,"^",6) Q:COUNT'=XY
 ..S Y=$G(^FHEN(E1,0))
 ..S D1=$P(Y,"^",3) S D2=$P(Y,"^",4),D4=$P(Y,"^",6) Q:'D2  Q:'D4
 ..I FHX1>0,D1'=FHX1 Q
 ..I $D(^FH(119.73,D4,"I")) Q
 ..S D6=$P(Y,"^",7),D3=$P(Y,"^",8),D9=$P(Y,"^",9),D5=$P(Y,"^",11) D C0
 ..S D2=$P($G(^FH(115.6,D2,0)),"^",1,2) Q:"^"[D2
 ..S Z1=$P(D2,"^",2),D2=$P(D2,"^",1)
 ..S D8=$F(TIT,";"_Z1_":") Q:D8<0
 ..S:D6="F" D2=D2_"~F"
 ..S S1=$G(^TMP($J,0,D8,D2,D4)) D UPD S ^TMP($J,0,D8,D2,D4)=S1
 ..S S1=$G(^TMP($J,D1,D8,D2,D4)) D UPD S ^TMP($J,D1,D8,D2,D4)=S1 S DD1=D1,DD8=D8,DD2=D2,DD4=D4 Q:'FHX2
 ..S (DTP,W1)=$P(Y,"^",2)\1 D DTP^FH I '$D(^TMP($J,D1,D8,D2,D4,W1)) S ^TMP($J,D1,D8,D2,D4,W1)=DTP,^(W1,0)=0 S D2=DD2,D3=DD3,D4=DD4 I '$D(^FHEN(E1,"P")) S DFN="^"_D5 D R3 Q
 ..F DFN=0:0 S DFN=$O(^FHEN(E1,"P",DFN)) Q:DFN<1  D R3
 ..Q
 .Q
 Q
 G R11
 ;
R3 ;
 S L=^TMP($J,D1,D8,D2,D4,W1,0)+1,^(0)=L S WW1=W1
 S ^TMP($J,D1,D8,D2,D4,W1,L)=DFN Q
 ;
R4 ;
 S DFN="^"_D5 D R3 G R2
 ;
C0 ;
 S C(8)=$P(Y,"^",10),(C(1),C(2),C(3),C(4),C(5),C(6),C(7))=0
 F DFN=0:0 S DFN=$O(^FHEN(E1,"P",DFN)) Q:DFN<1  S X=^(DFN,0) D C1
 S C(7)=C(8)-C(1)-C(2)-C(4)-C(5) S:C(7)<1 C(7)=0
 I D9'="I" S TM=C(1)+C(4)+C(7) I TM S TM=D3/TM,C(3)=TM*C(1),C(6)=TM*C(4),C(3)=$J(C(3),0,1),C(6)=$J(C(6),0,1) Q
 Q
 ;
C1 ;
 S Z=$P(X,"^",2) G:Z<1 C2 S Z=$P($G(^SC(+Z,0)),"^",3) G:Z'="W" C2
 S C(1)=C(1)+1,C(2)=C(2)+$P(X,"^",3) S:D9="I" C(3)=C(3)+D3 Q
 ;
C2 ;
 S C(4)=C(4)+1,C(5)=C(5)+$P(X,"^",3) S:D9="I" C(6)=C(6)+D3 Q
 ;
UPD ;Update S1 record
 S $P(S1,"^",1)=$P(S1,"^",1)+1,$P(S1,"^",2)=$P(S1,"^",2)+D3
 F K=1:1:8 I C(K) S $P(S1,"^",K+2)=$P(S1,"^",K+2)+C(K)
 Q
 ;
P1 ;load data by paramters/totals for each Communication Office
 S DTP=SDT\1 D DTP^FH S DTE=DTP_" to " S DTP=EDT\1 D DTP^FH S DTE=DTE_DTP,PG=0 D HEAD I FHX1>0 S NAM="" D D0
 S (NX,D8)="",CT=0 F K=1:1:11 S (I(K),J(K))=0
 ;
 F KK=0:0 S D8=$O(^TMP($J,0,D8)) Q:D8=""  S CT=CT+1 D:CT'=1 STOT W ! D PR F K=0:0 S NX=$O(^TMP($J,0,D8,NX)) Q:NX=""  S X1=$P(NX,"~",1)_$S($P(NX,"~",2)="F":"  (F)",1:"") Q:X1=""  S S1=$G(^TMP($J,0,D8,NX,D4)) D PP
 D STOT W ! S X=" T O T A L" D PX D TOT W ! F K=1:1:11 S (I(K),J(K))=0 I FHX1<0 G Q2 D HEAD I FHX2<0 D Q2
 ;
P2 ;load data for each clinician
 D:$Y>55 HEAD S (D8,NAM)="",CT=0
 S D8=0
 F D1=0:0 S D1=$O(^TMP($J,D1)) G:D1="" P2A S CT=CT+1 D:CT'=1 STOT W ! F D8=0:0 S D8=$O(^TMP($J,D1,D8)) Q:D8'>0  D PR,D0 S D2="" F L1=0:0 S D2=$O(^TMP($J,D1,D8,D2)) Q:D2=""  S S1=$G(^TMP($J,D1,D8,D2,D4)) Q:S1=""   D SETX1,PP I FHX2 D P3
 D STOT G P2
P2A D STOT W ! S X=" TOTAL ENCOUNTERS" D TOT W @IOF D DEL S X1=SDT G Q2
 ;
SETX1 ;
 S X1=$P(D2,"~",1)_$S($P(D2,"~",2)="F":"  (F)",1:"")
 Q
D0 ;Get Clinician Name
 I FHX1>0 S D1=FHX1
 S NAM=$P(^VA(200,D1,0),"^",1),NAM=$E(NAM,1,30) W !,NAM Q
 ;
P3 ;
 S DTP=""
 ;
P4 ;
 S DTP=$O(^TMP($J,D1,D8,D2,D4,DTP)) Q:DTP=""  S S1=^(DTP),W1=0
 ;
P5 ;
 S W1=$O(^TMP($J,D1,D8,D2,D4,DTP,W1)) G:W1="" P4 S DFN=^(W1) G:DFN<1 P6
 S Y=$G(^DPT(DFN,0)) G:Y="" P5 D PID^FHDPA
 W !?7,S1,?17,BID,?26,$P(Y,"^",1) G P5
 ;
P6 ;
 W !?7,S1,?17,$P(DFN,"^",2) G P5
 ;
PP ;Print totals for Communications Offices
 D:$Y>58 HEAD W !?5,X1,?47,$J($P(S1,"^",1),6,0) S I(1)=I(1)+$P(S1,"^",1),J(1)=J(1)+$P(S1,"^",1)  ;)
 F K=1:1:6 S Z=$P(S1,"^",K+2),I(K+2)=I(K+2)+Z,J(K+2)=J(K+2)+Z W $S(K=3!(K=6):$S(Z:$J(Z,8,1),1:$J("",8)),1:$J($S(Z:Z,1:""),6))
 S Z=$P(S1,"^",9),I(9)=I(9)+$S(Z'<1:Z,1:0),J(9)=J(9)+$S(Z'<1:Z,1:0) W ?97,$J($S(Z'<1:Z,1:""),6)
 ;
 I Z S Z=$P(S1,"^",2)-$P(S1,"^",5)-$P(S1,"^",8),I(10)=I(10)+$S(Z'<1:Z,1:0),J(10)=J(10)+$S(Z'<1:Z,1:0)
 ;
 W $S(Z'<1:$J(Z,8,1),1:$J("",8))
 S Z=$P(S1,"^",10),I(11)=I(11)+Z,J(11)=J(11)+Z W ?113,$J($S(Z'<1:Z,1:""),6)
 I $P(S1,"^",2) W $J($P(S1,"^",2),8,1) S I(2)=I(2)+$P(S1,"^",2),J(2)=J(2)+$P(S1,"^",2)
 ;
 Q
 ;
PX ;Accumulate amount for final total
 S II(1)=II(1)+I(1)  ;,II(3)=II(3)+I(3),II(6)=II(6)+I(6)
 F K=1:1:6 S II(K+2)=II(K+2)+I(K+2) ;,II(K+2)=II(K+2)+I(K+2)
 S II(9)=II(9)+I(9),II(10)=II(10)+I(10),II(11)=II(11)+I(11)
 Q
 ;
PR ;
 S X=$P($E(TIT,D8,999),";",1)
 D:$Y>55 HEAD W !?3,X Q
 Q
 ;
STOT ;Print sub-totals for Communications Office and Clinician
 W !?5,"Subtotal",?47,$J(J(1),6) F K=1:1:6 W $S(K=3!(K=6):$S(J(K+2):$J(J(K+2),8,1),1:$J("",8)),1:$J($S(J(K+2):J(K+2),1:""),6))
 W ?97,$S(J(9):$J(J(9),6),1:$J("",6)),$S(J(10):$J(J(10),8,1),1:$J("",8))
 W ?113,$S(J(11):$J(J(11),6),1:$J("",6)),$S(J(2):$J(J(2),8,1),1:$J("",8)) W !
 F K=1:1:11 S J(K)=0
 Q
 ;
TOT ;
 ;Totals by Communications Offices
 W !?3,NAME,X,?47,$J(I(1),6) F K=1:1:6 W $S(K=3!(K=6):$S(I(K+2):$J(I(K+2),8,1),1:$J("",8)),1:$J($S(I(K+2):I(K+2),1:""),6))
 W ?97,$S(I(9):$J(I(9),6),1:$J("",6)),$S(I(10):$J(I(10),8,1),1:$J("",8))
 W ?113,$S(I(11):$J(I(11),6),1:$J("",6)),$S(I(2):$J(I(2),8,1),1:$J("",8))
 F K=1:1:11 S I(K)=0
 Q
 ;
ALLTOT ; 
 ;Final Totals - all Communication Offices
 S XS="ALL COMMUNICATIONS OFFICES " W !,XS,?47,$J(II(1),6) F K=1:1:6 W $S(K=3!(K=6):$S(II(K+2):$J(II(K+2),8,1),1:$J("",8)),1:$J($S(II(K+2):II(K+2),1:""),6))
 W ?97,$S(II(9):$J(I(9),6),1:$J("",6)),$S(II(10):$J(II(10),8,1),1:$J("",8))
 W ?113,$S(II(11):$J(II(11),6),1:$J("",6)) W $S(II(5):$J(II(5),8,1),1:$J("",6))
 D DEL Q
 ;
HEAD ;Print page headers
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?30,"D I E T E T I C   E N C O U N T E R  ",?69,HEADER,?120,"Page ",PG
 W !?2,NAME,?(114-$L(DTE)\2),DTE,!?47,"Number      Inpatients         Outpatients            Others           Total"
 W !?56,"Pat   Col   Units   Pat   Col   Units",?98,"Persn   Units   Persn   Units",! Q
 ;
DEL ;DELETE RECORDS FROM ^TMP
 K ^TMP($J)
 W !!
 Q
Q ;
QUIT ;
 Q
