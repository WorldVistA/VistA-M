RCDPEWL ;ALB/TMK/KML - ELECTRONIC EOB MESSAGE WORKLIST ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,208,269,298,317**;Mar 20, 1995;Build 8
 ;Per VA Directive 6402, this routine should not be modified.
 ; IA for read access to ^IBM(361.1 = 4051
 ;
EN ; Main entry point
 N RCFASTXT,DA,DIC,X,Y,RCERA,RCNOED,RCQUIT  ;PRCA*4.5*317 Added RCQUIT
 D FULL^VALM1
 ;
 S DIR(0)="SA^L:LIST;S:SPECIFIC"
 S DIR("A")="Do you want a (L)IST of ERAs or a (S)PECIFIC one?: "
 S DIR("?",1)="Enter LIST to see a list of ERAs."
 S DIR("?")="Enter SPECIFIC to see a selected ERA."
 S DIR("B")="LIST"
 W !
 D ^DIR
 K DIR
 Q:$D(DTOUT)!$D(DUOUT)
 I Y="S" D  Q
 . S DIC="^RCY(344.4,",DIC(0)="AEMQ"
 . D ^DIC
 . I Y>0 D WL^RCDPEWL7(+Y)
 ;
 ; Calling Preferred View API in Menu Option Mode
 D PARAMS^RCDPEWL0("MO")
 Q:$G(RCQUIT)
 D EN^VALM("RCDPE WORKLIST ERA LIST")
 Q
 ;
DISP(RCERA,RCNOED) ; Entry to worklist from receipt processing
 ;  RCERA = ien of entry in file 344.49
 ; RCNOED = 1 if receipt exists/no editing allowed
 ;        = 2 if no edit and called from receipt processing
 ;  ; prca*4.5*298 - added AUTOPOST input argument
 ; AUTOPOST = "" if ERA is non-autopost
 ;          = 0  if auto-posted ERA is in UNPOSTED status
 ;          = 1 if auto-posted ERA is in PARTIAL posted status
 ;          = 2 if auto-posted ERA is in COMPLETE status
 ;
 N DUOUT,DTOUT,DIC,DIK,X,Y,DIR,RCQUIT,DA,DIE,DR,RCSCR,RC0,RC5,RCDAT,RCUNM
 ;
 S RCSCR("NOEDIT")=+$G(RCNOED)
 S RCQUIT=0,RC0=$G(^RCY(344.4,RCERA,0)),RC5=$G(^RCY(344.4,RCERA,5))
 I 'RCSCR("NOEDIT"),'$O(^RCY(344.49,"B",RCERA,0)) D  G:RCQUIT DISPQ
 . ;allow additional selections
 . S DIR("A",1)="No worklist scratchpad entry exists for this ERA."
 . S DIR("A")="(C)reate scratchpad, (V)iew ERA details or (E)xit:"
 . S DIR(0)="SAO^C:CREATE SCRATCHPAD;V:VIEW ERA DETAILS;E:EXIT"
 . W ! D ^DIR K DIR
 . I (Y'="V")&(Y'="C")&(Y'="E") S RCERA=-1,RCQUIT=1 Q
 . I Y="V" S RCSCR=RCERA D PRERA1^RCDPEWL0 S RCERA=-1,RCQUIT=1  Q
 . I Y="E" S RCERA=-1,RCQUIT=1 Q
 . ; prca*4.5*298  Y is = "C" therefore perform the pre-existing scratchpad creation/editing algorithm
 . I $P(RC0,U,15)'="" W !!,"PAYMENT METHOD CODE REPORTED: "_$P(RC0,U,15),!
 . I $P(RC0,U,15)="" W !!,"NO PAYMENT METHOD CODE REPORTED",!
 . I $P(RC0,U,9)=0,$P(RC5,U,2)="" D  Q:RCQUIT
 .. S RCQUIT=0,RCUNM=0
 .. I +$P(RC0,U,5)=0,"ACH"'[(U_$P(RC0,U,15)_U) D  Q:RCQUIT!RCUNM
 ... S DIR("A",1)="This ERA has no payment associated with it and can be marked as",DIR("A",2)="'MATCH-0 PAYMENT' to remove it from the ERA AGING REPORT if no paper check or",DIR("A",3)="EFT is expected to be received for this ERA"
 ... S DIR("?")="Do NOT respond YES here unless you are sure there will be no EFT or paper",DIR("?",1)=" check to be received for this 0-PAYMENT ERA"
 ... S DIR("A")="Do you want to do this?: "
 ... S DIR(0)="YA"
 ... D ^DIR K DIR
 ... I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 ... I Y'=1 Q
 ... S DIE="^RCY(344.4,",DR=".09////3;.14////3",DA=RCERA D ^DIE S RCUNM=1
 .. I 'RCUNM D
 ... S DIR("A",1)="This ERA does NOT have a matching EFT",DIR("A")="Enter the number of the paper check you received for this ERA: ",DIR(0)="344.01,.07A"
 ... I $P(RC5,U,2)'="" S DIR("B")=$P(RC5,U,2)
 ... I $G(DIR("B"))="",$P(RC0,U,2)'="" S DIR("B")=$P(RC0,U,2)
 ... W ! D ^DIR K DIR
 ... I $D(DTOUT)!$D(DUOUT)!(Y="") D  S RCQUIT=1 Q
 .... S DIR(0)="EA",DIR("A",1)="There must be either a paper check or an EFT for this ERA",DIR("A")="PRESS RETURN TO CONTINUE " W !!  D ^DIR K DIR
 ... S RCDAT("CHECK#")=Y
 ... S DIR(0)="344.01,.1O",DIR("B")=$$FMTE^XLFDT($P(RC0,U,4),2)
 ... W ! D ^DIR K DIR
 ... I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 ... S RCDAT("CHECKDT")=Y
 ... S DIR(0)="344.01,.08O"
 ... W ! D ^DIR K DIR
 ... I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 ... S RCDAT("BANK")=Y
 ... S DIR("A",1)="ERA #"_RCERA_" (TRACE #:"_$P(RC0,U,2)_") matched to paper check "_RCDAT("CHECK#"),DIR("A")="Is this correct?: ",DIR(0)="YA",DIR("B")="YES" W ! D ^DIR K DIR
 ... I Y'=1 S RCQUIT=1 Q
 ... S DIE="^RCY(344.4,",DA=RCERA,DR=".13////"_RCDAT("CHECK#")_";.09////2" D ^DIE
 ;
 S RCSCR=+$O(^RCY(344.49,"B",RCERA,0))
 I 'RCSCR D  ; Build the entry in file 344.49
 . I RCSCR("NOEDIT") D  Q
 .. S DIR("A")="NO worklist entry exists for this ERA - PRESS RETURN TO CONTINUE ",DIR(0)="EA" W ! D ^DIR K DIR
 . ;
 . S RCSCR=+$$ADDREC(RCERA,.RCDAT)
 . I RCSCR D  Q:'RCSCR
 .. F X=1:1:6 L +^RCY(344.4,RCSCR):5 Q:$T  I X=6 D  Q
 ... S DA=RCSCR,DIK="^RCY(344.49," D ^DIK S RCSCR=0
 ... S DIR(0)="EA",DIR("A",1)="Another user has locked this entry - NEW RECORD NOT CREATED",DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR
 .. Q:'RCSCR
 .. ; prca*4.5*298  per patch requirements, keep code related to 
 .. ; creating/maintaining batches but just remove from execution.
 .. ;D SETBATCH^RCDPEWLB(RCSCR) ; prca*4.5*298
 .. D ADDLINES^RCDPEWLA(RCSCR)
 .. K ^TMP($J,"BATCHES")
 ;
 I RCSCR D  G:'RCSCR DISPQ
 . ; prca*4.5*298  per patch requirements, keep code related to 
 . ; creating/maintaining batches but just remove from execution.
 . ;Q:'$$BAT^RCDPEWL7(RCSCR)
 . ;I 'RCSCR("NOEDIT"),'$G(^TMP("RCBATCH_SELECTED",$J)) L +^RCY(344.4,RCSCR):5 I '$T W !!,"Another user is currently editing this entry",! S DIR(0)="E" D ^DIR K DIR S RCSCR=0 Q
 . I 'RCSCR("NOEDIT") L +^RCY(344.4,RCSCR):5 I '$T W !!,"Another user is currently editing this entry",! S DIR(0)="E" D ^DIR K DIR S RCSCR=0 Q
 . D EN^VALM("RCDPE EOB WORKLIST")
 ;
DISPQ L -^RCY(344.4,+$G(RCERA))
 Q
 ;
INIT ; -- set up initial variables
 N RCQUIT,RCREV
 S VALMCNT=0,VALMBG=1
 S RCQUIT=0
 ; PRCA*4.5*298: Removed functionality for retrieving/storing user preferences in file #344.49
 ; and replaced with the use of parameters handled by PARAMS^RCDPEWLA.
 D PARAMS^RCDPEWLA("MO") I $G(RCQUIT) S VALMQUIT=1 Q
 D BLD^RCDPEWL1($G(^TMP($J,"RC_SORTPARM")))
 Q
 ;
CV ; Change View Action for EEOB Worklist
 D FULL^VALM1
 D PARAMS^RCDPEWLA("CV")
 D BLD^RCDPEWL1($G(^TMP($J,"RC_SORTPARM"))),HDR
 S VALMBCK="R",VALMBG=1
 Q
 ;
ADDREC(RCERA,RCDAT) ; Add a record to file 344.49
 ; RCERA = ien of file 344.4
 ; RCDAT = array containing additional data to add to new entry
 ;
 N DIC,DLAYGO,X,Y,DO,DD,RCY,DINUM
 S RCY=0,DIC("DR")=""
 S DIC(0)="L",DLAYGO=344.49,(DINUM,X)=RCERA,DIC="^RCY(344.49,"
 I $G(RCDAT("CHECK#"))'="" S DIC("DR")=".04////"_RCDAT("CHECK#")_";"
 I $G(RCDAT("CHECKDT"))'="" S DIC("DR")=DIC("DR")_".05////"_RCDAT("CHECKDT")_";"
 I $G(RCDAT("BANK"))'="" S DIC("DR")=DIC("DR")_".06////"_RCDAT("BANK")_";"
 K DD,DO D FILE^DICN K DIC
 I Y>0 S RCY=+Y
 Q RCY
 ;
HDR ; Creates header lines for the selected ERA display
 N X,Z,I,RC,RC5,RC4,RCSORTBY,RCEEOBPU
 F I=1:1:5 S VALMHDR(I)=""
 I '$G(RCSCR) S VALMQUIT=1 Q
 S RC=$G(^RCY(344.4,+RCSCR,0)),RC5=$G(^RCY(344.4,+RCSCR,5))
 S RC4=$G(^RCY(344.4,+RCSCR,4))  ;prca*4.5*298 
 S VALMHDR(1)=$E("ERA Entry #: "_$P(RC,U)_$J("",31),1,31)_"Total Amt Pd: "_$J(+$P(RC,U,5),"",2)
 S VALMHDR(2)="Payer Name/ID: "_$P(RC,U,6)_"/"_$P(RC,U,3)
 S Z=+$O(^RCY(344.31,"AERA",+RCSCR,0))
 I Z S VALMHDR(3)="EFT #/TRACE #: "_$P($G(^RCY(344.3,+$G(^RCY(344.31,Z,0)),0)),U)_"/"_$P(RC,U,2)
 I 'Z,$P(RC5,U,2)'="" S VALMHDR(3)="PAPER CHECK #: "_$P(RC5,U,2)
 ; prca*4.5*298  per patch requirements, keep code related to creating/maintaining
 ; batches but just remove from execution.
 ;I $G(^TMP("RCBATCH_SELECTED",$J)) D
 ;. N Z,Z0
 ;. S Z=+$G(^TMP("RCBATCH_SELECTED",$J)),Z0=$G(^RCY(344.49,RCSCR,3,Z,0))
 ;. S RCT=RCT+1,VALMHDR(RCT)="BATCH: "_Z_"  "_$P(Z0,U,2)_"  "_$$EXTERNAL^DILFD(344.493,.03,"",$P(Z0,U,3))
 I $G(RCSCR("NOEDIT")) D
 . S VALMHDR(4)="*** RECEIPT(S) ALREADY CREATED *** ("_$$RECEIPTS(RCSCR)_")"
 I $P(RC4,U,2)]"" D  ;AUTO-POST STATUS (344.4, 4.02);  if not null, then the selected ERA is designated for auto-post
 . ; Setting the Auto-Post info in the header
 . N AUTOPSTS
 . S AUTOPSTS="Auto-Post Status: "_$S($P(RC4,U,2)=0:"Unposted",$P(RC4,U,2)=1:"Partial",1:"Complete")
 . S AUTOPSTS=AUTOPSTS_"    Auto-Post Date: "_$S($P(RC4,U,2)=2:$$FMTE^XLFDT($P(RC4,U)),1:"")
 . S VALMHDR(5)=AUTOPSTS
 ; Displaying Current View (PRCA*4.5*298)
 S $E(VALMHDR(1),60)="Current View:"
 S RCSORTBY=$G(^TMP($J,"RC_SORTPARM"))
 S $E(VALMHDR(2),60)=$S(RCSORTBY="F":"ZERO-PAYMENTS FIRST",RCSORTBY="L":"ZERO-PAYMENTS LAST",1:"NO SORT ORDER")
 S RCEEOBPU=$G(^TMP($J,"RC_EEOBPOST"))
 S $E(VALMHDR(3),60)=$S(RCEEOBPU="P":"POSTED EEOBs ONLY",RCEEOBPU="U":"UNPOSTED EEOBs ONLY",1:"ALL EEOBS")
 Q
 ;
FNL ; -- Clean up list
 K ^TMP("RCDPE-EOB_WLDX",$J),^TMP("RCDPE-EOB_WL",$J),^TMP($J,"RC_SORTPARM"),^TMP($J,"RC_BILL")
 D CLEAN^VALM10,CLEAR^VALM1
 K RCFASTXT
 Q
 ;
SEL(RCDA) ; Select entry from worklist scratch pad screen
 ; RCDA = array returned if selections made
 ;    RCDA(n)=ien of entry(s) in file 344.41 
 ;            where n = the line # selected  
 K RCDA
 N VALMY
 D EN^VALM2($G(XQORNOD(0)),"S")
 S RCDA=0 F  S RCDA=$O(VALMY(RCDA)) Q:'RCDA  S RCDA(RCDA)=$P($G(^TMP("RCDPE-EOB_WLDX",$J,RCDA)),U,2,5)
 Q
 ;
NOEDIT ; Display no edit allowed if receipt exists
 N DIR,X,Y
 S DIR(0)="EA",DIR("A",1)="This action is NOT available since the ERA already has a receipt."
 S DIR("A")="PRESS RETURN TO CONTINUE "
 W ! D ^DIR K DIR W !
 Q
 ;
NOBATCH ; Display action not allowed if working at batch level not the ERA level
 N DIR,X,Y
 S DIR(0)="EA",DIR("A",1)="This action is NOT valid when in a batch within the ERA."
 S DIR("A")="PRESS RETURN TO CONTINUE "
 W ! D ^DIR K DIR W !
 Q
 ;
RECEIPTS(RCSCR) ; get list of receipts for the ERA 
 ; Input: RCSCR: ERA File (#344.4) IEN
 ; Output: "" - No Receipt / REC# - One Receipt / REC#A-REC#Z - Range of Receipts
 N X,RECEIPT,CTR,RC0
 K ARRAY,STR
 S X=0,CTR=1,(STR,RECEIPT)=""
 F  S X=$O(^RCY(344.4,RCSCR,1,"RECEIPT",X)) Q:'X  D
 . S:X RECEIPT=$P($G(^RCY(344,X,0)),U)  ; get external form of receipt 
 . I RECEIPT]"" S ARRAY(RECEIPT)=""
 ; array of receipts does not exist so this could be a non auto-posted ERA; so only 1 receipt will be assigned; retrieve at 344.4, .08
 I '$D(ARRAY),$$GET1^DIQ(344.4,RCSCR,.08)'="" S ARRAY($$GET1^DIQ(344.4,RCSCR,.08))=""
 ;
 I $O(ARRAY($O(ARRAY(""))))'="" D
 . S STR=$O(ARRAY(""))_"-"_$O(ARRAY(""),-1)
 E  D
 . S STR=$O(ARRAY(""))
 Q STR
