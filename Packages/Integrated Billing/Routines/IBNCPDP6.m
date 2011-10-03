IBNCPDP6 ;OAK/ELZ - TRICARE NCPDP TOOLS; 02-AUG-96 ;10/18/07  13:40
 ;;2.0;INTEGRATED BILLING;**383,384,411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
START(IBKEY,IBELIG,IBRT) ; initial storage done during
 ; billing determination check (updates allowed)
 ;  Input:    IBKEY  --  1 ; 2, where
 ;                         1 = Pointer to the prescription in file #52
 ;                         2 = Pointer to the refill in file #52.1, or
 ;                             0 for the original fill
 ;            IBELIG --  single character indicating elig indicator
 ;                         V = Veteran
 ;                         T = Tricare
 ;            IBRT   --  Rate type pointer to be used for the bill later
 ;
 N IBCHTRN,DO,DIC,X,Y,DIE,DA,DR
 S IBCHTRN=$O(^IBCNR(366.15,"B",IBKEY,0))
 I 'IBCHTRN D
 . S DIC="^IBCNR(366.15,",DIC(0)="",X=IBKEY D FILE^DICN
 . S IBCHTRN=+Y
 S DIE="^IBCNR(366.15,",DA=IBCHTRN,DR=".02////^S X=IBELIG;.03////^S X=IBRT"
 D ^DIE
 Q
 ;
BILL(IBKEY,IBCHG,IBRT) ; Create the TRICARE Rx copay charge.
 ;  Input:    IBKEY  --  1 ; 2, where
 ;                         1 = Pointer to the prescription in file #52
 ;                         2 = Pointer to the refill in file #52.1, or
 ;                             0 for the original fill
 ;            IBCHG  --  charge amount
 ;            IBRT   --  rate type on 3rd party (optional)
 ;
 N IBCHTRN,IBY,IBATYP,IBSERV,IBDESC,IBUNIT,IBSL,IBFR,DA,DIE,DR,DFN,IBN,IBZ
 ;
 S IBY=1
 I '$G(IBKEY) G BILLQ
 S IBCHTRN=$O(^IBCNR(366.15,"B",IBKEY,0))
 I 'IBCHTRN G BILLQ
 S IBZ=$G(^IBCNR(366.15,IBCHTRN,0))
 ;
 ; - Tricare?
 I $P(IBZ,"^",2)'="T",'$G(IBRT) G BILLQ
 I $G(IBRT),$P($G(^DGCR(399.3,IBRT,0)),"^")'="TRICARE" G BILLQ
 ;
 ; - already billed, need to cancel to bill
 I $P(IBZ,"^",4) D CANC(IBKEY)
 ;
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
 ; - need a charge amount
 S IBCHG=+$G(IBCHG)
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
 ; - update the rx file (#366.15)
 S DA=IBCHTRN,DIE="^IBCNR(366.15,",DR=".04////"_IBN D ^DIE K DA,DIE,DR
 ;
BILLQ ;
 I IBY<0 D ERRMSG^IBACVA2(1,2)
 ;
 Q
 ;
 ;
CANC(IBKEY) ; Cancel the TRICARE Rx copay charge.
 ;  Input:    IBKEY  --  1 ; 2, where
 ;                         1 = Pointer to the prescription in file #52
 ;                         2 = Pointer to the refill in file #52.1, or
 ;                             0 for the original fill
 ;
 N IBCHTRND,IBDUZ,IBN,IBCRES,DFN,IBSITE,IBFAC,IBND,IBPARNT,IBCANC,IBH,IBCANTR,IBXA,IBATYP,IBSEQNO,IBIL,IBUNIT,IBCHG,IBFR,DIE,DA,DR,IBCHTRN,IBY
 ;
 S IBY=1,IBDUZ=DUZ
 S IBCHTRN=$O(^IBCNR(366.15,"B",IBKEY,0))
 I 'IBCHTRN G CANCQ
 S IBCHTRND=$G(^IBCNR(366.15,IBCHTRN,0)),DFN=$$FILE^IBRXUTL(+IBKEY,2)
 S IBN=+$P(IBCHTRND,"^",4) I 'IBN G CANCQ
 I '$$CHECK^IBECEAU(0) S IBY="-1^IB009" G CANCQ
 S IBCRES=$O(^IBE(350.3,"B","RX CANCELLED",0)) S:'IBCRES IBCRES=5
 ;
 ; - cancel the charge
 D CED^IBECEAU4(IBN) I IBY<0 G CANCQ
 D CANC^IBECEAU4(IBN,IBCRES,1)
 ;
 S DIE="^IBCNR(366.15,",DA=IBCHTRN,DR=".04///@" D ^DIE
CANCQ ;
 I IBY<0 D ERRMSG^IBACVA2(0,2)
 ;
 Q
 ;
RT(IBKEY) ; returns rate type previously determined
 Q $P($G(^IBCNR(366.15,+$O(^IBCNR(366.15,"B",IBKEY,0)),0)),"^",3)
 ;
TRICARE(IBKEY) ; returns if the Key is RT Tricare
 N IBRT
 S IBRT=+$$RT(IBKEY)
 Q $S($P($G(^DGCR(399.3,IBRT,0)),"^")["TRICARE":1,1:0)
 ;
 ;gets the insurance phone
 ;input:
 ; IB36 - ptr to INSURANCE COMPANY File (#36)
 ;output:
 ; the phone number
PHONE(IB36) ;
 N IB1
 ;check first CLAIMS (RX) PHONE NUMBER if empty
 S IB1=$$GET1^DIQ(36,+IB36,.1311,"E")
 Q:$L(IB1)>0 IB1
 ;check BILLING PHONE NUMBER if empty - return nothing
 S IB1=$$GET1^DIQ(36,+IB36,.132,"E")
 Q IB1
 ;IBNCPDP6
