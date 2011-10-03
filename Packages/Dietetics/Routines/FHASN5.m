FHASN5 ; HISC/NCA - Print Patient's Nutrition Status History ;12/13/93  12:58
 ;;5.5;DIETETICS;;Jan 28, 2005
EN2 ; Select Patient to print
 S ALL=1 D ^FHDPA G:'DFN KIL S:WARD="" (ADM,ADTE,DSCH)=""
 I $P($G(^DPT(DFN,.35)),"^",1) W *7,!!?5,"Patient has expired." G EN2
 S X5=$O(^FHPT(FHDFN,"S",0)) I X5="" W *7,!!?5,"No status on file for this patient." G EN2
 I $O(^FHPT(FHDFN,"A",0))<1 G D1
 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="Q",DA=FHDFN,X="??" D ^DIC
 S WARD=$G(^DPT(DFN,.1))
A0 W !!,"Select ADMISSION",$S(WARD'="":" (or C for CURRENT)",1:""),": " R X:DTIME G:'$T!(X["^") KIL D:X="c" TR^FH I X="" G D1:WARD="",KIL
 I WARD'="",X="C" S ADM=$G(^DPT("CN",WARD,DFN)) G A1:ADM,KIL
 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="EQM" D ^DIC G:Y<1 A0 S ADM=+Y
A1 S ADTE=$P($G(^DGPM(ADM,0)),"^",1),DSCH=$P($G(^DGPM(ADM,0)),"^",17) I DSCH S Z1=$G(^DGPM(DSCH,0)),MV=$P(Z1,"^",18),DSCH=$S("^13^42^43^45^46^"[("^"_MV_"^"):$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",14),1:$P(Z1,"^",1))
D1 S %DT="AEPTX",%DT("A")="Starting Date: FIRST// " W ! D ^%DT S:$D(DTOUT) X="^" G:X[U KIL S:X="" Y=ADTE G:Y<0 D1 S SDT=+Y
 I SDT\1'<DT W *7,"  [Must Start before Today!] " G D1
 I SDT,SDT<ADTE W *7," [Must not be before Admission!]" G D1
D2 S %DT="AEPTX",%DT("A")="Ending Date: LAST// " D ^%DT S:$D(DTOUT) X="^" G:X[U KIL S:X="" Y=DSCH G:Y<0 D2 S EDT=+Y
 I EDT\1>DT W *7,"  [Greater than Today?] " G D1
 I EDT,EDT<SDT W *7," [Must not be before Starting Date!] " G D1
 I EDT,DSCH,EDT>DSCH W *7,!?24," [Must not exceed the length of stay of this admission!] " G D1
P0 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q0^FHASN5",FHLST="FHDFN^DFN^PID^ADM^EDT^SDT^ADTE^WARD^DSCH" D EN2^FH G KIL
 U IO D Q0 D ^%ZISC K %ZIS,IOP G FHASN5
Q0 D NOW^%DTC S NOW=% S PG=0,Y=$G(^DPT(DFN,0)),NAM=$P(Y,"^",1)
 K ^TMP($J,"SH") S (ANS,LN,RM)="",$P(LN,"-",80)="",SDT=9999999-SDT,ZZ=EDT#1,EDT=$S(EDT:9999999-$S(ZZ:EDT,1:(EDT+.3)),1:EDT)
 I ADM S Y=$G(^FHPT(FHDFN,"A",ADM,0)),WARD=$P(Y,"^",8),WARD=$P($G(^FH(119.6,+WARD,0)),"^",1),RM=$P(Y,"^",9),RM=$P($G(^DG(405.4,+RM,0)),"^",1)
 D HDR F X5=EDT:0 S X5=$O(^FHPT(FHDFN,"S",X5)) Q:X5<1!(X5>SDT)  S X4=$G(^(X5,0)) I X4'="" S X2=9999999-X5,^TMP($J,"SH",X2,0)=X4
 I $O(^TMP($J,"SH",0))<1 W *7,!,"No Status on file on this Admission." G KIL
 F X5=0:0 S X5=$O(^TMP($J,"SH",X5)) Q:X5<1  S X4=$G(^(X5,0)) D LP Q:ANS="^"
KIL K ^TMP($J,"SH") G KILL^XUSCLEAN
LP ; Print History list
 D:$Y'<(IOSL-3) HD Q:ANS="^"
 S STS=$P(X4,"^",2),TIT=$S(STS=1:"I  ",STS=2:"II ",STS=3:"III",STS=4:"IV ",1:"V  ")_"  "_$S(STS<5:$P($G(^FH(115.4,+STS,0)),"^",3),1:"UNCLASSIFIED") W !?2,TIT
 W ?35 S DTP=$P(X4,"^",1) D DTP^FH W DTP
 S Y=$P(X4,"^",3) W ?55,$E($P($G(^VA(200,+Y,0)),"^",1),1,25)
 Q
HD ; Check for end of page
 I IOST?1"C".E W:$X>1 ! W *7 K DIR S DIR(0)="E" D ^DIR I 'Y S ANS="^" Q
HDR ; Heading for the Nutrition Status History
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W ! W:PID'="" PID W ?17,NAM S DTP=NOW D DTP^FH W ?53,DTP,?72,"Page ",PG,!
 I ADM W:WARD'="" ?17,"WARD  ",WARD W:RM'="" ?53,"RM  ",RM
 W !,LN,!?15,"N U T R I T I O N   S T A T U S   H I S T O R Y",!!
 W ?2,"Status Level",?35,"Date Entered",?55,"Clinician Who Entered",! Q
