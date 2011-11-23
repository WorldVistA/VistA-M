DVBCXFRA ;ALB/GTS-557/THM-TRANSFER C&P REQUESTS ; 4/18/91  2:14 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 D HOME^%ZIS K CORR S FF=IOF G EN
 ;
CORSEL I SEL=1 G EN
 I SEL=2 G DOMAIN
 I SEL=3 G EXAMS
 I SEL=4 K CORR,EXAMS,X,Y,REQDA G EN
 I SEL[U G EXIT
 ;
SET ;** EXAMS - Xfr all
 S EXMNM=$P(^DVB(396.6,$P(^DVB(396.4,JJ,0),U,3),0),U,1)
 I $P(^DVB(396.4,JJ,0),U,4)["X" W EXMNM," is CANCELED and cannot be transferred.",!,*7 Q
 I $P(^DVB(396.4,JJ,0),U,4)="C" W EXMNM," is COMPLETED and cannot be transferred.",!,*7 Q
 I $P(^DVB(396.4,JJ,0),U,4)="T" W EXMNM," has been TRANSFERRED and cannot be selected.",!,*7 Q
 W !,EXMNM," is OK to transfer.",!!
 S EXAMS=EXAMS_$P(^DVB(396.4,JJ,0),U,3)_U,XEXAMS(JJ)="",XMCNT=XMCNT+1
 ;
 ;** Set XMVAR(XMCNT)=$EXAM AMIE EXAM IFN^INSUFF REASON IFN
 S XMVAR(XMCNT)="$EXAM "_$P(^DVB(396.4,JJ,0),U,3)_U_$S(+$P(^DVB(396.4,JJ,0),U,11)>0:$P(^DVB(396.94,$P(^DVB(396.4,JJ,0),U,11),0),U,1),1:"")
 ;EXAMS for MailMan msg, XEXAMS sets exam status
 ;XMVAR() add one exam/line to bulletin - Future
 Q
 ;
EN W @FF,!,"Transfer C&P Exams",!!!!
 K DVBAINSF S DIC="^DVB(396.3,",DIC(0)="AEQMZ",DIC("A")="Select VETERAN NAME: " D ^DIC K DIC G:X=""!(X=U) EXIT I +Y<0 W *7,"  ???" H 2 G EN
 I $P(Y(0),U,18)'="P" W !!,*7,"This request does not have a PENDING status and may not be transferred.",!! H 3 G EN
 I $P(Y(0),U,22)]"" W !!,*7,"This request was transferred in and CANNOT be transferred to any other site !",!! H 3 G EN
 ;
ENQUEST W !!!,"Is this the correct request" S %=2 D YN^DICN G:%<0 EXIT I %=2 H 1 G EN
 I %=0 W !!,"Enter Y if the correct Veteran or N if not.",!! DO
 .D CONTMES^DVBCUTL4
 I %=0 G ENQUEST
 K DVBAINSF
 S REQDA=+Y,DFN=$P(Y,U,2),PNAM=$P(^DPT(DFN,0),U,1),SSN=$P(^(0),U,9)
 S:$P(^DVB(396.3,REQDA,0),U,10)="E" DVBAINSF=""
 I $D(CORR) G DISPLAY
 ;
DOMAIN W @FF,!,"Selection of transfer domain:",!!!!
 S DIC("A")="Send to domain: ",DIC="^DIC(4.2,",DIC(0)="AEQM" D ^DIC G:X=""!(X=U) EXIT I +Y<0 W *7,"  ???" H 2 G EN
 ;
DOMQST W !!!,"Is this the correct domain" S %=2 D YN^DICN G:%<0 EXIT I %=2 H 1 G DOMAIN
 I %=0 W !!,"Enter Y if the domain is correct or N to reselect." D CONTMES^DVBCUTL4 G DOMQST
 S DOMNUM=$S($P(^DIC(4.2,+Y,0),U,3)]"":$P(^(0),U,3),1:+Y),DOMNAM=$P(^(0),U,1),DOMNUM1=+Y
 I $D(CORR) G DISPLAY
 ;
EXAMS K XEXAMS W @FF,!,"Exam selection",!!!! S EXAMS="",XMCNT=0
 F LPCNT=0:0 S LPCNT=$O(XMVAR(LPCNT)) Q:LPCNT=""  K XMVAR(LPCNT)
 W !!,"Do you want to transfer ALL exams" S %=2 D YN^DICN G:%<0 EXIT
 I %=2 W !! G PART
 I %=0 W !!,"Enter Y if you want to transfer all exams or N if not.",!! D CONTMES^DVBCUTL4 G EXAMS
 W !!! F JJ=0:0 S JJ=$O(^DVB(396.4,"C",REQDA,JJ)) Q:JJ=""  D SET
 D PAUSE^DVBCUTL4
 G @$S(EXAM]""&(Y):"DISPLAY",1:"EN")
 ;
PART W @FF,!,"Individual exam selection",!!!!
 S Y=$$EXSRH^DVBCUTL4("Select EXAM TO TRANSFER: ","I $D(^DVB(396.4,""ARQ""_REQDA,+Y))") ;*Exam lookup function call
 K DIC G:X=""&(EXAMS]"") DISPLAY G:X=U EXIT
 I +Y<0 W *7,!!,"No exams have been selected for transfer." D CONTMES^DVBCUTL4 G EN
 I $P(^DVB(396.4,+Y,0),U,4)["X" W !!,"This exam is CANCELED and cannot be transferred.",*7,!! D CONTMES^DVBCUTL4 G PART
 I $P(^DVB(396.4,+Y,0),U,4)="C" W !!,"This exam has been COMPLETED and cannot be transferred.",!!,*7 D CONTMES^DVBCUTL4 G PART
 I $P(^DVB(396.4,+Y,0),U,4)="T" W !!,"This exam has been TRANSFERRED and cannot be selected.",!!,*7 D CONTMES^DVBCUTL4 G PART
PART1 W !!!,"Is this the correct exam" S %=2 D YN^DICN G:%<0 EXIT I %=2 G EXAMS
 I %=0 W !!,"Enter Y if all is correct or N to reselect another exam." D CONTMES^DVBCUTL4 G PART1
 I EXAMS[$P(^DVB(396.4,+Y,0),U,3)_U DO
 .W !!,*7,"You have already selected this exam for transfer."
 .D CONTMES^DVBCUTL4
 I EXAMS[$P(^DVB(396.4,+Y,0),U,3)_U G PART
 S EXAMS=EXAMS_$P(^DVB(396.4,+Y,0),U,3)_U,XEXAMS(+Y)="",XMCNT=XMCNT+1
 D SETXMVR^DVBCXUTL ;** Set XMVAR(XMCNT)
 W !! G PART
 ;
DISPLAY I EXAMS="" W @FF,!!!,"No exams have been selected for transfer.",!! D PAUSE^DVBCUTL4 G EN
 W @FF,!!,"You have selected the following:",!!!,"Veteran name: ",PNAM,?50,"SSN: ",SSN,!,"Request date: " S Y=$P(^DVB(396.3,REQDA,0),U,2) X ^DD("DD") W Y,!!!,"Exams selected for transfer:",!!
 F I=1:1 S X=$P(EXAMS,U,I) Q:X=""  W $P(^DVB(396.6,X,0),U,1),"; " I $X>45 W !?2
 ;
YN K DA(1) W !!!,"Is this information correct" S %=2 D YN^DICN I %<0 K EXAMS,REQDA,X,DIC,DA,Y,DVBAINSF,XMCNT F LPCNT=0:0 S LPCNT=$O(XMVAR(LPCNT)) Q:LPCNT=""  K XMVAR(LPCNT)
 I %<0 K LPCNT G EN
 I %=0 W !!,"Answer YES if correct and NO if not" G YN
 I %=1 W !!,"One moment please ...   "
 ;
DISPLAY1 ;
 K CORR I %=2 S CORR=1 W @FF,!!,"Select part to correct:",!!!,"1. Veteran name",!,"2. Domain",!,"3. Exams",!,"4. All parts",!!,"Selection: " R SEL:DTIME G:'$T!(SEL[U) EXIT
 I $D(CORR) I (SEL'?1N)!(+SEL'>0)!(+SEL'<5)!(SEL["?") W *7,!!,"Must be a number from 1 to 4.   " D CONTMES^DVBCUTL4 G DISPLAY1
 I $D(CORR) G CORSEL
 D INREAS^DVBCXUTL
 G ^DVBCXFRB
 ;
EXIT D CLRVAR^DVBCXUTL
 D KILLVRS^DVBCXUTL G KILL^DVBCUTIL
