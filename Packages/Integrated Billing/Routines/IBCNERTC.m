IBCNERTC ;AITC/HN - Covered by Health Insurance ;03-MAR-2017
 ;;2.0;INTEGRATED BILLING;**593,822**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will loop through the ACHI Index of the Patient (2) file to update the 
 ;  Covered by Health Insurance (2.3192) field based on current active policies.
 ;
 ;  This option is designed to run through TaskMan after midnight.  It shouldn't take long since there
 ;  should not be many entries in the ACHI index per day.
 ;
 ;  UPATF should be used with care since it will process the entire Patient File
 ;
 Q
 ;
EN(IBDT) ;From Taskman nightly job.  Call from label TASK.
 N DFN
 S DFN=""
 F  S DFN=$O(^DPT("ACHI",IBDT,DFN)) Q:'DFN  D INS(DFN,IBDT)
 Q
 ;
INS(DFN,IBDT) ;Check insurance
 N DA,DIE,IBCOV,IBIND,IBINS,IBNCOV,DR,IBINSD,IENS,EFFDT,IBIENS,DEFIND,IBIEN,IBSYM
 S (IBCOV,IBNCOV)=$$GET1^DIQ(2,DFN_",","COVERED BY HEALTH INSURANCE?","I")
 D ALL^IBCNS1(DFN,"IBINS",2,IBDT) S IBINSD=+$G(IBINS(0))
 ;
 ; -- initial value ="" or Unknown
 I $TR(IBCOV,"U","")']"" S IBNCOV=$S('$O(^DPT(DFN,.312,0)):"U",IBINSD:"Y",1:"N")
 ; -- initial value = YES or NO (treat the same)
 I "YN"[IBCOV S IBNCOV=$S('$O(^DPT(DFN,.312,0)):"N",IBINSD:"Y",1:"N")
 ;
 I IBCOV'=IBNCOV S DIE="^DPT(",DR=".3192///"_IBNCOV,DA=DFN D ^DIE
 ;
 ; Create Buffer entry for those whose Effective Date = IBDT
 ;
 S DA=0 F  S DA=$O(IBINS(DA)) Q:'DA  D
 . S IBIEN=+IBINS(DA,0)
 . S IBIENS=DA_","_DFN_","
 . S EFFDT=$$GET1^DIQ(2.312,IBIENS,8,"I")
 . I EFFDT'=IBDT Q
 . ; Add check to see if already in buffer
 . S DEFIND=$$BFEXIST(DFN,IBIEN) Q:DEFIND=1
 . S IBSYM=$P($$INSERROR^IBCNEUT3("I",IBIEN),"^",1)
 . D PT^IBCNEBF(DFN,DA,IBSYM,,1)
 Q
 ;
UPATF ;Update the entire Patient File
 ; This should be tasked for late evening since it will take awhile to run.
 N DFN,IENS
 S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . D INS(DFN,DT)
 Q
 ;
BFEXIST(DFN,INSNAME) ; Function returns 1 if an Entered Ins Buffer File 
 ; entry exists with the same DFN and INSNAME, otherwise it returns a 0
 ;
 ; DFN - Patient DFN
 ; INSNAME - Insurance Company Name File 36 - Field .01
 ;
 NEW EXIST,IEN,EDATE
 S EXIST=0
 S INSNAME=$P($G(^DIC(36,IBIEN,0)),U) ;$$TRIM^XLFSTR(INSNAME)  ; trimmed
 I ('DFN)!(INSNAME="") G BFEXIT
 ;
 S IEN=0
 F  S IEN=$O(^IBA(355.33,"C",DFN,IEN)) Q:'IEN!EXIST  D
 .  ; Quit if status is NOT 'Entered'
 .  I $$GET1^DIQ(355.33,IEN_",","STATUS","I")'="E" Q
 .  ; Quit if Ins Buffer Ins Co Name (trimmed) is NOT EQUAL to 
 .  ;  the Ins Co Name parameter (trimmed)
 .  I $$TRIM^XLFSTR($$GET1^DIQ(355.33,IEN_",","INSURANCE COMPANY NAME"))'=INSNAME Q
 .  ; Quit if Date Enterd Matches
 .  S EDATE=$P($$GET1^DIQ(355.33,IEN_",","DATE ENTERED","I"),".")
 .  I IBDT'=EDATE Q
 .  ; Match found
 .  S EXIST=1
 .  Q
BFEXIT ;
 Q EXIST
 ;
XREF ;Build the "ACHI" cross reference
 N CNT,DA,DFN,FILE,DIK,X,Y
 S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . I $$GET1^DIQ(2,DFN_","_"DATE OF DEATH") Q  ;Patient Deceased
 . S DA(1)=DFN
 . S DIK="^DPT("_DA(1)_",.312,"
 . S DIK(1)="3^ACHI"
 . D ENALL^DIK
 . S DIK(1)="8^ACHI"
 . D ENALL^DIK
 ;
 ;
DBR ; IB*822/DTG run in background the selected insurance patients verified date check
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 ;
 ; run now
 S ZTDTH=$$NOW^XLFDT()
 ;
 ; Set up the other TaskManager variables
 S ZTRTN="SPEC^IBCNERTC"
 S ZTSAVE("IBBINSEL")=""
 S ZTDESC="Daily Selected Ins Patient Verify Date Check"
 S ZTIO=""
 D ^%ZTLOAD            ; Call TaskManager
 ;
DBRX ; Exit
 Q
 ;
ER ; Unlock the eIV Nightly Task and return to log error
 L -^TMP("IBCNERTCS")
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZTER
 D UNWIND^%ZTER
 Q
 ;
 ;
SPEC ; IB*822/DTG  run re-verify for Specific Insurances
 ;
 ;
 ;Quit if VAMC Site is MANILA (#358) & EIV is disabled for MANILA.
 I $P($$SITE^VASITE,U,3)=358,$$GET1^DIQ(350.9,"1,",51.33,"I")="N" Q
 ;
 N $ES,$ET
 S $ET="D ER^IBCNERTC"
 ; Check lock
 L +^TMP("IBCNERTCS"):1 I '$T D  G SPECX
 . I '$D(ZTSK) W !!,"The Check of Selected Ins. Patients verified date is already running, please retry later." D PAUSE^VALM1
 ;
 S IBBINSEL=$G(IBBINSEL)
 I IBBINSEL="" D  G SPECX:'IBBINSEL
 . S IBBINSEL=+$$FIND1^DIC(200,,"MX","IB,AUTOINS FILEUPDATE") Q:IBBINSEL
 . I '$D(ZTSK) W !!,"Missing the default proxy user" D PAUSE^VALM1
 ;
 ; process the selected insurance companies
 ;
 N FDA,IBA,IBB,IBC,IBCO,IBCON,IBD,IBER,IBERT,IBFRDY,IBFRSHDY,IBI,IBINIEN,IBINST,IBLEN,IBPLAN
 N IBPTDFN,IBPTINIE,IBPTRINS,IBRET,IBRETURN,IBTDT,IBUSER
 ;
 S IBFRSHDY=$$GET1^DIQ(350.9,"1,",51.01,"I")
 S IBRETURN="^TMP(""IBCNERTCA"","_$J_")",IBER="IBERT"
 ;
 F IBI=1:1 S IBCON=$P($T(SPECLST+IBI),";;",2) Q:IBCON=""  D SPECP
 ;
 G SPECX
 ;
 Q
 ;
SPECX ; Purge task record - if queued
 K ^TMP("IBCNERTCA",$J)
 L -^TMP("IBCNERTCS")
 Q
 ;
SPECLST ; list of specified Insurance Companies
 ;;US DEPART OF LABOR MED DFEC
 ;;US DEPT OF LABOR MED DCMWC
 ;;US DEPT OF LABOR MED DEEOIC
 ;;US DEPART OF LABOR PHARM DFEC
 ;;US DEPT OF LABOR PHARM DCMWC
 ;;US DEPT OF LABOR PHARM DEEOIC
 ;;CAMP LEJEUNE (WNR)
 ;;IVF - WNR
 ;;VHA DIRECTIVE 1029 WNR
 ;;REGIONAL COUNSEL (02)
 ;;OFFICE OF REGIONAL COUNSEL
 ;;
 ;
SPECP ; process insurance name
 ;
 N IBCHKDT,IBOK
 ;get insurance IENs for name from B cross
 S IBTDT=$$NOW^XLFDT  ; set the file time for each insurance company
 S IBINIEN=0 F  S IBINIEN=$O(^DIC(36,"B",IBCON,IBINIEN)) Q:'IBINIEN  D
 . S IBINST=+$$GET1^DIQ(36,IBINIEN_",",.05,"I") I IBINST Q  ; only process active Insurance Co's with that name
 . ; get the list of patients who are: 1) active ins co,  (2) active plans,
 . ; (3) patient is active
 . K @IBRETURN,@IBER
 . ;
 . D INSSUB^IBCNINSU(IBINIEN,.IBRETURN,.IBER)
 . S IBA=$G(@IBER) I IBA'="" Q  ; error on lookup
 . I '$D(@IBRETURN) Q  ; no data returned
 . ;
 . S IBTDT=$$NOW^XLFDT  ; set the file date/time for each insurance company
 . ;
 . ; now we have the data in IBRETURN
 . ; structure is ^TMP("IBCNERTCA",$J,Ins IEN,Plan IEN, PT DFN, PT (2.312) insurance IEN)
 . ; IBINIEN is already set
 . K IBA
 . ; IBRETURN="^TMP(""IBCNERTCA"","_$J_")"
 . S IBPLAN=0 F  S IBPLAN=$O(^TMP("IBCNERTCA",$J,IBINIEN,IBPLAN)) Q:'IBPLAN  D
 .. S IBPTDFN=0 F  S IBPTDFN=$O(^TMP("IBCNERTCA",$J,IBINIEN,IBPLAN,IBPTDFN)) Q:'IBPTDFN  D
 ... S IBPTINIE=0 F  S IBPTINIE=$O(^TMP("IBCNERTCA",$J,IBINIEN,IBPLAN,IBPTDFN,IBPTINIE)) Q:'IBPTINIE  D
 ... . ;
 ... . S IBA=$G(^TMP("IBCNERTCA",$J,IBINIEN,IBPLAN,IBPTDFN,IBPTINIE)),IBPTRINS=IBPTINIE_","_IBPTDFN_","
 ... . ; verify
 ... . S IBD=$$GET1^DIQ(2.312,IBPTRINS,"1.03","I")  ; last verified date
 ... . ;
 ... . I +IBFRSHDY&($P(IBD,".",1)'=""&($$FMDIFF^XLFDT(DT,$P(IBD,".",1),1)<IBFRSHDY)) Q  ; the verify dt difference is less than fresh days
 ... . ;
 ... . K FDA S IBTDT=$$NOW^XLFDT
 ... . S FDA(2.312,IBPTRINS,1.03)=IBTDT
 ... . S FDA(2.312,IBPTRINS,1.04)=IBBINSEL  ; proxy user IB,AUTOINS FILEUPDATE
 ... . S FDA(2.312,IBPTRINS,1.05)=IBTDT
 ... . S FDA(2.312,IBPTRINS,1.06)=IBBINSEL  ; proxy user IB,AUTOINS FILEUPDATE
 ... . D FILE^DIE("","FDA")
 ... . K FDA
 ;
 Q
 ;
