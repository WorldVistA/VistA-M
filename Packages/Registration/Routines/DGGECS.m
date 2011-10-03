DGGECS ;ALB/RMO/REW - MAS Generic Code Sheet Interface for AMIS ; 13 JUN 89 9:45 am
 ;;5.3;Registration;**50,70,151**;Aug 13, 1993
 ;
 ;Interface includes AMIS Segments 334-341, 345-346 and 401-420
AMS S DGRD("A")="Select AMIS SEGMENTS: ",DGRD(0)="S",DGRD(1)="334-341^generate code sheets for AMIS 334-341's."
 S DGRD(2)="345-346^generate code sheets for AMIS 345-346's.",DGRD(3)="401-420^generate code sheets for AMIS 401-420's."
 D SET^DGGECSR N ENT K DGRD G Q:X["^"!(X="") S DGARNG=X
 F I=+DGARNG:1 D  Q:I+1>$P(DGARNG,"-",2)
 .S ENT=$O(^GECS(2101.2,"B",I,""))
 .I $P(^GECS(2101.2,ENT,0),"^",5)="Y" S DGAMS(I)=""
 ;
DIV K DGDIV I $D(^DG(43,1,"GL")),$P(^("GL"),"^",2),DGARNG'="334-341",DGARNG'="345-346" S DIC("A")="Select DIVISION: ",DIC="^DG(40.8,",DIC(0)="AEMQ" D ^DIC K DIC G Q:Y<0 S DGDIV=+Y
 S DGDIV=$S($D(DGDIV):DGDIV,1:+$O(^DG(40.8,0)))
 ;MOVED DGSTA DEF TO AFTER MYR TO BE DATE DEPENDENT
 ;
MYR W !,"Select MONTH/YEAR: " R X:DTIME G Q:'$T!(X="")!(X["^")
 S %DT="EP",%DT(0)="-NOW" D ^%DT K %DT S DGERR=$S($E(Y,6,7)'="00":1,1:0) W:DGERR !!?2,"Do not specify day of month or a month/year in the future.",! G MYR:Y<0!(DGERR) S DGMYR=Y
 S DGSTA=$P($$SITE^VASITE(DGMYR+1,DGDIV),U,3) ; use +1 to get first day of month for proper site #
 I $G(DGSTA)'>0 S DGSTA=$S('$D(^DG(40.8,+DGDIV,0)):0,$P(^(0),"^",2)'="":$P(^(0),"^",2),$D(^DIC(4,+$P(^(0),"^",7),99)):$P(^(99),"^",1),1:0)
 I DGARNG="334-341"!(DGARNG="345-346") F I=+DGARNG:1:$P(DGARNG,"-",2) S DGERR=$S($D(^DGAM(+DGARNG,DGMYR,"SE",I,"D",DGDIV,0)):0,1:1) Q:'DGERR!(I+1>$P(DGARNG,"-",2))
 I DGARNG="401-420" S DGERR=1 F I=+DGARNG:1:$P(DGARNG,"-",2) D  Q:'DGERR!(I+1>$P(DGARNG,"-",2))
 . F J=0:0 S J=$O(^DG(391.1,I,"D",J)) Q:'J  I $D(^(J,"MY",DGMYR,"A1")) S DGERR=0 Q
 I DGERR W !!?2,*7,"AMIS ",DGARNG," data has not been generated for this month/year.",! G MYR
 ;
BAL K DGNOB I DGARNG="334-341"!(DGARNG="345-346") F I=+DGARNG:1:$P(DGARNG,"-",2) I $D(^DGAM(+DGARNG,DGMYR,"SE",I,0)),'$P(^(0),"^",2) S DGNOB(I)=""
 I DGARNG="401-420" F I=+DGARNG:1:$P(DGARNG,"-",2) I $D(^DG(391.1,I,"D",DGDIV,"MY",DGMYR,0)),'$P(^(0),"^",6) S DGNOB(I)=""
 I $D(DGNOB) D MSG G AMS
 ;
 S DGPGM="START^DGGECS",DGVAR="DGAMS#^DGDIV^DGSTA^DGMYR" W ! D ZIS^DGUTQ G Q:POP
 ;
START U IO S SDABORT=0
 F DGTTF=0:0 S DGTTF=$O(DGAMS(DGTTF)) Q:'DGTTF!SDABORT  D
 .S DGX=$P($G(^DG(391.1,DGTTF,0)),U,3)
 .I (DGX>0)&((DGX-100)<DGMYR) K DGAMS(DGTTF) Q  ;OK IF INACTIVE MONTH 
 .S DGSTR="" D BLD,GEN:'SDABORT
 ;
Q K DGX,DGAMS,DGARNG,DGDIV,DGEND,DGERR,DGFLG,DGHDR,DGMYR,DGNOB,DGPGM,DGRD,DGSFX,DGSTA,DGSTR,DGTTF,DGVAR,I,J,POP,SDABORT,X,Y D CLOSE^DGUTQ
 Q
 ;
MSG W !!?2,*7,"AMIS ",DGARNG," code sheets can not be generated for this month/year",!?2,"until the following segments are balanced:" W !!?2 F I=0:0 S I=$O(DGNOB(I)) Q:'I  W "  ",I
 Q
 ;
BLD S DGEND=$S(DGTTF=334!(DGTTF=336):15,DGTTF>333&(DGTTF<342):14,DGTTF>344&(DGTTF<347):17,DGTTF=420:40,DGTTF>400&(DGTTF<421):38,1:0) F I=1:1:DGEND S $P(DGSTR,"^",I)=0
 I DGTTF=334 F J=0:0 S J=$O(^DGAM(334,DGMYR,"SE",DGTTF,"D",J)) Q:'J  I $D(^(J,0)) S X=^(0) F I=1:1:DGEND S $P(DGSTR,"^",I)=$P(DGSTR,"^",I)+$S(I=12:+$P(X,"^",24),I=13:+$P(X,"^",I),I>13:+$P(X,"^",I+4),1:+$P(X,"^",I+1))
 I DGTTF>334,DGTTF<342 F J=0:0 S J=$O(^DGAM(334,DGMYR,"SE",DGTTF,"D",J)) Q:'J  I $D(^(J,0)) S X=^(0) F I=1:1:DGEND S $P(DGSTR,"^",I)=$P(DGSTR,"^",I)+$S(I<13:+$P(X,"^",I+1),I=15:0,1:+$P(X,"^",I+5))
 I DGTTF>344,DGTTF<347 F J=0:0 S J=$O(^DGAM(345,DGMYR,"SE",DGTTF,"D",J)) Q:'J  I $D(^(J,0)) S X=^(0) F I=1:1:DGEND S $P(DGSTR,"^",I)=$P(DGSTR,"^",I)+$P(X,"^",I+1)
 I DGTTF>400,DGTTF<421 S X=$G(^DG(391.1,DGTTF,"D",DGDIV,"MY",DGMYR,"A1")) F I=1:1:DGEND S $P(DGSTR,"^",I)=+$P(X,"^",I)
 Q
 ;
GEN S DGHDR=$S(DGTTF=334:"2^8",DGTTF>334&(DGTTF<342):"M^8",DGTTF>344&(DGTTF<347):"6^8",DGTTF>400&(DGTTF<421):"M^8",1:""),DGSFX=$S(DGTTF>333&(DGTTF<347):"",1:$E(DGSTA,4,5))
 S GECSSYS="MAS",GECS("AMIS")=DGMYR,GECS("SITENOASK")=DGSTA,GECS("TTF")=DGTTF,GECSAUTO="BATCH",GECS("STRING",0)="AMS^((^"_DGHDR_"^"_$E(DGSTA,1,3)_"^"_DGSFX_"^"_DGTTF_"^^"_DGSTR_"^$" W @IOF D ^GECSENTR
 Q
