IBCEM ;ALB/TMP - 837 EDI RETURN MESSAGE PROCESSING ;17-APR-96
 ;;2.0;INTEGRATED BILLING;**137,191,155,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
UPD ; Update messages manually from messages list
 N IBDA,IBOK,IBTDA,ZTSK,IBTSK,IBTYP,IBU,IBU1,IB0
 D FULL^VALM1
 D SEL(.IBDA,1)
 S IBDA=$O(IBDA(""))
 I IBDA="" G UPDQ
 S IBTDA=+IBDA(IBDA)
 I '$$LOCK(IBTDA) G UPDQ
 S IB0=$G(^IBA(364.2,IBTDA,0))
 ;
 I IB0="" D  G UPDQ
 . W !,*7,"Message ",IBDA," is no longer in return message file" S IBOK=""
 . D PAUSE^VALM1
 I $P(IB0,U,11) S IBOK=1 D  G:'IBOK UPDQ
 . N ZTSK
 . S ZTSK=$P(IB0,U,11) D STAT^%ZTLOAD Q:ZTSK(0)=0  ;Task not scheduled
 . I "12"[ZTSK(1) W *7,!,"This message has already been scheduled for update.  Task # is: ",$P(IB0,U,11) S IBOK="" D PAUSE^VALM1
 ;
 I $P(IB0,U,6)=""!("UP"'[$P(IB0,U,6)) D  G UPDQ
 . W !,*7,"Message status ("_$$EXPAND^IBTRE(364.2,.06,$P(IB0,U,6))_") is not appropriate for this action"
 . D PAUSE^VALM1
 ;
 S IBTYP=$P($G(^IBE(364.3,+$P(IB0,U,2),0)),U)
 S IBU=$S(IBTYP="REPORT":"MAILIT^IBCESRV2",IBTYP["837REC":"CON837^IBCESRV2",IBTYP["837REJ":"REJ837^IBCESRV2",IBTYP["835EOB":"EOB835^IBCESRV3",1:""),IBU1=$S(IBTYP["837":$E(IBTYP,$L(IBTYP)),1:2)
 I IBU="" W !,*7,"This message has an invalid message type - can't update" D PAUSE^VALM1 G UPDQ
 S IBTSK=$$TASK(IBU,$P(IB0,U,4),IBTDA,IBU1)
 I IBTSK W !,"Update has been tasked (#",IBTSK,")"
 I 'IBTSK W !,*7,"Update could not be tasked.  Please try again later!!!"
 D PAUSE^VALM1
 ;
 D BLD^IBCEM1
UPDQ I $G(IBTDA) L -^IBA(364.2,IBTDA,0)
 S VALMBCK="R"
 Q
 ;
VP ; View/Print Return Messages
 N DHD,DIC,FLDS,BY,FR,TO,DIR,Y,L,IBDA,IBTDA,IBBILLS
 D FULL^VALM1,SEL(.IBDA,1)
 S IBDA=$O(IBDA(""))
 G:'IBDA VPQ
 S IBTDA=$G(IBDA(IBDA)),IBBILLS=""
 I $P($G(^IBA(364.2,IBTDA,0)),U,4),'$P(^(0),U,5) D
 .S DIR(0)="YA",DIR("B")="NO",DIR("A")="Do you want to list all bills for this batch?: " D ^DIR K DIR
 .I Y S IBBILLS=1
 S DHD=$S(IBBILLS:"[IBCEM MESSAGE LIST HDR]",1:""),DIC="^IBA(364.2,",FLDS=$S(IBBILLS:"[IBCEM MESSAGE LIST]",1:"[CAPTIONED]"),BY="@NUMBER",(FR,TO)=$G(IBDA(IBDA)),L=0 D EN1^DIP
 D PAUSE^VALM1
VPQ S VALMBCK="R"
 Q
 ;
SEL(IBDA,ONE) ; Select entry(s) from list
 ; IBDA = array returned if selections made
 ;    IBDA(n)=ien of bill selected in file 399
 ; ONE = if set to 1, only one selection can be made at a time
 N IB
 K IBDA
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S IBDA=0 F  S IBDA=$O(VALMY(IBDA)) Q:'IBDA  S IB=$G(^TMP("IBCEM-837DX",$J,IBDA)),IBDA(IBDA)=+$P(IB,U,2)
 Q
 ;
UPDEDI(IBDA,FUNC,NOCT) ; Update EDI files - cancel/resubmit/print as
 ;   resolution to message
 ; IBDA = transmit bill ien # for bill
 ; FUNC = "E" for edit/resubmit, "C" for cancel, "R" for resubmit not
 ;       from edit, "P" for print, "Z" for COB processed , "N" for no
 ;       further action needed-close record
 ; NOCT = 1 if not necessary to update batch count, 0 if update needed
 ;
 N IB0,IBBA,IBBDA,IBCT,IBM,IBTDA,IBNEW,DA,DIE,DR,Z,IBTEXT,IBZ,IBIFN,IBSTAT
 S IB0=$G(^IBA(364,+IBDA,0)),IBBA=$P(IB0,U,2)
 Q:IB0=""  S IBIFN=+IB0
 ;
 S IBNEW=$S(FUNC="E"!(FUNC="R"):+$P($G(^IBA(364,+$$LAST364^IBCEF4(+IB0),0)),U,2),1:"") S:IBNEW=IBBA IBNEW=""
 ;
 S IBSTAT=$P(IB0,U,3)                ; current status in file 364
 I '$F(".C.R.E.Z.","."_IBSTAT_".") D   ; don't update if in final status
 . S DR=".03////"_$S(FUNC="E":"R","NP"'[FUNC:FUNC,1:"Z")_";.04///NOW" S:FUNC="E"!(FUNC="R") DR=DR_$S(IBNEW:";.06////"_IBNEW,1:"")
 . S DA=+IBDA,DIE="^IBA(364," D ^DIE ;Update the transmit bill record
 . Q
 ;
 I IBBA D CKRES^IBCESRV2(IBBA) ;Update completely resubmitted flags
 ;
 I IBBA,(FUNC="P"!(IBNEW&'$G(NOCT))) D CTDOWN^IBCEM02(IBBA,1) ;If resubmitted in a new batch or printed, update old batch
 ;
 S IBTEXT(1)=" UPDATED BY: "_$$EXTERNAL^DILFD(361.02,.02,,+$G(DUZ))
 S IBTEXT(2)="ACTION USED: "_$S(FUNC="E":"BILL EDITED/RESUBMITTED",FUNC="C":"BILL CANCELED",FUNC="R":"BILL RESUBMITTED WITHOUT EDIT",FUNC="P":"PRINT BILL",FUNC="Z":"PROCESS COB",1:"")
 S IBTEXT(2)=$S(IBTEXT(2)="":"UNSPECIFIED",1:IBTEXT(2)_" - REVIEW MARKED AS COMPLETE")
 S IBTEXT=2
 ;
 ; Update file 361
 S IBZ=0 F  S IBZ=$O(^IBM(361,"AERR",+IBDA,IBZ)) Q:'IBZ  I $D(^IBM(361,IBZ,0)),$P(^(0),U,10)="",$P(^(0),U,9)<2 D
 . S DIE="^IBM(361,",DR=".09////2;.1////"_$TR(FUNC,"RCEIBZPN","RCROOFOO"),DA=IBZ D ^DIE
 . I FUNC'="","ECRPIBZ"[FUNC D  ; Update review status, notes for message
 .. D NOTECHG^IBCECSA2(IBZ,1,.IBTEXT)
 ;
 ; Update file 361.1 with the Cancel Status, to cancel All EOB's on file
 I FUNC="C" D STAT^IBCEMU2(IBIFN,9,0)
 ;
 Q
 ;
DEL ; Delete messages from messages list - locked with IB SUPERVISOR key
 N IBDA,IBOK,IBTDA,IBTYP,IBU,IBU1,IB0,DIR,IBT,IBE,Z,X,Y,XMSUBJ,XMTO,XMBODY,XMDUZ
 D FULL^VALM1
 S IBTDA=0
 I '$D(^XUSEC("IB SUPERVISOR",DUZ)) D  G DELQ
 . W !,"You don't have authority to use this action. See your supervisr for assistance"
 . D PAUSE^VALM1
 D SEL(.IBDA,1)
 S IBDA=$O(IBDA(""))
 I IBDA="" G DELQ
 W !
 S DIR(0)="YA",DIR("A",1)="This action will PERMANENTLY delete a return message from your system",DIR("A",2)="A bulletin will be sent to report the deletion",DIR("A",3)=" "
 S DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE? ",DIR("B")="NO"
 D ^DIR K DIR
 G:Y'=1 DELQ
 S IBTDA=+IBDA(IBDA)
 I '$$LOCK(IBTDA) G DELQ
 S IB0=$G(^IBA(364.2,IBTDA,0))
 ;
 I $P(IB0,U,11) S IBOK=1 D  G:'IBOK DELQ
 . N ZTSK
 . S ZTSK=$P(IB0,U,11) D STAT^%ZTLOAD Q:ZTSK(0)=0  ;Task not scheduled
 . I "12"[ZTSK(1) W *7,!,"This message is currently scheduled for update.  Task # is: ",$P(IB0,U,11) S IBOK="" D PAUSE^VALM1
 ;
 I $P(IB0,U,6)=""!("UP"'[$P(IB0,U,6)) D  G DELQ
 . W !,*7,"Message status ("_$$EXPAND^IBTRE(364.2,.06,$P(IB0,U,6))_") is not appropriate for this action"
 . D PAUSE^VALM1
 ;
 S DIR(0)="YA",DIR("A",1)=" ",DIR("A",2)="",$P(DIR("A",2),"*",54)="",DIR("A",3)="* This message is about to be PERMANENTLY deleted!! *",DIR("A",4)=DIR("A",2),DIR("A",5)=" "
 S DIR("A")="ARE YOU STILL SURE YOU WANT TO CONTINUE? ",DIR("B")="NO"
 W ! D ^DIR W ! K DIR
 I Y'=1 W !!,"Nothing deleted" D PAUSE^VALM1 G DELQ
 ;
 K ^TMP("IBMSG",$J)
 M ^TMP("IBMSG",$J)=^IBA(364.2,IBTDA)
 D DELMSG^IBCESRV2(IBTDA)
 I $D(^IBA(364.2,IBTDA)) D  G DELQ
 . W !,"Message not deleted - problem with delete" D PAUSE^VALM1
 ;
 S IBT(1)="EDI return message #"_$P(IB0,U)_" has been deleted"
 S IBT(2)=" "
 S IBT(3)="DELETED BY: "_$P($G(^VA(200,+$G(DUZ),0)),U)_"   "_$$FMTE^XLFDT($$NOW^XLFDT,2)
 S Z=$$EXPAND^IBTRE(364.2,.06,$P(IB0,U,6)) S:Z="" Z="??"
 S IBT(4)="    STATUS: "_$E(Z_$J("",11),1,11)_"  MESSAGE TYPE: "_$P($G(^IBE(364.3,+$P(IB0,U,2),0)),U,5)
 S IBT(5)=" MESSAGE #: "_$E($P(IB0,U)_$J("",11),1,11)_"   STATUS DATE: "_$$FMTE^XLFDT($P($G(^TMP("IBMSG",$J,1)),U,3))
 S IBT(6)="   BATCH #: "_$E($P($G(^IBA(364.1,+$P(IB0,U,4),0)),U)_$J("",11),1,11)_"        BILL #: "_$$EXPAND^IBTRE(364.2,.05,$P(IB0,U,5))
 S IBT(7)=" "
 S IBT(8)="MESSAGE TEXT:",IBE=8
 S Z=0 F  S Z=$O(^TMP("IBMSG",$J,2,Z)) Q:'Z  S IBE=IBE+1,IBT(IBE)=$G(^(Z,0))
 S XMSUBJ="EDI MESSAGE DELETED",XMBODY="IBT",XMDUZ="",XMTO("I:G.IB EDI")=""
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 ;
 K ^TMP("IBMSG",$J)
 ;
 W !,"A bulletin has been sent to report this deletion",!
 D PAUSE^VALM1
 ;
 D BLD^IBCEM1
DELQ L -^IBA(364.2,IBTDA,0)
 S VALMBCK="R"
 Q
 ;
TASK(IBRTN,IBBDA,IBTDA,IBTYP) ; Schedule the task to update data base from message
 ; IBRTN = routine to task
 ; IBBDA = batch # associated with the message (OPTIONAL)
 ; IBTDA = internal entry of message
 ; IBTYP = the number that is the last digit in the message type
 ;
 N ZTSK,ZTDESC,ZTIO,ZTDTH,ZTSAVE,DA,DR,DIE
 S ZTIO="",ZTDTH=$H,ZTDESC="UPDATE DATA BASE FROM EDI RETURN MESSAGE",ZTSAVE("IB*")="",ZTRTN=IBRTN
 D ^%ZTLOAD
 I $G(ZTSK),$G(^IBA(364.2,IBTDA,0)) S DIE="^IBA(364.2,",DR=".11////"_ZTSK_";.06////U",DA=IBTDA D ^DIE
 Q $G(ZTSK)
 ;
LOCK(IBTDA) ; Attempt to lock message file entry IBTDA
 ; Return 1 if successful, 0 if not able to lock
 ;
 N OK
 S OK=1
 L +^IBA(364.2,IBTDA,0):5
 I '$T D
 . I '$D(DIQUIET) W !,*7,"Another user is editing this entry ... try again later" D PAUSE^VALM1
 . S IBDA="",OK=0
 Q OK
 ;
