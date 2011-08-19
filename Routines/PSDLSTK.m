PSDLSTK ;BIR/JPW-List Active Stock Items for NAOUs ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 W !!,?5,"You may select a single NAOU, several NAOUs,",!,?5,"or enter ^ALL to select all NAOUs.",!!
ASKN ;ask NAOU(s)
 D NOW^%DTC S PSDT=X K DA,DIC
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>PSDT:1,1:0),$P(^(0),""^"",2)'=""P"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC Q:Y<0  S NAOU(+Y)=""
 I '$D(NAOU)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),$P($G(^(0)),"^",2)'="P",$P($G(^(0)),"^",3)=+PSDSITE S NAOU(PSD)=""
 K DA,DIR,DIRUT S DIR(0)="SO^T:TYPE/LOCATION/DRUG;A:ALPHABETICALLY BY DRUG",DIR("A",1)="You may print by either of these sorting methods."
 S DIR("?",1)="Enter 'T' if you wish to print the NAOU stock list sorted by TYPE",DIR("?",2)="  and within TYPE by LOCATION.",DIR("?")="Enter 'A' to print the NAOU stock list alphabetically."
 S DIR("A")="Select SORT ORDER for Report" D ^DIR K DIR G:$D(DIRUT) END S ANS=Y
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
DEV ;asks device and queueing information
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN=$S(ANS="T":"START^PSDLSTK1",1:"START^PSDLSTK2"),ZTDESC="CS PHARM List Stock Drugs" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G:ANS="T" START^PSDLSTK1 G:ANS="A" START^PSDLSTK2
END ;
 K %,%H,%I,%ZIS,ANS,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IO("Q"),NAOU,POP,PSD,PSDT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save variables for queueing
 S ZTSAVE("ANS")="",ZTSAVE=("PSDSITE")="",ZTSAVE("PSD")="",ZTSAVE("PSDT")="" S:$D(NAOU) ZTSAVE("NAOU(")=""
 Q
