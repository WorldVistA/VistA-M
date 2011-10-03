SDSCUTL ;ALB/JAM/RBS - ASCD Utility Program ; 4/24/07 4:26pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 Q
 ;
TYPE ; Select proper user type based on security key.
 ; called by routines:  SDSCEDT,SDSCLST,SDSCMSR,SDSCRP1,SDSCSSD
 ;     sets variables:  SDTYPE,SDSCTAT,SDOPT,SDSCCR
 ;                      (should be killed by calling routines)
 I $G(SDTYPE)=""!($G(SDSCTAT)="")!($G(SDOPT)="") D
 . I $D(^XUSEC("SDSC SUPER",DUZ)) D  Q
 .. ; Supervisor can look at encounters with any status.
 .. S SDTYPE="S",SDSCTAT="",SDOPT="SA^Y:YES;N:NO;S:SKIP;R:REVIEW"
 .. S SDSCCR=""
 .. Q
 . I $D(^XUSEC("SDSC CLINICAL",DUZ)) D  Q
 .. ; Clinician can only look at encounters with a status of REVIEW.
 .. S SDTYPE="C",SDSCTAT="R",SDOPT="SA^Y:YES;N:NO;S:SKIP;R:REVIEW"
 .. S SDSCCR="I $P(^(0),U,5)=SDSCTAT"
 .. Q
 . ; User (default) can only look at encounters with a status of NEW.
 . S SDTYPE="U",SDSCTAT="N",SDOPT="SA^Y:YES;N:NO;S:SKIP;R:REVIEW"
 . S SDSCCR="I $P(^(0),U,5)=SDSCTAT"
 . Q
 Q
 ;
NBFP(SDOE) ; Is first-party non-billable based on either clinic, stop code, or patient?
 N SDOE0,SDPAT,SDOEDT
 I $G(SDOE)="" Q 0
 S SDOE0=$$GETOE^SDOE(SDOE),SDPAT=$P(SDOE0,U,2),SDOEDT=+SDOE0
 I '+$$FIRST^IBRSUTL(SDOE) Q 1
 Q 0
 ;
NBTP(SDOE) ; Is third-party non-billable based on either clinic, stop code, or patient?
 N SDOE0,SDPAT,SDOEDT,SDCOV
 I $G(SDOE)="" Q 0
 S SDOE0=$$GETOE^SDOE(SDOE),SDPAT=$P(SDOE0,U,2),SDOEDT=+SDOE0
 I '+$$THIRD^IBRSUTL(SDOE) Q 1
 ; ICR#: 4419 (SUPPORTED) - look for Outpatient coverage
 S SDCOV=$S($$INSUR^IBBAPI(SDPAT,SDOEDT,"O","",16)<1:0,1:1)
 I 'SDCOV Q 1
 Q 0
 ;
SENS(SDFN,SDFLG) ; Check for Sensitive Patient
 ; Input
 ;     SDFN  - Patient IEN
 ;     SDFLG - '1' if called from ListMan edit
 ;           - '0' if called from roll-and-scroll
 ;  Returns
 ;     '0' - OK to view (patient is not sensitive, user has key, or answered 'OK')
 ;     '1' - not OK to view patient (patient is sensitive, user does not have key and answered 'NO')
 ;
 N SDANS
 S SDANS=0
 I +$P($G(^DGSL(38.1,+SDFN,0)),U,2) D
 . NEW DIC,Y,DFN,X,VADM
 . S DFN=SDFN D DEM^VADPT
 . I $G(SDFLG)=0 W !!,$E(VADM(1),1,25)_" ("_$E($P(VADM(2),U),6,9)_")",!!
 . I $G(SDFLG)=1 D FULL^VALM1
 . S DIC(0)="AE",Y=SDFN
 . D ^DGSEC
 . I Y<0 S SDANS=1
 . I $D(^XUSEC("DG SENSITIVITY",DUZ)) D
 .. ; If user holds key, prevent sensitive patient warning from scrolling off screen
 .. N DIR W ! S DIR(0)="E" D ^DIR
 .D KVA^VADPT
 Q SDANS
 ;
DIV ;  Ask for Division
 N SDN
 S SDN=0
 F  S SDN=$O(^DG(40.8,SDN)) Q:'SDN  D
 . S DIR("A",SDN)=SDN_"  "_$P(^DG(40.8,SDN,0),"^",1)
 . S SCLN=SDN
 S SCLN=SCLN+1,DIR("A",SCLN)=SCLN_"  ALL"
 S DIR(0)="L^1:"_SCLN,DIR("B")=SCLN
 S DIR("A")="Select DIVISION"
 Q
 ;
SRV ;  Ask for Clinic Service
 N TDIR
 S TDIR="M:MEDICINE;S:SURGERY;P:PSYCHIATRY;R:REHAB MEDICINE;N:NEUROLOGY;0:NONE;"
 S TDIR=TDIR_"A:ALL"
 S DIR(0)="S^"_TDIR,DIR("A")="Select SERVICE"
 Q
 ;
STEDT(SDOE,SDTYPE,SDRFLG,SDSCC) ; Store the TRACK EDITS multiple for encounter
 ;  Input:
 ;    SDOE - Encounter IEN
 ;  SDTYPE - Type of User - (Supervisor, Clinician, User)
 ;  SDRFLG - Review flag var
 ;   SDSCC - visit file service connected value (1/0)
 ;
 ;  Output: none
 ;
 ; First add a new entry to the multiple.
 Q:'$G(SDOE)
 N DD,DO,X,DA,DIC,DIE,DLAYGO,SDIENS,SDPD,SDVBA,ERR
 I '$D(^SDSC(409.48,SDOE,1,0)) S ^SDSC(409.48,SDOE,1,0)="^409.481^^"
 S X=$P(^SDSC(409.48,SDOE,1,0),U,3)+1
 S DA(1)=SDOE,DA=X,DIC="^SDSC(409.48,"_DA(1)_",1,",DIE=DIC
 S DLAYGO=409.481,DIC("P")=DLAYGO,DIC(0)="L"
 K DD,DO
 D FILE^DICN
 K DD,DO
 ; Next update the fields within the multiple.
 S SDIENS=$$IENS^DILF(.DA)
 S SDPD(409.481,SDIENS,.02)=DT
 S SDPD(409.481,SDIENS,.03)=DUZ
 S SDPD(409.481,SDIENS,.04)=$G(SDTYPE)
 ; If user answered "REVIEW", set the review flag to "YES".
 ; Else, set SERV. CONNECT (OK BY USER?) field with current SC status.
 I $G(SDRFLG)=1 S SDPD(409.481,SDIENS,.06)=1
 E  S SDPD(409.481,SDIENS,.05)=$G(SDSCC)
 D FILE^DIE("","SDPD","ERR")
 ;
 ; -- If not "REVIEW" flag,
 ;    Set file;field (#409.48;.09) SERV. CONNECT (OK BY VBA/ICD?)
 ;    equal to the VBA/ICD9 match result.
 I '$G(SDRFLG) D
 . K SDPD,ERR
 . S SDVBA=$$SC^SDSCAPI(,,SDOE)
 . S SDPD(409.48,SDOE_",",.09)=$P(SDVBA,U,3)
 . D FILE^DIE("","SDPD","ERR")
 Q
 ;
CONT ; Standard press RETURN to continue prompt.
 N DIR,X,Y,DTOUT,DUOUT
 S DIR(0)="EA"
 S DIR("A")="Enter RETURN to continue "
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S SDQFLG=1
 W @IOF,!,"Encounter ",SDOE," (cont'd)"
 Q
 ;
ANCPKG(SCEIEN) ;check if visit came from an ancillary package & if to continue
 N PCEIEN,DIR,DA,X,Y
 I '$G(SCEIEN) Q 1
 S PCEIEN=$P($$GETOE^SDOE(SCEIEN),"^",5) I 'PCEIEN Q 1
 I $P($G(^AUPNVSIT(PCEIEN,150)),"^",3)'="A" Q 1
 W $C(7)
 S DIR("A",1)="WARNING: This encounter came from another package. If it is changed"
 S DIR("A",2)="         it will not agree with what is in the originating package."
 S DIR("A",3)="        "
 S DIR("A")="Do you want to continue with this encounter"
 S DIR("B")="YES",DIR(0)="Y"
 D ^DIR
 Q $S(Y:1,Y<0:1,1:0)
NCTCL(SDCLIN) ;Checks if a non-count clinic
 I $P($G(^SC(+SDCLIN,0)),U,17)="Y" Q 1
 Q 0
SCHNG(SDOE) ;Checks if a completed encounter SC value was changed.
 ;Input:  SDOE - Encounter IEN
 ;Output: SC Changed^Orignal Value(1 or 0)^Last Value(1 or 0)
 ;         SC Changed: 0-no change, 1-change
 ;         Null is return if invalid
 N SDVAL,SDORG,SDUSR
 I $G(SDOE)="" Q ""
 S SDVAL=$G(^SDSC(409.48,SDOE,0)) I SDVAL="" Q ""
 I $P(SDVAL,"^",5)'="C" Q ""
 S SDORG=$P(SDVAL,U,13),SDUSR=$P(SDVAL,U,6)
 I SDORG="" S SDORG=1
 Q $S(SDORG=SDUSR:0,1:1)_U_SDORG_U_SDUSR
 ;
LOCK(SCIEN) ;Locks an ASCD record.
 ; This function locks an ASCD so as to prevent another process from 
 ; editing the same record.
 ;  Input:  SCIEN - IEN of record in file #409.48
 ;
 ; Output:  Returns 1 if lock was successful, 0 otherwise
 ;
 I $G(SCIEN) L +^SDSC(409.48,SCIEN):5
 Q $T
 ;
UNLOCK(SCIEN) ;Unlocks an ASCD record.
 ; This function releases the lock on an ASCD record created by $$LOCK.
 ;  Input: SCIEN - IEN of record in file #409.48
 ;
 ; Output: None
 ;
 I $G(SCIEN) L -^SDSC(409.48,SCIEN)
 Q
 ;
SCSEL() ;Prompts for the type of service connection records to review.
 ; Input:  No input required
 ; Output: 1 - SC, 0 - NSC, 2 - All and "" (null)
 N DIR
 W !,"Service Connected Encounters Review Selection"
 S DIR(0)="SO^S:Service Connected;N:Non-Service Connected;A:All"
 S DIR("B")="S",DIR("A")="Which type do you want to review?"
 D ^DIR I $D(DIRUT) Q ""
 Q $S(Y="S":1,Y="N":0,1:2)
