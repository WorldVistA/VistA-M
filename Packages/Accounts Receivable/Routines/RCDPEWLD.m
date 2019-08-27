RCDPEWLD ;ALB/CLT - Continuation of routine RCDPEWL0 ;09 DEC 2016
 ;;4.5;Accounts Receivable;**252,317,321,326,332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
PROV(RCSCR,RCSCR1,RCXM1,RC) ;Get prov data from ERA (FILE 344.4) and claim (FILE 399)
 N RCXXX,RCYYY,RCDPEPV,RCCLAIM,RCIEN,RCBILL,RCID,RCBLANK,RCNPI,DIC,X,Y
 N RCPROV,RCEXP,XUSNPI,RCRTN,RCBNM,RCCOM1,RCCOM2,RCWARN,RCYNODE3
 ;
 S RCBLANK="" F X=1:1:30 S RCBLANK=RCBLANK_" "
 S RC=RC+1 S RCXM1(RC-1)=RCBLANK
 S RCYNODE3=$G(^RCY(344.4,RCSCR,1,RCSCR1,3))
 ;
LKBOX ;Get provider data from ELECTRONIC REMITTANCE ADVICE file (#344.4)
 S RC=RC+1,RCXM1(RC-1)=$E("**EOB PROVIDER(S)/NPI"_$J(" ",39),1,39)_"CLAIM PROVIDER(S)/NPI**"  ;setting sub-header for worklist
 S RC=RC+1,RCXM1(RC-1)=$E("---------------------"_$J(" ",39),1,39)_"-----------------------"
 ;
 S RCPROV="BILLING",$P(RCYYY(RCPROV),U,3)=0        ; piece 3 initialize for error msgs
 I $P(RCYNODE3,U)'="" S RCYYY(RCPROV)="/"_$P(RCYNODE3,U)   ; Billing Prov NPI 
 ;
 S RCPROV="RENDERING"
 I $P(RCYNODE3,U,3)=2 S RCPROV="SERVICING"
 I $P(RCYNODE3,U,3)="",($P(RCYNODE3,U,4)'[","),($P(RCYNODE3,U,4)'="") S RCPROV="SERVICING"
 I $P(RCYNODE3,U,2)'=""!($P(RCYNODE3,U,4)'="") S RCYYY(RCPROV)=$E($P(RCYNODE3,U,4),1,20)_"/"_$P(RCYNODE3,U,2)
 S $P(RCYYY(RCPROV),U,3)=0                          ; initialize for error msgs
 D NPICHK        ; RCPROV has to be "RENDERING" or "SERVICING" when this tag is called !
 ;
CLAIM ;Retrieve provider data from the claim
 S RCCLAIM=$$GET1^DIQ(361.1,$P(^RCY(344.4,RCSCR,1,RCSCR1,0),U,2),.01) ;determine claim num based on entry in 344.4
 S DIC="^DGCR(399,",DIC(0)="",X=RCCLAIM D ^DIC S RCCLAIM=+Y      ;find ien for file 399
 D GETS^DIQ(399,RCCLAIM,"222*","IE","RCXXX")         ;retrieve prov information
 S RCBILL=$$GET1^DIQ(399,RCCLAIM,.22,"I")            ;retrieve default division
 S RCBNM=$$GET1^DIQ(4,$$GET1^DIQ(40.8,RCBILL,.07,"I"),.01)  ;get name from institution file
 S RCBILL=$$GET1^DIQ(4,$$GET1^DIQ(40.8,RCBILL,.07,"I"),41.99)  ;get NPI from institution file
 ;
 S $P(RCYYY("BILLING"),U,2)=RCBNM_"/"_RCBILL_"^"_0  ;NPI set into local array
 I $D(RCXXX) S RCPROV="" F  S RCPROV=$O(RCXXX(399.0222,RCPROV)) Q:RCPROV=""  D  ;loop through claim providers
 . S RCIEN=$P(RCXXX(399.0222,RCPROV,.02,"I"),";",1)
 . S RCID=$S($P(RCXXX(399.0222,RCPROV,.02,"I"),";",2)["VA(200":"Individual_ID",1:"Non_VA_Provider_ID")
 . S RCNPI=$$NPI^XUSNPI(RCID,RCIEN)                  ;retrieve provider NPI
 . S $P(RCYYY(RCXXX(399.0222,RCPROV,.01,"E")),U,2)=$E(RCXXX(399.0222,RCPROV,.02,"E"),1,20)_"/"_$S(+RCNPI=0:"No NPI on file",+RCNPI=-1:"Can't look up NPI",1:+RCNPI)
 . S:$P(RCYYY(RCXXX(399.0222,RCPROV,.01,"E")),U,3)="" $P(RCYYY(RCXXX(399.0222,RCPROV,.01,"E")),U,3)=0
LINESET ;SET THE PRINT LINES
 S (RCWARN,RCPROV)="" F  S RCPROV=$O(RCYYY(RCPROV)) Q:RCPROV=""  D  ;loop through the found provider types
 . S RC=RC+1                                          ;increment line counter
 . ; build display detail line
 . S RCXM1(RC-1)=RCPROV_": "_$P(RCYYY(RCPROV),U,1)
 . I $L(RCXM1(RC-1))>39 D
 .. S RCXM1(RC-1)=$E($P(RCXM1(RC-1),"/"),1,27)_"/"_$P(RCXM1(RC-1),"/",2)
 . S RCXM1(RC-1)=$E(RCXM1(RC-1)_RCBLANK,1,39)_$P(RCYYY(RCPROV),U,2)
 . I $P(RCYYY(RCPROV),U,3)'=0 S RCWARN=$P(RCYYY(RCPROV),U,3)
 I RCWARN'="" D
 . S RC=RC+1,RCXM1(RC-1)=" "                          ;Blank line for separation
 . S RC=RC+1,RCXM1(RC-1)="Rendering/Servicing Provider NPI Warning:"
 . S RC=RC+1,RCXM1(RC-1)=RCWARN
 S RC=RC+1,RCXM1(RC-1)=" "                            ;Blank line to separate from possible comments
 S RCCOM1=$P(RCYNODE3,U,5),RCCOM2=$P(RCYNODE3,U,6) D  ;Error in NPI format
 . I $G(RCCOM1)'="" S RC=RC+1,RCXM1(RC-1)=RCCOM1
 . I $G(RCCOM2)'="" S RC=RC+1,RCXM1(RC-1)=RCCOM2
 Q
 ;
NPICHK ;CHECK THAT THE NPI RETURNED MATCHES THE ENTITY TYPE QUALIFIER
 S RCEXP="" Q:$P(RCYNODE3,U,3)=""               ; ENTITY TYPE QUALIFIER
 ;
 S RCCOM2=$P(RCYNODE3,U,6) ; Ren/Serv comment
 S XUSNPI=$P(RCYNODE3,U,2)
 I RCCOM2="",(XUSNPI="") S RCEXP="**NO SERVICING/RENDERING NPI INCLUDED IN 835**" D EXPSET Q
 S RCRTN=$$QI^XUSNPI(XUSNPI)
 I $P(RCRTN,U,1)="Individual_ID" D  Q
 . I $P(RCYNODE3,U,3)'=1 S RCEXP="**NPI from 835 indicated organizational but is associated with an individual**" D EXPSET Q
 I $P(RCRTN,U,1)="Organization_ID" D  Q
 . I $P(RCYNODE3,U,3)'=2 S RCEXP="**NPI from 835 indicated individual but is associated with an organization**" D EXPSET Q
 I $E($P(RCRTN,U,1),1,3)="Non" D  Q
 . N RCIEN,RCTYPE S RCIEN=$P(RCRTN,U,2),RCTYPE=$$GET1^DIQ(355.93,RCIEN,.02,"I") Q:$G(RCTYPE)=""
 . I $P(RCYNODE3,U,3)=1,RCTYPE=1 S RCEXP="**NPI from 835 indicated individual but is associated with an organization**" D EXPSET Q
 . I $P(RCYNODE3,U,3)=2,RCTYPE=2 S RCEXP="**NPI from 835 indicated organizational but is associated with an individual**" D EXPSET Q
 I RCCOM2="",(+RCRTN=0) S RCEXP="**The NPI returned on the 835 is not associated with this VistA system**" D EXPSET Q
 Q
 ;
EXPSET ;SET THE PRINT LINE WITH THE ERROR AS DEFINED IN RCEXP
 S $P(RCYYY(RCPROV),U,3)=RCEXP
 Q
 ;
PARAMS(RCQUIT) ;PARAMETERS ENTRY CONTINUED FROM RCDPEWL0
 I $G(RCQUIT) K ^TMP("RCERA_PARAMS",$J)
PARMSQ ;
 Q
 ;
PARAMS2() ;EP from RCDPEWL0
 ; PRCA*4.5*317 - Moved due to routine size issues
 ; Input:   None
 ; Returns: RCQUIT  - 1 if user ^ or timed out, 0 otherwise
 S RCQUIT=$$PAYMNT()                        ; Ask for zero/payment PRCA*4.5*321
 Q:RCQUIT 1                                                      ; PRCA*4.5*321
 S RCQUIT=$$POSTSTAT()                      ; Ask Posting Status
 Q:RCQUIT 1
 S RCQUIT=$$POSTMETH                        ; Ask Posting Method
 Q:RCQUIT 1
 S RCQUIT=$$MATCHST                         ; Ask ERA-EFT Matching Status
 Q:RCQUIT 1
 S RCQUIT=$$CLAIMTYP()                      ; Ask Claim Type
 Q:RCQUIT 1
 S RCQUIT=$$PAYR()                          ; Ask for selected payers
 Q RCQUIT
 ;
PAYMNT() ; Payment Type (Zero/Payment or Both) Selection ; PRCA*4.5*321 this whole subroutine
 ; Input:   ^TMP("RCERA_PARAMS")               - Global array of preferred values (if any)
 ; Output:  ^TMP("RCERA_PARAMS",$J,"RCPAYMNT") - ERA Posting Status filter
 ; Returns: 1 if user quit or timed out, 0 otherwise
 N DIR,DTOUT,DUOUT,RCTYPEDF
 S RCTYPEDF=$G(^TMP("RCERA_PARAMS",$J,"RCPAYMNT"))
 K DIR S DIR(0)="SA^Z:ZERO;P:PAYMENT;B:BOTH"
 S DIR("A")="(Z)ERO, (P)AYMENT, or (B)OTH: "
 S DIR("B")="B"
 S DIR("?",1)="Select ZERO to only see ERAs with a zero total amount paid."
 S DIR("?",2)="Select PAYMENT to only see ERAs with a non-zero amount paid."
 S DIR("?")="Select BOTH to see both zero and non-zero amount ERAs."
 S:RCTYPEDF'="" DIR("B")=RCTYPEDF     ;Stored preferred value, use as default
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 S ^TMP("RCERA_PARAMS",$J,"RCPAYMNT")=Y
 Q 0
 ;
POSTSTAT() ; ERA Posting Status (Posted/Unposted/Both) Selection
 ; Input:   ^TMP("RCERA_PARAMS")            - Global array of preferred values (if any)
 ; Output:  ^TMP("RCERA_PARAMS",$J,"RCPOST")- ERA Posting Status filter
 ; Returns: 1 if user quit or timed out, 0 otherwise
 N DIR,DTOUT,DUOUT,RCPOSTDF
 S RCPOSTDF=$G(^TMP("RCERA_PARAMS",$J,"RCPOST"))
 K DIR S DIR(0)="SA^U:UNPOSTED;P:POSTED;B:BOTH"
 S DIR("A")="ERA posting status: (U)NPOSTED, (P)OSTED, or (B)OTH: "
 S DIR("B")="U"
 S DIR("?",1)="Select UNPOSTED to only see ERAs with a status of UNPOSTED."
 S DIR("?",2)="Select POSTED to only see ERAs with a status of POSTED."
 S DIR("?")="Select BOTH to see both unposted and posted ERAs."
 S:RCPOSTDF'="" DIR("B")=RCPOSTDF    ; Stored preferred value, use as default
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 S ^TMP("RCERA_PARAMS",$J,"RCPOST")=Y
 Q 0
 ;
POSTMETH()  ; PRCA*4.5*317 moved from RCDPEWL0 because of routine size issues
 ; ERA Posting Method (Auto-Posting/Non Auto-Posting/Both) Selection
 ; Input:   ^TMP("RCERA_PARAMS")             - Global array of preferred values (if any)
 ; Output:  ^TMP("RCERA_PARAMS",$J,"RCAUTOP")- ERA Posting Status filter
 ; Returns: 1 if user quit or timed out, 0 otherwise
 N DIR,DTOUT,DUOUT,RCAUTOPDF
P1 S RCAUTOPDF=$G(^TMP("RCERA_PARAMS",$J,"RCAUTOP")) ; PRCA*4.5*326
 K DIR S DIR(0)="SA^A:AUTO-POSTING;N:NON AUTO-POSTING;B:BOTH"
 S DIR("A")="Display (A)UTO-POSTING, (N)ON AUTO-POSTING, or (B)OTH: "
 S DIR("B")="B"
 S DIR("?",1)="Select AUTO-POSTING to only see auto-posted ERAs."
 S DIR("?",2)="Select NON AUTO-POSTING to only see ERAs that were NOT auto-posted."
 S DIR("?")="Select BOTH to see both auto-posted and non auto-posted ERAs."
 S:RCAUTOPDF'="" DIR("B")=RCAUTOPDF    ;Stored preferred value, use as default
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 G:'$$VALP(Y) P1 ; PRCA*4.5*326
 S ^TMP("RCERA_PARAMS",$J,"RCAUTOP")=Y
 ; If including auto-post ERA ask for auto-post status filters
 I Y'="N" Q $$AUTOPST() ; PRCA*4.5*326
 Q 0
 ;
MATCHST()  ; ERA-EFT Matching Status(Matched/Unmatched/Both) Selection
 ; Input:   ^TMP("RCERA_PARAMS")             - Global array of preferred values (if any)
 ; Output:  ^TMP("RCERA_PARAMS",$J,"RCMATCH")- ERA Posting Status filter
 ; Returns: 1 if user quit or timed out, 0 otherwise
 N DIR,DTOUT,DUOUT,RCMATCHD
M1 S RCMATCHD=$G(^TMP("RCERA_PARAMS",$J,"RCMATCH")) ; PRCA*4.5*326
 K DIR S DIR(0)="SA^N:NOT MATCHED;M:MATCHED;B:BOTH"
 S DIR("A")="ERA-EFT match status: (N)OT MATCHED, (M)ATCHED, or (B)OTH: "
 S DIR("B")="B"
 S DIR("?",1)="Select NOT MATCHED to only see unmatched ERAs."
 S DIR("?",2)="Select MATCHED to only see matched ERAs."
 S DIR("?")="Select BOTH to see both matched and unmatched ERAs."
 S:RCMATCHD'="" DIR("B")=RCMATCHD      ;Stored preferred value, use as default
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 G:'$$VALM(Y) M1 ; PRCA*4.5*326
 S ^TMP("RCERA_PARAMS",$J,"RCMATCH")=Y
 Q 0
 ;
CLAIMTYP()  ; Claim Type (Medical/Pharmacy/Both) Selection
 ; Input:   ^TMP("RCERA_PARAMS")             - Global array of preferred values (if any)
 ; Output:  ^TMP("RCERA_PARAMS",$J,"RCTYPE") - ERA Posting Status filter
 ; Returns: 1 if user quit or timed out, 0 otherwise
 N DIR,DTOUT,DUOUT,RCTYPEDF
 S RCTYPEDF=$G(^TMP("RCERA_PARAMS",$J,"RCTYPE"))
 ; PRCA*4.5*321 - Changed set of codes and help
 K DIR S DIR(0)="SA^M:MEDICAL;P:PHARMACY;T:TRICARE;A:ALL"
 S DIR("A")="(M)EDICAL, (P)HARMACY, (T)RICARE or (A)LL: "
 S DIR("B")="A"
 S DIR("?",1)="Select MEDICAL to only see ERAs with a payer type of medical."
 S DIR("?",2)="Select PHARMACY to only see ERAs with a payer type of pharmacy."
 S DIR("?",3)="Select TRICARE to only see ERAs with a payer type of Tricare."
 S DIR("?")="Select ALL to see medical, pharmacy and Tricare ERAs."
 ; PRCA*4.5*321 - End modified code block
 S:RCTYPEDF'="" DIR("B")=RCTYPEDF     ;Stored preferred value, use as default
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 S ^TMP("RCERA_PARAMS",$J,"RCTYPE")=Y
 Q 0
 ;
PAYR() ; Payer Selection
 ; Input:   ^TMP("RCERA_PARAMS",$J)          - Global array of preferred values (if any)
 ; Output:  ^TMP("RCERA_PARAMS",$J,"RCTYPE") - ERA Posting Status filter
 ; Returns: 1 if user quit or timed out, 0 otherwise
 N DIR,DTOUT,DUOUT,RCPAYR,RCPAYRDF,RCOUT,RCDONE
 S RCPAYRDF=$G(^TMP("RCERA_PARAMS",$J,"RCPAYR"))
 ; PRCA*4.5*332 - wrapped prompts in a for loop to allow the payer range prompt to return to inital prompt if
 ;                user cancels out
 S (RCQUIT,RCDONE,RCOUT)=0
 F  Q:RCDONE  D  ; PRCA*4.5*332 - Remove GOTO and instead make FOR loop
 . K DIR S DIR(0)="SA^A:ALL;R:RANGE"
 . S DIR("A")="(A)LL payers, (R)ANGE of payer names: "
 . S DIR("B")="ALL"
 . S DIR("?",1)="Entering ALL will select all payers."
 . S DIR("?")="If RANGE is entered, you will be prompted for a payer range."
 . S:$P(RCPAYRDF,"^")'="" DIR("B")=$P(RCPAYRDF,"^",1)      ;Stored preferred value, use as default
 . W !
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S (RCDONE,RCOUT)=1 Q
 . S RCPAYR=Y
 . I RCPAYR="A" D  Q
 . . S ^TMP("RCERA_PARAMS",$J,"RCPAYR")=Y       ;All payers selected
 . . S RCDONE=1
 . I RCPAYR="R" D
 . . W !,"Names you select here will be the payer names from the ERA, not the ins. file"
 . . K DIR
 . . S DIR("?")="Enter a name from 1 to 30 characters in UPPER CASE."
 . . S DIR(0)="FA^1:30^K:X'?.U X"
 . . S DIR("A")="Start with payer name: "
 . . S:$P(RCPAYRDF,"^",2)'="" DIR("B")=$P(RCPAYRDF,"^",2)  ;Stored preferred value, use as default
 . . W !
 . . D ^DIR
 . . I $D(DTOUT)!$D(DUOUT) D  Q
 . . . K ^TMP("RCERA_PARAMS",$J,"RCPAYR")
 . . S RCPAYR("FROM")=Y
 . . K DIR
 . . S DIR("?")="Enter a name from 1 to 30 characters in UPPER CASE."
 . . S DIR(0)="FA^1:30^K:X'?.U X",DIR("A")="Go to payer name: "
 . . S DIR("B")=$E(RCPAYR("FROM"),1,27)_"ZZZ"
 . . S:$P(RCPAYRDF,"^",3)'="" DIR("B")=$P(RCPAYRDF,"^",3)   ;Stored preferred value, use as default
 . . W !
 . . D ^DIR
 . . I $D(DTOUT)!$D(DUOUT) Q
 . . S ^TMP("RCERA_PARAMS",$J,"RCPAYR")=RCPAYR_"^"_RCPAYR("FROM")_"^"_Y
 . . S RCDONE=1
 Q RCOUT
 ;
 ; BEGIN PRCA*4.5*326
AUTOPST() ; Auto-post Status (Marked/Partial/Complete/All) Selection
 ; Input: ^TMP("RCERA_PARAMS") - Global array of preferred values (if any)
 ; Output: ^TMP("RCERA_PARAMS",$J,"RCAPSTA") - Auto-post Status filter
 ; Returns: 1 if user quit or timed out, 0 otherwise
 N DIR,DTOUT,DUOUT,APTYPEDF
A1 S APTYPEDF=$G(^TMP("RCERA_PARAMS",$J,"RCAPSTA"))
 K DIR S DIR(0)="SA^M:MARKED;P:PARTIAL;C:COMPLETE;A:ALL"
 S DIR("A")="Auto-Post status: (M)ARKED, (P)ARTIAL, (C)OMPLETE or (A)LL: "
 S DIR("B")="A"
 S DIR("?",1)="Select MARKED to only see ERAs currently marked for autopost."
 S DIR("?",2)="Select PARTIAL to only see ERAs with a partial auto-post status."
 S DIR("?",3)="Select COMPLETE to only see ERAs with a complete auto-post status."
 S DIR("?")="Select ALL to see ERAs with any autopost status."
 S:APTYPEDF'="" DIR("B")=APTYPEDF     ;Stored preferred value, use as default
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 G:'$$VALA(Y) A1
 S ^TMP("RCERA_PARAMS",$J,"RCAPSTA")=Y
 Q 0
 ;
VALA(INP) ; Compare input auto-post status filter to other filters
 ; Input INP - Y value from ^DIR
 ; Output 1 = Valid 0 = Invalid
 ;
 I INP="C",$G(^TMP("RCERA_PARAMS",$J,"RCPOST"))="U" D  Q 0
 .W !!,"Auto-post COMPLETE is an invalid selection for UNPOSTED ERAs"
 I INP="P",$G(^TMP("RCERA_PARAMS",$J,"RCPOST"))="U" D  Q 0
 .W !!,"Auto-post PARTIAL is an invalid selection for UNPOSTED ERAs"
 I INP="M",$G(^TMP("RCERA_PARAMS",$J,"RCPOST"))="P" D  Q 0
 .W !!,"MARKED for Auto-post is an invalid selection for POSTED ERAs"
 Q 1
 ;
VALM(INP) ; Compare input match type filter to other filters
 ; Input INP - Y value from ^DIR
 ; Output 1 = Valid 0 = Invalid
 ;
 I INP="N",$G(^TMP("RCERA_PARAMS",$J,"RCAUTOP"))="A" D  Q 0
 .W !!,"NOT MATCHED is an invalid selection for AUTO-POSTING ERAs"
 Q 1
 ;
VALP(INP) ; Compare input posting method filter to other filters
 ; Input INP - Y value from ^DIR
 ; Output 1 = Valid 0 = Invalid
 ;
 I INP="A",$G(^TMP("RCERA_PARAMS",$J,"RCPAYMNT"))="Z" D  Q 0
 .W !!,"AUTO-POSTING is an invalid selection for ZERO ERAs"
 Q 1
 ; END PRCA*4.5*326
