IBCECOB ;ALB/CXW - IB COB MANAGEMENT SCREEN ;16-JUN-1999
 ;;2.0;INTEGRATED BILLING;**137,155,288,432,488,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for COB management
 K IBSRT,IBMRADUP
 I $G(IBMRANOT) D EN^VALM("IBCEM COB MANAGEMENT") ;WCJ;IB*2.0*432
 I '$G(IBMRANOT) D EN^VALM("IBCEM MRA MANAGEMENT") ;WCJ;IB*2.0*432
 Q
 ;
HDR ; -- header code
 I '$G(IBMRANOT) S VALMSG="!=Data Mismatch/MSE      Enter ?? for more actions"
 Q
 ;
INIT ; -- init variables and list array
 N DIC,DIRUT,DIROUT,DTOUT,DUOUT,X,Y,DIR,IB1
 K ^TMP("IBBIL",$J),^TMP("IBBIL-DIV",$J)
 S IBSRT=""
 S IB1=1
 W !
 F  S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Select "_$S('IB1:"Another ",1:"")_"BILLER: "_$S('IB1:"",1:"ALL//") D ^DIC K DIC D  Q:Y<0
 . Q:Y<0
 . I $D(^TMP("IBBIL",$J,+Y)) W !,"This biller has already been selected" Q
 . S ^TMP("IBBIL",$J,+Y)=""
 . S IB1=0
 I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 G INITQ
 ;
 I '$G(IBMRANOT) G DIVX
 ;
DIV ; division
 W !
 S DIR(0)="SA^A:All Divisions;S:Selected Divisions"
 S DIR("A")="Include All Divisions or Selected Divisions? "
 S DIR("B")="All"
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT) S VALMQUIT=1 G INITQ  ;Timeout or User "^"
 I Y="A" G DIVX
 ;
 W !
 S IBQUIT=0
 F  D  I IBQUIT S IBQUIT=IBQUIT-1 Q
 . S DIC=40.8,DIC(0)="AEMQ",DIC("A")="   Select Division: "
 . I $O(^TMP("IBBIL-DIV",$J,"")) S DIC("A")="   Select Another Division: "
 . D ^DIC K DIC                ; lookup
 . I X="^^" S IBQUIT=2 Q       ; user entered ^^
 . I +Y'>0 S IBQUIT=1 Q        ; user is done
 . S ^TMP("IBBIL-DIV",$J,+Y)=$P(Y,U,2)
 . Q
 ;
 I IBQUIT S VALMQUIT=1 G INITQ  ;User "^" out of the selection
 ;
 I '$O(^TMP("IBBIL-DIV",$J,"")) D  G DIV
 . W *7,!!?3,"No divisions have been selected.  Please try again."
 . Q
 ;
DIVX ; Exit Division selection.
 ;
 W !
 S DIR("A")=""
 I '$G(IBMRANOT) S DIR("A")="Within Division "
 S DIR("A")=DIR("A")_"Sort By: ",DIR("B")="BILLER"
 S DIR(0)="SBA^B:BILLER;D:DAYS SINCE TRANSMISSION OF LATEST BILL;L:DATE LAST "_$S($G(IBMRANOT):"EOB",1:"MRA")_" RECEIVED;"
 S DIR(0)=DIR(0)_"I:SECONDARY INSURANCE COMPANY;M:"_$S($G(IBMRANOT):"EOB",1:"MRA")_" STATUS;P:PATIENT NAME;R:PATIENT RESPONSIBILITY;S:SERVICE DATE"
 S DIR("?")="Enter the code to indicate how the list should be sorted." D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 G INITQ
 S IBSRT=Y
 ;
 W !
 S IBMRADUP=0
 S DIR("A")="Do you want to include Denied "_$S($G(IBMRANOT):"EOB",1:"MRA")_"s for Duplicate Claim/Service",DIR("B")="No",DIR(0)="YO"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 G INITQ
 I Y S IBMRADUP=1
 ;
 D BLD^IBCECOB1
 ;
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBBIL",$J),^TMP("IBBIL-DIV",$J)
 K ^TMP("IBCECOB",$J),^TMP("IBCECOB1",$J)
 K ^TMP("IBCOBST",$J),^TMP("IBCOBSTX",$J)
 D CLEAN^VALM10
 Q
 ;
EXP ; -- expand code to show additional details of the EOB record
 NEW IBDA,IBIFN,LSTENTRY
 D SEL^IBCECOB2(.IBDA,1)                       ; selects a bill
 S LSTENTRY=+$O(IBDA(0)) I 'LSTENTRY G EXPQ    ; list entry number
 S IBIFN=+$G(IBDA(LSTENTRY)) I 'IBIFN G EXPQ   ; bill#
 ;
 ; If only one MRA on file, call the listman screen and quit
 I $$MRACNT^IBCEMU1(IBIFN)=1 D EN^VALM("IBCEM MRA DETAIL") G EXPQ
 ;
EXPLOOP ; At this point, we know there are multiple MRA's on file
 ;
 D FULL^VALM1
 I $$SEL^IBCEMU1(IBIFN,1,LSTENTRY) D  G EXPLOOP  ; MRA lister/selection
 . NEW IBIFN,LSTENTRY,IBDASAVE                   ; protect variables
 . M IBDASAVE=IBDA                               ; save off IBDA array
 . D EN^VALM("IBCEM MRA DETAIL")                 ; call the listman
 . M IBDA=IBDASAVE                               ; restore IBDA array
 . Q
EXPQ ;
 S VALMBCK="R"
 Q
 ;
COBPOSS(IB364) ; Returns 1 if transmit bill ien in IB364 is currently
 ; in a status where COB may be performed on the bill
 ; Used by index "ACOB", file 364
 N IBWNR,IBNSEQ,IB01,IBM1,IBU1,IB0,IBOK,IBMRA
 S IBOK=1
 S IB0=$G(^IBA(364,IB364,0))
 S IBWNR=$$WNRBILL^IBEFUNC(+IB0),IBMRA=$P($G(^DGCR(399,+IB0,"TX")),U,5)
 S IB01=$G(^DGCR(399,+IB0,0)),IBM1=$G(^("M1")),IBU1=$G(^("U1"))
 I 'IBWNR,IBU1-$P(IBU1,U,2)'>0 S IBOK=0 G COBQ ; Bill has a 0 balance
 I $S('IBWNR:$E($P(IB0,U,3))'="A",1:IBMRA'="1N"&(IBMRA'="A")) S IBOK=0 G COBQ ; Not in correct transmit status
 S IBNSEQ=+$TR($P(IB0,U,8),"PST","230")
 I 'IBNSEQ!'$D(^DGCR(399,+IB0,"I"_IBNSEQ)) S IBOK=0 G COBQ ; No next ins
 I "234"'[$P(IB01,U,13) S IBOK=0 G COBQ ; Bill invalid status for COB
 I IBNSEQ D
 . N Z,IBSTOP
 . S IBSTOP=0
 . F Z=IBNSEQ:1:3 D  Q:IBSTOP
 .. I $D(^DGCR(399,+IB0,"I"_Z)) D
 ... ;Insurance must reimburse
 ... I $P($G(^DIC(36,+^DGCR(399,+IB0,"I"_Z),0)),U,2)="N" S IBOK=0 Q
 ... I $P(IBM1,U,4+Z) S IBOK=0,IBSTOP=1 Q  ; Already has a next seq bill
 ... S (IBOK,IBSTOP)=1
 ;
COBQ Q IBOK
 ;
