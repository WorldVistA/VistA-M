YTMCMI2C ;ALB/ASF-MCMI2 REPORT CONTINUED; ;4/11/91  15:39
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
V ;
 D TOP S V=$P(R,U,26) W !!,"This report is ",$S(V=1:"OF QUESTIONABLE VALIDITY",V>1:"**** INVALID ***",1:"VALID")," based on the validity scale." K V
 I +R>590!(+R<145) W !,"Validity Questioned based on ",$S(+R>150:"high",1:"low")," DISCLOSURE score"
 D RD S YSIO=$E(X,176),YSEP=$E(X,177) W:YSIO?1A !,"Patient entered as an ",$S(YSIO="I":"Inpatient",1:"Outpatient"),"." W:YSIO="" !,"No setting entered, patient assumed to be outpatient."
 W !,"Duration of recent Axis I episode: " W:YSEP'?1N "not entered assumed be one to four weeks"
 W:YSEP?1N $P("Cannot Categorize^Less than 1 week^1-4 weeks^1-3 months^3-12 months^Periodic; 1-3 years^Coninuous; 1-3 years^Periodic; 3-7 years^Continuous 3-7 years^More than 7 years",U,YSEP+1)
 I $L(X,"X")>12 W !!!,"There were less than 164 responses to the items on the inventory.",!,"Computer interpretative analysis of any responses to these",!,"items would not yield valid results." D:IOST?1"C-".E SCR G DONE
CD ;
 W !,"Personality Code= " I +R'>590,+R'<145,$P(R,U,26)<2 D CDX0 F J1="CP","SP" D CDX W "//"
 W !,"Syndrome Code= " I +R'>590,+R'<145,$P(R,U,26)<2 F J1="CS","SS" D CDX W "//"
 K ^UTILITY("YT",$J) W ! D ^YTMCMI2D
 ;
 G DONE:YSLFT D SCR G DONE:YSLFT W !!?20,"*** NOTEWORTHY RESPONSES ***",!
HP D RD W !,"Health Preocupation" S J2=0 F J1=18,29,33,68,71,72,96 I $E(X,J1)="T" W !,J1,"."," ",^YTT(601,201,"Q",J1,"T",1,0) S J2=J2+1,J3=1 F  S J3=$O(^YTT(601,201,"Q",J1,"T",J3)) Q:'J3  W !?5,^(J3,0)
 W:'J2 !?5,"  ** none **"
IA ;
 D:$Y+5>IOSL SCR G DONE:YSLFT W !!,"Interpersonal Alienation" S J2=0
 F J1=13,32,47,49,83,102,141,150 D:$Y+5>IOSL SCR Q:YSLFT  I $E(X,J1)="T" W !,J1,"."," ",^YTT(601,201,"Q",J1,"T",1,0) S J2=J2+1,J3=1 F  S J3=$O(^YTT(601,201,"Q",J1,"T",J3)) Q:'J3  W !?5,^(J3,0)
 W:'J2 !?5,"  ** none **"
ED ;
 G DONE:YSLFT D:$Y+5>IOSL SCR G DONE:YSLFT W !!,"Emotional Dyscontrol" S J2=0
 F J1=5,26,36,43,58,67,151,167 D:$Y+5>IOSL SCR Q:YSLFT  I $E(X,J1)="T" W !,J1,"."," ",^YTT(601,201,"Q",J1,"T",1,0) S J2=J2+1,J3=1 F  S J3=$O(^YTT(601,201,"Q",J1,"T",J3)) Q:'J3  W !?5,^(J3,0)
 W:'J2 !?5,"  ** none **"
SDP ;
 G DONE:YSLFT D:$Y+5>IOSL SCR W !!,"Self-Destructive Potential" S J2=0
 F J1=54,59,76,79,108,115,120,136 D:$Y+5>IOSL SCR Q:YSLFT  I $E(X,J1)="T" W !,J1,"."," ",^YTT(601,201,"Q",J1,"T",1,0) S J2=J2+1,J3=1 F  S J3=$O(^YTT(601,201,"Q",J1,"T",J3)) Q:'J3  W !?5,^(J3,0)
 W:'J2 !?5,"  ** none **"
 Q
DONE ;
 K YSTY,X,Y,A,B,K,YSKK,L,L1,L2,M,J,YSIT,YSRS,YSSS,I,P,YSMX,YSTL,YSTTL Q
RD ;
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,L\200) Q
SCR ;
 ;  Added 5/6/94 LJA
 N A,B,B1,C,D,E,E1,F,F1,G,G1,H,I,J,J1,J2,J3,J4,K,L,L1,L2,M,N
 N N1,N2,N3,N4,P,P0,P1,P3,R,R1,S,S1,T,T1,T2,TT,V,V1,V2,V3
 N V4,V5,V6,W,X,X0,X1,X2,X3,X4,X7,X8,X9,Y,Y1,Y2,Z,Z1,Z3
 ;
 G:IOST'?1"C-".E TOP F I0=1:1:(IOSL-$Y-2) W !
 N DTOUT,DUOUT,DIRUT
 S DIR(0)="E" D ^DIR K DIR S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT),YSLFT=$D(DIRUT)
 D TOP:'YSLFT Q
CDX0 ;
 K ^UTILITY("YT",$J) F J=2:1:25 S A=$P(S,U,J),J1=$S(J<4:"MOD",J<14:"CP",J<17:"SP",J<23:"CS",1:"SS") S J2=$S(A<35:"''",A<60:"""",A<75:"+",A<85:"*",1:"**"),^UTILITY("YT",$J,J1,J2,999-A,J)=""
 Q
CDX ;
 F J2="**","*","+","""","''" Q:J1'="CP"&(J2="+")  W:'$D(^UTILITY("YT",$J,J1,J2)) " - " D CDX1 W J2," "
 Q
CDX1 ;
 S J3=0 F  S J3=$O(^UTILITY("YT",$J,J1,J2,J3)) Q:'J3  D CDX2:J1'="CP",CDXM:J1="CP"&(YSSEX="M"),CDXF:J1="CP"&(YSSEX="F")
 Q
CDX2 S J4=0 F  S J4=$O(^UTILITY("YT",$J,J1,J2,J3,J4)) Q:'J4  W $P($P(^YTT(601,201,"S",J4,0),U,2)," ")," "
 Q
CDXM ;
 F J4=13,4,7,9,10,6,8,11,12,5 I $D(^UTILITY("YT",$J,J1,J2,J3,J4)) W $P($P(^YTT(601,201,"S",J4,0),U,2)," ")," "
 Q
CDXF ;
 F J4=9,4,10,8,5,12,13,11,7,6 I $D(^UTILITY("YT",$J,J1,J2,J3,J4)) W $P($P(^YTT(601,201,"S",J4,0),U,2)," ")," "
 Q
TOP ;
 S X=$P(^YTT(601,YSTEST,"P"),U) D DTA^YTREPT W !!?(72-$L(X)\2),X Q
