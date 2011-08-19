IBCEOB3 ;ALB/TMP - 835 EDI EOB BULLETINS ;18-FEB-99
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 Q
 ;
CHGBULL(IBEOB,IBBULL) ; Send bulletin that name and/or id number for insured
 ;  has been reported changed via EDI
 ; IBEOB = the internal entry # of the entry in file 361.1
 ; IBBULL = the flag that has 2 '^' pieces that indicate whether there
 ;          was a name change ('^' piece 1 = 1) or an ID # change ('^'
 ;          piece 2 = 1)
 ;
 N XMBODY,XMSUBJ,XMTO,XMDUZ,IB0,IBT
 Q:'$TR($P($G(IBBULL),U,1,2),U)
 S IB0=$G(^IBM(361.1,+IBEOB,0))
 S XMTO("I:G.IB EDI")="",XMBODY="IBT"
 S IBT(1)="An EOB for Bill # "_$$EXTERNAL^DILFD(399,.01,,+IB0)_" (COB sequence: "_$$EXTERNAL^DILFD(361.1,.15,,$P(IB0,U,15))_") has indicated the following changes:"
 S IBT(2)=" "
 S Z=2
 I $P(IBBULL,U) S Z=Z+1,IBT="  INSURED'S NAME CHANGED FROM: "_$P(IBBULL,U,3)_" to "_$P(IBBULL,U,4),Z=Z+1,IBT(Z)=$J("",10)_"(Only the claim has been updated with the new name)"
 I $P(IBBULL,U,2) S Z=Z+1,IBT="  INSURED'S ID # CHANGED FROM: "_$P(IBBULL,U,5)_" to "_$P(IBBULL,U,6),Z=Z+1,IBT(Z)=$J("",10)_"(Both claim and policy have been updated with the new id)"
 S XMSUBJ="INSURED'S "_$S(IBBULL:"NAME ",1:"")_$S($P(IBBULL,U,2):$S(IBBULL:"AND ",1:"")_"ID ",1:"")_"CHANGE INDICATED ON EOB"
 S XMDUZ=""
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 Q
 ;
COBBULL(IBEOB) ; Send bulletin that COB may be pending on processing an EOB
 ; IBEOB = the internal entry # of the entry in file 361.1
 ;
 N IBBILL,IB0,IBT,XMBODY,XMSUBJ,XMTO,XMDUZ
 S XMTO("I:G.IB EDI")="",XMBODY="IBT"
 S IB0=$G(^IBM(361.1,+IBEOB,0))
 S IBBILL=$$BN^PRCAFN(+IB0)
 Q:IB0=""
 S IBT(1)="         BILL NUMBER: "_IBBILL
 S IBT(2)="CURRENT COB SEQUENCE: "_$$EXTERNAL^DILFD(361.1,.15,,$P(IB0,U,15))
 S IBT(3)="            EOB DATE: "_$$FMTE^XLFDT($P(IB0,U,5),2)
 S IBT(4)=" "
 S IBT(5)="There is subsequent insurance and the balance on the bill is > 0."
 S IBT(6)="COB processing is needed to collect from this bill's next payer."
 S XMSUBJ="FINAL EOB RECEIVED-"_IBBILL
 S XMDUZ=""
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 Q
 ;
