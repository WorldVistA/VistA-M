IBCEM02 ;ALB/TMP - 837 EDI RESUBMIT BATCH PROCESSING ;12-SEP-96
 ;;2.0;INTEGRATED BILLING;**137,191,296**;21-MAR-94
 Q
 ;
BATCH2 ; Resubmit a batch of bills not necessarily in error
 N DIR,DIC,X,Y,IB
 K ^TMP("IBEDI_TEST_BATCH",$J)
 F  S DIC="^IBA(364.1,",DIC(0)="AEMQ" D ^DIC Q:Y<0  S IB=+Y D  I IB Q:'$$BATCH(+IB)
 . N Y,IB0
 . S IB0=$G(^IBA(364.1,IB,0)) I $P(IB0,U,14),'$O(^IBA(364,"C",IB,0)) D  Q:'IB
 .. S DIR("A",1)="THIS IS A TEST BATCH AND CANNOT BE RESUBMITTED."
 .. I +$P(IB0,U,15) S DIR("A",2)="IT WAS CREATED AS A RESULT OF BATCH "_$P($G(^IBA(364.1,+$P(IB0,U,15),0)),U)_" BEING RESUBMITTED.",DIR("A",3)="RESUBMIT THIS ORIGINAL BATCH INSTEAD."
 .. S DIR("A")="PRESS RETURN TO CONTINUE: "
 .. S DIR(0)="EA"
 .. W ! D ^DIR K DIR W !
 .. S IB=0
 . ;
 . S DIR("A")="Are you resubmitting the claims in this batch for testing?: ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S IB=0 Q
 . I +Y S ^TMP("IBEDI_TEST_BATCH",$J)=1 Q
 . K ^TMP("IBEDI_TEST_BATCH",$J)
 K ^TMP("IBEDI_TEST_BATCH",$J)
 Q
 ;
BATCH(IBBDA) ;
 N DIR,IBOK,IB0,IB1,ZTSK,IBSTAT,IBCE,IBASK,IBSTOP,IBTEST
 S IB0=$G(^IBA(364.1,IBBDA,0)),IB1=$G(^(1)),IBSTAT=$P(IB0,U,2),IBASK=0
 S IBTEST=+$G(^TMP("IBEDI_TEST_BATCH",$J))
 ;
 I 'IBTEST,$P(IB0,U,9) D  I 'IBOK S IBASK=1 G BATCHQ
 . S IBOK=1,ZTSK=$P(IB0,U,9) D STAT^%ZTLOAD
 . I ZTSK(0)=0 S DIE="^IBA(364.1,",DA=IBBDA,DR=".09///@" D ^DIE Q  ;Task not scheduled - delete task #
 . I "125"[ZTSK(1) W *7,!,"Cannot resubmit this batch.",!,"This batch is currently ",$S("2"[ZTSK(1):"being resubmitted",1:"scheduled for resubmission")," - Task # is: ",$P(IB0,U,9),! S IBOK=0
 ;
 W !
 S DIR("A",1)=$P(IB0,U,8)
 S DIR("A",2)="Current Batch Status: "_$$EXPAND^IBTRE(364.1,.02,IBSTAT)
 S DIR("A",3)="         Recorded On: "_$$FMTE^XLFDT($P(IB1,U,6),2)
 S DIR("A",4)=" "
 S DIR("A",5)="      Date Last Sent: "_$$FMTE^XLFDT($P(IB1,U,3),2)
 S DIR("A",6)="        Last Sent By: "_$$EXPAND^IBTRE(364.1,1.04,$P(IB1,U,4))
 S DIR("A",7)=" "
 S DIR("A",8)="     Date First Sent: "_$$FMTE^XLFDT($P(IB1,U),2)
 S DIR("A",9)="       First Sent By: "_$$EXPAND^IBTRE(364.1,1.02,$P(IB1,U,2))
 S DIR("A",10)="     Number Of Bills: "_$P(IB0,U,3)
 S DIR("A",11)=" "
 ;
 I $P(IB0,U,13),'IBTEST D  G:IBSTOP BATCHQ
 . S DIR("A",12)="BATCH WAS LAST RESUBMITTED ON "_$$FMTE^XLFDT($P(IB0,U,13),2),DIR("A",13)=" "
 . S DIR(0)="YA",DIR("A")="ARE YOU SURE YOU WANT TO RESUBMIT IT AGAIN?: ",DIR("B")="NO" D ^DIR K DIR I 'Y!$D(DTOUT)!$D(DUOUT) S IBSTOP=1 Q
 . S IBSTOP=0
 ;
 I IBSTAT'="P",'IBTEST S DIR("A",11)="WARNING - BATCH TRANSMITTED PREVIOUSLY & CONFIRMED RECEIVED BY "_$P("AUSTIN^PAYER/INTERMEDIARY",U,$TR(IBSTAT,"A")+1)
 S DIR("A")="ARE YOU SURE YOU WANT TO RESUBMIT THIS BATCH"_$S(IBTEST:" FOR TEST",1:"")_"?: "
 S DIR(0)="YA",DIR("B")="NO"
 D ^DIR K DIR
 S IBSTOP=('Y)
 ;
 K ^TMP("IBNOT",$J)
 W !
 I IBSTOP S IBASK=1 G BATCHQ
 I IBSTAT'="P"!IBTEST D
 . S DIR("A")="Do you want to exclude any bills from being resubmitted?: ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR
 . I Y D
 .. N IBDAB,Z,IBCEFUNC
 .. S IBCEFUNC=1,IBCE("VALMSG")="Select bills that should NOT be resubmitted"
 .. D EN^VALM("IBCEM BATCH BILL LIST")
 W !
 D RESUB(IBBDA,$S(IBTEST:0,IBSTAT="P":1,1:0))
 ;
BATCHQ Q IBASK
 ;
RESUB(IBBDA,IBOLD) ; Resubmit a batch entry # IBBDA in file 364.1
 ;IBOLD = 1 if old batch # should be used   0 if new batch # needed
 ;
 N IBIFN,IB0,IBS,IBS1,IBSCT,IBEXCT,IBE,IB,DIR,Y,IBT,IBPT,IBB,IBZTSK,IBTEST
 K ^TMP("IBRESUBMIT",$J),^TMP("IBRESUB",$J)
 S IBTEST=+$G(^TMP("IBEDI_TEST_BATCH",$J))
 S IBOLD=+$G(IBOLD),^TMP("IBRESUB",$J)=$P($G(^IBA(364.1,IBBDA,0)),U)_U_IBBDA_U_IBOLD_U_IBTEST
 ;
 S (IBE,IBE(0),IBSCT,IBEXCT,IBIFN)=0
 F  S IBIFN=$O(^IBA(364,"ABABI",IBBDA,IBIFN)) Q:'IBIFN  S IB=$O(^IBA(364,"ABABI",IBBDA,IBIFN,"")) Q:'IB  S IB0=$G(^IBA(364,IB,0)),IBS=$P($G(^DGCR(399,IBIFN,0)),U,13) D
 . I $D(^TMP("IBNOT",$J,IB)) S IBEXCT=IBEXCT+1 Q
 . S IBSCT=IBSCT+1,IBS1=$P(IB0,U,3)
 . I IBTEST!(IBS>1&(IBS<6)&("CRDZ"'[IBS1)) S ^TMP("IBRESUB",$J,IB)=IBIFN Q
 . S IBE(0)=IBE(0)+1
 . I IBS1'="","CRDZ"[IBS1 S IBE(IBS1)=$G(IBE(IBS1))+1 Q
 . S IBE=IBE+1,^TMP("IBNOT",$J,IB)=IBIFN
 ;
 I 'IBTEST,'IBE(0),'IBSCT,'$D(^TMP("IBNOT",$J)) D CKRES^IBCESRV2(IBBDA) G RESUBQ
 I IBE(0)!'IBSCT S Y=1 D  G:'Y RESUBQ
 . I IBE(0)=IBSCT W !,*7,"There are no bill(s) in this batch in a valid status to be resubmitted" W:IBEXCT !,IBEXCT," bill(s) in this batch have been specifically excluded" D PAUSE^VALM1 S Y="" Q
 . F Z="C","R","D" I $D(IBE(Z)) W !,*7,IBE(Z)," bill(s) in this batch have been ",$S(Z="C":"cancelled",Z="R":"resubmitted",1:"deleted from batch")," previously"
 . I IBE W !,*7,IBE," bill(s) in this batch are not in a valid status to be re-submitted"
 . I IBEXCT W !,IBEXCT," bill(s) in this batch have been specifically excluded" Q:'IBE
 . K DIR S DIR("A")="Do you want to resubmit the other "_(IBSCT-IBE(0))_" bill(s) in this batch?: ",DIR(0)="YA",DIR("B")="NO" D ^DIR K DIR
 . W !
 . I 'Y W !,*7,"Batch NOT resubmitted" D PAUSE^VALM1 S Y=0,IBSTOP=1 K ^TMP("IBRESUB",$J),^TMP("IBNOT",$J) Q
 ;
 S IBZTSK=""
 I $O(^TMP("IBRESUB",$J,0)) D
 . S ^TMP("IBRESUBMIT",$J)=$G(^TMP("IBRESUB",$J))
 . S IB="" F  S IB=$O(^TMP("IBRESUB",$J,IB)) Q:'IB  S IBIFN=$P($G(^IBA(364,IB,0)),U),Y=$S('IBOLD&'IBTEST:$$ADDTBILL^IBCB1(IBIFN),1:IB) D
 .. I IBTEST Q:$D(^TMP("IBNOT",$J,IB))
 .. I 'IBTEST,'IBOLD,'$P(Y,U,3) S ^TMP("IBNOT",$J,IB)=IBIFN K ^TMP("IBRESUB",$J,IB) Q
 .. S ^TMP("IBRESUBMIT",$J,+Y)=^TMP("IBRESUB",$J,IB),^TMP("IBRESUBMIT",$J,+Y,"OLD")=$S('IBTEST:IB,1:0)
 . D EN1^IBCE837B(.IBZTSK,0)
 . I 'IBTEST,$G(^TMP("IBRESUBMIT",$J))="ABORT" D  ; No resubmit - delete entries
 .. S IB="" F  S IB=$O(^TMP("IBRESUBMIT",$J,IB)) Q:'IB  S DIK="^IBA(364,",DA=IB D ^DIK
 .. K ^TMP("IBRESUBMIT",$J)
 I IBZTSK S ^TMP("IBRESUBMIT",$J)=^TMP("IBRESUB",$J),DIE="^IBA(364.1,",DR=".09////"_IBZTSK,DA=$S('IBTEST:+$P($G(^TMP("IBRESUBMIT",$J)),U,2),1:0) D:DA ^DIE ;task was queued
 ;
RESUBQ Q
 ;
RESUBUP ; Update old entries in file 364 for resubmitted bills, send bulletin
 ; for bills not resubmitted in batch, if any, update new batch(s) with
 ; old batch reference
 N IBBA,IBE,IBT,IB,IBV,IBB,XMSUBJ,XMBODY,XMTO,XMDUZ
 ;
 S IBBA=+$P($G(^TMP("IBRESUBMIT",$J)),U,2) ;Original batch entry #
 ;
 I $O(^TMP("IBNOT",$J,0)) D
 . S IBE=5,IB=""
 . F  S IB=$O(^TMP("IBNOT",$J,IB)) Q:IB=""  S IBB=+$G(^(IB)),IBV=$$DISP^IBCEM3(IBB,"",1) D
 .. Q:"CRDZ"[$P($G(^IBA(364,IB,0)),U,3)
 .. S IBE=IBE+1,IBPT=$P(IBV,U,3)
 .. S IBT(IBE)="  "_$E($P(IBV,U,2)_$J("",10),1,10)_$E($E($P(IBPT,"("),1,20)_"("_$P(IBPT,"(",2)_$J("",32),1,32)_"  "_$E($P(IBV,U,4)_$J("",10),1,10)_"  "_$$EXPAND^IBTRE(399,.13,$P($G(^DGCR(399,IBB,0)),U,13))
 . I IBE>5 D  ;Batch resubmit is still incomplete
 .. S IBT(1)="The resubmission of bills in batch "_$P($G(^TMP("IBRESUB",$J)),U)_" was incomplete."
 .. S IBT(2)="The following bills were NOT resubmitted:"
 .. S IBT(3)=" ",IBT(4)="  BILL #    PATIENT"_$J("",27)_"TYPE        BILL STATUS",IBT(5)="",$P(IBT(5),"-",76)="",IBT(5)="  "_IBT(5)
 .. S XMSUBJ="BILLS NOT RESUBMITTED WITH THEIR BATCH",XMBODY="IBT",XMDUZ="",XMTO("I:G.IB EDI")=""
 .. D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 .. I '$P($G(^IBE(364.1,IBBA,0)),U,10) S DIE="^IBA(364.1,",DR=".1////1",DA=IBBA D ^DIE
 ;
 I $G(^TMP("IBRESUBMIT",$J,0)),'$P($G(^TMP("IBRESUBMIT",$J)),U,3) D
 . N IB,IBCT,IBO,IBIFN
 . S (IB,IBCT)=0
 . F  S IB=$O(^TMP("IBRESUBMIT",$J,IB)) Q:'IB  S IBIFN=+$G(^(IB)),IBO=$G(^(IB,"OLD")) D:IBO
 .. S IBCT=IBCT+1
 .. D UPDEDI^IBCEM(IBO,"R",1)
 . D CTDOWN(IBBA,IBCT)
 S DA=IBBA,DIE="^IBA(364.1,",DR=".09///@;.13///NOW;1.03///NOW;1.04////.5" D ^DIE
 L -^IBA(364.1,DA)
 K ^TMP("IBNOT",$J),^TMP("IBRESUB",$J)
 Q
 ;
CTDOWN(IBBA,IBCT) ; Upd the count, incomplete resubmit status on the batch
 ;IBBA = batch file ien
 ;IBCT = the # to decrease the count
 Q:'IBBA
 N IBCT1,IBSTAT,IB0
 S IB0=$G(^IBA(364.1,IBBA,0)),IBCT1=$P(IB0,U,3)-IBCT,IBSTAT=$P(IB0,U,10)
 S:IBCT1<0 IBCT1=0
 S IBINC=$S('IBSTAT:"",1:$$CKINC^IBCEM02(IBBA)),DIE="^IBA(364.1,",DR=".03////"_IBCT1_$S(IBINC'="":";.1////"_IBINC,1:""),DA=IBBA D ^DIE
 Q
 ;
CKINC(IBBA) ;Check to see if batch resubmit is incomplete
 ; IBBA = internal file 364.1 entry # of batch to check
 N IBZ,IBINC,DR,DA,DIE
 S IBZ="",IBINC=0
 F  S IBZ=$O(^IBA(364,"ABAST",IBBA,IBZ)) Q:IBZ=""  I "CRD"'[IBZ S IBINC=1 Q
 Q IBINC
 ;
LOCK(FILE,IBBDA) ; Lock file # FILE entry # IBBDA
 I IBBDA L +^IBA(FILE,IBBDA):5
 Q $T
 ;
