IB20P203 ;DSI/ESG - CANCEL CLAIM BUG FIX ;17-OCT-2002
 ;;2.0;INTEGRATED BILLING;**203**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; The purpose of this routine is to correctly "cancel" bills on the
 ; ClaimsManager server that have been cancelled in VistA.  A bill is
 ; considered cancelled in ClaimsManager when all of it's line items
 ; have a status of deleted.
 ;
EN ;
 NEW IBIFN,IBSTAT,CMDATA,TIFLAG,IBCISNT,IBCISTAT,IBCIREDT,IBCIERR,OK
 NEW IBCIPBCT,IBCISOCK
 ;
 ; Make sure the site is using ClaimsManager
 I '$$CK0^IBCIUT1() G EXIT
 ;
 ; If we're in the TEST account, use different ports
 I $$ENV^IBCIUT5="T" D
 . NEW PORT,DA,DIK,DIC,X,Y
 . F PORT=10040,10050,10060 D
 .. S DA=$O(^IBE(350.9,1,50.06,"B",PORT,"")) Q:'DA
 .. S DA(1)=1,DIK="^IBE(350.9,1,50.06,"
 .. D ^DIK
 .. Q
 . Q
 ;
 ; This initial loop is just to count how many bills will be sent
 ; to ClaimsManager.
 ;
 I '$D(ZTQUEUED) W !,"Counting eligible bills ... "
 S IBIFN=0,IBCIPBCT=0
 F  S IBIFN=$O(^IBA(351.9,IBIFN)) Q:'IBIFN  D
 . S IBSTAT=$P($G(^DGCR(399,IBIFN,0)),U,13)     ; IB bill status
 . I IBSTAT'=7 Q                                ; must be cancelled
 . S CMDATA=$G(^IBA(351.9,IBIFN,0))
 . I '$P(CMDATA,U,15) Q                ; must have been sent to CM
 . ;
 . ; If the bill was last sent to CM before 3/27/02, then we're OK
 . ; because the bug was not released until this date.
 . I $P(CMDATA,U,3)<3020327 Q
 . ;
 . ; update count
 . S IBCIPBCT=IBCIPBCT+1
 . Q
 ;
 I '$D(ZTQUEUED) D
 . W "Done"
 . W !!,"The number of cancelled bills that will be sent to ClaimsManager is ",IBCIPBCT,"."
 . I 'IBCIPBCT Q
 . W !!,"Note:  Each ""."" below represents 10 bills."
 . W !!,"Sending cancelled bills to ClaimsManager "
 . Q
 ;
 ; This is the main processing loop.
 ;
 S IBIFN=0,OK=1,IBCIPBCT=0
 F  S IBIFN=$O(^IBA(351.9,IBIFN)) Q:'IBIFN  D  I 'OK Q
 . S IBSTAT=$P($G(^DGCR(399,IBIFN,0)),U,13)     ; IB bill status
 . I IBSTAT'=7 Q                                ; must be cancelled
 . S CMDATA=$G(^IBA(351.9,IBIFN,0))
 . I '$P(CMDATA,U,15) Q                ; must have been sent to CM
 . ;
 . ; If the bill was last sent to CM before 3/27/02, then we're OK
 . ; because the bug was not released until this date.
 . I $P(CMDATA,U,3)<3020327 Q
 . ;
 . ; update count and display a "." every 10 bills
 . S IBCIPBCT=IBCIPBCT+1
 . I IBCIPBCT#10=0,'$D(ZTQUEUED) W "."
 . ;
 . ; temporary information flag; assume 3,4,5 nodes exist
 . S TIFLAG=1
 . I '$P($G(^IBA(351.9,IBIFN,3)),U,1) S TIFLAG=0  ; if they don't exist
 . ;
 . ; Process this bill and retrieve variable OK
 . D PROCESS(IBIFN,.OK)
 . ;
 . ; remove the 3,4,5 nodes if they were not there before
 . I 'TIFLAG D DELTI^IBCIUT4
 . Q
 ;
 I 'OK,'$D(ZTQUEUED) D
 . W !!,"The post-install routine failed due to too many tcp/ip failures with 1 bill."
 . W !,"Please check the error trap."
 . W !,"This routine will now intentionally crash."
 . W !!
 . Q
 ;
 I 'OK X "<BOOM>"    ; intentional crash
 ;
 I '$D(ZTQUEUED) W " Done"
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 ;
PROCESS(IBIFN,OK) ; Procedure to process 1 bill
 ; IBIFN is passed in as the internal bill#
 ; OK is an output parameter to determine if we can proceed
 ;
 NEW IBCIPECT,IBCIPZE
 S IBCIPECT=0,IBCIPZE=""         ; error variables
TRYAGN ;
 D SEND(IBIFN)                   ; send to ClaimsManager
 ;
 ; Control comes here after error trap processing
 ; and stack levels are unwound
 ;
 I IBCIPZE="" S OK=1 G PROCX     ; no errors, we're OK
 I IBCIPECT>5 S OK=0 G PROCX     ; too many errors, we're done
 HANG 2                          ; pause in between sendings
 G TRYAGN                        ; try again
PROCX ;
 Q
 ;
 ;
SEND(IBIFN) ; Send one bill to ClaimsManager
 NEW $ESTACK,$ETRAP
 S $ETRAP="D ERRTRP^IB20P203"
 S IBCISNT=4,IBCIPZE=""
 D ST2^IBCIST
 HANG 2
SENDX ;
 Q
 ;
 ;
ERRTRP ; Error Trap processing
 ;
 S IBCIPZE=$$EC^%ZOSV                         ; error message
 DO CLOSE^%ZISTCP                             ; close the tcp/ip port
 I $G(IBCISOCK) L -^IBCITCP(IBCISOCK)         ; unlock the port
 KILL ^TMP($J,"CMRESP2"),^TMP("IBCIMSG",$J)   ; kill scratch globals
 S IBCIPECT=IBCIPECT+1                        ; error count for this bill
 I IBCIPECT>5 D ^%ZTER                        ; log error if cascading
 I '$D(ZTQUEUED) D
 . W !!,"Error detected: ",IBCIPZE
 . W !,"       Bill ID: ",$P($G(^DGCR(399,IBIFN,0)),U,1)
 . W !,"   Error count: ",IBCIPECT
 . Q
 G UNWIND^%ZTER                               ; unwind stack levels
 ;
