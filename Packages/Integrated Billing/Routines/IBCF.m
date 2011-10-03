IBCF ;ALB/RLW - task 1500/UB printing ;12-JUN-92
 ;;2.0;INTEGRATED BILLING;**33,63,52,121,51,137,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN1 ; call appropriate print routine for the claim form type to be printed
 K IBRESUB
 ;
EN1X ; Entrypoint for reprint (IBRESUB will be defined)
 N IBF,IB,IBFORM,IBJ
 S IB=$$FT^IBCU3(IBIFN)    ; form type ien (2 or 3)
 S IBFT=$$FTN^IBCU3(IB)    ; form type name
 S IBF=$P($G(^IBE(353,+IB,2)),U,8)
 S:IBF="" IBF=IB ;Forces the use of the output formatter to print bills
 D ENFMT(IBIFN,IB,IBF,,$G(IBRESUB))
END K IBFT,IBRESUB
 Q
 ;
EN2 ; send to default A/R device
 S ZTDTH=$H,IBIFN=PRCASV("ARREC"),IBPNT=PRCASV("NOTICE")
 D FORM S (IBFORM1,ZTDESC)="FOLLOW-UP AR FORM "_$P($G(^IBE(353,+IBFT,0)),"^")
 D QUEUE
 Q
 ;
EN3 ;queue an Rx Addendum for a bill, IBIFN must be defined
 Q:'$D(^DGCR(399,+$G(IBIFN),0))  I '$D(^IBA(362.4,"AIFN"_+IBIFN)),'$D(^IBA(362.5,"AIFN"_+IBIFN)) Q
 N IBFT S IBFT=$$FNT^IBCU3("BILL ADDENDUM") Q:'IBFT  S (IBFORM1,ZTDESC)="BILL ADDENDUM FOR "_$P(^DGCR(399,+IBIFN,0),U,1)
 S ZTSAVE("IB*")="",ZTDTH=$H
 S ZTIO=$P($G(^IBE(353,IBFT,0)),"^",2),ZTRTN=$G(^IBE(353,IBFT,1)) I (ZTIO="")!(ZTRTN="") K ZTDESC,ZTSAVE,ZTDTH,ZTIO,ZTRTN Q
 D ^%ZTLOAD
 Q
 ;
EN4 ;queue bills, IBIFN must be defined
 S ZTDTH=$H,IBPNT=1 Q:'$D(^DGCR(399,+$G(IBIFN),0))
 D FORM
 S IBF=$P($G(^IBE(353,+IBFT,2)),U,8)
 I $P($G(^IBE(353,+IBFT,0)),U,2)="",IBF="" Q
 S (IBFORM1,ZTDESC)=$P($G(^IBE(353,+IBFT,0)),"^")_" BILL "_$P(^DGCR(399,+IBIFN,0),U,1)
 S ZTSAVE("IB*")=""
 S ZTIO=$P($G(^IBE(353,IBFT,0)),"^",2),ZTRTN=$S(IBF="":$G(^IBE(353,IBFT,1)),1:"ENFMT^IBCF(IBIFN,IBFT,IBF,ZTIO,$G(IBRESUB))")
 I (ZTIO="")!(ZTRTN="") S IBAR("ERR")="BILL FORM TYPE NOT COMPLETE FOR"_IBFORM1 Q
 D ^%ZTLOAD I '$D(ZTSK) S IBAR("ERR")="QUEUEING OF "_IBFORM1_" FAILED",IBAR("OKAY")=0 W IBAR("ERR") Q
 S IBAR("OKAY")=1
 Q
 ;
EN5 ;queue 1500 Rx Addendum to Follow-up (AR) printer, IBIFN must be defined - no longer used
 Q:'$D(^DGCR(399,+$G(IBIFN),0))  I '$D(^IBA(362.4,"AIFN"_+IBIFN)),'$D(^IBA(362.5,"AIFN"_+IBIFN)) Q
 Q:$$FT^IBCU3(IBIFN)'=2
 N IBFT S IBFT=$$FNT^IBCU3("BILL ADDENDUM") Q:'IBFT  S (IBFORM1,ZTDESC)="BILL ADDENDUM FOR "_$P(^DGCR(399,+IBIFN,0),U,1)
 S ZTSAVE("IB*")="",ZTDTH=$H
 S ZTIO=$P($G(^IBE(353,IBFT,0)),"^",3),ZTRTN=$G(^IBE(353,IBFT,1)) I (ZTIO="")!(ZTRTN="") K ZTDESC,ZTSAVE,ZTDTH,ZTIO,ZTRTN Q
 D ^%ZTLOAD
 Q
 ;
ENFMT(IBIFN,IB,IBF,ZTIO,IBRESUB) ; Use formatter to print bill IBIFN
 N IBFT,IBFTP,IBFORM,IBJ
 S (IBFT,IBFORM)=IB,IBFTP="IBCFP"_IB,IBJ=$J
 K ^XTMP(IBFTP,$J),^TMP("IBQONE",$J)
 S ^XTMP(IBFTP,$J,1,1,1,IBIFN)="",^TMP("IBQONE",$J)=""
 D FORM^IBCEFG7(IBF,$G(ZTIO))
 I $G(IBRESUB) D
 . N IBDA
 . S IBDA=$$LAST364^IBCEF4(IBIFN)
 . I IBDA D UPDEDI^IBCEM(IBDA,"P")
 K ^TMP("IBQONE",$J)
 I IBFT'=3 D EN3
 Q
 ;
FORM ;
 S IBFT=$$FT^IBCU3(IBIFN)
 Q
QUEUE ;
 S IBF=$P($G(^IBE(353,+IBFT,2)),U,8)
 S ZTSAVE("IB*")=""
 S ZTIO=$P($G(^IBE(353,IBFT,0)),"^",3),ZTRTN=$S(IBF="":$G(^IBE(353,IBFT,1)),1:"ENFMT^IBCF(IBIFN,IBFT,IBF,ZTIO,$G(IBRESUB))")
 I ((ZTIO="")&(IBF=""))!(ZTRTN="") S IBAR("ERR")="BILL FORM TYPE NOT COMPLETE FOR"_IBFORM1 Q
 D ^%ZTLOAD I '$D(ZTSK) S IBAR("ERR")="QUEUEING OF "_IBFORM1_" FAILED",IBAR("OKAY")=0 W IBAR("ERR") Q
 S IBAR("OKAY")=1
 Q
 ;
DISPX ; call to exclude transmittable bills
 D DISP1(1)
 Q
 ;
DISP ; call to include all bills
 D DISP1(0)
 Q
 ;
DISP1(IBTX) ;print list of authorized bills - exclude transmittables if
 ; IBTX=1
 N IBIFN,IBC,Y
 S IBIFN=0,IBC=0,Y="" W !
 F  S IBIFN=$O(^DGCR(399,"AST",3,IBIFN)) Q:'IBIFN  S IBX=$G(^DGCR(399,IBIFN,0)) I IBX'="" D  Q:Y="^"
 . I $G(IBTX) D  Q:IBX=""
 .. N Z
 .. S Z=0 F  S Z=$O(^IBA(364,"B",IBIFN,Z)) Q:'Z  I $D(^IBA(364,"ASTAT","X",Z)) S IBX="" Q
 . W !,$P(IBX,U,1),?10,$E($P($G(^DPT(+$P(IBX,U,2),0)),U,1),1,20),?32,$$DATE^IBCFP(+$P(IBX,U,3)),?42,$S(+$P(IBX,U,5)<3:"INPT",1:"OUTPT")
 . W ?49,$P($G(^DGCR(399.3,+$P(IBX,U,7),0)),U,4),?59,$E($$EXSET^IBEFUNC(+$P(IBX,U,13),399,.13),1,7),?68,$E($$FTN^IBCU3($$FT^IBCU3(IBIFN)),1,11)
 . S IBC=IBC+1 I '(IBC#10) R !,"Press RETURN to continue or '^' to exit: ",Y:DTIME
 Q
 ;
DISPT ;print list of all bills awaiting transmission
 N IBI,IBIFN,IBC,Y S (IBC,IBI)=0,Y="" W !
 F  S IBI=$O(^IBA(364,"ASTAT","X",IBI)) Q:'IBI  S IBIFN=+$G(^IBA(364,+IBI,0)),IBX=$G(^DGCR(399,IBIFN,0)) I IBX'="" D  Q:Y="^"
 . W !,$P(IBX,U,1),?10,$E($P($G(^DPT(+$P(IBX,U,2),0)),U,1),1,20),?32,$$DATE^IBCFP(+$P(IBX,U,3)),?42,$S(+$P(IBX,U,5)<3:"INPT",1:"OUTPT")
 . W ?49,$P($G(^DGCR(399.3,+$P(IBX,U,7),0)),U,4),?59,$E($$EXSET^IBEFUNC(+$P(IBX,U,13),399,.13),1,7),?68,$E($$FTN^IBCU3($$FT^IBCU3(IBIFN)),1,11)
 . S IBC=IBC+1 I '(IBC#10) R !,"Press RETURN to continue or '^' to exit: ",Y:DTIME
 Q
 ;
