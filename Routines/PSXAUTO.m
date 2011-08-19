PSXAUTO ;BIR/WPB-Routine to Automatically Run CMOP Suspense ;14 DEC 2001
 ;;2.0;CMOP;**1,2,3,24,28,36,41**;11 Apr 97
 ;Reference to ^XUSEC(  supported by DBIA #10076
 ;This routine will be called from a menu option and will allow
 ;the user to start or change auto-processing. The user must hold
 ;the PSXAUTOX security key.
 G START
STARTCS ; entry from edit auto CS Schedule menu option (future - post *41))
 S PSXCS=1
START ;
 S PSXCS=+$G(PSXCS)
 I '$D(^XUSEC("PSXAUTOX",DUZ)) W !,"You are not authorized to use this option!" Q
 I '$D(^XUSEC("PSX XMIT",DUZ)) W !,"You are not authorized to use this option!" Q
 I '$D(^XUSEC("PSXCMOPMGR",DUZ)) W !,"You are not authorized to use this option!" Q
 D SET^PSXSYS I $G(PSXSYS)="" W !!,"The Station number is missing in the Institution file.",!,"The Station number is required for CMOP transmissions.",!,"Please contact your IRM and have this problem corrected, then try again." Q
 I '$D(^PSX(550,"C")) W !,"The CMOP is not an active CMOP site and can not schedule auto transmissions." Q
 I $D(^PSX(550,"TR","T")) W !,"A transmission is in progress, try later." Q
 L +^PSX(550.1):5 I '$T W !,"A transmission is in progress, try later." Q
 S PSXSTAT="T" D PSXSTAT^PSXRSYU I $G(PSXLOCK) G EXIT
 S PSXDUZ=DUZ
 F PSXCS=0,1 D GETSCH S DTTM(PSXCS)=PSXDATE ; store pre-edit schedule values
ASK D EDTBSCH ; edit both schedules
FILE ; if either schedule changed send appropriate message
 F PSXCS=0,1 D GETSCH D
 . I DTTM(PSXCS)=PSXDATE Q  ;no change - quit
 . I 'PSXDATE,DTTM(PSXCS) S (PSXAUTO,PSXHOUR)=0 D AUTOMSG^PSXMSGS,SERV^PSXMISC W !,$S(PSXCS:"",1:"NON-"),"CS Cancel Schedule Sent to CMOP" H 3 Q  ; schedule deleted
 . S PSXAUTO=1 D AUTOMSG^PSXMSGS,SERV^PSXMISC W !,$S(PSXCS:"",1:"NON-"),"CS New Schedule Sent to CMOP" H 3 ; new/changed schedule to send
 K DTTM
 G EXIT
 ;
ENCS ; entry from auto CS Tasking Option Schedule (future-post *41)
 S PSXCS=1
EN ;Entry from Kernel Option Tasking NON-CS
 S PSXCS=+$G(PSXCS)
 Q:'$D(^PSX(550,"C"))  ;no CMOP selected M xref
 Q:'$D(^PSX(550,"ST","A"))  ;no CMOP selected Regular xref
 S ZTSK=$G(ZTSK),PSXZTSK=ZTSK,PSXCS=+$G(PSXCS)
 ; test if previous job still running
LOCK ; >>>**** LOCK OF FILE 550.1 ****<<<
 L +^PSX(550.1):60 I '$T D RQUEMSG G EXIT ; no lock then reque 30 minutes later
 ;if a lock is obtainable , no transmission is running
TFLAG I $D(^PSX(550,"TR","T")) D  G TFLAG ;clear 'T' flags
 .  D ^PSXRCVRY
 .  N PSXSYS S PSXSYS=$O(^PSX(550,"TR","T",0)) S PSXSTAT="H" D PSXSTAT^PSXRSYU
 ; proceeding to process files
 D SET^PSXSYS Q:$P(PSXSYS,"^",2)=""
 I $D(^PSX(550.2,"AQ")) D EN1^PSXRCVRY
 ; set running task into 550  RUNNING TASK
 K DIC,DIE,DR,DA S DIE=550,DA=+PSXSYS,DR="9////"_$G(ZTSK) D ^DIE K DIC,DIE,DR,DA
 ; proceed tp process, setup variables, call into LOCK^PSXRSUS
 S XX=$S('PSXCS:11,1:12) S THRU=+$$GET1^DIQ(550,+PSXSYS,XX)
 S TPRTDT=DT S:$G(THRU)>0 TPRTDT=$$FMADD^XLFDT(DT,THRU,0,0,0)
 S PSXDIVML=1,PSXFLAG=1,PSXTRANS=1,PSOINST=$P(PSXSYS,"^",2)
 G LOCK^PSXRSUS
 ;
EDTBSCH ; display/edit both schedules as they are interactive with each other
 W @IOF D DSPSCH
 K DIR S DIR(0)="SO^C:Controlled Substance;N:NON-Controlled Substance;",DIR("A")="Edit     CS <C>  or  NON-CS <N> "
 D ^DIR K DIR
 I Y'="C",Y'="N" Q
 N PSXCS
 S PSXCS=$S(Y="C":1,1:0)
 D EDIT
 G EDTBSCH
 ;
EDIT ;Edit scheduling of transmissions and parameter "Number of days to transmit"
 ;schedules must be separated by 2 hours
 S PSXCS=+$G(PSXCS)
 S XX=$S($G(PSXCS):"PSXR SCHEDULED CS TRANS",1:"PSXR SCHEDULED NON-CS TRANS")
 D EDIT^XUTMOPT(XX)
 I '$D(PSXSYS) D SET^PSXSYS
 I +PSXSYS S DIE=550,DR="11",DA=+PSXSYS S:PSXCS DR="12" D ^DIE
 ;check for 2 hour difference
 I $$CHKSCH() Q  ; 2 hour difference satisfied 
 W @IOF,!,"Sorry, there has to be at least 2 hours between the daily transmission runs.",!
 D DELSCH
 W !! K DIR S DIR(0)="E",DIR("A")="The "_$S(PSXCS:"CS",1:"NON-CS")_" schedule has been cleared for RE-EDIT. <cr>" D ^DIR
 Q
 ;
CHKSCH() ;CHECK Task schedules for 2 hour difference
 N PSXCS,CSTSK,CSDATE,CSTHRU,CSHOUR,NCSTSK,NCSDATE,NCSTHRU,NCSHOUR,TSDIF
 S PSXCS=1 D GETSCH
 S CSTSK=+TSK(1),CSDATE=PSXDATE,CSHOUR=PSXHOUR,CSTHRU=THRU
 S PSXCS=0 D GETSCH
 S NCSTSK=+TSK(1),NCSDATE=PSXDATE,NCSHOUR=PSXHOUR,NCSTHRU=THRU
 I NCSTSK,CSTSK I 1
 E  Q 1  ; quit test if either is not scheduled
 S CSDATE=(CSDATE#1)+DT,NCSDATE=(NCSDATE#1)+DT
 S X1=CSDATE,X2=NCSDATE
 I CSDATE>NCSDATE S X1=NCSDATE,X2=CSDATE
 S TSDIF=$$FMDIFF^XLFDT(X2,X1,2)
 ;W ! ZW X1,X2,XX,NCSDATE,CSDATE H 5
 I TSDIF<7200 Q 0
 I TSDIF>79200 Q 0
 Q 1
 ;
DELSCH ;Delete startup time and its pending task
 S PSXCS=+$G(PSXCS)
 S XX=$S($G(PSXCS):"PSXR SCHEDULED CS TRANS",1:"PSXR SCHEDULED NON-CS TRANS")
 D RESCH^XUTMOPT(XX,"@")
 D:'+PSXSYS SET^PSXSYS
 Q
 ;
GETSCH ; get schedule information from Kernel Option Scheduling
 S PSXCS=+$G(PSXCS)
 D:'$D(PSXSYS) SET^PSXSYS
 S XX=$S($G(PSXCS):"PSXR SCHEDULED CS TRANS",1:"PSXR SCHEDULED NON-CS TRANS")
 K TSK D OPTSTAT^XUTMOPT(XX,.TSK) S TSK(1)=$G(TSK(1))
 S (PSXDATE,PSXHOUR,THRU)=""
 S PSXZTSK=+TSK(1),PSXDATE=$P(TSK(1),U,2),PSXHOUR=$P(TSK(1),U,3)
 S XX=$S('PSXCS:11,1:12) S THRU=$$GET1^DIQ(550,+PSXSYS,XX)
 Q
 ;
DSPSCH ;Display schedules for transmissions
 N PSXCS,CSTSK,CSDATE,CSTHRU,CSHOUR,NCSTSK,NCSDATE,NCSTHRU,NCSHOUR
 S PSXCS=1 D GETSCH
 S CSTSK=+TSK(1),CSDATE=PSXDATE,CSHOUR=PSXHOUR,CSTHRU=THRU
 S PSXCS=0 D GETSCH
 S NCSTSK=+TSK(1),NCSDATE=PSXDATE,NCSHOUR=PSXHOUR,NCSTHRU=THRU
 S Y=CSDATE X ^DD("DD") S CSDATE=Y S Y=NCSDATE X ^DD("DD") S NCSDATE=Y
 W !,?25,"CS Transmission",?55,"Non-CS Transmission"
 W !,"Scheduled to Run",?25,CSDATE,?55,NCSDATE
 W !,"Frequency (hrs)",?25,CSHOUR,?55,NCSHOUR
 W !,"Thru days",?25,CSTHRU,?55,NCSTHRU
 W !,"Tasking ID",?25,CSTSK,?55,NCSTSK
 Q
 ;
RQUEMSG ; lock on 550.1 not achieved send transmission requeued message
 S PSXCS=+$G(PSXCS)
 S ZTSAVE("PSXCS")=""
 D NOW^%DTC
 S ZTDTH=$$FMADD^XLFDT(%,,,30)
 S Y=% X ^DD("DD") S DTTM=Y
 S ZTDESC="CMOP "_$S(PSXCS:"",1:"NON-")_"CS AUTO TRANSMISSION REQUEUE"
 S ZTRTN="EN^PSXAUTO",ZTIO=""
 D ^%ZTLOAD
 S XMDUZ="Postmaster",XMSUB=$S($G(PSXCS):"",1:"NON-")_"CS Scheduled Transmission RE-Queued"
 S XMTEXT="TXT("
 S TXT(1,0)="The "_$S($G(PSXCS):"",1:"NON-")_"CS Scheduled Transmission for "_DTTM
 S TXT(2,0)="was re-queued with task # "_ZTSK_" to run again in 30 minutes."
 S TXT(3,0)="It could not obtain a lock on the RX QUEUE file #550.1."
 S TXT(4,0)="That indicates that a transmission was in progress."
 S TXT(5,0)=" "
 S TXT(6,0)="If you are getting this message frequently, please contact your IRM Group"
 D GRP1^PSXNOTE
 ;S XMY(DUZ)=""
 D ^XMD
 Q
EXIT ;
 L -^PSX(550.1)
 D:'$D(PSXSYS) SET^PSXSYS
 S PSXSTAT="H" D PSXSTAT^PSXRSYU
 K TIME,STDATE,NUM,X,Y,FREQ,PSXZTSK,START,ZTSK,%,%DT,DTE,LCNT,LL,N,RECD,RR,SITE,XMDUN,XMDUZ,XMSUB,XMZ,PSXDUZ,PSXAUTO,PSXDATE,PSXHOUR,DTTM
 K ZTSAVE,ZTDESC,ZTRTN,ZTIO,ZTREQ,ZTDTH,SDATE,DIR,DIRUT,DUOUT,DTOUT
 K PSXSYS,DIROUT,THRU,NEXT,RE,PSXLOCK,XX,PSXXDIV
 S ZTREQ="@"
 Q
STOPET ; set a stop auto-error-trap node
 S ^XTMP("PSXAUTOERR")=DT_"^"_DT_"^AUTO ERROR TRAP STOP NODE"
 Q
STARTET ; remove any stop node
 K ^XTMP("PSXAUTOERR")
 Q
