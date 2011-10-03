IBAKAT ;ALB/CPM - CANCEL COPAY CHARGES FOR KATRINA VETS ; 05-MAR-06
 ;;2.0;INTEGRATED BILLING;**340**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
CAN() ; Cancel copayments for Katrina vets
 N IBCRES,IBBEG,IBEND,IBTOT,IBHIT,IBBUCK,IBD,IBN,IBND,IBCHG,IBIL
 N DFN,DIE,DA,DR,IBND1,IBH,IBDEC,IBTRAN
 S IBCRES=$O(^IBE(350.3,"B","KATRINA AFFECTED VETERAN",0)),IBTOT=""
 I 'IBCRES G CANQ
 ;
 S IBBEG=3050829,IBEND=3060228,IBTOT="0^0^0"
 ;
 S DFN=0 F  S DFN=$O(^IB("APTDT",DFN)) Q:'DFN   D
 .;
 .; - quit if vet should not have charges cancelled
 .Q:'$$CHK^RCKATP(DFN)  S (IBHIT,IBBUCK)=0 K IBH
 .;
 .; - examine all charges billed from 8/29/05 through 2/28/06
 .S IBD=3050828.9 F  S IBD=$O(^IB("APTDT",DFN,IBD)) Q:'IBD  D
 ..S IBN=0 F  S IBN=$O(^IB("APTDT",DFN,IBD,IBN)) Q:'IBN  D
 ...;
 ...S IBND=$G(^IB(IBN,0)),IBND1=$G(^(1))
 ...;
 ...; - skip event records
 ...Q:$P(IBND,"^",8)["ADMISSION"
 ...;
 ...; - skip if this is not the last entry for the parent
 ...Q:'$P(IBND,"^",9)
 ...Q:IBN'=$$LAST^IBECEAU($P(IBND,"^",9))
 ...;
 ...; - skip if entry is cancelled
 ...Q:$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",5)=2
 ...I IBN=$P(IBND,"^",9),($P(IBND,"^",5)=10!($P(IBND,"^",10))) Q
 ...;
 ...; - skip if rx copay is after 2/28/06
 ...I '$P(IBND,"^",14),$E(IBD,1,7)>IBEND Q
 ...;
 ...; - skip if medical care copay is out of range
 ...I $P(IBND,"^",14),($P(IBND,"^",15)<IBBEG!($P(IBND,"^",14)>IBEND)) Q
 ...;
 ...S IBCHG=+$P(IBND,"^",7),IBIL=$P(IBND,"^",11),IBTRAN=$P(IBND,"^",12)
 ...;
 ...; - if charge is not passed to AR, cancel it in IB
 ...I '$P($G(^IBE(350.21,+$P(IBND,"^",5),0)),"^",4) D  Q
 ....S $P(IBTOT,"^",3)=$P(IBTOT,"^",3)+IBCHG
 ....S $P(IBTOT,"^",2)=$P(IBTOT,"^",2)+IBCHG,IBHIT=1
 ....S DIE="^IB(",DA=IBN,DR=".05////10;.1////"_IBCRES D ^DIE
 ...;
 ...; - cancel the charge in AR, to the extent possible, if it
 ...;   were never on hold in IB
 ...I '$P(IBND1,"^",6) D  Q
 ....S $P(IBTOT,"^",2)=$P(IBTOT,"^",2)+IBCHG,IBHIT=1
 ....S IBBUCK=IBBUCK+$$DEC^RCKATP(IBIL,IBCHG)
 ...;
 ...; - for charges once on hold, see if there is "credit" in AR
 ...;   that would preclude our need to cancel the charge.  The
 ...;   amount to decrease the charge is in IBDEC.
 ...S IBDEC=IBCHG D  Q:'IBDEC
 ....N IBAR,IBB
 ....;
 ....; - have AR update the credit amount
 ....S IBAR=$$TPP^RCKATP(IBTRAN,.IBH)
 ....;
 ....; - if the receivable in file 430 couldn't be defined, quit
 ....;   and decrease the entire charge amount
 ....S IBB=$P(IBAR,"^",2) I 'IBB Q
 ....;
 ....; - initialize the credit amount for the bill
 ....I '$G(IBH(IBB)) S IBH(IBB)=0
 ....;
 ....; - increment the credit amount by what is returned from AR
 ....S IBH(IBB)=IBH(IBB)+IBAR
 ....;
 ....; - if there is no additional credit, quit and decrease the
 ....;   entire charge amount
 ....I 'IBH(IBB) Q
 ....;
 ....; - if the credit amount is greater than the charge, set the
 ....;   decrease amount to zero; otherwise, set it to the charge
 ....;   amount minus the available credit
 ....S IBDEC=$S(IBH(IBB)>IBCHG:0,1:IBCHG-IBH(IBB))
 ....;
 ....; - if the credit amount is less than the charge, set it to
 ....;   zero; otherwise, offset it by the charge amount
 ....S IBH(IBB)=$S(IBH(IBB)<IBCHG:0,1:IBH(IBB)-IBCHG)
 ...;
 ...;
 ...; - decrease account by the adjusted amount IBDEC
 ...S $P(IBTOT,"^",2)=$P(IBTOT,"^",2)+IBDEC,IBHIT=1
 ...S IBBUCK=IBBUCK+$$DEC^RCKATP(IBIL,IBDEC)
 .;
 .;
 .; - flag each patient in AR, even if no charges are found
 .D FLAG^RCKATP(DFN)
 .;
 .; - update patient counter
 .I IBHIT S $P(IBTOT,"^")=$P(IBTOT,"^")+1
 .;
 .; - if there's anything in the bucket, further reduce account
 .I IBBUCK D ADJ^RCKATP(DFN,IBBUCK)
 ;
 ;
CANQ Q IBTOT
 ;
 ;
 ;
CANRES ; Patch *340 post-init entry point
 D BMES^XPDUTL(">>> Adding new cancellation reason into file #350.3...")
 S IBCR="KATRINA AFFECTED VETERAN^KAT^3"
 I $O(^IBE(350.3,"B",$P(IBCR,"^"),0)) D  G CANRESQ
 .D MES^XPDUTL(" >> '"_$P(IBCR,"^")_"' is already on file.")
 S DIC="^IBE(350.3,",DIC(0)="L",DLAYGO=350.3,X=$P(IBCR,"^")
 K DD,DO D FILE^DICN K DD,DO
 I Y<0 D MES^XPDUTL(" >> Unable to file this entry!") G CANRESQ
 S DIE=DIC,DA=+Y,DR=".02///"_$P(IBCR,"^",2)_";.03///"_$P(IBCR,"^",3)
 D ^DIE,MES^XPDUTL(" >> '"_$P(IBCR,"^")_"' has been filed.")
CANRESQ K DA,DIC,DIE,DR,DLAYGO,IBCR,X,Y
 Q
