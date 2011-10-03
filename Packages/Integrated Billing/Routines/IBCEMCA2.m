IBCEMCA2 ;ALB/ESG - Multiple CSA Message Management - Actions ;20-SEP-2005
 ;;2.0;INTEGRATED BILLING;**320,377**;21-MAR-1994;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
CANCEL ; mass claim cancel
 NEW NS,IBIFN,NSC,DIR,X,Y,DUOUT,DTOUT,DIRUT,DIROUT,IBDA,IB364,DISP,IBCE
 NEW IBMCSRSC,IBMCSRNB,IBMCSCNT,IBMCSTOT,IBMCSTOP,IBMCSCAN,MRACHK,IBCAN,IBMCSCAC
 D FULL^VALM1
 ;
 I '$$KCHK^XUSRB("IB AUTHORIZE") D  G CANCELX
 . W !!?5,"You don't hold the proper security key to access this option."
 . W !?5,"The necessary key is IB AUTHORIZE.  Please see your manager."
 . D PAUSE^VALM1
 . Q
 ;
 S NS=+$G(^TMP($J,"IBCEMCL",4))
 I 'NS D  G CANCELX
 . W !!?5,"There are no selected messages." D PAUSE^VALM1
 . Q
 ;
 ; count number of claims too
 S IBIFN=0 F NSC=0:1 S IBIFN=$O(^TMP($J,"IBCEMCL",4,2,IBIFN)) Q:'IBIFN
 ;
 W !!?5,"Number of messages selected:  ",NS
 W !?7,"Number of claims selected:  ",NSC
 W !!,"In order to cancel "
 W $S(NSC=1:"this claim",1:"these claims")
 W ", a Reason Cancelled and a Reason Not Billable"
 W !,"are required.  You may also provide an optional CT Additional Comment."
 W !,"These will be used as the default responses for "
 W $S(NSC=1:"this claim",1:"all claims")
 W "."
 ;
CANQ1 ; reader call for the Reason Cancelled field
 W !
 S DIR(0)="399,19"
 S DIR("A")="Reason Cancelled"
 D ^DIR K DIR
 I X="",Y="" W *7,!,"This is a required response. Enter '^' to exit." G CANQ1
 I $D(DIRUT) G CANCELX
 M IBMCSRSC=Y           ; save the entered text for reason cancelled
 ;
CANQ2 ; reader call for the reason not billable field
 W !
 S DIR(0)="356,.19"
 S DIR("A")="Reason Not Billable"
 D ^DIR K DIR
 I X="",Y="" W *7,!,"This is a required response. Enter '^' to exit." G CANQ2
 I $D(DIRUT) G CANCELX
 M IBMCSRNB=Y           ; save the reason not billable code/desc
 ;
CANQ3 ; reader call for the Claims Tracking Additional Comment field
 W !
 S DIR(0)="356,1.08O"
 S DIR("A")="CT Additional Comment"
 D ^DIR K DIR
 I $D(DIRUT) G CANCELX
 M IBMCSCAC=Y
 ;
 W !
 S DIR(0)="YO"
 S DIR("A")="OK to proceed into the cancel claim loop",DIR("B")="No"
 D ^DIR K DIR
 I Y'=1 G CANCELX
 ;
 S IBIFN=0,IBMCSCNT=0,IBMCSTOT=NSC,IBMCSTOP=0
 F  S IBIFN=$O(^TMP($J,"IBCEMCL",4,2,IBIFN)) Q:'IBIFN  D  Q:IBMCSTOP
 . S IBMCSCNT=IBMCSCNT+1
 . S IBDA=+$O(^TMP($J,"IBCEMCL",4,2,IBIFN,""),-1)  ; most recent 361 ien
 . S IB364=+$P($G(^IBM(361,IBDA,0)),U,11)          ; transmit bill 364 ien
 . W !!," *** Processing MCS claim# ",IBMCSCNT," of ",IBMCSTOT," ***"
 . S DISP=$$DISP^IBCEM3(IBIFN,"cancel","",1,.DIRUT)
 . ;
 . I $D(DIRUT) D  Q       ; up arrow or time-out
 .. N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 .. S DIR(0)="YO"
 .. S DIR("A")="Do you want to Exit this MCS cancel claim loop"
 .. S DIR("B")="Yes"
 .. W ! D ^DIR K DIR
 .. I Y=1 S IBMCSTOP=1    ; Yes, exit out altogether
 .. Q
 . ;
 . I 'DISP Q              ; user said No to cancel
 . ;
 . I 'IBDA!'IB364 D  Q
 .. W !?4,"Cannot determine the EDI transmission record."
 .. W !?4,"This claim can't be cancelled here."
 .. D PAUSE^VALM1
 .. Q
 . ;
 . D MRACHK^IBCECSA4 I MRACHK Q
 . ;
 . ; set-up required variables for main call to cancel this claim
 . S IBCAN=1,IBMCSCAN=1
 . S IBCE("EDI")=1
 . S Y=IBIFN
 . D
 .. ; protect variables to be restored after call to IBCC and
 .. ; leftover junk variables from IBCC
 .. NEW IBIFN,IBMCSTOP,IBMCSCNT,IBMCSTOT,IBCSAMCS
 .. NEW IBCCCC,IBCCR,IBQUIT,NAME,POP,RDATES,COL,CTRLCOL,FINISH
 .. D NOPTF^IBCC
 .. Q
 . Q
 ;
 I IBMCSTOP W !!?5,"MCS cancel loop aborted."
 I 'IBMCSTOP W !!?5,"Done with MCS cancel loop!"
 D PAUSE^VALM1
 ;
 ; rebuild the list
 KILL ^TMP($J,"IBCEMCA"),VALMHDR
 S VALMBG=1
 D UNLOCK^IBCEMCL
 D INIT^IBCEMCL
 I $G(IBCSAMCS)=1 S IBCSAMCS=2   ; flag to rebuild CSA
 ;
CANCELX ;
 S VALMBCK="R"
 Q
 ;
