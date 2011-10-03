IBECEA2 ;ALB/CPM-Cancel/Edit/Add... Edit a Charge ; 15-MAR-93
 ;;2.0;INTEGRATED BILLING;**57,52,150,176,183,240**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ONE ; Edit a single charge.
 N IBGMTR
 S IBGMTR=0 ; GMT Related flag
 ;
 D HDR^IBECEAU("E D I T")
 ;
 ; - don't allow edit of CHAMPVA charges
 I $P($G(^IB(IBN,1)),"^",5) W !,"Sorry!  You cannot edit the CHAMPVA inpatient subsistence charge.",!,"Please cancel this charge and add a new charge." G ONEQ
 ;
 ; - don't allow edit of TRICARE charges
 I $P($G(^IBE(350.1,+$P($G(^IB(IBN,0)),"^",3),0)),"^",11)=7 W !,"Sorry!  You cannot edit TRICARE copayment charges.",!,"Please cancel this charge and add a new charge." G ONEQ
 ;
 ; - don't allow edit of LTC charges
 S IBXA=$P($G(^IBE(350.1,+$P($G(^IB(IBN,0)),"^",3),0)),"^",11)
 I IBXA>7,IBXA<10 W !,"Sorry!  You cannot edit LTC copayment charges.",!,"Please cancel this charge and add a new charge." G ONEQ
 ;
 ; - perform up-front edits
 I 'IBND S IBY="-1^IB021" G ONEQ
 S IBPARNT=+$P(IBND,"^",9) I '$D(^IB(IBPARNT,0)) S IBY="-1^IB027" G ONEQ
 I $$LAST^IBECEAU(IBPARNT)'=IBN W !,"You can only edit the last transaction for an original charge." G ONEQ
 S IBATYP=$G(^IBE(350.1,+$P(IBND,"^",3),0)) I IBATYP="" S IBY="-1^IB022" G ONEQ
 S IBSEQNO=$P(IBATYP,"^",5) I 'IBSEQNO S IBY="-1^IB023" G ONEQ
 I $P(IBATYP,"^",5)=2 W !,"You cannot edit cancellation transactions... please add a new charge." G ONEQ
 I $P(IBND,"^",5)=10 W !,"You cannot edit charges which have been directly cancelled.",!,"Please add a new charge." G ONEQ
 ;
 ; - see if charge has been billed or not
 S IBH="^1^2^8^9^99^"[("^"_+$P(IBND,"^",5)_"^"),IBXA=$P(IBATYP,"^",11)
 S IBIL=$P(IBND,"^",11),IBUNITP=+$P(IBND,"^",6),IBCHGP=+$P(IBND,"^",7)
 S IBATYP=+$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",9)
 I 'IBH D  G:IBY<0 ONEQ
 .I 'IBUNITP W !,"This charge has been billed, but there are no units!" S IBY=-1 Q
 .I 'IBCHGP W !,"There is no charge amount associated with this action!" S IBY=-1 Q
 .I IBIL="" W !,"This charge has been billed, but there is no bill number!" S IBY=-1 Q
 I IBH,$P(IBND,"^",5)'=8 W !,"*** Please Note:  This charge has not yet been passed to Accounts Receivable ***"
 I $P(IBND,"^",5)=8 W !?17,"*** Please Note:  This charge is on hold. ***",!?9,"Editing it will cause it to be passed to Accounts Receivable."
 ;
 ; - ask user for the cancellation reason
 I 'IBH,IBXA'=4 D REAS^IBECEAU2("E") G:IBCRES<0 ONEQ
 ;
 ; - ask user for data to be edited
 D ^IBECEA21 G:IBY<0 ONEQ
 ;
 ; - okay to proceed?
 D PROC^IBECEAU4("edit") G:IBY<0 ONEQ S IBUPD=IBND
 ;
 ; - cancel 354.71 transaction (copay cap)
 S:$P(IBND,"^",19) IBAMC=$$CANCEL^IBARXMN(DFN,$P(IBND,"^",19),.IBY) G:IBY<0 ONEQ
 ;
 ; - build the cancellation transaction
 D CANC^IBECEAU4(IBN,IBCRES,0) G:IBY<0 ONEQ
 ;
 ; - build new 354.71 transaction (copay cap)
 I IBXA=5 W !!,"Building the new cap transaction...  " S IBAM=$$ADD^IBARXMN(DFN,"^^"_DT_"^^P^^"_IBUNIT_"^"_IBCHG_"^"_IBDESC_"^^"_IBCHG_"^0^"_IBSITE) I IBAM<0 S IBY="-1^IB316" G ONEQ
 ;
 ; - build the updated transaction
 D UPD^IBECEA22 G:IBY<0 ONEQ
 ;
 ; - handle updating of clock
 I "^1^2^3^"[("^"_IBXA_"^") D CLOCK^IBECEAU(IBDOLA-IBCLDOL,IBCLDAY,IBDAYA-IBCLDAY)
 ;
ONEQ D ERR^IBECEAU4:IBY<0,PAUSE^IBECEAU
 K IBBS,IBCRES,IBDESC,IBIL,IBND,IBARTYP,IBSEQNO,IBTOTL,IBUNIT,IBATYP,IBIDX,IBN,IBY,IBPARNT,IBH,IBXA,IBNOS,IBRTED,IBADJMED,IBAM,IBAMC
 K IBAFY,IBCAN,IBCHG,IBCHGP,IBCLDA,IBCLDAY,IBCLDOL,IBCLDOLO,IBCLDT,IBCLST,IBDAYA,IBDAYP,IBDOLA,IBDOLP,IBDT,IBFR,IBFRP,IBI,IBJ,IBLIM,IBMED,IBTO,IBTOP,IBTRAN,IBUNIT,IBUNITP,IBUPD
 Q
