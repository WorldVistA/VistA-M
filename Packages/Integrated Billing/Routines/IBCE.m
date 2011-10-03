IBCE ;ALB/TMP - 837 EDI TRANSMISSION UTILITIES/NIGHTLY JOB ;22-JAN-96
 ;;2.0;INTEGRATED BILLING;**137,283,296,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
EN ; Run all jobs needed for EDI processing nightly
 ; including transmit bills waiting for extract, batches not sent,
 N IBLAST,IBZ,IBZ0
 D NOTSENT^IBCEBUL
 D EN^IBCE837
 D EN^IBCEMPRG      ; purge status messages from file 361
 D PURGE^IBCEPTU    ; purge transmission detail and claims status data associated with test transmissions after 60 days
 S IBLAST=$G(^IBA(364.2,"ALAST")),^IBA(364.2,"ALAST")=$$NOW^XLFDT()
 ; Clean up ACOB xref in 364
 S IBZ=0
 F  S IBZ=$O(^IBA(364,"ACOB",IBZ)) Q:'IBZ  S IBZ0=0 F  S IBZ0=$O(^IBA(364,"ACOB",IBZ,IBZ0)) Q:'IBZ0  I '$$COBPOSS^IBCECOB(IBZ0) D UPDEDI^IBCEM(IBZ0,"N",1)
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
RESUB(IB364) ; Manually resubmit bill for transmission (ien file 364 = IB364)
 N DIR,X,Y,IBBTCH,DTOUT,DUOUT,IBIFN,NEW364
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
 . S NEW364=$$ADDTBILL^IBCB1(IBIFN)    ; Add a new transmission record
 . I '$P(NEW364,U,3) D  Q
 .. S DIR("A",1)="FAILED TO ADD A NEW EDI TRANSMISSION",DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE " W ! D ^DIR K DIR
 .. Q
 . ;
 . K ^TMP("IBONE",$J),^TMP("IBSELX",$J),^TMP("IBCE-BATCH",$J)
 . S ^TMP("IBONE",$J,+NEW364)="",^TMP("IBONE",$J)=0,^TMP("IBSELX",$J)=""
 . D ONE^IBCE837
 . S IBBTCH=$O(^TMP("IBCE-BATCH",$J,0))                     ; external batch#
 . I IBBTCH'="" S IBBTCH=+$G(^TMP("IBCE-BATCH",$J,IBBTCH))  ; internal batch#
 . K ^TMP("IBONE",$J),^TMP("IBSELX",$J),^TMP("IBCE-BATCH",$J)
 . ;
 . I 'IBBTCH D
 .. S DIR("A",1)="BILL NOT RESUBMITTED - CHECK ALERTS/MAIL FOR DETAILS"
 . E  D
 .. N DIE,DR,DA
 .. D UPDEDI^IBCEM(IB364,"R")   ; update EDI files for old transmission
 .. S DIE="^IBA(364,",DR=".06////"_+IBBTCH,DA=IB364 D ^DIE
 .. S DIR("A",1)="BILL RESUBMITTED IN BATCH #"_$P($G(^IBA(364.1,+IBBTCH,0)),U,1)
 . S DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE " W ! D ^DIR K DIR
 . Q
 ;
 ; Later retransmission of claim
 D UPDEDI^IBCEM(IB364,"R")      ; update EDI files for old transmission record
 S Y=$$ADDTBILL^IBCB1(IBIFN)    ; Add a new transmission record
 S DIR("A",1)="BILL'S TRANSMISSION STATUS RESET TO 'READY TO EXTRACT'"
 S DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE " W ! D ^DIR K DIR
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
