RGEVPRG ;BAY/ALS-OPTIONS TO PURGE MPI/PD EXCEPTIONS ;08/23/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**3,12,19,32,35,43,44,50,52**;30 Apr 99;Build 2
 ;
MAIN ;
 ;Q:($D(^TMP("RGEXC")))!($D(^TMP("RGEXC2")))
 L +^RGHL7(991.1):0 I '$T Q
 L -^RGHL7(991.1)
 L +^RGHL7(991.1,"RG PURGE EXCEPTION"):5 E  Q
 I $D(ZTQUEUED) S ZTREQ="@"
 S $P(^RGSITE(991.8,1,"EXCPRG"),"^",1)=$$NOW^XLFDT
 S $P(^RGSITE(991.8,1,"EXCPRG"),"^",3)="R"
 ;D PROC  ;**52 Module is obsolete
 D PRGDUP
 D PRG30
 D PRGZZ
 S $P(^RGSITE(991.8,1,"EXCPRG"),"^",2)=$$NOW^XLFDT
 S $P(^RGSITE(991.8,1,"EXCPRG"),"^",3)="C"
 L -^RGHL7(991.1,"RG PURGE EXCEPTION")
 Q
PRGPAT ;Purge by Patient
 W !
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: "
 D ^DIC K DIC G:Y<0 QUIT  S RGDFN=+Y
 S EXCT="",FLAG=0
 F  S EXCT=$O(^RGHL7(991.1,"ADFN",EXCT)) Q:EXCT=""  D
 . I $D(^RGHL7(991.1,"ADFN",EXCT,RGDFN)) S FLAG=1 Q
 I FLAG=0 W !,"There are no exceptions on file for this patient." G PRGPAT
 I $$IFLOCAL^MPIF001(RGDFN) W !,"This patient does not have a national ICN assigned, do not purge." Q
 S DFN=RGDFN D DEM^VADPT
 S DIR(0)="YA",DIR("B")="YES"
 S DIR("A")="Are you sure you want to purge all exceptions on file for "_VADM(1)_"?   YES//  "
 D ^DIR Q:$D(DIRUT)  I Y>0 D
 . S EXCT="",CNT=0
 . F  S EXCT=$O(^RGHL7(991.1,"ADFN",EXCT)) Q:'EXCT  D
 .. S IEN=0
 .. F  S IEN=$O(^RGHL7(991.1,"ADFN",EXCT,RGDFN,IEN)) Q:'IEN  D
 ... S IEN2=0
 ... F  S IEN2=$O(^RGHL7(991.1,"ADFN",EXCT,RGDFN,IEN,IEN2)) Q:'IEN2  D
 .... S NUM="" S NUM=$P(^RGHL7(991.1,IEN,1,0),"^",4)
 .... I NUM=1 S DIK="^RGHL7(991.1,",DA=IEN D ^DIK K DIK,DA S CNT=CNT+1
 .... E  I NUM>1 D DEL
 . W !,"All exceptions purged for "_VADM(1)_"   DFN: "_RGDFN
 K EXCT,DFN,FLAG,VADM,CNT,IEN,IEN2,NUM,RGDFN,Y
QUIT Q
 ;
PRGDT ; Purge by Date
 W !!,"Enter a date for the purge. All exceptions on file, on or before that date, will be deleted."
 K DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="DA^:DT:EPX",DIR("A")="Enter Date for Purge: "
 D ^DIR K DIR Q:$D(DIRUT)
 S PURDT=Y
 S PDATE=$$FMTE^XLFDT(PURDT)
 S DIR(0)="YA",DIR("B")="YES"
 S DIR("A")="Are you sure you want to purge all exceptions on file dated on or before "_PDATE_"?  YES//  "
 D ^DIR Q:$D(DIRUT)  I Y>0 D
 . S EXCDT="",CNT=0
 . F  S EXCDT=$O(^RGHL7(991.1,"AD",EXCDT)) Q:'EXCDT  D
 .. I ($P(EXCDT,".",1)=PURDT)!($P(EXCDT,".",1)<PURDT) D
 ... S IEN=0
 ... F  S IEN=$O(^RGHL7(991.1,"AD",EXCDT,IEN)) Q:'IEN  D
 .... S NUM="" S NUM=$P($G(^RGHL7(991.1,IEN,1,0)),"^",4) Q:NUM<1
 .... S CNT=CNT+NUM
 .... S DIK="^RGHL7(991.1,",DA=IEN
 .... D ^DIK K DIK,DA
 I CNT=0 W !,"There are no exceptions dated on or before "_PDATE_", no data to purge."
 E  I CNT>0 W !,CNT_" exceptions, dated on or before "_PDATE_" have been purged!"
 K PDATE,PURDT,EXCDT,CNT,IEN,NUM,Y
 Q
PRG30   ; Purge Exceptions over 30 days old
 S TODAY=""
 S TODAY=$$NOW^XLFDT D
 . S EXCDT="",CNT=0,DIFF=""
 . F  S EXCDT=$O(^RGHL7(991.1,"AD",EXCDT)) Q:'EXCDT  D
 .. S DIFF=$$FMDIFF^XLFDT(TODAY,EXCDT)
 .. I DIFF>30 D
 ... S IEN=0
 ... F  S IEN=$O(^RGHL7(991.1,"AD",EXCDT,IEN)) Q:'IEN  D
 .... S NUM="" S NUM=$P($G(^RGHL7(991.1,IEN,1,0)),"^",4) Q:'NUM
 .... S IEN2=0
 .... F  S IEN2=$O(^RGHL7(991.1,IEN,1,IEN2)) Q:'IEN2  D
 ..... S STAT=""
 ..... S STAT=$P(^RGHL7(991.1,IEN,1,IEN2,0),"^",5)
 ..... ; Only delete PROCESSED exceptions
 ..... I (STAT>0)!(STAT="") D
 ...... I NUM>1 D DEL
 ...... E  I NUM=1 D
 ....... S CNT=CNT+NUM
 ....... S DIK="^RGHL7(991.1,",DA=IEN
 ....... D ^DIK K DIK,DA
 K DIFF,TODAY,EXCDT,CNT,IEN,IEN2,NUM,STAT
 Q
PRGEXC ; Purge by Exception Type
 ;**52 This module was obsolete before 52; just adding comment
 ;S DIC="^RGHL7(991.11,",DIC(0)="QEAM"
 ;S DIC("A")="Enter an exception type to purge: "
 ;D ^DIC K DIC G:Y<200 QUIT  S EXCTYP=+Y,ETYPE=X
 ;S DIR(0)="YA",DIR("B")="YES"
 ;S DIR("A")="*WARNING* This will permanently delete all "_ETYPE_" exceptions. Are you sure you want to do this?  YES//  "
 ;D ^DIR Q:$D(DIRUT)  I Y>0 D
 ;. S CNT=0,IEN=""
 ;. F  S IEN=$O(^RGHL7(991.1,"AC",EXCTYP,IEN)) Q:'IEN  D
 ;.. S IEN2=0
 ;.. F  S IEN2=$O(^RGHL7(991.1,"AC",EXCTYP,IEN,IEN2)) Q:'IEN2  D
 ;... S NUM="" S NUM=$P(^RGHL7(991.1,IEN,1,0),"^",4)
 ;... I NUM=1 S DIK="^RGHL7(991.1,",DA=IEN D ^DIK K DIK,DA S CNT=CNT+1
 ;... E  I NUM>1 D DEL
 ;I CNT=0 W !,"There are no "_ETYPE_" exceptions on file."
 ;E  I CNT>0 W !,CNT_" "_ETYPE_" Exceptions purged!"
 ;K ETYPE,CNT,IEN,IEN2,NUM,X,Y
 Q  ;**52;if module accidentally called, should quit instead of falling into next module.
PRGDUP ;Purge Duplicate Entries; retain most recent for all except types.
 ;**50 through remainder of module.
 S EXCTYP="",CNT=0
 K ^TMP("RGEVDUP",$J)
 F  S EXCTYP=$O(^RGHL7(991.1,"ADFN",EXCTYP)) Q:'EXCTYP  D
 . S RGDFN=""
 . F  S RGDFN=$O(^RGHL7(991.1,"ADFN",EXCTYP,RGDFN)) Q:'RGDFN  D
 .. S IEN=0
 .. F  S IEN=$O(^RGHL7(991.1,"ADFN",EXCTYP,RGDFN,IEN)) Q:'IEN  D
 ... S IEN2=0
 ... F  S IEN2=$O(^RGHL7(991.1,"ADFN",EXCTYP,RGDFN,IEN,IEN2)) Q:'IEN2  D
 .... I $P($G(^RGHL7(991.1,IEN,1,IEN2,0)),"^",5)=1 K ^RGHL7(991.1,"ADFN",EXCTYP,RGDFN,IEN,IEN2) Q  ;exception processed
 .... S EXCDT=$P($G(^RGHL7(991.1,IEN,0)),"^",3) ;incoming date
 .... I '$D(^TMP("RGEVDUP",$J,RGDFN,EXCTYP)) D  Q
 ..... S ^TMP("RGEVDUP",$J,RGDFN,EXCTYP)=EXCDT_"^"_IEN_"^"_IEN2
 .... I $D(^TMP("RGEVDUP",$J,RGDFN,EXCTYP)) D  ;duplicate exists; compare incoming to previous.
 ..... S OLDNODE=^TMP("RGEVDUP",$J,RGDFN,EXCTYP)
 ..... S OLDDT=$P(OLDNODE,"^"),OLDIEN=$P(OLDNODE,"^",2),OLDIEN2=$P(OLDNODE,"^",3)
 ..... I EXCDT>OLDDT D  Q  ;incoming date greater than previous? purge old, keep new.
 ...... S NUM="" S NUM=$P(^RGHL7(991.1,IEN,1,0),"^",4)
 ...... I NUM=1 S DIK="^RGHL7(991.1,",DA=OLDIEN D ^DIK K DIK,DA
 ...... I NUM>1 D
 ....... S DA(1)=OLDIEN,DA=OLDIEN2
 ....... S DIK="^RGHL7(991.1,"_DA(1)_",1," D ^DIK K DIK,DA
 ...... S ^TMP("RGEVDUP",$J,RGDFN,EXCTYP)=EXCDT_"^"_IEN_"^"_IEN2
 ..... ;
 ..... I OLDDT>EXCDT!(OLDDT=EXCDT) D  ;previous date greater or equal incoming? purge new, keep old.
 ...... S NUM="" S NUM=$P(^RGHL7(991.1,IEN,1,0),"^",4)
 ...... I NUM=1 S DIK="^RGHL7(991.1,",DA=IEN D ^DIK K DIK,DA
 ...... I NUM>1 D DEL
 ...... ;
 K CNT,EXCDT,EXCTYP,IEN,IEN2,NUM,OLDDT,OLDIEN,OLDIEN2,OLDNODE,RGDFN,RGDT,^TMP("RGEVDUP")
 Q
 ;
PRGZZ ;Purge if name field is null (incomplete record)
 ;Purge if -9 node exists, this indicates the record has been merged.
 S EXCTYP="",CNT=""
 F  S EXCTYP=$O(^RGHL7(991.1,"ADFN",EXCTYP)) Q:'EXCTYP  D
 . S RGDFN=""
 . F  S RGDFN=$O(^RGHL7(991.1,"ADFN",EXCTYP,RGDFN)) Q:'RGDFN  D
 .. S IEN=0
 .. F  S IEN=$O(^RGHL7(991.1,"ADFN",EXCTYP,RGDFN,IEN)) Q:'IEN  D
 ... S IEN2=0
 ... F  S IEN2=$O(^RGHL7(991.1,"ADFN",EXCTYP,RGDFN,IEN,IEN2)) Q:'IEN2  D
 .... S DFN=RGDFN D DEM^VADPT
 .... I VADM(1)=""!($D(^DPT(RGDFN,-9))) D
 ..... S NUM="" S NUM=$P(^RGHL7(991.1,IEN,1,0),"^",4)
 ..... I NUM=1 S DIK="^RGHL7(991.1,",DA=IEN D ^DIK K DIK,DA
 ..... E  I NUM>1 D DEL
 K EXCTYP,RGDFN,DFN,IEN,IEN2,NUM,VADM
 Q
DEL ;
 S CNT=CNT+1
 S DA(1)=IEN,DA=IEN2
 S DIK="^RGHL7(991.1,"_DA(1)_",1,"
 D ^DIK K DIK,DA
 Q
PROC ;Set these exception types to PROCESSED if they have a national ICN
 ;**52 The PROC module is obsolete and is no longer being called.
 ;209 - Required field(s) missing for patient sent to MPI,
 ;227 - Multiple ICNs, 213 - SSN Match Failed, 214 - Name Doesn't Match
 ;S EXCTYP=""
 ;S HOME=$$SITE^VASITE()
 ;F  S EXCTYP=$O(^RGHL7(991.1,"AC",EXCTYP)) Q:'EXCTYP  D
 ;. I (EXCTYP=209)!(EXCTYP=227)!(EXCTYP=213)!(EXCTYP=214) D  ;**43
 ;.. S IEN=0
 ;.. F  S IEN=$O(^RGHL7(991.1,"AC",EXCTYP,IEN)) Q:'IEN  D
 ;... S IEN2=0,ICN="",RGDFN=""
 ;... F  S IEN2=$O(^RGHL7(991.1,"AC",EXCTYP,IEN,IEN2)) Q:'IEN2  D
 ;.... S RGDFN=$P(^RGHL7(991.1,IEN,1,IEN2,0),"^",4) Q:'RGDFN
 ;.... S ICN=+$$GETICN^MPIF001(RGDFN)
 ;.... I $E(ICN,1,3)'=$E($P(HOME,"^",3),1,3)&(ICN>0) D
 ;..... L +^RGHL7(991.1,IEN):10
 ;..... S DA(1)=IEN,DA=IEN2,DR="6///"_1,DIE="^RGHL7(991.1,"_DA(1)_",1,"
 ;..... D ^DIE K DIE,DA,DR
 ;..... L -^RGHL7(991.1,IEN)
 ;K EXCTYP,HOME,ICN,IEN,IEN2,RGDFN
 Q
