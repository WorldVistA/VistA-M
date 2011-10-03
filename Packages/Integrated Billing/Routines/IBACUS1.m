IBACUS1 ;ALB/CPM - TRICARE PATIENT RX COPAY CHARGES ; 02-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,240,347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
BILL(IBKEY,IBCHTRN) ; Create the TRICARE Rx copay charge.
 ;  Input:    IBKEY  --  1 ; 2, where
 ;                         1 = Pointer to the prescription in file #52
 ;                         2 = Pointer to the refill in file #52.1, or
 ;                             0 for the original fill
 ;          IBCHTRN  --  Pointer to the transaction entry in file #351.5
 ;
 S IBY=1
 I '$G(IBKEY) G BILLQ
 I $$FILE^IBRXUTL(+IBKEY,.01)="" G BILLQ
 ;
 ; - need patient
 S DFN=$$FILE^IBRXUTL(+IBKEY,2)
 I 'DFN S IBY="-1^IB002" G BILLQ
 ;
 ; - need action type
 S IBATYP=$O(^IBE(350.1,"E","TRICARE RX COPAY",0))
 I 'IBATYP S IBY="-1^IB008" G BILLQ
 ;
 ; - need facility number
 I '$$CHECK^IBECEAU(0) S IBY="-1^IB009" G BILLQ
 ;
 ; - need the Pharmacy service pointer; get from #350.1 and check it
 S IBSERV=$P($G(^IBE(350.1,1,0)),"^",4)
 I '$$SERV^IBARX1(IBSERV) S IBY="-1^IB003" G BILLQ
 ;
 ; - need a charge amount (from file #351.5)
 S IBCHG=+$G(^IBA(351.5,IBCHTRN,2))
 I 'IBCHG S IBY="-1^IB029" G BILLQ
 ;
 ; - set remaining variables
 S IBDESC="TRICARE RX COPAY",IBUNIT=1
 S IBSL="52:"_+IBKEY S:$P(IBKEY,";",2) IBSL=IBSL_";1:"_$P(IBKEY,";",2)
 S IBFR=DT
 ;
 ; - add the charge to file #350
 D ADD^IBECEAU3 I IBY<0 G BILLQ
 ;
 ; - release the charge to AR
 D AR^IBR
 ;
 ; - update the rx transaction file (#351.5)
 S DA=IBCHTRN,DIE="^IBA(351.5,",DR=".08////"_IBN D ^DIE K DA,DIE,DR
 ;
BILLQ I IBY<0 D ERRMSG^IBACVA2(1,2)
 K IBY,IBATYP,IBSERV,IBCHG,IBDESC,IBUNIT,IBSL,IBFR
 Q
 ;
 ;
 ;
CANC(IBCHTRN) ; Cancel the TRICARE Rx copay charge.
 ;  Input:  IBCHTRN  --  Pointer to the transaction entry in file #351.5
 ;
 S IBY=1,IBDUZ=DUZ
 S IBCHTRND=$G(^IBA(351.5,IBCHTRN,0)),DFN=+$P(IBCHTRND,"^",2)
 S IBN=+$P(IBCHTRND,"^",8) I 'IBN G CANCQ
 I '$$CHECK^IBECEAU(0) S IBY="-1^IB009" G CANCQ
 S IBCRES=$O(^IBE(350.3,"B","RX CANCELLED",0)) S:'IBCRES IBCRES=5
 ;
 ; - cancel the charge
 D CED^IBECEAU4(IBN) I IBY<0 G CANCQ
 D CANC^IBECEAU4(IBN,IBCRES,1)
 ;
CANCQ I IBY<0 D ERRMSG^IBACVA2(0,2)
 K IBCHTRND,IBDUZ,IBN,IBCRES,DFN,IBSITE,IBFAC,IBND,IBPARNT,IBCANC,IBH
 K IBCANTR,IBXA,IBATYP,IBSEQNO,IBIL,IBUNIT,IBCHG,IBFR
 Q
