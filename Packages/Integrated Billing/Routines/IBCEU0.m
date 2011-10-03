IBCEU0 ;ALB/TMP - EDI UTILITIES ;02-OCT-96
 ;;2.0;INTEGRATED BILLING;**137,197,155,296,349,417**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
NOTECHG(IBDA,IBNTEXT) ; Enter who/when review stat change was entered
 ; IBDA = ien of entry in file 361.1
 ; IBNTEXT = array containing the lines of text to store if not using the
 ;           default text  IBNTEXT = # of lines  IBNTEXT(#)=line text
 N IBIEN,IBTEXT,DA,X,Y,DIC,DO,DLAYGO,DD
 S DA(1)=IBDA,DIC="^IBM(361.1,"_DA(1)_",2,",DIC(0)="L",DLAYGO=361.121
 S X=$$NOW^XLFDT
 D FILE^DICN K DIC,DD,DO,DLAYGO
 Q:Y'>0
 S DA(2)=DA(1),DA(1)=+Y,IBIEN=DA(1)_","_DA(2)_","
 I $G(IBNTEXT) D
 . M IBTEXT=IBNTEXT
 E  D
 . S IBTEXT(1)="REVIEW STATUS CHANGED TO '"_$$EXTERNAL^DILFD(361.1,.2,,$P(^IBM(361.1,DA(2),0),U,20))_"'  BY: "_$$EXTERNAL^DILFD(361.121,.02,,+$G(DUZ))
 D WP^DIE(361.121,IBIEN,.03,,"IBTEXT") K ^TMP("DIERR",$J)
 Q
 ;
LOCK(IBFILE,IBREC) ; Lock record # IBREC in file #IBFILE (361 or 361.1)
 N OK
 S OK=0
 L +^IBM(IBFILE,IBREC):3 I $T S OK=1
 I 'OK D
 . W !,"Another user has locked this record - try again later"
 . D PAUSE^VALM1
 Q OK
 ;
UNLOCK(IBFILE,IBREC) ; Unlock record # IBREC in file #IBFILE
 I $G(IBREC) L -^IBM(IBFILE,IBREC)
 Q
 ;
MSTAT ; Enter reviewed by selected range
 N IBDAX,IBA,IBCLOSE,IBLOOK,IBOK,IBSTOP,IBREBLD,IBCLOK,DA,DIR,X,Y,DIE,DR
 D FULL^VALM1
 D SEL^IBCECSA4(.IBDAX)
 S IBREBLD=0
 I $O(IBDAX(""))="" G MSTATQ
 S DIR("?,1")="ONLY SELECT TO CLOSE THE TRANSMIT RECORDS IF YOU KNOW THESE ARE THE FINAL",DIR("?",2)="  ELECTRONIC MESSAGES YOU WILL RECEIVE FOR ALL THE BILLS REFERENCED BY",DIR("?")="  THESE MESSAGES"
 S DIR(0)="YA",DIR("A",1)="DO YOU WANT TO AUTOMATICALLY CLOSE THE TRANSMIT RECORDS FOR ANY MESSAGES",DIR("A")=" THAT AREN'T REJECTS?: ",DIR("B")="NO" W ! D ^DIR K DIR W !
 G:$D(DIRUT) MSTATQ
 S IBCLOSE=(Y=1)
 S DIR(0)="YA",DIR("A")="DO YOU WANT TO SEE EACH MESSAGE BEFORE MARKING IT REVIEWED?: ",DIR("B")="NO"
 S DIR("?",1)="IF YOU OPT TO SEE EACH MESSAGE, YOU CAN CONTROL WHETHER OR NOT THE MESSAGE",DIR("?",2)="  IS MARKED AS REVIEWED"
 I 'IBCLOSE S DIR("?")=DIR("?",2) K DIR("?",2)
 I IBCLOSE S DIR("?",2)=DIR("?",2)_" AND, FOR NON-REJECTS, WHETHER OR NOT TO CLOSE THE",DIR("?")="  TRANSMIT RECORD FOR THE BILL"
 W ! D ^DIR K DIR W !
 G:$D(DIRUT) MSTATQ
 S IBLOOK=(Y=1)
 S IBDAX=0,IBSTOP=0
 F  S IBDAX=+$O(IBDAX(IBDAX)) Q:'IBDAX  D  Q:IBSTOP
 . S IBA=$G(IBDAX(IBDAX))
 . S DIE="^IBM(361,",DA=$P(IBA,U,2),DR=""
 . I DA D
 .. S IBOK=1
 .. S IBCLOK=$S(IBCLOSE:1,1:0)
 .. I IBLOOK D  Q:'IBOK
 ... S DIC="^IBM(361," D EN^DIQ
 ... I '$$LOCK(361,DA) W ! S IBOK=0 Q
 ... S DIR(0)="YA",DIR("A")="OK TO MARK REVIEWED?: ",DIR("B")="YES",DIR("?",1)="IF YOU ENTER YES, THIS MESSAGE WILL BE MARKED REVIEWED"
 ... S DIR("?",2)="IF YOU ENTER NO, THIS MESSAGE WILL NOT BE ALTERED",DIR("?",3)="IF YOU ENTER AN ^, THIS MESSAGE WILL NOT BE ALTERED & NONE OF THE",DIR("?")="   REMAINING MESSAGES WILL BE PROCESSED" D ^DIR K DIR
 ... I Y'>0 S IBOK=0 S:$D(DIRUT) IBSTOP=1 Q
 ... I 'IBCLOSE D
 .... S DIR(0)="YA",DIR("A")="OK TO CLOSE THIS BILL'S TRANSMIT RECORD?: ",DIR("B")="NO"
 .... S DIR("?",1)="If you respond YES to this prompt, the transmit status of this bill will",DIR("?",2)="  be set to CLOSED.  No further electronic processing of this bill will be"
 .... S DIR("?",3)="  allowed.  If you respond NO to this prompt, this electronic message will",DIR("?",4)="  be filed as reviewed, but the bill's transmit status will not be changed."
 .... S DIR("?",5)="  You may wish to periodically print a list of bills with a non-final",DIR("?",6)="  (closed/cancelled/etc) status to ensure the electronic processing of all"
 .... S DIR("?",7)="  bills has been completed.  Closing the transmit bill record here will",DIR("?")="  eliminate the bill from this list."
 .... W ! D ^DIR K DIR W !
 .... I Y'=1 S IBCLOK=0
 .. I 'IBLOOK,$P($G(^IBM(361,DA,0)),U,3)="R" D  Q:'IBOK
 ... S DR="1",DIC="^IBM(361," D EN^DIQ W !,"Bill Number: ",$$EXPAND^IBTRE(361,.01,+^IBM(361,DA,0))
 ... S DIR(0)="YA",DIR("A")="THIS IS A REJECTION ... ARE YOU SURE YOU WANT TO MARK IT REVIEWED?: ",DIR("B")="NO"
 ... S DIR("?",1)="IF YOU ENTER YES, THIS MESSAGE WILL BE MARKED REVIEWED"
 ... S DIR("?",2)="IF YOU ENTER NO, THIS MESSAGE WILL NOT BE ALTERED",DIR("?",3)="IF YOU ENTER AN ^, THIS MESSAGE WILL NOT BE ALTERED & NONE OF THE",DIR("?")="   MESSAGES FOLLOWING THIS ONE WILL BE PROCESSED" D ^DIR K DIR
 ... I Y'=1 S IBOK=0 S:$D(DIRUT) IBSTOP=1
 .. S:'IBREBLD IBREBLD=1
 .. S DR=".09////2;.1////F" D ^DIE
 .. N IBUPD
 .. S IBUPD=0
 .. I $$PRINTUPD($G(^IBM(361,DA,1,1,0)),+$P(^IBM(361,DA,0),U,11)) S IBUPD=1
 .. I $G(^IBM(361,DA,1,1,0))["CLAIM SENT TO PAYER" D UPDTX^IBCECSA2(+$P(^IBM(361,DA,0),U,11),$S(IBCLOK:"Z",1:"A2")) S IBUPD=1
 .. I $G(^IBM(361,DA,1,1,0))["CLAIM REJECTED" D UPDTX^IBCECSA2(+$P(^IBM(361,DA,0),U,11),"E") S IBUPD=1
 .. I IBCLOK,'IBUPD D UPDTX^IBCECSA2(+$P(^IBM(361,DA,0),U,11),"Z")
 .. I 'IBLOOK D
 ... W !,"Seq #: ",IBDAX,"  Bill number: ",$$EXPAND^IBTRE(361,.01,+^IBM(361,DA,0)),?45,"REVIEWED"
 .. D NOTECHG^IBCECSA2(DA,1)
 .. D UNLOCK(361,DA)
 W !!,"LAST SELECTION PROCESSED",!
 D PAUSE^VALM1
MSTATQ S VALMBCK="R"
 I IBREBLD D BLD^IBCECSA1
 Q
 ;
PRPAY(IBIFN,IBMCR) ; Returns total amount of prior payments applied to
 ; bill ien IBIFN
 ; IBMCR = flag passed in as 1 if MRA total should be included
 ;
 N IBTOT,IBZ,IBSEQ
 S IBSEQ=$$COBN^IBCEF(IBIFN)
 I IBSEQ'>1 S IBTOT=0 G PRPAYQ
 D F^IBCEF("N-PRIOR PAYMENTS","IBZ",,IBIFN)
 S IBTOT=IBZ
 I $G(IBMCR),$$MCRONBIL^IBEFUNC(IBIFN)=1 D  ; MCR on bill before curr ins
 . N Z,Z0,Z2,Q
 . F Z=1:1:IBSEQ-1 I $$WNRBILL^IBEFUNC(IBIFN,Z) D
 .. S IBTOT=+$$MCRPAY(IBIFN)
PRPAYQ Q IBTOT
 ;
PRINTUPD(IBTEXT,IBDA) ; If the status message indicates claim was printed
 ;    or the claim record in file 399 says it was, update the transmit
 ;    message status to closed
 ; IBTEXT = the first line text of the status message (optional)
 ; IBDA = the ien of the transmission record in file 364
 ;
 ; FUNCTION returns 1 if message status changed
 ;
 N IBP,IBP1
 S IBP=0,IBP1=$P($G(^DGCR(399,+$G(^IBA(364,+$G(IBDA),0)),"TX")),U,7)
 I $G(IBTEXT)["CLAIM RECEIVED, PRINTED AND MAILED BY PRINT CENTER"!IBP1 D
 . N Z
 . S Z=$E($P($G(^IBA(364,IBDA,0)),U,3),1)
 . I "AP"'[Z Q  ; Only change if status is pending or received/accepted
 . D UPDTX^IBCECSA2(IBDA,"Z") S IBP=1
 Q IBP
 ;
MCRPAY(IBIFN) ; Calculate MRA total for the bill IBIFN
 N IBPAY,Q,Z0
 S IBPAY=0
 ;include eligible bill for process
 S Q=0 F  S Q=$O(^IBM(361.1,"B",IBIFN,Q)) Q:'Q  I $$EOBELIG^IBCEU1(Q) S IBPAY=IBPAY+$P($G(^IBM(361.1,Q,1)),U,1)
 Q IBPAY
 ;
PREOBTOT(IBIFN) ; Function - Calculates Patient Responsibility Amount
 ; Input:  IBIFN - ien of Bill Number (ien of file 399)
 ; Output Function returns: Patient Responsibility Amount for all EOB's for bill
 ;
 N FRMTYP,IBPTRES
 S IBPTRES=0
 ; Form Type 2=CMS-1500; 3=UB-04
 S FRMTYP=$$FT^IBCEF(IBIFN)
 ;
 ; For bills w/CMS-1500 Form Type, total up Pt Resp amount from top
 ; level of EOB (field 1.02) for All MRA type EOB's on file for that
 ; bill (IBIFN)
 ;  
 I FRMTYP=2 D  Q IBPTRES
 . N IBEOB,EOBREC,EOBREC1,IBPRTOT
 . S (IBEOB,IBPRTOT,IBPTRES)=0
 . F  S IBEOB=$O(^IBM(361.1,"B",IBIFN,IBEOB)) Q:'IBEOB  D  ;
 . . S EOBREC=$G(^IBM(361.1,IBEOB,0)),EOBREC1=$G(^(1))
 . . I $P(EOBREC,U,4)'=1 Q  ;make sure it's an MRA
 . . Q:$D(^IBM(361.1,IBEOB,"ERR"))  ;no filing error
 . . ; Total up Pt Resp Amounts on all valid MRA's
 . . S IBPTRES=IBPTRES+$P(EOBREC1,U,2)
 ;
 ; For bills w/UB-04 Form Type, loop through all EOB's and sum up amounts
 ; on both Line level and on Claim level
 N EOBADJ,IBEOB,LNLVL
 S IBEOB=0
 F  S IBEOB=$O(^IBM(361.1,"B",IBIFN,IBEOB)) Q:'IBEOB  D  ;
 . I $P($G(^IBM(361.1,IBEOB,0)),U,4)'=1 Q    ; must be an MRA
 . Q:$D(^IBM(361.1,IBEOB,"ERR"))  ; no filing error
 . ; get claim level adjustments
 . K EOBADJ M EOBADJ=^IBM(361.1,IBEOB,10)
 . S IBPTRES=IBPTRES+$$CALCPR(.EOBADJ)
 . ;
 . ; get line level adjustments
 . S LNLVL=0
 . F  S LNLVL=$O(^IBM(361.1,IBEOB,15,LNLVL)) Q:'LNLVL  D  ;
 . . K EOBADJ M EOBADJ=^IBM(361.1,IBEOB,15,LNLVL,1)
 . . S IBPTRES=IBPTRES+$$CALCPR(.EOBADJ)
 Q IBPTRES
 ;
CALCPR(EOBADJ) ; Function - Calculate Patient Responsibilty Amount
 ; For Group Code PR; Ignore the PR-AAA kludge
 ; Input - EOBADJ = Array of Group Codes & Reason Codes from either the Claim
 ;                 Level (10) or Service Line Level (15) of EOB file (#361.1)
 ; Output - Function returns Patient Responsibility Amount
 ;
 N GRPLVL,RSNCD,RSNAMT,PTRESP
 S (GRPLVL,PTRESP)=0
 F  S GRPLVL=$O(EOBADJ(GRPLVL)) Q:'GRPLVL  D
 . I $P($G(EOBADJ(GRPLVL,0)),U)'="PR" Q  ;grp code must be PR
 . S RSNCD=0
 . F  S RSNCD=$O(EOBADJ(GRPLVL,1,RSNCD)) Q:'RSNCD  D
 . . I $P($G(EOBADJ(GRPLVL,1,RSNCD,0)),U,1)="AAA" Q   ; ignore PR-AAA
 . . S RSNAMT=$P($G(EOBADJ(GRPLVL,1,RSNCD,0)),U,2)
 . . S PTRESP=PTRESP+RSNAMT
 Q PTRESP
 ;
COBMOD(IBXSAVE,IBXDATA,SEQ) ; output the modifiers from the COB
 ; SEQ is which modifier we're extracting (1-4)
 ; Build IBXDATA(line#)=Modifier# SEQ
 NEW LN,N,Z,MOD,LNSEQ
 KILL IBXDATA
 I '$G(SEQ) Q
 S (LN,LNSEQ)=0
 F  S LN=$O(IBXSAVE("LCOB",LN)) Q:'LN  D
 . S LNSEQ=LNSEQ+1
 . S (N,Z)=0
 . F  S Z=$O(IBXSAVE("LCOB",LN,"COBMOD",Z)) Q:'Z  D
 .. S N=N+1
 .. S MOD(LNSEQ,N)=$P($G(IBXSAVE("LCOB",LN,"COBMOD",Z,0)),U,1)
 .. Q
 . S MOD=$G(MOD(LNSEQ,SEQ))
 . I MOD'="" S IBXDATA(LNSEQ)=MOD
 . Q
 Q
 ;
