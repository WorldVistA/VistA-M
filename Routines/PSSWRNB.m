PSSWRNB ;BIR/EJW-NEW WARNING SOURCE CUSTOM WARNING LIST BUILDER ; 9/8/05 3:46pm
 ;;1.0;PHARMACY DATA MANAGEMENT;**87,98,144**;9/30/97;Build 13
 ;
 ;IA: 3735 ^PSNDF(50.68
 ;IA: 4445 ^PS(50.625
 ;IA: 4446 ^PS(50.626
 ;IA: 4448 ^PS(50.627
 D NOTE^PSSWRNE,NOTE2^PSSWRNE
 W ! K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")=" Would you like to print a list of the entries in these files" D ^DIR K DIR I Y["^"!($D(DTOUT)) W !!?3,"Nothing queued to print." G SEL
 I 'Y G SEL
 S SPANISH=0
 W ! K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")=" Would you like to include the Spanish translations" D ^DIR K DIR I Y["^"!($D(DTOUT)) W !!?3,"Nothing queued to print." G SEL
 I Y S SPANISH=1
 D RPT
SEL ;
 W @IOF
 D NOTE^PSSWRNE
 W !!,?2,"Select one of the following to display drugs that match that criteria to"
 W !,?2,"examine or edit their drug warnings:"
 K DIR
 S DIR("B")=""
 S DIR("A")="Enter selection or '^' to exit: "
 S DIR("A",1)="1. Drug has WARNING LABEL filled in but there are no FDB warnings for the drug"
 S DIR("A",2)="2. Drug has WARNING LABEL numbers higher than 20"
 S DIR("A",3)="3. Select by range of drug names"
 S DIR("A",4)="4. Drug has more than 5 warning labels"
 S DIR("A",5)="5. Drugs containing specific WARNING LABEL number"
 S DIR("A",6)="6. Drug has WARNING LABEL that does not map to new data source"
 S DIR("A",7)="7. Drugs containing specific new data source warning number"
 S DIR("A",8)="8. Drugs containing gender-specific warnings"
 S DIR("A",9)="9. Drugs with warning mapping, but drug doesn't contain ""mapped to"" number"
 S DIR(0)="SA^1:DRUGS WITH NO FDB WARNINGS;2:LOCAL WARNING (>20);3:RANGE OF DRUG NAMES;4:GREATER THAN 5 WARNINGS;5:SPECIFIC WARNING LABEL NUMBER;6:NO MAPPING;7:SPECIFIC NEW WARNING;8:GENDER-SPECIFIC WARNING;9:NO MAPPED TO"
 D ^DIR K DIR S SEL=Y
 I 'SEL G KILL
 N DR,ACTIVE,SKIP,QUIT,PSO9
 S SKIP=1,QUIT=0
 K ^TMP("PSSWRNB",$J)
ASK K DIR W ! S DIR(0)="Y",DIR("B")="Y",DIR("A")="Exclude drugs with NEW WARNING LABEL LIST filled in" D ^DIR K DIR I Y["^"!($D(DTOUT)) G SEL
 I 'Y S SKIP=0
 W !!,$C(7),"NOTE: Only the first 5 warnings will print on the yellow auxillary labels."
 K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to see the warning text for all warnings" D ^DIR K DIR I Y["^"!($D(DTOUT)) G SEL
 S ENDWARN=5
 I Y S ENDWARN=99 D
 .W !,"  Warnings (>5) that won't print and won't be sent to CMOP"
 .W !,"  will be marked with a ""*"" on the following screens."
 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 ;
 I SEL=1 D SEL1^PSSWRNC
 ;
 I SEL=2 D SEL2^PSSWRNC
 ; 
 I SEL=3 D SEL3^PSSWRNC
 ;
 I SEL=4 D SEL4^PSSWRNC
 ;
 I SEL=5!(SEL=9) D SEL59^PSSWRNC
 ;
 I SEL=6 D SEL6^PSSWRNC
 ;
 I SEL=7 D SEL7^PSSWRNC
 ;
 I SEL=8 D SEL8^PSSWRNC
 ;
 I 'QUIT I '$D(^TMP("PSSWRNB",$J)) W !,"Nothing meets selection criteria" H 2 S QUIT=1
 I 'QUIT D EDIT^PSSWRNE
 G SEL
RPT ;
RPTQ W !!,"You may queue the report to print, if you wish.",!
 ;
DVC K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !,"Nothing queued to print.",! G DONE
 S ZTSAVE("*")=""
 I $D(IO("Q")) S ZTRTN="PRT54^PSSWRNB",ZTDESC="WARNING LABEL TEXT REPORTS" D ^%ZTLOAD K %ZIS W !,"Report queued to print.",! G DONE
PRT54 ;
 U IO
 S PSSOUT=0,PSSDV=$S($E(IOST,1,2)="C-":"C",1:"P")
 S PSSPGCT=0,PSSPGLN=IOSL-7,PSSPGCT=1
 S TITLE="RX CONSULT file - WARNING LABEL TEXT"
 D TITLE
 ;
 S SEQ=0 F  S SEQ=$O(^PS(54,SEQ)) Q:'SEQ  D PRTRPT
 G END
PRTRPT ;
 I $G(^PS(54,SEQ,0))'="" D RXCON D FULL I $G(PSSOUT) Q
 D FULL I $G(PSSOUT) Q
 W ! F MJT=1:1:70 W "-"
 Q
RXCON D FULL Q:$G(PSSOUT)  W !,"RX CONSULT NUMBER:  ",SEQ
 N PSSTXT
 D FULL I $G(PSSOUT) Q
 W !
 S PSSTXT=0 F  S PSSTXT=$O(^PS(54,SEQ,1,PSSTXT)) Q:'PSSTXT  D FULL Q:$G(PSSOUT)  W !,?3,^PS(54,SEQ,1,PSSTXT,0)
 I $G(SPANISH),$D(^PS(54,SEQ,3)) W !!,"Spanish translation:" D
 .S PSSTXT=^PS(54,SEQ,3) Q:PSSTXT=""  D FULL Q:$G(PSSOUT)  W !,?3 D
 ..N LEN,I,STR
 ..S LEN=0
 ..F I=1:1:$L(PSSTXT," ") S STR=$P(PSSTXT," ",I),LEN=LEN+$L(STR) W:LEN>62 !,?3 S:LEN>62 LEN=0 W STR," "
 Q
 ;
FULL ;
 I ($Y+5)>IOSL&('$G(PSSOUT)) D TITLE
 Q
 ;
TITLE ;
 I $E($G(PSSDV))="C",$G(PSSPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 ;
 W @IOF
 W !,?16,TITLE,!
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?70,"Page: ",PSSPGCT,!
 F MJT=1:1:79 W "="
 W !
 S PSSPGCT=PSSPGCT+1
 Q
END ;
 I '$G(PSSOUT),$E($G(PSSDV))="C" W !!,"End of Rx Consult file Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $E($G(PSSDV))="C" W !
 E  W @IOF
 G PRTNEW
END2 ;
 I '$G(PSSOUT),$E($G(PSSDV))="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $E($G(PSSDV))="C" W !
 E  W @IOF
DONE ;
 K SEQ,MJT,PSSPGCT,PSSPGLN,Y,DIR,INDT,PSSXX,X,OITM,IOP,POP,IO("Q"),DIRUT,DUOUT,DTOUT
 K PSSDV,PSSOUT D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
PRTNEW ;
 U IO
 S PSSOUT=0,PSSDV=$S($E(IOST)="C":"C",1:"P")
 S PSSPGCT=0,PSSPGLN=IOSL-7,PSSPGCT=1
 S TITLE="WARNING LABEL-ENGLISH file - WARNING LABEL TEXT"
 D TITLE
 ; REPORT FROM NEW WARNING LABEL SOURCE
 S SEQ=0 F  S SEQ=$O(^PS(50.625,SEQ)) Q:'SEQ  D RPTNEW
 G END2
RPTNEW ;
 I $G(^PS(50.625,SEQ,0))'="" D FDBWARN D FULL I $G(PSSOUT) Q
 D FULL I $G(PSSOUT) Q
 W ! F MJT=1:1:70 W "-"
 Q
FDBWARN D FULL Q:$G(PSSOUT)  W !,"WARNING LABEL-ENGLISH NUMBER:  ",+SEQ
 N PSSTXT
 D FULL I $G(PSSOUT) Q
 W !
 S PSSTXT=0 F  S PSSTXT=$O(^PS(50.625,SEQ,1,PSSTXT)) Q:'PSSTXT  D FULL Q:$G(PSSOUT)  W !,?3,^PS(50.625,SEQ,1,PSSTXT,0)
 I $G(SPANISH) W !!,"Spanish translation:" D
 .S PSSTXT=0 F  S PSSTXT=$O(^PS(50.626,SEQ,1,PSSTXT)) Q:'PSSTXT  D FULL Q:$G(PSSOUT)  W !,?3,^PS(50.626,SEQ,1,PSSTXT,0)
 Q
 ;
KILL ;
 K ^TMP("PSSWRNB",$J),NDF,PSSWRN,SEL,SPANISH,WARN54,RXNUM,WARN,WARN20,STR,PSOWARN,JJJ,TEXT,WWW,DRUGN,DRUG,DEA,TITLE
 Q
DRUG ;
 S NDF=0
 N PSOPROD,GCNSEQNO,I,NEWWARN
 S PSSWRN=""
 S PSOPROD=$P($G(^PSDRUG(DR,"ND")),"^",3) I PSOPROD="" Q
 S NDF=1
 S GCNSEQNO=$$GET1^DIQ(50.68,PSOPROD,11,"I")
 I GCNSEQNO="" Q
 D GCN^PSSWRNA
 Q
WARN ; ENTRY POINT DRUG ENTER/EDIT OPTION
 S DRUGENT=1
 S DRUG=$P($G(^PSDRUG(DA,0)),"^") I DRUG="" Q
 S ^TMP("PSSWRNB",$J,DRUG)=""
 D EDIT^PSSWRNE
 Q
ACTIVE ;
 S ACTIVE=1
 I $P($G(^PSDRUG(DR,"I")),"^"),$P($G(^("I")),"^")<DT S ACTIVE=0 Q
 Q
