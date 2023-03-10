IBCE ;ALB/TMP - 837 EDI TRANSMISSION UTILITIES/NIGHTLY JOB ;22-JAN-96
 ;;2.0;INTEGRATED BILLING;**137,283,296,371,623,659,641,650**;21-MAR-94;Build 21
 ;Per VA Directive 6402, this routine should not be modified
EN ; Run all jobs needed for EDI processing nightly
 ; including transmit bills waiting for extract, batches not sent,
 N IBLAST,IBZ,IBZ0
 D NOTSENT^IBCEBUL
 D EN^IBCE837
 D EN^IBCEMPRG      ; purge status messages from file 361
 D PURGE^IBCEPTU    ; purge transmission detail and claims status data associated with test transmissions after 60 days
 S IBLAST=$G(^IBA(364.2,"ALAST")),^IBA(364.2,"ALAST")=$$NOW^XLFDT()
 ; Clean up ACOB xref in 364
 ;JWS;IB*2.0*650v6;if status = A0, don't prematurely close EDI entry, so users can see A0s on ECS report if not acknowledged receipt in FSC.
 S IBZ=0
 F  S IBZ=$O(^IBA(364,"ACOB",IBZ)) Q:'IBZ  S IBZ0=0 F  S IBZ0=$O(^IBA(364,"ACOB",IBZ,IBZ0)) Q:'IBZ0  I '$$COBPOSS^IBCECOB(IBZ0) D
 . I $P($G(^IBA(364,IBZ0,0)),"^",3)="A0" Q
 . D UPDEDI^IBCEM(IBZ0,"N",1)
 . Q
 Q
 ;
EN1 ; Manual entry point for transmitting EDI bills
 N DIR,X,Y,IBLAST,IBTASK,IBOPTX,DTOUT,DUOUT
 I '$$MGCHK(1) G EN1Q
 S DIR("A")="Select transmit option: ",DIR("B")="S",DIR(0)="SAM^A:Transmit (A)LL bills in READY FOR EXTRACT status;S:Transmit only (S)ELECTED bills"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G EN1Q
 S IBOPTX=Y
 I Y="A" D  G EN1Q
 . S DIR("A",1)="This option will run a job to transmit ALL bills ready for EDI transmission"
 . S DIR("A",2)="This option's last scheduled run was "_$$FMTE^XLFDT($G(^IBA(364.2,"ALAST")),2)
 . S DIR("A",3)=" "
 . S DIR("A")="Are you absolutely sure this is what you want to do? "
 . S DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR
 . Q:'Y
 . S DIR(0)="YA",DIR("A",1)=" "
 . S DIR("A",2)="Transmission of ALL bills will be run now"
 . S DIR("A")="Is this OK? ",DIR("B")="NO"
 . D ^DIR K DIR
 . Q:'Y
 . D EN1^IBCE837B(.IBTASK)
 . I $G(IBTASK) D
 .. S DIR("A",1)="Task # for this job is: "_IBTASK
 . E  D
 .. I $G(IBTASK)'="" S DIR("A",1)="Error encountered in tasking job - check IRM for reported errors"
 .. S DIR(0)="EA",DIR("A")=" Press RETURN to continue " W !! D ^DIR K DIR
 I IBOPTX="S" D SUB1^IBCEM03 G EN1Q
EN1Q Q
 ;
RESUB(IB364,IBRESULT) ; Manually resubmit bill for transmission (ien file 364 = IB364)
 ; added new parameter IBRESULT to see the result of calling this tag
 ; set to 0 initially and 1 if successful
 ; parameter is needed by IBCECSA4 calling routine 
 N DIR,X,Y,IBBTCH,DTOUT,DUOUT,IBIFN,NEW364,IBC364
 S IBRESULT=0  ;WCJ;IB641
 I '$$MGCHK(1) G RESUBQ
 S IBIFN=+$P($G(^IBA(364,+$G(IB364),0)),U,1) I 'IBIFN G RESUBQ
 S IBBTCH=""
 W ! S DIR(0)="SA^I:IMMEDIATE TRANSMIT;L:TRANSMIT LATER WITH REST OF READY FOR EXTRACT BILLS",DIR("A")="TRANSMIT (I)MMEDIATELY OR (L)ATER?: ",DIR("B")="L"
 S DIR("?",1)="IF YOU CHOOSE TO TRANSMIT IMMEDIATELY, THE BILL'S DATA WILL BE BATCHED BY",DIR("?",2)=" ITSELF AND SENT OUT IMMEDIATELY.  IF YOU CHOOSE TO TRANSMIT LATER, THE"
 S DIR("?",3)="  BILL'S TRANSMISSION STATUS WILL BE RESET TO 'READY FOR EXTRACT' AND THE BILL'S",DIR("?",4)="  DATA WILL BE EXTRACTED THE NEXT TIME A GENERAL TRANSMISSION OF YOUR BILLS",DIR("?")="  IN READY TO EXTRACT STATUS OCCURS"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G RESUBQ
 ;
 ; immediate retransmission of claim
 I Y="I" D  G RESUBQ
 . ;JWS;IB*2.0*650v4;attempt to prevent duplicates
 . S IBC364=$$LAST364^IBCEF4(IBIFN)
 . I IB364'=IBC364,$P($G(^IBA(364,IBC364,0)),U,3)="X"!($D(^IBA(364,"AC",1,IBC364))) D  Q
 .. S DIR("A",1)="This Claim is already awaiting extract for retransmission.",DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE " W ! D ^DIR K DIR
 .. Q
 . I $P($G(^IBA(364,IB364,0)),U,3)="X"!($D(^IBA(364,"AC",1,IB364))) D  Q
 .. S DIR("A",1)="This Claim is already awaiting extract for retransmission.",DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE " W ! D ^DIR K DIR
 .. Q
 . ;JWS;IB*2.0*641v9;added 4th parameter passing 1 to indicate 364, field .09 set = 1; not implemented but leaving for knowledge
 . S NEW364=$$ADDTBILL^IBCB1(IBIFN)    ; Add a new transmission record
 . I '$P(NEW364,U,3) D  Q
 .. S DIR("A",1)="FAILED TO ADD A NEW EDI TRANSMISSION",DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE " W ! D ^DIR K DIR
 .. Q
 . ;
 . K ^TMP("IBONE",$J),^TMP("IBSELX",$J),^TMP("IBCE-BATCH",$J)
 . S ^TMP("IBONE",$J,+NEW364)="",^TMP("IBONE",$J)=0,^TMP("IBSELX",$J)=""
 . ;JWS;IB*2.0*641v6;issue with resubmit of claim, batch # not generated until submitted
 . ;                ;in FHIR, transaction does not get transmitted immediately
 . I $$GET1^DIQ(350.9,"1,",8.21,"I") S ^TMP("IBRESUBMIT",$J,$P(NEW364,U))=""
 . D ONE^IBCE837
 . S IBBTCH=$O(^TMP("IBCE-BATCH",$J,0))                     ; external batch#
 . I IBBTCH'="" S IBBTCH=+$G(^TMP("IBCE-BATCH",$J,IBBTCH))  ; internal batch#
 . K ^TMP("IBONE",$J),^TMP("IBSELX",$J),^TMP("IBCE-BATCH",$J)
 . ;
 . ;JWS;IB*2.0*641v6;if FHIR is on, no Batch # will be available
 . I 'IBBTCH,'$$GET1^DIQ(350.9,"1,",8.21,"I") D 
 .. S DIR("A",1)="BILL NOT RESUBMITTED - CHECK ALERTS/MAIL FOR DETAILS"
 . E  D
 .. ;JWS;IB*2.0*623v24;add setting resubmission flag
 .. ;;D SETSUB^IBCE837I($P(NEW364,U),1) 
 .. N DIE,DR,DA
 .. D UPDEDI^IBCEM(IB364,"R")   ; update EDI files for old transmission
 .. ;JWS;IB*2.0*641v6;837 FHIR just indicate submitted
 .. I $$GET1^DIQ(350.9,"1,",8.21,"I") D  Q
 ... S DIR("A",1)="BILL placed onto 837 FHIR Transaction list. It will be submitted shortly..."
 .. S DIE="^IBA(364,",DR=".06////"_+IBBTCH,DA=IB364 D ^DIE
 .. S DIR("A",1)="BILL RESUBMITTED IN BATCH #"_$P($G(^IBA(364.1,+IBBTCH,0)),U,1)
 .. S IBRESULT=1   ;WCJ;IB641;successful
 . S DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE " W ! D ^DIR K DIR
 . Q
 ;
 ; Later retransmission of claim
 ;JWS;IB*2.0*650v4;attempt to prevent duplicates
 S IBC364=$$LAST364^IBCEF4(IBIFN)
 I IB364'=IBC364,$P($G(^IBA(364,IBC364,0)),U,3)="X"!($D(^IBA(364,"AC",1,IBC364))) D  Q
 . S DIR("A",1)="This Claim is already awaiting extract for retransmission.",DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE " W ! D ^DIR K DIR
 . Q
 I $P($G(^IBA(364,IB364,0)),U,3)="X"!($D(^IBA(364,"AC",1,IB364))) D  Q
 . S DIR("A",1)="This Claim is already awaiting extract for retransmission.",DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE " W ! D ^DIR K DIR
 . Q
 D UPDEDI^IBCEM(IB364,"R")      ; update EDI files for old transmission record
 S Y=$$ADDTBILL^IBCB1(IBIFN)    ; Add a new transmission record
 ;JWS;IB*2.0*623v24;add setting resubmission flag
 D SETSUB^IBCE837I(+Y,1)
 S DIR("A",1)="BILL'S TRANSMISSION STATUS RESET TO 'READY TO EXTRACT'"
 S DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE " W ! D ^DIR K DIR
 S IBRESULT=1   ;WCJ;IB641;successful
 ;
RESUBQ Q
 ;
MGCHK(DSP) ; Returns 1 if mail group IB EDI has at least 1 local member,
 ; 0 if none found
 ; DSP = flag that if =1, displays error message
 N IB
 S IB=$$GOTLOCAL^XMXAPIG("IB EDI")
 I 'IB,$G(DSP) D
 . ; No local members in mail group for EDI messages
 . S DIR("A",1)="YOU MUST HAVE AT LEAST 1 MEMBER IN THE 'IB EDI' MAIL GROUP TO TRANSMIT A BILL",DIR("A")="PRESS RETURN TO CONTINUE "
 . S DIR(0)="EA" D ^DIR K DIR
 Q IB
 ;
