PSAVER4 ;;BIR/JMB-Verify Invoices - CONT'D ;9/8/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15,60,71**; 10/24/97;Build 10
 ;This routine prints the report of new drugs that will be added to
 ;each pharmacy location or master vault.
 ;
 ;Asks & prints all invoices the user can verify.
 W @IOF,!,"The verified invoices contain new drugs for the assigned pharmacy location.",!,"A report will print by pharmacy location listing the new drugs. Use the"
 W !,"Balance Adjustment option to enter an adjustment that reflects the total",!,"dispense units on hand for each new drug.",!!,"It is suggested that you send the report to a print."
 K IO("Q") S %ZIS="Q" W !
 D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 I $D(IO("Q")) D  G QUIT
 .N ZTSAVE,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK
 .S ZTDESC="Drug Acct. - Print New Drugs",ZTDTH=$H,ZTRTN="PRINT^PSAVER4"
 .S ZTSAVE("PSANEWD(")="" D ^%ZTLOAD
 ;
PRINT ;Sends invoices to printer
 S (PSALOC,PSAOUT)=0,PSAPG=1,PSADLN="",$P(PSADLN,"=",80)="",PSASLN="",$P(PSASLN,"-",80)=""
 F  S PSALOC=+$O(PSANEWD(PSALOC)) Q:'PSALOC!(PSAOUT)  S PSADRGN=1 D HDR  Q:PSAOUT  D  Q:PSAOUT
 .F  S PSADRGN=$O(PSANEWD(PSALOC,PSADRGN)) Q:PSADRGN=""!(PSAOUT)  D:$Y+5>IOSL HDR Q:PSAOUT  W !,PSADRGN,!,PSASLN,!
 D:$E(IOST,1,2)="C-"&('PSAOUT) END^PSAPROC W:$E(IOST)'="C" @IOF
 K PSANEWD(PSALOC)
QUIT D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
 ;
HDR ;Prints the header to the New Drug Report on the screen & paper.
 I $E(IOST,1,2)="C-" D:PSAPG'=1 END^PSAPROC Q:PSAOUT  W @IOF,!?28,"<<< NEW DRUG REPORT >>>"
 I $E(IOST)'="C" W:PSAPG'=1 @IOF W !?20,"DRUG ACCOUNTABILITY/INVENTORY INTERFACE",!?28,"<<< NEW DRUG REPORT >>>",?72,"Page "_PSAPG
 I $P($G(^PSD(58.8,PSALOC,0)),"^",2)="M" W !?34,"MASTER VAULT",!!,$P($G(^PSD(58.8,PSALOC,0)),"^")
 I $P($G(^PSD(58.8,PSALOC,0)),"^",2)="P" D
 .D SITES^PSAUTL1 S PSALOCN=$P(^PSD(58.8,PSALOC,0),"^")_PSACOMB
 .W !?31,"PHARMACY LOCATION",!!
 .W:$L(PSALOCN)>76 $P(PSALOCN,"(IP)",1)_"(IP)",!?17,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<77 PSALOCN
 W !,PSADLN S PSAPG=PSAPG+1
 Q
 ;
VERLOCK ;==> PSA*3*60 (RJS-VMP)Sets invoice's status to Verifying
 N DIC,DA,DR,DIE
 I '$D(^PSD(58.811,"ASTAT","V",PSAIEN,PSAIEN1)),'$D(^PSD(58.811,"ASTAT","P",PSAIEN,PSAIEN1)),$D(^PSD(58.811,"ASTAT","L",PSAIEN,PSAIEN1)) D  Q
 .S PSAMSG="**This Invoice is currently being Verified by another user"
 I '$D(^PSD(58.811,"ASTAT","P",PSAIEN,PSAIEN1)),'$D(^PSD(58.811,"ASTAT","L",PSAIEN,PSAIEN1))&(($D(^PSD(58.811,"ASTAT","V",PSAIEN,PSAIEN1)))!($D(^PSD(58.811,"ASTAT","C",PSAIEN,PSAIEN1)))) D  Q
 .S PSAMSG="**This Invoice has already been Verified by another user"
 F  L +^PSD(58.811,PSAIEN,1,PSAIEN1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 I '$D(^PSD(58.811,"ASTAT","L",PSAIEN,PSAIEN1)),'$D(^PSD(58.811,"ASTAT","V",PSAIEN,PSAIEN1)),$D(^PSD(58.811,"ASTAT","P",PSAIEN,PSAIEN1)) D
 .S DA=PSAIEN1,DA(1)=PSAIEN,DIE="^PSD(58.811,"_DA(1)_",1,",DR="2///L;12////^S X="_DUZ
 .D ^DIE
 .S PSALOCK(PSA)=PSAIEN_"^"_PSAIEN1
 .I PSATMP S PSATMP=PSATMP_","_PSA
 .I 'PSATMP S PSATMP=PSA
 L -^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 Q
 ;
VERUNLCK ; VERIFY CANCELED RESET INVOICE TO PROCESSED
 N Y,PSAPC S PSACNT=0 F PSAPC=1:1 S PSA=+$P(PSASEL,",",PSAPC) Q:'PSA  D
 .S PSAIEN=$P(PSALOCK(PSA),"^"),PSAIEN1=$P(PSALOCK(PSA),"^",2)
 .I $D(^PSD(58.811,"ASTAT","L",PSAIEN,PSAIEN1)) D
 ..N DIC,DA,DR,DIE
 ..F  L +^PSD(58.811,PSAIEN,1,PSAIEN1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 ..S DA=PSAIEN1,DA(1)=PSAIEN,DIE="^PSD(58.811,"_DA(1)_",1,",DR="2///P;12////@" D ^DIE
 ..L -^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 Q  ;<== PSA*3*?? (RJS-VMP)
 ;
LCKCHK ; CHECK FOR LOCKED INVOICES
 I $D(^XTMP("PSALCK",DUZ)) D UNLCK  ;; <*71 RJS >
 N PSACT,PSACNT,PSAIEN,PSAIEN1,PSADUZ,PSASUP,PSALCHK,DUOUT S (PSACNT,PSAIEN)=0
 F  S PSAIEN=+$O(^PSD(58.811,"ASTAT","L",PSAIEN)) Q:'PSAIEN  D
 .Q:'$D(^PSD(58.811,PSAIEN,0))
 .S PSAIEN1=0 F  S PSAIEN1=+$O(^PSD(58.811,"ASTAT","L",PSAIEN,PSAIEN1)) Q:'PSAIEN1  D
 ..Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,0))!($P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",11)'=DUZ)
 ..S PSACNT=PSACNT+1,PSALCHK(PSACNT)=PSAIEN_"^"_PSAIEN1
 Q:'$D(PSALCHK)
 D MSG
 S PSACT=0 F  S PSACT=$O(PSALCHK(PSACT)) Q:'PSACT  D
 .S PSAIEN=$P(PSALCHK(PSACT),"^",1),PSAIEN1=$P(PSALCHK(PSACT),"^",2),PSACNT=PSACT
 .W !,?3,PSACNT,".",?8,"Order#: ",$P(^PSD(58.811,PSAIEN,0),"^"),?35,"Invoice#: ",$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^")
 W ! S DIR(0)="Y",DIR("A")="Do you want to reset the Order Status to PROCESSED",DIR("B")="NO"  D ^DIR K DIR Q:'Y!($G(DUOUT))
 I PSACNT=1 S PSAIEN=$P(PSALCHK(1),"^"),PSAIEN1=$P(PSALCHK(1),"^",2)  D LCK1 Q
 I PSACNT>1 D
 .S DIR(0)="S^A:All;S:Selected"
 .S DIR("A")="Which Orders"
 .D ^DIR K DIR Q:'$D(Y)!($G(DUOUT))
 I Y="S" D  Q
 .S DIR(0)="L^1:"_PSACNT D ^DIR K DIR Q:'Y!($G(DUOUT))
 .N PSACNT,PSANUM,PSACNTR S PSANUM=Y K Y
 .D LCK2 I $G(Y)=0 K Y Q
 .F PSACNTR=1:1 S PSACNT=$P(PSANUM,",",PSACNTR) Q:'PSACNT  D
 ..S PSAIEN=$P(PSALCHK(PSACNT),"^",1),PSAIEN1=$P(PSALCHK(PSACNT),"^",2)  D LCK1
 I Y="A" D
 .D LCK2 I $G(Y)=0 K Y Q
 .N PSACNT,PSACNTR
 .S PSACNT=0 F  S PSACNT=$O(PSALCHK(PSACNT)) Q:'PSACNT  D
 ..S PSAIEN=$P(PSALCHK(PSACNT),"^",1),PSAIEN1=$P(PSALCHK(PSACNT),"^",2)  D LCK1
 Q
LCK1 ; RESET ORDER STATUS TO PROCESSED
 W !,?5,"Order Status has been reset to PROCESSED for",!,?8,"Order#: ",$P(^PSD(58.811,PSAIEN,0),"^")," Invoice#: ",$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^")
 N DIC,DA,DR,DIE
 F  L +^PSD(58.811,PSAIEN,1,PSAIEN1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 S DA=PSAIEN1,DA(1)=PSAIEN,DIE="^PSD(58.811,"_DA(1)_",1,",DR="2///P;12////@" D ^DIE
 L -^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 Q
LCK2 ; DOUBLE CHECK WITH USER BEFORE RESETTING INVOICE STATUS
 S DIR(0)="Y",DIR("A")="Are you sure you want to change the Order Status to PROCESSED",DIR("B")="NO"
 D ^DIR K DIR
 Q
CLCK ; RESET ORDER STATUS TO COMPLETED <*71 RJS 
 W !,?5,"Order Status has been reset to COMPLETED for",!,?8,"Order#: ",$P(^PSD(58.811,PSAIEN,0),"^")," Invoice#: ",$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^"),!
 N DIC,DA,DR,DIE
 F  L +^PSD(58.811,PSAIEN,1,PSAIEN1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 S DA=PSAIEN1,DA(1)=PSAIEN,DIE="^PSD(58.811,"_DA(1)_",1,",DR="2///C" D ^DIE
 L -^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 Q
UNLCK ; RESET ORDER STATUS TO PROCESSED
 D MSG
 N PSAIEN,PSAIEN1,DUOUT S PSAIEN=0
 F  S PSAIEN=$O(^XTMP("PSALCK",DUZ,PSAIEN)) Q:'PSAIEN  D
 .S PSAIEN1=0 F  S PSAIEN1=$O(^XTMP("PSALCK",DUZ,PSAIEN,PSAIEN1)) Q:'PSAIEN1  D
 ..W !,?8,"Order#: ",$P(^PSD(58.811,PSAIEN,0),"^"),?35,"Invoice#: ",$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^"),?60,"LOCKED VERIFYING"
 ..N DIR
 ..S DIR(0)="S^P:RESET TO PROCESSED;C:MARK COMPLETED;S:SKIP"
 ..S DIR("A")="PROCESS OR COMPLETE"
 ..D ^DIR K DIR Q:'$D(Y)!($G(DUOUT))
 ..I Y="P" D LCK1 W ! Q
 ..I Y="C" D CLCK W ! Q
 ..I Y="S" W !!,?5,"Order#: ",$P(^PSD(58.811,PSAIEN,0),"^")," Invoice#: ",$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^")," HES BEEN SKIPPED",!
 K ^XTMP("PSALCK",DUZ)
 Q  ;;*71 RJS >
MSG ; SHOW LOCK WARNING
 W !!,?3,"The following Invoices currently have a status of LOCKED VERIFYING."
 W !,?3,"These Invoices are either currently being Verified by you in another"
 W !,?3,"session, or it may not have completed the Verify process correctly.",!
 Q 
