IBTRKR31 ;ALB/AAS - CLAIMS TRACKING - DBLCHK RX FILLS ; 13-AUG-93
 ;;2.0;INTEGRATED BILLING;**33,121,160,309,347,405**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
% ; -- Double check rx data routine
DBLCHK(IBTRN) ; -- double check rx before billing, input tracking id
 N IBX,IBFILL,IBFILLD,IBRXN,IBTRND,IBRMARK,IBRXSTAT,IBDEA,IBDRUG,IBRXDATA,X,Y,IBY,IBDFN
 S IBX=0
 S IBTRND=$G(^IBT(356,+IBTRN,0)) I IBTRND="" G DBLCHKQ
 S IBRXN=$P(IBTRND,"^",8),IBFILL=$P(IBTRND,"^",10),IBFILLD=""
 ;
 S IBDFN=$$FILE^IBRXUTL(IBRXN,2)
 I IBFILL=0 S IBY=$$RXSEC^IBRXUTL(IBDFN,IBRXN),IBFILLD=$P(IBY,U,2)_U_$P(IBY,U,13)_U_$P(IBY,U,15)
 I IBFILL>0 S IBY=$$ZEROSUB^IBRXUTL(IBDFN,IBRXN,IBFILL),IBFILLD=$P(IBY,U,1)_U_$P(IBY,U,18)_U_$P(IBY,U,16)
 ;
 I (IBFILL'>0&(IBFILL'=0))!(IBRXN<1) S IBRMARK="INVALID PRESCRIPTION ENTRY" G DBLCHKQ
 ;
 S IBRXDATA=$$RXZERO^IBRXUTL(IBDFN,IBRXN),IBRXSTAT=$P(IBRXDATA,"^",15)
 ;S DFN=+$P(IBRXDATA,"^",2),IBDT=+IBFILLD
 ;I IBDT=$P($O(^DPT(DFN,"S",(IBDT-.00001))),".") S IBRMARK="REFILL ON VISIT DATE" G DBLCHKQ
 ;
 ; -- check rx status (not  deleted)
 I IBRXSTAT=13 S IBRMARK="PRESCRIPTION DELETED" G DBLCHKQ
 ;
 ; -- refill not released or returned to stock
 I '$P(IBFILLD,"^",2) S IBRMARK="PRESCRIPTION NOT RELEASED" G DBLCHKQ
 I $P(IBFILLD,"^",3) S IBRMARK="PRESCRIPTION NOT RELEASED" G DBLCHKQ
 ;
 ; -- check drug (not investigational, supply, or over the counter drug
 S IBDRUG=$P(IBRXDATA,"^",6)
 D ZERO^IBRXUTL(IBDRUG)
 S IBDEA=$G(^TMP($J,"IBDRUG",+IBDRUG,3))
 I IBDEA["I"!(IBDEA["S")!(IBDEA["9")!(IBDEA["N") S IBRMARK="DRUG NOT BILLABLE" G DBLCHKQ ; investigational drug, supply or otc
 ;
 S IBX=1
 K ^TMP($J,"IBDRUG")
 ;
DBLCHKQ I $G(IBRMARK)]"" D
 .S IBRMARK=$O(^IBE(356.8,"B",IBRMARK,0)) I 'IBRMARK S IBRMARK=999
 .N DA,DR,DIC,DIE
 .L +^IBT(356,+IBTRN):5 I '$T Q
 .S DA=IBTRN,DIE="^IBT(356,",DR=".19////"_IBRMARK
 .D ^DIE
 .L -^IBT(356,+IBTRN)
 Q IBX
 ;
 ;
BULL ; -- send bulletin
 ;
 S XMSUB="Rx Refills added to Claims Tracking Complete"
 S IBT(1)="The process to automatically add Rx Refills has successfully completed."
 S IBT(1.1)=""
 S IBT(2)="              Start Date: "_$$DAT1^IBOUTL(IBTSBDT)
 S IBT(3)="                End Date: "_$$DAT1^IBOUTL(IBTSEDT)
 I $D(IBMESS) S IBT(3.1)=IBMESS
 S IBT(4)=""
 S IBT(5)="  Total Rx fills checked: "_$G(IBCNT)
 S IBT(6)="Total NSC Rx fills Added: "_$G(IBCNT1)
 S IBT(7)=" Total SC Rx fills Added: "_$G(IBCNT2)
 S IBT(8)=""
 S IBT(9)="*The fills added as SC require determination and editing to be billed"
 D SEND
BULLQ Q
 ;
SEND S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 K XMY S XMN=0
 S XMY(DUZ)=""
 D ^XMD
 K X,Y,IBI,IBT,IBGRP,XMDUZ,XMTEXT,XMY,XMSUB
 Q
