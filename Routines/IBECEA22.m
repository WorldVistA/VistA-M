IBECEA22 ;ALB/CPM-Cancel/Edit/Add... Edit Utilities;23-APR-93
 ;;2.0;INTEGRATED BILLING;**150,183**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
UPCHG(P7,P6,P14,P15) ; Update the incomplete charge and pass to AR?
 ; Input:  P7  --  New amount [required]
 ;         P6  --  New Units [optional]
 ;        P14  --  New Bill From date [optional]
 ;        P15  --  New Bill To date [optional]
 N DA,DIE,DIR,DIRUT,DR,DUOUT,DTOUT,X,Y
 S DIR(0)="Y",DIR("A")="Okay to update this charge and pass it to Accounts Receivable"
 S DIR("?")="Enter 'Y' or 'YES' to update and pass the charge, or 'N', or '^' to quit."
 D ^DIR I 'Y!($D(DIRUT))!($D(DUOUT)) S IBY=-1 Q
 W !,"Updating the incomplete charge and passing to Accounts Receivable...  "
 S $P(^IB(IBN,0),"^",7)=P7 S:$G(P6) $P(^(0),"^",6)=P6 S:$G(P14) $P(^(0),"^",14)=P14 S:$G(P15) $P(^(0),"^",15)=P15
 ;
 ; - update copay account records
 D:$P(IBND,"^",19) UPCHG^IBARXMN($P(IBND,"^",19),P6,P7)
 D PASSCH I IBY>0 W "done." S IBCOMMIT=1
 Q
 ;
PASS ; Okay to pass charge to Accounts Receivable?
 N DIR,DIRUT,DUOUT,DTOUT
 S DIR(0)="Okay to pass this charge to Accounts Receivable",DIR(0)="Y"
 S DIR("?")="Enter 'Y' or 'YES' to pass this charge to AR, or 'N' or '^' to quit."
 D ^DIR I Y W !,"Passing the charge to Accounts Receivable...  " D PASSCH I IBY>0 W "done." S IBCOMMIT=1
 Q
 ;
PASSCH ; Pass charge to Accounts Receivable.
 I $G(IBXA)=5 D FILER^IBARXMA(IBN) ; transmit cap info
 N IBSERV S IBNOS=IBN D ^IBR S IBY=Y
 Q
 ;
CHCL ; Update charge and clocks.
 D UPCHG(IBCHG,IBUNIT,IBFR,IBTO)
 I IBY>0 D CLOCK^IBECEAU(IBDOLA-IBCLDOL,IBCLDAY,IBDAYA-IBCLDAY) S IBY=-1
 Q
 ;
UPD ; Build an 'update' transaction.
 N DA,DIK
 S IBATYP=$P($G(^IBE(350.1,+$P(IBUPD,"^",3),0)),"^",7) I IBATYP="" S IBY="-1^IB022" G UPDQ
 S IBSEQNO=$P($G(^IBE(350.1,IBATYP,0)),"^",5) I 'IBSEQNO S IBY="-1^IB023" G UPDQ
 W !!,"Building the updated transaction... "
 D ADD^IBAUTL I Y<1 S IBY=Y G UPDQ
 S $P(IBUPD,"^",3)=IBATYP,$P(IBUPD,"^",5)=1,$P(IBUPD,"^",6,7)=IBUNIT_"^"_IBCHG,$P(IBUPD,"^",12)=""
 S:IBXA'=5 $P(IBUPD,"^",14,15)=IBFR_"^"_IBTO,IBUPD=$P(IBUPD,"^",1,16)
 S:$D(IBAM) $P(IBUPD,"^",19)=IBAM
 S $P(IBUPD,"^",21)=$S($G(IBGMTR):1,1:"") ; GMT Related
 S ^IB(IBN,0)=IBUPD,$P(^(1),"^")=DUZ S DA=IBN,DIK="^IB(" D IX1^DIK
 D PASSCH W:IBY>0 "done."
UPDQ Q
