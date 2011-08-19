IBCEBUL ;ALB/TMP - 837 EDI SPECIAL BULLETINS PROCESSING ;19-SEP-96
 ;;2.0;INTEGRATED BILLING;**137,250,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
NOTSENT ; Check for batches in pending status (no confirmation from Austin)
 ;  from yesterday or before
 N XMTO,XMSUBJ,XMBODY,XMDUZ,IBT,IB,IBE,IBCT,IBI,IB0,IB1,Z,IBTYP
 K ^TMP($J,"IBNOTSENT")
 S (IBCT,IBI)=0
 F  S IBI=$O(^IBA(364.1,"ASTAT","P",IBI)) Q:'IBI  D
 . I $$BCHCHK(IBI) Q    ; Batch check function
 . S IBCT=IBCT+1
 . S IBTYP=$P($G(^IBA(364.1,IBI,0)),U,7)
 . I IBCT'>10,IBTYP'="" S ^TMP($J,"IBNOTSENT",IBTYP,IBI)=""
 . Q
 ;
 I IBCT D
 .S IBT(1)="There are "_IBCT_" EDI batch(es) still pending Austin receipt "
 .S IBT(2)="for more than 1 day.  Please investigate why they have not yet been confirmed"
 .S IBT(3)="as being received by Austin."
 .S IBT(4)=" "
 .I IBCT>10 S IBT(5)="Since there were more than 10 batches found, please run the ",IBT(6)="  EDI BATCHES PENDING RECEIPT report to get a list of these batches."
 .I IBCT'>10 D
 ..S IBT(5)="      BATCH #      PENDING SINCE             MAIL MESSAGE #",IBT(6)="",$P(IBT(6),"-",76)="",IBT(6)="  "_IBT(6),IBE=6
 ..S IBTYP=""
 ..F  S IBTYP=$O(^TMP($J,"IBNOTSENT",IBTYP)) Q:IBTYP=""  D
 ...S Z=$$EXPAND^IBTRE(364.1,.07,IBTYP) S:Z="" Z="??"
 ...I $O(^TMP($J,"IBNOTSENT",IBTYP),-1)'="" S IBE=IBE+1,IBT(IBE)=" "
 ...S IBE=IBE+1,IBT(IBE)="  BATCH TYPE: "_Z
 ...S IBI=0 F  S IBI=$O(^TMP($J,"IBNOTSENT",IBTYP,IBI)) Q:'IBI  D
 ....S IBE=IBE+1,IB0=$G(^IBA(364.1,IBI,0)),IB1=$G(^(1))
 ....S IBT(IBE)="      "_$E($P(IB0,U)_$J("",10),1,10)_"   "_$E($$FMTE^XLFDT($P(IB1,U,6),1)_$J("",20),1,20)_"      "_$P(IB0,U,4),IBE=IBE+1,IBT(IBE)=$J("",8)_$E($P(IB0,U,8),1,72)
 .S XMSUBJ="EDI BATCHES WAITING AUSTIN RECEIPT FOR OVER 1 DAY",XMBODY="IBT",XMDUZ="",XMTO("I:G.IB EDI")=""
 .D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO)
 K ^TMP($J,"IBNOTSENT")
 Q
 ;
UPDBCH(BCHIEN) ; update the status of this batch to show A0:received in Austin
 NEW DIE,DA,DR
 S DIE=364.1,DA=+BCHIEN,DR=".02///A0"
 I $D(^IBA(DIE,DA,0)) D ^DIE
UPDBCHX ;
 Q
 ;
BCHCHK(BCHIEN) ; This function will check the EDI claims associated with this
 ; batch and determine if this batch has been received in Austin or not.
 ;
 ; ** This function is also called by routine IBCERP3 **
 ;
 ; Function value = 1 if we can determine that the batch was received in Austin, or
 ;                = 1 if there are no claims in this batch, or
 ;                = 1 if the batch is less than 24 hours old - too new to worry about
 ;                = 1 means don't display on report or MailMan message
 ;
 ; Function value = 0 if the batch has not yet been received in Austin
 ;                = 0 means we need to display batch on report and in MailMan message
 ;
 NEW IBEDI,IBOK,IBZ,IBIFN,IB0,AR,IBSECS
 S IBEDI=0,IBOK=1,BCHIEN=+$G(BCHIEN)
 ;
 ; if the batch transmission is still less than 24 hours old, skip this batch and get out
 S IBSECS=$$FMDIFF^XLFDT($$NOW^XLFDT,$P($G(^IBA(364.1,BCHIEN,1)),U,6),2)
 I IBSECS<86400 G BCHCHKX    ; # seconds in a day
 ;
 ; if no edi claims in this batch, update batch status and get out
 I '$O(^IBA(364,"C",BCHIEN,0)) D UPDBCH(BCHIEN) G BCHCHKX
 ;
 F  S IBEDI=$O(^IBA(364,"C",BCHIEN,IBEDI)) Q:'IBEDI  D  Q:'IBOK
 . S IBZ=$G(^IBA(364,IBEDI,0))
 . S IBIFN=+IBZ,IB0=$G(^DGCR(399,IBIFN,0))
 . I $P(IB0,U,13)=7 Q                    ; cancelled in IB
 . I $P(IBZ,U,3)'="P" Q                  ; edi claim status is not pending
 . S AR=$P($$BILL^RCJIBFN2(IBIFN),U,2)   ; AR status DBIA 1452
 . I $F(".22.26.39.","."_AR_".") Q       ; collected/closed or cancelled
 . ;
 . ; if we get to this point, then we have found an EDI claim in this batch
 . ; that is not cancelled in IB, the EDI claim status is "P", and the
 . ; AR status is not collected/closed nor cancelled in AR.  So therefore
 . ; this claim didn't get to Austin, so the batch didn't get to Austin.
 . S IBOK=0
 . Q
 ;
 ; If we find the batch has been received in Austin, then change the batch status.
 I IBOK D UPDBCH(BCHIEN)
 ;
BCHCHKX ;
 Q IBOK
 ;
