IBCEMQA ;DAOU/ESG - MRA QUIET BILL AUTHORIZATION ;25-MAR-2003
 ;;2.0;INTEGRATED BILLING;**155,432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q   ; must be called at proper entry point
 ;
 ;
AUTOCOB(IBIFN,IBEOB,ERRMSG,IBMRANOT,IBNCN) ; This procedure mimics and automates the
 ; Process COB action on the MRA management screen.  This is intended
 ; to be called in background mode (no user interface).
 ;
 ; Input
 ;    IBIFN - bill#
 ;    IBEOB - ien of entry in file 361.1 (MRA)
 ;    IBMRANOT - 1 indicates process is NOT from MRA
 ;    IBNCN - By Reference.  Need to pass back the new claim number
 ;
 ; Output
 ;    ERRMSG - optional output parameter, passed by reference
 ;           - error message text
 ;
 NEW MRADATA,IB364,IBCBASK,IBCBCOPY,IBCAN,IBIFNH,IBAUTO,IBDA
 NEW IBCE,IBSILENT,IBPRCOB,IBERRMSG,IBSTSM
 NEW IBCOB,IBCOBIL,IBCOBN,IBINS,IBINSN,IBINSOLD,IBMRAIO,IBMRAO,IBNMOLD
 S (IBIFN,IBIFNH)=+$G(IBIFN),IBEOB=+$G(IBEOB),ERRMSG=""
 ;
 S MRADATA=$G(^IBM(361.1,IBEOB,0))
 ; IB*2.0*432 - Add auto-process of non-MRA's
 I $G(IBMRANOT)'=1,$P(MRADATA,U,1)'=IBIFN S ERRMSG="Incorrect Bill or MRA EOB" G AUCOBX
 I $G(IBMRANOT)'=1,$P(MRADATA,U,4)'=1 S ERRMSG="EOB is not a Medicare MRA" G AUCOBX
 S IB364=+$P(MRADATA,U,19)
 I $G(IBMRANOT)'=1,'IB364 S ERRMSG="Missing or incorrect Transmission record" G AUCOBX
 ;
 I '$P($G(^DGCR(399,IBIFN,"I"_($$COBN^IBCEF(IBIFN)+1))),U,1) D  G AUCOBX
 . S ERRMSG="No next payer for this bill"
 . Q
 ;
 ; Make sure that Medicare WNR is the current insurance for this bill if MRA processing
 I $G(IBMRANOT)'=1,'$$WNRBILL^IBEFUNC(IBIFN) D  G AUCOBX
 . S ERRMSG="Medicare (WNR) is not the current payer for this bill"
 . Q
 ;
 ; Set variable flags for use in IBCCCB/IBCCC2
 S (IBCBASK,IBCBCOPY,IBCAN,IBAUTO,IBCE("EDI"),IBSILENT,IBPRCOB)=1
 ; IB*2.0*432 - if non-MRA processing, set Secondary/Tertiary Silent mode=1
 S:$G(IBMRANOT)=1 IBSTSM=1
 S IBDA=IBEOB
 ;
 D CHKB1^IBCCCB
 ;
 I $G(IBMRANOT)=1 S IBNCN=$S($G(IBCE("EDI","NEW")):IBCE("EDI","NEW"),1:$G(IBHV("IBIFN1")))
 S IBIFN=IBIFNH                                   ; restore bill#
 I $G(IBERRMSG)'="" S ERRMSG=IBERRMSG G AUCOBX    ; error message
 D UPDEDI^IBCEM(IB364,"Z")                        ; status updates
AUCOBX ;
 Q
 ;
 ;
AUTH(IBIFN,ERRMSG,IBMRANOT) ; Entry Point
 ; This procedure's job is to authorize this bill.  The manual
 ; process to authorize a bill is found in routine IBCB1.  This
 ; routine borrows heavily from that routine.
 ;
 ; *** Any changes here should be considered also in IBCB1 ***
 ;
 ; This routine is called when receiving an incoming MRA from
 ; Medicare.  If that MRA/EOB meets certain criteria, then the bill
 ; will become a secondary bill and we will try to authorize it (using
 ; this procedure) and put it in the EDI queue ready for extract.
 ;
 ; Input
 ;    IBIFN - internal bill#
 ;    IBMRANOT - 1 indicates process is NOT from MRA
 ;
 ; Output
 ;    ERRMSG - optional output parameter, passed by reference
 ;           - error message text
 ;
 NEW CST,IBTXSTAT,IB364,PRCASV,DFN,STSMSG
 NEW DIE,DA,DR,IBYY
 ;
 ; Check the bill, make sure the current status is valid
 S IBIFN=+$G(IBIFN),ERRMSG=""
 S CST=$P($G(^DGCR(399,IBIFN,0)),U,13)
 I CST="" S ERRMSG="Bill has no current status defined." G AUTHX
 ; IB*2.0*432  add auto-processing of non-MRA's
 I $G(IBMRANOT)'=1,CST'=2 S ERRMSG="This bill's status is "_$$GET1^DIQ(399,IBIFN_",",.13)_".  It must be REQUEST MRA." G AUTHX
 ;
 ; authorize the bill quietly
 S DIE=399,DA=IBIFN,DR="[IB STATUS]",IBYY="@902" D ^DIE
 ;
 ; Update the review status for all EOB's on file
 D STAT^IBCEMU2(IBIFN,3)     ; Accepted - Complete EOB
 ;
 ; Checks for need to add any codes to bill for EDI (call in quiet mode)
 D AUTOCK^IBCEU2(IBIFN,1)
 ;
 ; Calculate transmittable status
 ;   0 = not transmittable
 ;   1 = yes, live transmittable
 ;   2 = yes, test transmittable
 ; P432 add MRANOT flag so it will create new entry in trans file for non-MRA's
 S IBTXSTAT=+$$TXMT^IBCEF4(IBIFN,,$G(IBMRANOT))
 ;
 ; If transmittable, add this bill to the bill transmission file
 I IBTXSTAT D  I ERRMSG'="" G AUTHX
 . S IB364=$$ADDTBILL^IBCB1(IBIFN,IBTXSTAT)
 . I '$P(IB364,U,3) S ERRMSG="Error loading bill into transmit file."
 . Q
 ;
 ; Pass completed bill to Accounts Receivable (quietly)
 D ARPASS^IBCB1(IBIFN,0)
 I '$G(PRCASV("OKAY")) S ERRMSG="Error while passing bill to A/R." G AUTHX
 ;
 ; Find and process any IB charges on hold
 S DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2)
 D FIND^IBOHCK(DFN,IBIFN)
 ;
 ; If transmittable, check for unreviewed items & update 364 status
 I IBTXSTAT D
 . S STSMSG=$$STATUS^IBCEF4(IBIFN)
 . I $P(STSMSG,U,1) D UPDEDI^IBCEM($P(STSMSG,U,1),"E")
 . I $P(STSMSG,U,2),$P(STSMSG,U,2)'=$P(STSMSG,U,1) D UPDEDI^IBCEM($P(STSMSG,U,2),"E")
 . Q
 ;
AUTHX ;
 Q
 ;
