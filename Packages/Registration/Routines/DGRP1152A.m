DGRP1152A ;ALB/LEG - REGISTRATION SCREEN 11.5.2/VERIFICATION INFORMATION ;JUN 08, 2020@23:00
 ;;5.3;Registration;**1014**;AUG 13, 1993;Build 42
 ;=======================================================================================
EN(DFN) ;Main entry point to invoke the DGEN CCP DETAIL list
 ; Input  -- DFN      Patient IEN
 D WAIT^DICD
 D EN^VALM("DGEN CCP DETAIL")
 N VALMHDR,VALMBCK,VALMSG,VALMCNT
 Q
 ;
HDR ;Header code
 N DGDOB,DGPTYPE,DGSSNSTR,DGSSN
 N DGBLANKS,DGMEMID,DGNAME,DGPREFNM,DGPTYPE,DGTMP
 K VALMHDR
 S DGDOB=$$GET1^DIQ(2,DFN,.03,"I")
 S DGDOB=$$UP^XLFSTR($$FMTE^XLFDT($E(DGDOB,1,12),1))
 S DGSSNSTR=$$SSNNM^DGRPU(DFN)
 S DGSSN=$P($P(DGSSNSTR,";",2)," ",3)
 S DGPTYPE=$$GET1^DIQ(391,$$GET1^DIQ(2,DFN_",",391,"I")_",",.01)
 S:DGPTYPE="" DGPTYPE="PATIENT TYPE UNKNOWN"
 S VALMHDR(1)=$P(DGSSNSTR,";",1)_$S($$GET1^DIQ(2,DFN,.2405)'="":" ("_$$GET1^DIQ(2,DFN,.2405)_")",1:"")_"    "_DGDOB
 S VALMHDR(2)=$S($P($P(DGSSNSTR,";",2)," ",2)'="":$E($P($P(DGSSNSTR,";",2)," ",2),1,40)_"    ",1:"")_DGSSN_"    "_DGPTYPE
 S VALMHDR(3)=$J("",5)_"CCP Name"_$J("",20)_"Effective Date"
 Q
 ;
INIT ;Build patient Collateral screen
 D CLEAN^VALM10
 D CLEAR^VALM1
 D TMP^DGRP1152U(.DGTMP)
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K DGTMP,^TMP("VALM DATA",$J)
 Q
 ;
PEXIT ;DGEN CCP MENU protocol exit code
 ;Reset after page up or down
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HELP ; Invoked from HELP CODE in List Template [DGEN CCP DETAIL] 
 S X="?" D DISP^XQORM1
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
ACT(DGACT) ; Entry point for menu action selection
 ; INPUT: DGACT = "A" - Add - DGEN CCP ADD protocol
 ;              = "E" - Edit - DGEN CCP EDIT protocol
 ;              = "R" - Remove - DGEN CCP REMOVE protocol
 N DGX,DA,DIE,DIC,DIK,DIPA,DR
 I $G(DGACT)="" G ACTQ
 ; DGRPV represents the "VIEW" or "EDIT" status that is created in routine DGRPV
 I $G(DGRPV) D FULL^VALM1 W !,"View only. This action cannot be selected." D PAUSE^VALM1 G ACTQ
 D FULL^VALM1
 I DGACT="A" D ADD,ACTQ Q
 I DGACT="E" D EDIT,ACTQ Q
 I DGACT="R" D REMOVE,ACTQ Q
 Q
 ;
ACTQ ; menu action exit point 
 S VALMBCK="R"
 D TMP^DGRP1152U(.DGTMP)
 Q
 ;
ADD ; Add new CCP to #1910 sub-file
 N DGCCPCD,DGEFFDT
 I '$$ADASKCCP(.DGCCPCD) Q
 I '$$ADASKEFDT(DGCCPCD,.DGEFFDT) Q
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT,DGCCPNM
 S DGCCPNM=$$EXTERNAL^DILFD(2.191,1,"",DGCCPCD)
 S DIR(0)="Y",DIR("A")="Are you adding '"_DGCCPNM_"' as a new CCP",DIR("B")="NO"
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!'Y Q
 D SAVREC(DFN,DGCCPCD,DGEFFDT) ;saves new record
 Q
 ;
EDIT ;EDIT EXISTING CCP
 N DGSEL,DGORIGIDX,DGORIGREC,DGCCPCD,DGEFFDT
 S DGSEL=$$SELECT("E",.DGORIGIDX,.DGORIGREC) Q:'DGSEL
 I '$$EDASKCCP(DGORIGIDX,.DGCCPCD) Q
 I '$$EDASKEFDT(DGORIGIDX,DGORIGREC,DGCCPCD,.DGEFFDT) Q
 D SAVREC(DFN,DGCCPCD,DGEFFDT) ;saves new record
 D SAVENDT(DGORIGIDX) ; set END DATE into originally edited record
 Q
 ;
REMOVE ;REMOVE EXISTING CCP
 N DGSEL,DGORIGIDX
 S DGSEL=$$SELECT("R",.DGORIGIDX) Q:'DGSEL
 N DIR,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S DIR(0)="Y",DIR("A")="Are you sure you want to remove this CCP entry",DIR("B")="NO"
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!'Y Q
 D SAVENDT(DGORIGIDX) ; set END DATE into removed record
 Q
 ;
SELECT(DGACT,DGORIGIDX,DGORIGREC) ;
 ; Input:   DGACT - "E"dit or "R"emove
 ; Output:  DGORIGIDX - (Pass by reference) The entry number of the selected CCP
 ;          DGORIGREC - (Pass by reference) The fields of the selected CCP
 ; Returns the entry number selected
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,DGRECS,DGSEL
 S DGRECS=$O(DGTMP("IDX",""),-1)
 I 'DGRECS D  Q 0
 . W !,"There are no entries to "_$S(DGACT="E":"edit.",1:"remove.")
 . D PAUSE^VALM1
 S DIR(0)="NA^1:"_DGRECS_":0"
 S DIR("A",1)="",DIR("A")="Select Entry (1-"_DGRECS_"): " D ^DIR K DIR
 S DGSEL=Y
 I $D(DTOUT)!$D(DUOUT) Q 0
 ; translate the display [num] to the ^DPT(DFN,5,IDX)
 S DGORIGIDX=$O(DGTMP("IDX",DGSEL,"")),DGORIGREC=^DPT(DFN,5,DGORIGIDX,0)
 Q DGSEL
 ;
ADASKCCP(DGCCPCD) ; Prompts for CCP to be ADDed 
 ; Output: DGCCPCD - CCP Code to be added (Pass by Reference)
 ; Returns - TRUE if valid CCP entered
 ;
 N DIR,DTOUT,DUOUT,DGGOOD,Y,X
L1 ; Tag to call for re-prompting
 S DIR(0)="2.191,1,A,O^^"
 S DIR("A")="Add CCP: "
 D ^DIR
 K DIR
 I $D(DUOUT)!$D(DTOUT) Q 0
 I Y="" Q 0
 S DGCCPCD=Y
 D CHKMULT1(DFN,DGCCPCD,.DGGOOD)
 I 'DGGOOD W "  ** Already have this CCP on file." G L1
 Q 1
 ;
EDASKCCP(DGORIGIDX,DGCCPCD) ; ASK EDIT CCP
 ; Input:  DGORIGIDX - Entry number of the CCP selected for edit
 ; Output: DGCCPCD - The CCP Code that has been entered {Pass by Reference)
 ; Returns: TRUE is edit of the CCP was successful
 ;
 N DIR,DGENTRY,DTOUT,DUOUT,DGGOOD,X,Y
L2 ; Tag to call for re-prompting
 S DIR("B")=$$GET1^DIQ(2.191,DGORIGIDX_","_DFN_",",1)
 S DIR(0)="2.191,1,A,r^^"
 S DIR("A")="CCP: "
 D ^DIR
 K DIR
 I $D(DUOUT)!$D(DTOUT) Q 0
 S DGCCPCD=Y
 D CHKMULT1(DFN,DGCCPCD,.DGGOOD)
 I 'DGGOOD W "  ** Already have this CCP on file." G L2
 Q 1
 ;
ADASKEFDT(DGCCPCD,DGEFFDT) ; ASK ADD EFFECTIVE DATE AND IF VALID SAVE
 ; Input: DGCCPCD - CCP Code associated with the effective date
 ; Outut: DGEFFDT - Effective date entered for this CCP (Pass by Reference)
 ; Returns TRUE if valid effective date added for this CCP
 ;
 N DIR,DTOUT,DUOUT,Y,X,DGGOOD,DGEXDT,X,Y
 ; Sets DGEFFDT for the CCP to be added
 ;
L3 ; Tag to call for re-prompting
 S DIR(0)="2.191,2,A^^"
 S DIR("A")="Enter EFFECTIVE DATE: "
 S DIR("B")="T"
 K X,Y
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) Q 0
 I +Y<1 Q 0
 I Y,$L(Y(0))=10 S Y(0)=$P(Y(0)," ")_" 0"_$P(Y(0)," ",2)
 S DGEFFDT=Y,DGEXDT=Y(0)
 I '$L(DGEXDT) W:Y<0 "  '"_X_"' is not a valid date." G L3
 D CHKMULT2(DFN,DGCCPCD,DGEFFDT,.DGGOOD)
 I 'DGGOOD D MULTERR^DGRP1152U G L3
 Q 1
 ; 
EDASKEFDT(DGORIGIDX,DGORIGREC,DGCCPCD,DGEFFDT) ; ASK EFFECTIVE DATE AND IF VALID SAVE
 ; Input:  DGORIGIDX - Entry number of the CCP selected for edit
 ;         DGORIGREC - The fields of the selected CCP (0 node)
 ;         DGCCPCD - CCP code for the associated Effective Date
 ; Input:  DGEFFDT - Updated Effective Date (Pass by reference)
 ; Returns: TRUE is edit of Effective Date was successful
 ;
 N DIR,DTOUT,DUOUT,Y,X,DGGOOD,DGEXDT
L4 ; Tag to call for re-prompting
 S DIR(0)="2.191,2,A,r^^"
 S DIR("A")="Enter EFFECTIVE DATE: "
 S DIR("B")=$$GET1^DIQ(2.191,DGORIGIDX_","_DFN_",",2)
 K X,Y
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) Q 0
 I +Y<1 Q 0
 I Y,$L(Y(0))=10 S Y(0)=$P(Y(0)," ")_" 0"_$P(Y(0)," ",2)
 S DGEFFDT=Y,DGEXDT=Y(0)
 I '$L(DGEXDT) W:Y<0 "  '"_X_"' is not a valid date." G L4
 ; If the edited CCP/Date matches the original CCP/Date quit - no changes
 I (DGCCPCD_"^"_DGEFFDT)=$P(DGORIGREC,U,2,3) Q 0
 D CHKMULT2(DFN,DGCCPCD,DGEFFDT,.DGGOOD)
 I 'DGGOOD D MULTERR^DGRP1152U G L4
 Q 1
 ;
CHKMULT1(DFN,DGCCP,DGGOOD) ; checks for disallowed 'A' or 'I' multiples
 ; Input:  DFN
 ;         DGCCCP - The CPP code to check
 ; Output: DGGOOD - (Pass by Reference) - TRUE if OK
 ;
 N DGI,DGTIDX,DGTREC,DGTCCP,DGTENDT
 S DGGOOD=1
 I $L(DGCCP)'=1 Q
 ; checks for duplicate CCP if "ART/IVF" or "NEWBORN"
 I "AI"[DGCCP D  Q
 . S DGTIDX=0,DGI=""
 . F  S DGI=$O(DGTMP("IDX",DGI)) Q:'DGI  S DGTIDX=$O(DGTMP("IDX",DGI,"")) Q:'DGTIDX  I DGI'=$G(DGSEL) S DGTREC=$G(DGTMP("IDX",DGI,DGTIDX)) Q:DGTREC=""  D  Q:'DGGOOD
 . . S DGTCCP=$P(DGTREC,U,2),DGTENDT=$P(DGTREC,U,4)
 . . I DGTCCP=DGCCP,'DGTENDT S DGGOOD=0
 Q
 ;
CHKMULT2(DFN,DGCCP,DGFMDT,DGGOOD) ; checks for disallowed same CCP with same EFFECTIVE DATE
 ; Input:  DFN
 ;         DGCCCP - The CPP code to check
 ;         DGFMDT - Effective Date to check (Fileman format)
 ; Output: DGGOOD - (Pass by Reference) - TRUE if OK
 ;
 N DGTIDX,DGTCCP,DGTENDT,DGTREC
 S DGGOOD=1
 I $L(DGCCP)'=1 Q
 ; checks for duplicate date for same CCP
 I "?CT"[DGCCP,DGFMDT D
 . S DGTIDX=""
 . F  S DGTIDX=$O(DGTMP("EFDT",DGFMDT,DGTIDX)) Q:'DGTIDX  D  Q:'DGGOOD
 . . S DGTREC=DGTMP("EFDT",DGFMDT,DGTIDX)
 . . S DGTCCP=$P(DGTREC,U,2)
 . . S DGTENDT=$P(DGTREC,U,4)
 . . I DGTCCP=DGCCP,'DGTENDT S DGGOOD=0
 Q
 ;
SAVREC(DFN,DGCCPCD,DGEFFDT) ;save newly ADDed or EDITed record
 ;
 ; If this combination of Code and Effective date already exists in an End-Dated record, it will be reactivated
 I $$SAVEXIST(DFN,DGCCPCD,DGEFFDT) Q
 ; Otherwise, save a new record
 N %,Y,X,DGERR,DGIENS,DGFDA
 S DGERR=0
 S DGIENS=DFN_","
 S DGIENS="+1,"_DGIENS
 D NOW^%DTC
 S DGFDA(2.191,DGIENS,.01)=%
 S DGFDA(2.191,DGIENS,1)=DGCCPCD
 S DGFDA(2.191,DGIENS,2)=DGEFFDT
 D UPDATE^DIE("","DGFDA","","DGERR")
 I DGERR W " **UNABLE TO SAVE**"
 Q
 ;
SAVEXIST(DFN,DGCCP,DGFMDT) ; Check for an existing CCP record to be saved
 ; Checks for a matching CCP/EFFECTIVE DATE record among the End Dated CCPs. If found, reuse it (Remove the end date)
 ; Inputs:  DFN - Patient DFN
 ;          DGCCP - CCP Code
 ;          DGFMDT - CCP Effective date
 ; Returns: The Entry number of the reactivated CCP if found or NULL
 ;
 N DGTIDX,DGTCCP,DGTENDT,DGTREC,DGEXIST,DGERR,DGFDA
 I $L(DGCCP)'=1!('DGFMDT) Q ""
 ; For the effective date, check for a matching CCP - (the record should be end dated since there cannot be duplicate effective dates for an active CCP)
 S (DGEXIST,DGTIDX)=""
 F  S DGTIDX=$O(DGTMP("EFDT",DGFMDT,DGTIDX)) Q:'DGTIDX  D  Q:DGEXIST
 . S DGTREC=DGTMP("EFDT",DGFMDT,DGTIDX)
 . ; Don't check archived records
 . I $P(DGTREC,U,5) Q
 . S DGTCCP=$P(DGTREC,U,2)
 . S DGTENDT=$P(DGTREC,U,4)
 . I DGTCCP=DGCCP,DGTENDT'="" D
 . . ; Matching record found
 . . S DGEXIST=DGTIDX
 . . ; Set the LAST DATE UPDATED and Clear the End Date
 . . S DGFDA(2.191,DGTIDX_","_DFN_",",.01)=$$NOW^XLFDT()
 . . S DGFDA(2.191,DGTIDX_","_DFN_",",3)=""
 . . D FILE^DIE("","DGFDA","DGERR")
 Q DGEXIST
 ;
SAVENDT(DGSIDX) ;save END DATE in old rec
 ; Input:  DGSIDX - Entry number of the CCP to set End Date
 ;
 N DGERR,DGFDA,X
 ; CCP LAST UPDATED DATE
 S DGFDA(2.191,DGSIDX_","_DFN_",",.01)=$$NOW^XLFDT()
 ; END DATE 
 D NOW^%DTC
 S DGFDA(2.191,DGSIDX_","_DFN_",",3)=X
 D FILE^DIE("","DGFDA","DGERR")
 Q
