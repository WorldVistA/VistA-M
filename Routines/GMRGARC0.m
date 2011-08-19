GMRGARC0 ;HIRMFO/RM-ARCHIVE/PURGE UTILITY FOR GMR TEXT FILE ;4/15/96
 ;;3.0;Text Generator;**1**;Jan 24, 1996
 ;
EN1 ; Entry from the option Purge GMR Text File Data [GMRG-PURGE PT DATA]
 ;
 L +^GMRD(124.1,1,"PURGE"):1 I '$T W !!,"SOMEONE ELSE IS RUNNING THE PURGE OPTION, TRY AGAIN LATER!!" G Q
 I $P($G(^GMRD(124.1,1,"PURGE")),"^") W !!,"THE GMR TEXT FILE PURGE IS ALREADY RUNNING, TRY AGAIN LATER!!" G UNL
 K DIR S DIR("?")="   ENTER THE NUMBER OF MONTHS OF GMR TEXT DATA TO BE RETAINED.",DIR("?",1)="   YOU MUST RETAIN AT LEAST SIX MONTHS OF GMR TEXT DATA."
 S DIR(0)="NAO^6:99999",DIR("A")="Enter number of months to RETAIN GMR Text data: " W ! D ^DIR K DIR G UNL:'Y
 S GMRGPMO=Y,X="T-"_GMRGPMO_"M",%DT="" D ^%DT I Y<0 G UNL
 S GMRGPURG=Y,GMRGPURG(0)=$$FMTE^XLFDT(Y)
 S DIR("?")="   ANSWERING YES HERE CONFIRMS YOU WISH TO PURGE THE GMR TEXT DATA."
 S DIR("A",1)="Are you sure you only want to retain data from "_GMRGPURG(0),DIR("A")="to today (Y/N): ",DIR(0)="YA" W ! D ^DIR K DIR I Y'=1 G UNL
 S DIR("?")="   ANSWERING YES HERE WILL BEGIN THE PURGE.",DIR("B")="YES"
 S DIR("A")="OK to proceed: ",DIR(0)="YA" W ! D ^DIR K DIR I Y'=1 G UNL
 S ZTIO="",ZTRTN="START^GMRGARC0",ZTDESC="GMR Text File Date Purge",ZTSAVE("GMRGPURG")="" D ^%ZTLOAD I '$D(ZTSK) W !!,"Job not queued, please try again..." G UNL
 W !!,"Job queued as task #"_ZTSK
 S $P(^GMRD(124.1,1,"PURGE"),"^")=ZTSK
 S DA=1,DIK="^GMRD(124.1,",DIK(1)=2 D IX1^DIK
 K ZTSK
 G UNL
START ; Enter here from queued job
 ;
 ;  Input variable:  GMRGPURG=date to end loop for data purge
 ;
 S GMRGDATE=0 F  S GMRGDATE=$O(^GMR(124.3,"AUPDT",GMRGDATE)) Q:GMRGDATE'>0!(GMRGDATE>GMRGPURG)!$G(ZTSTOP)  S GMRGPDA=0 F  S GMRGPDA=$O(^GMR(124.3,"AUPDT",GMRGDATE,GMRGPDA)) Q:GMRGPDA'>0!$G(ZTSTOP)  D
 .   S DA=0 F  S DA=$O(^NURSC(216.8,"B",GMRGPDA,DA)) Q:DA'>0  S DIK="^NURSC(216.8," D ^DIK
 .   S DA=GMRGPDA,DIK="^GMR(124.3," D ^DIK
 .   I $$S^%ZTLOAD S ZTSTOP=1
 .   Q
 I '$G(ZTSTOP) S DIE="^GMRD(124.1,",DA=1,DR="2///@" D ^DIE
Q ; Clean up and exit
 I $D(ZTQUEUED),'$G(ZTSTOP) D
 .  S ZTREQ="@"
 .  N XQA,XQAMSG,XQAOPT,XQAROU,XQAID,XQADATA,XQAFLAG
 .  S XQA(DUZ)="",XQAMSG="Purge is completed.  Restart journaling for the GMR and NURSC globals." D SETUP^XQALERT
 .  S XQA(DUZ)="",XQA("G.NURS-ADP")="",XQAMSG="Patient plan of care data older than "_$$FMTE^XLFDT(GMRGPURG,2)_" has been purged from the system." D SETUP^XQALERT
 .  Q
 K %DT,DA,DIE,DIK,DIR,DR,GMRGDATE,GMRGPDA,GMRGPMO,GMRGPURG,X,Y D ^%ZISC
 Q
UNL ; Unlock ^GMRD(124.1,1,"PURGE") and go to Q
 L -^GMRD(124.1,1,"PURGE")
 G Q
