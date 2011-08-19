IBCESRV2 ;ALB/TMP - Server based Auto-update utilities - IB EDI ;03/05/96
 ;;2.0;INTEGRATED BILLING;**137,191,155,296,403**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
CON837 ; Confirmation of 837 batch - auto update
 ;Input expected: IBTDA = the ien of the message entry in file 364.2
 ;
 N IB0,IBBDA,IBBILL,IBMSG,IBFLAG,IBTYP,IBBST,DR,DA,DIE,Z
 Q:'$G(IBTDA)
 S IB0=$G(^IBA(364.2,IBTDA,0)),IBBDA=+$P(IB0,U,4) ;Batch ien
 S IBTYP=$P($G(^IBE(364.3,+$P(IB0,U,2),0)),U)
 ;
 Q:IBTYP'["837REC"
 ;
 I $P(IB0,U,14) D UPDTEST^IBCEPTM(IBTDA) Q  ; Test claim message from claim resubmitted claim
 ;
 ; Austin receipt is '837REC0',
 ;  other non-payer confirmations are '837REC1',
 ;  payer confirmations are '837REC2'
 S IBTYP=+$P(IBTYP,"837REC",2)
 S IBBST=$P($G(^IBA(364.1,IBBDA,0)),U,2)
 ;
 I $S(IBBST?1"A"1N:IBTYP<+$P(IBBST,"A",2),1:0) D  Q
 . ;Don't allow status to go backwards
 . D DELMSG(IBTDA)
 ;
 D UPDCONF(IBBDA,IBTDA,IBTYP,1)
 ;
 Q
 ;
BILLSTAC(IBBILL,IBTYP) ;Change status of transmit bill
 ; IBBILL = the ien of the entry in file 364 to update
 ; IBTYP = code for new status (see field 364;.03 for details)
 ;
 N IBSTAT,DIE,DA,DR,X,Y
 ;
 S IBSTAT=$P($G(^IBA(364,IBBILL,0)),U,3)
 ;
 Q:IBSTAT=IBTYP!(IBTYP="")  ;Status hasn't changed or new status is null
 Q:"CREZ"[IBSTAT  ;Don't update status of completed transmit record
 ;
 ; Don't allow the status to go backwards
 I $E(IBSTAT)="A","PX"[IBTYP Q
 I $E(IBSTAT)="A",$E(IBTYP)="A",$P(IBTYP,"A",2)<$P(IBSTAT,"A",2) Q
 ;
 S DIE="^IBA(364,",DA=IBBILL,DR=".03////"_IBTYP_";.04///NOW" D ^DIE
 Q
 ;
REJ837 ; Rejections 837
 ;Input IBTDA = the ien of the message entry in file 364.2
 ;
 Q:'$G(IBTDA)
 ;
 D UPDREJ(+$P($G(^IBA(364.2,IBTDA,0)),U,4),IBTDA)
 Q
 ;
DELMSG(IBTDA) ;
 ; Delete message after it successfully updates the database.
 ; IBTDA = the ien of the message in file 364.2
 D TRADEL^IBCESRV1(IBTDA)
 Q
 ;
BILLSTAR(IBBILL,IBTDA) ;Change status of transmit bill and bill on rejection
 ; IBBILL = ien of bill (399)
 ; IBTDA = ien of error message
 ;
 N DR,DIE,DA,IBSTAT,IBDA,IBCBH
 ;
 S IBDA=$S($P($G(^IBA(364.2,IBTDA,0)),U,5):$P(^(0),U,5),1:+$O(^IBA(364,"B",IBBILL,""),-1))
 S IBSTAT=$P($G(^IBA(364,IBDA,0)),U,3),IBCBH=$P($G(^DGCR(399,IBBILL,0)),U,21)
 ;
 Q:"CREZ"[IBSTAT  ;Don't update status of completed transmit record
 ;
 I IBSTAT'="E" S DIE="^IBA(364,",DA=IBDA,DR=".03////E;.04///NOW;.05////"_IBTDA D ^DIE
 ;
 ; Don't process further if only testing transmission with insurance co
 Q:+$G(^DIC(36,+$P($G(^DGCR(399,IBBILL,"I"_($F("PST",IBCBH)-1))),U),3))=2
 ;
 ; Suspend bill if waiting for MRA - allows it to be edited
 ;I $P($G(^DGCR(399,IBBILL,0)),U,13)=2,$$NEEDMRA^IBEFUNC(IBBILL)="1N" S DIE="^DGCR(399,",DA=IBBILL,DR=".13////6" D:DA ^DIE
 Q
 ;
UPDMSG(IBTDA,STAT,UPD) ; Update msg with status of 'P','U' or delete message
 ; STAT = 'P' 'U' for pending or updating, 'R' to delete
 ; UPD = flag that says update the data base updated field (.12) if 1
 ;
 N DIE,DA,DR
 ;
 I STAT="R" D DELMSG(IBTDA) Q
 ;
 I $P($G(^IBA(364.2,IBTDA,0)),U,6)'=STAT D
 . S DR=".06////"_STAT_$S($G(UPD):".12////1",1:"")
 . S DIE="^IBA(364.2,",DA=IBTDA
 . I $G(^IBA(364.2,DA,0)) D ^DIE
 Q
 ;
STOREM(IBTDA,IBTEXT,IBE) ;Store message text in file 364.2
 ; INPUT:
 ;   IBTDA = ien in file 364 message field entry #IBTDA
 ;   IBTEXT = name of the array where the message text is retrieved from
 ;            or "@" to delete the text from the message field
 ; OUTPUT:
 ;   IBE = array of errors (IBE("DIERR")) returned, pass by reference
 ;
 N IBZ,X,Y
 ;
 Q:$S($G(IBTEXT)="@":0,1:$D(@IBTEXT)<10)
 ;
 K IBE("DIERR")
 ;
 F IBZ=1:1:20 D WP^DIE(364.2,IBTDA_",",2,"AK",""_IBTEXT_"","IBE") Q:$S('$D(IBE("DIERR")):1,+IBE("DIERR")=1:$G(IBE("DIERR",1))'=110,1:1)  K IBE("DIERR") H .5 ; On lock error, retry up to 20 times
 Q
 ;
CKRES(IBBDA,IBDEF,IBLIST) ;Chk to see if the batch file can be updated to
 ; completely resubmitted based on finding all bills in it
 ; having a status of cancelled, resubmitted, deleted or closed
 ; or if none of these statuses, they at least have a transmission
 ; record for the same bill created at a later date/time.
 ;
 ; IBBDA : Batch # ien in file 364.1
 ; IBDEF : Default to set the batch status to.
 ;         0 or undefined, status will set to 0 (NOT INCOMPLETE)
 ;                         if no incomplete submissions found
 ;         1 status will set to 1 (INCOMPLETE)
 ;                  if any incomplete submissions found
 ;        -1 status will not be updated
 ; IBLIST : If passed by reference and IBLIST=1, returns list of bill
 ;          #'s not resubmitted in IBLIST(ien of file 364)=""
 ;
 N IB,IBINC,IBBILL,DIE,DR,DA,Z,Z0
 ;
 S IBDEF=+$G(IBDEF),IBINC=0
 Q:$S('$G(IBBDA):1,IBDEF'<0:'$P($G(^IBA(364.1,IBBDA,0)),U,10),1:0)
 ;
 I $G(IBLIST) K IBLIST S IBLIST=1
 S IB="" F  S IB=$O(^IBA(364,"ABAST",IBBDA,IB)) Q:IB=""  I "CRDZ"'[IB D  Q:'$G(IBLIST)
 . S Z=0 F  S Z=$O(^IBA(364,"ABAST",IBBDA,IB,Z)) Q:'Z  D
 .. S Z0=($$LAST364^IBCEF4(+$G(^IBA(364,Z,0)))=Z)
 .. I Z0,'$G(IBLIST) S IBINC=1 Q
 .. I $G(IBLIST),Z0 S IBLIST(Z)=""
 ;
 I $S('IBDEF:'IBINC,IBDEF>0:IBINC,1:0) S DA=IBBDA,DIE="^IBA(364.1,",DR=".1////"_IBDEF D ^DIE
 ;
 Q
 ;
UPDCONF(IBBDA,IBTDA,IBTYP,IBAUTO) ; Add status msgs to STATUS file #361
 ;   Update data base from confirmation msg
 ; IBBDA = ien of batch
 ; IBTDA = ien of message
 ; IBTYP = type of message
 ;         (0=Austin confirmation, 1=confirmation by non-payer
 ;          2=confirmation by payer)
 ; IBAUTO = flag for update mode
 ;         0 or null : manual   1 : auto
 ; ^TMP("IBCONF",$J,bill ien)="" where bill ien is the internal entry
 ;         number of any bills in file 364 to be excluded from the
 ;         confirmation due to reported errors
 ;
 N IBBILL,IBIDA,PRCASV,DA,DIE,DR,IBFLAG,IB0,IBS
 ;
 D UPDMSG(IBTDA,"U",0)
 ;
 S IB0=$G(^IBA(364.2,IBTDA,0))
 S IBS="A"_IBTYP
 ;
 S IBBILL="" F  S IBBILL=$O(^IBA(364,"ABABI",+IBBDA,IBBILL)) Q:'IBBILL  D
 . Q:$D(^TMP("IBCONF",$J,IBBILL))  ;Bill was rejected
 . ;Update status of all valid bills in a batch
 . S IBIDA=0 F  S IBIDA=$O(^IBA(364,"ABABI",IBBDA,IBBILL,IBIDA)) Q:'IBIDA  D
 .. D BILLSTAC(IBIDA,IBS)
 . ;
 . I 'IBTYP D
 .. S DR="20///NOW"
 .. S:$P($G(^DGCR(399,IBBILL,"TX")),U,5)="1N" DR=DR_";24///1R"
 .. S DA=IBBILL,DIE="^DGCR(399," D ^DIE
 ;
 I 'IBTYP D DELMSG(IBTDA)   ; remove Austin batch confirmation record from file 364.2
 ;
 I 'IBBDA,$P(IB0,U,5) D
 . N IB
 . S IB=$P($G(^IBA(364,+$P(IB0,U,5),0)),U,2) ; batch
 . D BILLSTAC($P(IB0,U,5),IBS) ;Upd individual transmitted bill entry
 . I $G(^IBA(364.1,+IB,0)),$P($G(^(0)),U,2)'="A0" S DIE="^IBA(364.1,",DA=+IB,DR=".02////A0" D ^DIE
 ;
 I IBBDA,$P($G(^IBA(364.1,+IBBDA,0)),U,2)'=IBS D
 . S DA=IBBDA,DIE="^IBA(364.1,"
 . S DR=".02////"_IBS_$S($G(IBFLAG)'="":";.06////"_IBFLAG,1:"")_";1.05////"_$P(IB0,U,10)_";1.06///NOW"
 . D ^DIE
 ;
 ; Add message to bill status file 361 for bill
 I IBTYP D UPD361^IBCEST(IBTDA)
 ;
 S ZTREQ="@"
 K ^TMP("IBCONF",$J)
 Q
 ;
UPDREJ(IBBDA,IBTDA) ;  Update data base from rejection msg
 ; IBBDA = ien of batch
 ; IBTDA = ien of message
 ;
 N DA,DR,DIE,IBBILL,IBTBILL,IB0
 ;
 D UPDMSG(IBTDA,"U",0)
 ;
 S IB0=$G(^IBA(364.2,IBTDA,0)),IBTBILL=+$P(IB0,U,5),IBBILL=+$G(^IBA(364,IBTBILL,0))
 ;
 I $P(IB0,U,14) D UPDTEST^IBCEPTM(IBTDA) Q  ; Test claim message from claim resubmission - store in test msg file instead
 ;
 I IBBILL D BILLSTAR(IBBILL,IBTDA) ;Update individual bill
 ;
 I IBBDA,'IBBILL D
 . S DA=IBBDA,DIE="^IBA(364.1,"
 . S DR=".11////"_IBTDA_";.06////1;1.05////"_$P(IB0,U,10)_";1.06///NOW;.05////1"
 . D ^DIE ;Batch Rejected
 .;
 . ;Update status of all bills in batch, bill file
 . F  S IBBILL=$O(^IBA(364,"ABABI",IBBDA,IBBILL)) Q:'IBBILL  D BILLSTAR(IBBILL,IBTDA)
 ;
 ;Add message to bill status file 361 for bill
 D UPD361^IBCEST(IBTDA)
 ;
 S ZTREQ="@"
 Q
 ;
MAILIT ; Mails the report text (bulletin) to the IB EDI SUPERVISOR mail grp;
 N IB0,IBHD,IBL,IBZ,IBOK,XMTO,XMSUBJ,XMBODY,XMDUZ,XMZ,Z
 K ^TMP("IBMSG",$J),^TMP("IBMSGH",$J)
 Q:'$G(IBTDA)  ;Assume this exists and is the IEN of the message in 364.2
 S (IBL,IBZ,IBHD)=0,IBOK=1
 F  S IBZ=$O(^IBA(364.2,IBTDA,2,IBZ)) Q:'IBZ  S IB0=$G(^(IBZ,0)) D
 . Q:$P(IB0,U)="REPORT"!($E(IB0,1,4)="99^$")
 . ;
 . I $P(IB0,U)="SUBJECT" D  Q
 .. I $O(^TMP("IBMSG",$J,0)) D SEND(.IBOK) ; send last report
 .. S ^TMP("IBMSGH",$J)=$P(IB0,"SUBJECT^",2)
 . ;
 . I $E(IB0,1,18)="***  NEW PAGE  ***" D  Q
 .. F Z=1:1:5 S IBL=IBL+1,^TMP("IBMSG",$J,IBL)=" "
 .. S ^TMP("IBMSG",$J,IBL)="*** END OF PAGE ***"
 .. F Z=1,2 S IBL=IBL+1,^TMP("IBMSG",$J,IBL)=" "
 . S IBL=IBL+1,^TMP("IBMSG",$J,IBL)=IB0
 . ;
 I $O(^TMP("IBMSG",$J,0)) D SEND(.IBOK)
 I IBOK D DELMSG($G(IBTDA))
 K ^TMP("IBMSG",$J),^TMP($J,"IBMSGH",$J)
 Q
 ;
SEND(IBOK) ; Send actual message for 1 report
 ;
 N XMSUBJ,XMBODY,XMTO,XMZ,XMDUZ
 S XMSUBJ=$G(^TMP("IBMSGH",$J)),XMBODY="^TMP(""IBMSG"",$J)",XMTO("I:G.IB EDI SUPERVISOR")=""
 D SENDMSG^XMXAPI(,$E(XMSUBJ,1,65),XMBODY,.XMTO,,.XMZ)
 I '$G(XMZ) S IBOK=0
 K ^TMP("IBMSG",$J),^TMP("IBMSGH",$J)
 Q
 ;
