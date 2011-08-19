IBECEAU4 ;ALB/CPM - Cancel/Edit/Add... Cancel Utilities ; 23-APR-93
 ;;2.0;INTEGRATED BILLING;**52,167,183,341**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CANCH(IBN,IBCRES,IBIND,IBCV) ; Cancel last transaction for a specific charge.
 ;  Input:    IBN   --  Charge to be cancelled
 ;          IBCRES  --  Cancellation reason
 ;           IBIND  --  1=>set MT bulletin flags; 0=>don't set flags
 ;            IBCV  --  1=>use the CHAMPVA error bulletin
 N IBY,IBHOLDN,IBND,IBPARNT,IBCANC,IBH,IBCANTR,IBXA,IBATYP,IBSEQNO,IBIL,IBUNIT,IBCHG
 S (IBN,IBHOLDN)=$$LAST^IBECEAU($P(^IB(IBN,0),"^",9)),IBY=1
 D CED(IBN) I IBCANTR!(IBY<0) G CANCHQ
 D CANC(IBN,IBCRES,1) I IBY<0 G CANCHQ
 I $G(IBIND) S IBARR(DT,IBHOLDN)="",(IBCANCEL,IBFND)=1
CANCHQ I IBY<1 D @$S($G(IBCV):"ERRMSG^IBACVA2(0,1)",1:"^IBAERR1")
 Q
 ;
CANC(IBCN,IBCRES,IBINC) ; Cancel a charge, after passing all edits
 ; Input:    IBCN  --  Internal entry # of IB Action to cancel
 ;          IBCRES --  Cancellation reason
 ;           IBINC --  Try to cancel an incomplete charge? [optional]
 N DA,DIK,IBCAN,IBSTOPDA,IBGMTR
 S IBCAN=$G(^IB(IBCN,0))
 ;
 ; - handle incomplete transactions
 I $G(IBINC) S:'$D(IBH) IBH='$P($G(^IBE(350.21,+$P(IBND,"^",5),0)),"^",4) I IBH D UPSTAT(IBCN,1) G CANCQ
 ;
 ; - handle regular transactions
 S IBATYP=$P($G(^IBE(350.1,+$P(IBCAN,"^",3),0)),"^",6) I IBATYP="" S IBY="-1^IB022" G CANCQ
 S IBSEQNO=$P($G(^IBE(350.1,IBATYP,0)),"^",5) I 'IBSEQNO S IBY="-1^IB023" G CANCQ
 W:$G(IBJOB)=4 !!,"Building the cancellation transaction... "
 D ADD^IBAUTL I Y<1 S IBY=Y G CANCQ
 S $P(IBCAN,"^",3)=IBATYP,$P(IBCAN,"^",5)=1,$P(IBCAN,"^",10)=IBCRES,$P(IBCAN,"^",12)=""
 ;  if there is a clinic stop, move it over
 S IBSTOPDA=$P(IBCAN,"^",20)
 S IBGMTR=$P(IBCAN,"^",21) ; 'GMT RELATED' flag
 S:IBXA'=5 IBCAN=$P(IBCAN,"^",1,16)
 S IBCAN=$P(IBCAN,"^",1,17)
 I IBSTOPDA S $P(IBCAN,"^",20)=IBSTOPDA
 S $P(^IB(IBN,0),"^",2,20)=$P(IBCAN,"^",2,20)
 I IBGMTR S $P(^IB(IBN,0),"^",21)=IBGMTR ; Set the 'GMT RELATED' flag
 ; DUZ may be null if this code is called by a process started by an HL7 multi-threaded listener
 ; if this condition occurs the approved fix is to use the Postmaster IEN.  2/27/06, IB*2.0*341
 S $P(^IB(IBN,1),"^")=$S(DUZ:DUZ,1:.5) ;
 S DA=IBN,DIK="^IB(" D IX1^DIK
 W:$G(IBJOB)=4 " .. " D PASS
 ;
 ; - cancel original charge (if it was an updated transaction)
 I $D(^IB(IBCN,0)),$P(^(0),"^",5)'=10 D UPSTAT(IBCN)
CANCQ Q
 ;
CED(IBN) ; Edits required to cancel a charge.
 ; Input:   IBN  --   Internal entry # of charge to be cancelled
 S IBND=$G(^IB(IBN,0)) I 'IBND S IBY="-1^IB021" G CEDQ
 S IBPARNT=+$P(IBND,"^",9) I '$D(^IB(IBPARNT,0)) S IBY="-1^IB027" G CEDQ
 I $$LAST^IBECEAU(IBPARNT)'=IBN S IBY="-1^^You can only cancel the last transaction for an original charge." G CEDQ
 S IBCANC=$G(^IBE(350.1,+$P(IBND,"^",3),0))
 S IBH='$P($G(^IBE(350.21,+$P(IBND,"^",5),0)),"^",4),IBCANTR=$P(IBCANC,"^",5)=2
 S IBXA=$P(IBCANC,"^",11),IBATYP=$P(IBCANC,"^",6)
 I '$D(^IBE(350.1,+IBATYP,0)) S IBY="-1^IB022" G CEDQ
 S IBSEQNO=$P(^IBE(350.1,+IBATYP,0),"^",5) I 'IBSEQNO S IBY="-1^IB023" G CEDQ
 S IBIL=$P(IBND,"^",11),IBUNIT=+$P(IBND,"^",6),IBCHG=+$P(IBND,"^",7),IBFR=$P(IBND,"^",14)
 I IBUNIT<1 S IBY="-1^IB025" G CEDQ
 I 'IBH,'IBCHG S IBY="-1^^There is no charge amount associated with this action." G CEDQ
 I $G(IBJOB)'=4,'IBH,IBIL="" S IBY="-1^IB024"
CEDQ Q
 ;
UPSTAT(IBCN,IB) ; Update the status, cancellation reason of incomplete charges.
 N DIE,DA,DR
 W:$G(IBJOB)=4&$G(IB) !,"Updating the status of the charge to 'cancelled'... "
 S DIE="^IB(",DA=IBCN,DR=".05////10;.1////"_IBCRES
 D ^DIE W:$G(IBJOB)=4&$G(IB) "done."
 Q
 ;
PASS ; Pass the action to Accounts Receivable.
 N IBSERV
 S IBNOS=IBN D ^IBR S IBY=Y I Y>0,$G(IBJOB)=4 W "done."
 Q
 ;
ERR ; Error Processing.
 Q:IBY>0
 I $P(IBY,"^",2)]"" W !,$P($G(^IBE(350.8,+$O(^IBE(350.8,"AC",$P($P(IBY,"^",2),";"),0)),0)),"^",2) Q
 I $P(IBY,"^",3)]"" W !,$P(IBY,"^",3)
 Q
 ;
PROC(EVT) ; Okay to proceed with Add, Edit, or Cancel?
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 W ! S DIR(0)="Y",DIR("A")="Okay to "_EVT_" this charge",DIR("?")="Enter 'Y' or 'YES' to "_EVT_" this charge, or 'N', 'NO', or '^' to quit."
 D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) W !,"This charge will not be ",$S(EVT="cancel":"cancelled",1:EVT_"ed"),"." S IBY=-1 G PROCQ
 S IBCOMMIT=1
PROCQ Q
