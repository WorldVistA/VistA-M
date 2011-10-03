PSDEXP ;BIR/BJW-CS Drug Expiration Date Report ; 10 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to print",!,?12,"CS reports.  PSJ RPHARM or PSJ PHARM TECH security key required.",! K OK Q
 W !!,"Controlled Substances Expiration Date Report",!!
DATE ;ask date range
 W ! K %DT S %DT="AEP",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=$E(PSDSD,1,5)_"00"-.1,PSDED=$E(PSDED,1,5)_"31"+.9999
ASKN ;ask NAOU(s)
 W !!,?5,"You may select a single NAOU, several NAOUs,",!,?5,"or enter ^ALL to select all NAOUs.",!
 D NOW^%DTC S PSDT=X K DA,DIC
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>PSDT:1,1:0),$P(^(0),""^"",2)'=""P"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC Q:Y<0  S NAOU(+Y)=""
 I '$D(NAOU)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),$P($G(^(0)),"^",2)'="P",$P($G(^(0)),"^",3)=+PSDSITE S NAOU(PSD)=""
 F JJ="" F CNT=0:1 S JJ=$O(NAOU(JJ)) Q:'JJ
 I CNT=1 S ANS="D" G DEV
SORT ;asks sort
 K DA,DIR,DIRUT S DIR(0)="SO^D:DATE/DRUG/NAOU;N:DATE/NAOU/DRUG",DIR("A",1)="You may print by either of these sorting methods."
 S DIR("?",1)="Enter 'D' if you wish to print the Expiration date list sorted by DATE",DIR("?",2)="  and within DATE by DRUG then NAOU."
 S DIR("?")="Enter 'N' to print by DATE and within DATE by NAOU then DRUG."
 S DIR("A")="Select SORT ORDER for Report" D ^DIR K DIR G:$D(DIRUT) END S ANS=Y
DEV ;dev & queue info
 W !!,"This report is designed for a 80 column format.",!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTSAVE,ZTDTH,ZTSK S PSDIO=ION,ZTIO="",ZTRTN="START^PSDEXP",ZTDESC="CS Drug Expiration Date Report" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;compile data
 K ^TMP("PSDEXP",$J) S PSDOUT=0
 F PSD=PSDSD:0 S PSD=$O(^PSD(58.8,"AEXP",PSD)) Q:'PSD!(PSD>PSDED)  F DRUG=0:0 S DRUG=$O(^PSD(58.8,"AEXP",PSD,DRUG)) Q:'DRUG  F NAOU=0:0 S NAOU=$O(^PSD(58.8,"AEXP",PSD,DRUG,NAOU)) Q:'NAOU  I $D(NAOU(NAOU)) D SET
 F PSD=PSDSD:0 S PSD=$O(^PSD(58.8,"AEXPO",PSD)) Q:'PSD!(PSD>PSDED)  F DRUG=0:0 S DRUG=$O(^PSD(58.8,"AEXPO",PSD,DRUG)) Q:'DRUG  F NAOU=0:0 S NAOU=$O(^PSD(58.8,"AEXPO",PSD,DRUG,NAOU)) Q:'NAOU  I $D(NAOU(NAOU)) D
 .F ORD=0:0 S ORD=$O(^PSD(58.8,"AEXPO",PSD,DRUG,NAOU,ORD)) Q:'ORD  D SET
 G:'$D(ZTQUEUED) PRINT^PSDEXP1
PRTQUE ;que print after compile
 K ZTSAVE,ZTIO S ZTIO=PSDIO,ZTRTN="Print CS Drug Expiration Date Report",ZTRTN="PRINT^PSDEXP1",ZTDTH=$H
 S ZTSAVE("^TMP(""PSDEXP"",$J,")="",ZTSAVE("PSDATE")="",ZTSAVE("CNT")="",ZTSAVE("ANS")=""
 D ^%ZTLOAD K ^TMP("PSDEXP",$J)
END ;
 K %,%DT,%H,%I,%ZIS,ANS,CNT,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DRUG,DRUGN,DUOUT,JJ,LN,NAOU,NAOUN,NODE,OK,ORD
 K PG,POP,PSD,PSDT,PSDATE,PSDED,PSDIO,PSDOUT,PSDPN,PSDSD,RPDT,TYPE,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDEXP",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE S (ZTSAVE("PSDSITE"),ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("PSDATE"),ZTSAVE("PSDIO"),ZTSAVE("ANS"),ZTSAVE("CNT"))=""
 S:$D(NAOU) ZTSAVE("NAOU(")=""
 Q
SET ;set data for printing
 S PSDPN="N/A"
 S DRUGN=$S($D(^PSDRUG(DRUG,0)):$P(^(0),"^"),1:"DRUG NAME MISSING")
 S NAOUN=$S($D(^PSD(58.8,NAOU,0)):$P(^(0),"^"),1:"NAOU NAME MISSING")
 S TYPE=$P($G(^PSD(58.8,NAOU,0)),"^",2) I TYPE'="N"!(TYPE="N"&'$D(ORD)) D TMP Q
 Q:'$D(^PSD(58.8,NAOU,1,DRUG,3,ORD,0))  S NODE=^(0)
 Q:+$P(NODE,"^",11)'=4&(+$P(NODE,U,11)'=13)  S PSDPN=$S($P(NODE,"^",16)]"":$P(NODE,"^",16),1:"N/A") D TMP
 Q
TMP ;set ^TMP
 I ANS="D"!(CNT<2) S ^TMP("PSDEXP",$J,PSD,DRUGN,NAOUN,PSDPN)="" Q
 S:ANS="N" ^TMP("PSDEXP",$J,PSD,NAOUN,DRUGN,PSDPN)=""
 Q
