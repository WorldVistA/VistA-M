RCDPEU2 ;AITC/CJE - ELECTRONIC PAYER UTILITIES ;05-NOV-02
 ;;4.5;Accounts Receivable;**326,332,409,436,439**;Mar 20, 1995;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;PRCA*4.5*409 Added AREVTYPE as an optional parameter
EFT344(PROMPT,IEN344,AREVTYPE) ; Select and EFT and update reciept - EP
 ; Input: PROMPT    - Prompt to use when picking an EFT
 ;        IEN344    - Internal entry number to file 344
 ;        AREVTYPE  - AR Event Type IEN (344.1) optional, defaults to null
 ; Output
 N FDA,IEN34431,SCREEN
 S:'$D(AREVTYPE) AREVTYPE=""                    ;PRCA*4.5*409 Added line
 S SCREEN="I '$O(^RCY(344,""AEFT"",+Y,0)),$P($G(^RCY(344.31,+Y,0)),U,8)=0"
 ;
 ;PRCA*4.5*436 Begin
 I AREVTYPE=18 D
 . S SCREEN=SCREEN_",$E($P($G(^RCY(344.31,+Y,0)),U,4),1,3)=""OGC"""
 I AREVTYPE=14 D
 . S SCREEN=SCREEN_",$E($P($G(^RCY(344.31,+Y,0)),U,4),1,3)'=""OGC"""
 ;PRCA*4.5*436 End
 ;
 S IEN34431=$$ASKEFT(PROMPT,SCREEN)
 I IEN34431>0,IEN344 D  ;
 . S FDA(344,IEN344_",",.17)=IEN34431
 . D FILE^DIE("","FDA")
 . I '$D(^TMP("DIERR",$J)) K DIC("W")
 . W !!,IEN34431,!!
 Q
ASKEFT(PROMPT,SCREEN,AREVTYPE) ; Select an EFT for an EDI Lockbox receipt - EP
 ; Input: PROMPT    - Prompt to use when asking user to enter an EFT.
 ;        SCREEN    - Screen for use in file 344.31 look-up
 ;        AREVTYPE  - AR Event Type IEN (344.1) optional, defaults to null
 ; Returns: IEN from file 344.31 or -1 if user times out or '^'
 ;
 N COUNT,DA,DIC,DIR,DIRUT,DIROUT,DTOUT,DUOUT,FIELDS,FILE,FLAGS,IENS,INDEXES,QUIT,RETURN,VALUE,X,Y
 K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 S (RETURN,QUIT)=0
 S FILE=344.31,IENS=""
 S FIELDS=".01;.02;.03;.04;.07;.14"
 S FLAGS="M"
 S INDEXES=""
 F  D  Q:QUIT  ;
 . W !,PROMPT R VALUE:DT
 . I '$T S QUIT=1,RETURN=-1 Q  ; Timeout
 . I VALUE="" S QUIT=1,RETURN=0 Q
 . I $E(VALUE)="^"!(VALUE="") S QUIT=1,RETURN=-1 Q
 . I $E(VALUE)="?" S VALUE=""
 . I VALUE="" D  ;
 . . D LIST^DIC(FILE,"",FIELDS,FLAGS,"*","","","B",SCREEN,"","","")
 . E  D  ;
 . . D FIND^DIC(FILE,"",FIELDS,FLAGS,VALUE,"","",SCREEN,"","","")
 . S COUNT=$P($G(^TMP("DILIST",$J,0)),"^",1)
 . I COUNT=1,VALUE'="" D  Q  ;
 . . S RETURN=+$P($G(^TMP("DILIST",$J,2,1)),"^",1),QUIT=1
 . I COUNT>0 D  ;
 . . S RETURN=$$PICKEFT()
 . . I RETURN>0 S QUIT=1
 Q RETURN
 ;
PICKEFT() ; Given output from FIND^DIC, pick an EFT from the list
 ; Input: ^TMP("DILIST",$J) in non-packed format
 ; Returns: IEN from file 344.31, or 0 if user does not pick an item from the list
 ;
 N CNT,COUNT,QUIT,RETURN
 S COUNT=$P($G(^TMP("DILIST",$J,0)),"^",1)
 S (RETURN,QUIT)=0
 F CNT=1:1:COUNT D  Q:QUIT  ;
 . D WRITE(CNT)
 . I CNT#10=0!(CNT=COUNT) D  Q:QUIT  ;
 . . S RETURN=$$READ(CNT) I RETURN=-1!(RETURN>0) S QUIT=1
 Q RETURN
 ;
READ(LAST) ;
 ; Input: LAST - The last number displayed that can be picked in the number range 1-LAST
 ; Returns: IEN from 344.31 if one is picked, otherwise -1 (^ or timeout) or 0 - nothing picked
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,QUIT,RETURN,VALUE,X,Y
 S RETURN=0
 S DIR(0)="NO^1:"_LAST
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q -1
 I Y,$D(^TMP("DILIST",$J,2,Y)) S RETURN=^TMP("DILIST",$J,2,Y)
 Q RETURN
WRITE(X) ; Write out one entry from 344.31
 ; Input: X=Counter from ^TMP("DILIST",$J) output from FIND^DIC
 ; Output: To screen
 N DEPDAT,DEPNO,EFTID,EFTIEN,EFTTR,PAYAMT,PAYNAM,PAYTR,SP,TIN
 S SP=$J("",3)
 S EFTIEN=$P(^TMP("DILIST",$J,1,X),".")
 S EFTID=^TMP("DILIST",$J,"ID",X,.01)
 S PAYNAM=^TMP("DILIST",$J,"ID",X,.02)
 S TIN=^TMP("DILIST",$J,"ID",X,.03)
 S PAYTR=^TMP("DILIST",$J,"ID",X,.04)
 S PAYAMT=^TMP("DILIST",$J,"ID",X,.07)
 S DEPNO=$$GET1^DIQ(344.3,EFTIEN,.03,"E")
 S DEPDAT=$$FMTE^XLFDT($$GET1^DIQ(344.3,EFTIEN,.07,"I"),"2DZ")
 ; EFT DETAIL lookup
 S PAYNAM=$E(PAYNAM,1,62-$L(TIN))_"/"_TIN I PAYNAM="/" S PAYNAM=""
 W !,$J(X,4),?7,EFTID,?16," ",PAYNAM
 W !,?16," ",PAYTR,?48," ",$J(PAYAMT,10)
 W ?59," ",DEPNO,?71," ",DEPDAT
 Q
 ;
 ; PRCA*4.5*332 - Start modified code block
CHKEOB(RCRECTDA,RCTRANDA,RCARRAY) ; EP from RCDPLPL3/4- Link payment to account, move/copy remove EOBs
 ; Inputs RCRECTDA - Receipt IEN file 344
 ;        RCTRANDA  - Payment multiple 344.01 IEN under RCRECTDA
 ;        RCARRAY  - If linking to multiple claims this array contains the list of claims
 ;                   A1^A2^A3^A4 where A1=Account Linked to, A2=Amount, A3=Comment, A4=Account Name
 ; Outputs None
 N CCLAIM,CLAIM,IEN344491,IEN3611,IFN,JUST,JUST1,LCLAIM,NCLAIM,NCLAIMS,OIFN,ORIG,QUIT
 N RCERA,RCLSUSP,RCORIG,RCOSEQ,RCSEQ,RCLORIG,RCSORIG,SCLAIM,X
 ;
 S RCERA=$$GET1^DIQ(344,RCRECTDA_",",.18,"I")
 S RCSEQ=$$GET1^DIQ(344.01,RCTRANDA_","_RCRECTDA_",",.27,"I")
 S RCOSEQ=$$GET1^DIQ(344.491,RCSEQ_","_RCERA_",",.01,"E")\1
 I 'RCOSEQ Q  ; No scratch pad entry for this payment, can not proceed.
 S IEN3611=$$ORIG(RCERA,RCOSEQ)
 I 'IEN3611 Q  ; Can not identify original EOB, can not proceed
 S ORIG=$$GET1^DIQ(361.1,IEN3611_",",.01,"E") ; Original Claim#
 S OIFN=$$GET1^DIQ(361.1,IEN3611_",",.01,"I") ; Original Bill IEN 399
 ;
 S (RCSORIG,RCLORIG,RCLSUSP)=0
 ; Check the scratch pad.  Get claims used in initial split/edit.
 ; Store claims other than original in SCLAIM array.
 ; If part payment was left on original claim set RCSORIG=1
 S X=RCOSEQ
 F  S X=$O(^RCY(344.49,RCERA,1,"B",X)) Q:((X\1)'=RCOSEQ)  D  ;
 . S IEN344491=""
 . F  S IEN344491=$O(^RCY(344.49,RCERA,1,"B",X,IEN344491)) Q:'IEN344491  D  ;
 . . I +$$GET1^DIQ(344.491,IEN344491_","_RCERA_",",.03)=0 Q  ; Ignore lines with zero value
 . . S CLAIM=$$GET1^DIQ(344.491,IEN344491_","_RCERA_",",.02,"E")
 . . I CLAIM=ORIG D  ;
 . . . S RCSORIG=1
 . . E  D  ;
 . . . S IFN=$$GET1^DIQ(344.491,IEN344491_","_RCERA_",",.07,"I")
 . . . I IFN S SCLAIM(IFN)=IFN
 ;
 ; Check link payment details.  Get claims we are linking to now.
 ; Store claims other than original in LCLAIM array.
 ; If part payment was left on original claim set RCLORIG=1
 S (NCLAIM,NCLAIMS)=""
 I '$D(RCARRAY) D
 . S NCLAIM=$$GET1^DIQ(344.01,RCTRANDA_","_RCRECTDA_",",.03,"E")
 . I NCLAIM["-" S NCLAIM=$P(NCLAIM,"-",2)
 . I NCLAIM=ORIG S RCLORIG=1 Q
 . ; Money is going on a new claim.
 . S IFN=$O(^DGCR(399,"B",NCLAIM,""))
 . I IFN S LCLAIM(IFN)=IFN
 E  D
 . S X=0
 . F  S X=$O(RCARRAY(X)) Q:'X  D
 . . ; Check if some money is going back to the original claim or remains in suspense.
 . . I $P(RCARRAY(X),"^",2)'=0 D  ;
 . . . I $P(RCARRAY(X),"^",1)="" S RCLSUSP=1  Q  ; Some money going back to suspense
 . . . S CLAIM=$P(RCARRAY(X),"^",4)
 . . . I CLAIM=ORIG S RCLORIG=1 Q  ; Money going back to original claim
 . . . I NCLAIMS'="" S NCLAIMS=NCLAIMS_","
 . . . S NCLAIMS=NCLAIMS_CLAIM
 . . . S IFN=$O(^DGCR(399,"B",CLAIM,""))
 . . . I IFN S LCLAIM(IFN)=IFN
 ;
 ; Do we need to move the EOB or copy it to new claims
 ; We will move the EOB, if the whole payment was put in suspense then linked to a single new claim
 I '$D(SCLAIM),'$D(RCARRAY),'RCLORIG,'RCSORIG D  Q  ;
 . K CLAIM
 . S IFN=$O(^DGCR(399,"B",NCLAIM,""))
 . I IFN D  ;
 . . S CLAIM(1)=IFN
 . . ; Change claim number on original EOB attached to ERA
 . . D AUTOMOVE^RCDPEM5(IEN3611,.CLAIM,"L")
 ;
 ; We will copy the EOB if money put into suspense is linked to multiple claims.
 ; *Or* if some money went to other claims in the original split.
 I $D(SCLAIM)!(RCSORIG)!($D(RCARRAY)) D  ;
 . K CLAIM
 . I '$D(RCARRAY),'RCLORIG D  ;
 . . S IFN=$O(^DGCR(399,"B",NCLAIM,""))
 . . I '$D(SCLAIM(IFN)) S CLAIM(IFN)=IFN ; Link to single claim not in the original split
 . I $D(RCARRAY) D  ;
 . . S X="" F  S X=$O(LCLAIM(X)) Q:'X  D  ;
 . . . I '$D(SCLAIM(X)) S CLAIM(X)=X ; Link to a claim that was not included in original split
 . I $D(CLAIM) D  ; Copy EOB to CLAIM(s)
 . . ; Copy EOB to new EOBs for "to" claims
 . . D AUTOCOPY^RCDPEM5(IEN3611,.CLAIM,"L")
 ;
 ; Remove the original EOB if no money left in suspense, or split or linked to original claim
 I 'RCSORIG,'RCLORIG,'RCLSUSP D  ;
 . S JUST="EEOB removed when payment from suspense was linked to claim(s) "_NCLAIMS
 . D AUTOREM^RCDPEM5(IEN3611,JUST)
 ;
 Q
 ;
ORIG(RCERA,RCOSEQ) ; Get the original claim from the EOB worklist
 ; Inputs RCERA - ERA IEN from file 344.49
 ;        RCOSEQ - Sequence number IEN from multiple 344.491
 ; Returns IEN from 361.1. EOB from 344.41
 N EEOBS,IEN491
 S IEN491=$O(^RCY(344.49,RCERA,1,"ASEQ",RCOSEQ,0))
 I IEN491="" Q "" ; Can't find referenced sequence number.
 S EEOBS=$$GET1^DIQ(344.491,IEN491_","_RCERA_",",.09,"E")
 I EEOBS["ADJ"!(EEOBS[",") Q ""  ; Don't proceed if this is not a split line.
 Q $$GET1^DIQ(344.41,(+EEOBS)_","_RCERA_",",.02,"I")
 ; PRCA*4.5*332 - End modified code block
 ;
 ; Next subroutine created for PRCA*4.5*439
UPDMATCH(ERAIEN,EFTIEN,STATUS) ; Standardize update of ERA and EFT when matching. (EP)
 ; EFT should be updated with pointer to ERA first to ensure audit is correctly updated when ERA match status is changed.
 ; Inputs:
 ;          ERAIEN - Pointer to file #344.4
 ;          EFTIEN - Pointer to file #344.31
 ;          STATUS - Match status - 1=MATCHED, -1=MATCHED WITH ERRORS
 ; Output - None. Files are updated
 N FDA,IENS
 S IENS=EFTIEN_","
 S FDA(344.31,IENS,.08)=STATUS
 S FDA(344.31,IENS,.1)=ERAIEN
 D FILE^DIE("","FDA")
 K FDA
 S IENS=ERAIEN_","
 S FDA(344.4,IENS,.09)=STATUS
 D FILE^DIE("","FDA")
 Q
