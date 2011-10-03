IBATLM2B ;LL/ELZ - TRANSFER PRICING PT TRANSACTION DETAIL ; 15-SEP-1998
 ;;2.0;INTEGRATED BILLING;**115,266**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
FE ; -- editing of facility
 N DA,DIE,DR,DTOUT
 D LMOPT^IBATUTL
 S DA=IBIEN,DIE="^IBAT(351.61,",DR=".11"
 I $P(^IBAT(351.61,DA,0),U,5)="X" W !!,"Transaction cancelled!" D H Q
 L +^IBAT(351.61,IBIEN):0
 I $T D ^DIE L -^IBAT(351.61,IBIEN) D INIT^IBATLM2 Q
 W !?5,"Another user is editing this entry."
 D H,INIT^IBATLM2
 Q
H ; call hang call
 D H^IBATLM1B
 Q
PI ; -- editing of pricing information
 N DA,DIE,DR,DTOUT,ICDVDT,ICPTVDT
 D LMOPT^IBATUTL
 L +^IBAT(351.61,IBIEN):0
 I '$T W !?5,"Another user is editing this entry." D H Q
 S (ICDVDT,ICPTVDT)=$P(IBDATA(0),U,4) ; Code Text Versioning
 S DR=$S($P(IBDATA(0),U,12)["DGPM":"1.01;D DRGDSP^IBATLM2B(X);1.02:1.06",$P(IBDATA(0),"^",12)["SCE":"[IBAT OUT PRICING EDIT]",$P(IBDATA(0),"^",12)["RMPR":"4.05",1:"4.02;4.03")
 S DIE="^IBAT(351.61,",DA=IBIEN
 I $P(^IBAT(351.61,DA,0),U,5)="X" W !!,"Transaction cancelled!" D H Q
 D ^DIE,TOTAL^IBATCM(IBIEN)
 L -^IBAT(351.61,IBIEN)
 D INIT^IBATLM2
 Q
DRGDSP(DRG) ; called from editing pricing info to display DRG pricing
 N IB0,X,Y,IBCHRG Q:'DRG
 S IB0=^IBAT(351.61,DA,0)
 S IBCHRG=$$INPT^IBATCM(DRG,$P(IB0,"^",4),$P(IB0,"^",11))
 S X=$P(IBCHRG,"^",2) D COMMA^%DTC
 W !!,?8,"Default Price $",X,! Q:'$P(IBCHRG,"^",3)
 S X=$P(IBCHRG,"^",3) D COMMA^%DTC
 W ?5,"Negotiated Price $",X,!
 Q
CPTDSP(CPT) ; called from editing pricing info to display CPT pricing
 N IB0,X,Y,IBCHRG Q:'CPT
 S IB0=^IBAT(351.61,DA(1),0)
 S IBCHRG=$$OPT^IBATCM(CPT,$P(IB0,"^",4),$P(IB0,"^",11))
 S X=$P(IBCHRG,"^",2) D COMMA^%DTC
 W !!,?8,"Default Price $",X,! Q:'$P(IBCHRG,"^",3)
 S X=$P(IBCHRG,"^",3) D COMMA^%DTC
 W ?5,"Negotiated Price $",X,!
 Q
