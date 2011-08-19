IBCSC9 ;ALB/MJB - MCCR SCREEN 9 (LOCAL SCREEN 9 SPECIFIC INFO) ;27 MAY 99 10:20
 ;;2.0;INTEGRATED BILLING;**52,51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN N IBCOB,IBSCRN,IBANY,IBXERR
 S IBCOB=$$COBN^IBCEF(IBIFN),IBANY=1
 S IBSCRN=$$LOCSCRN(IBIFN) ;Find screen from file 353
 I IBSCRN="" S IBANY="No local screen has been defined for this form type"
 I '$D(^DGCR(399,IBIFN,"I"_IBCOB)),'$P($G(^DGCR(399,IBIFN,"M")),U,11) S IBANY="Bill must have insurance co or resp institution to use this screen"
 D ^IBCSCU S IBSR=9,IBSR1=""
 D H^IBCSCU
 N IBWW,Z,IBPARMS
 ;Call formatter to extract data for screen here ... read thru the array
 ; ^TMP("IBXDATA",$J,1,PG,LINE,COL)=DATA to 'display' the data fields
 S IBPARMS(1)="BILL-SEARCH",IBPARMS(3)=$S($$INPAT^IBCEF(IBIFN):"I",1:"O"),IBPARMS(2)=$P($G(^DGCR(399,IBIFN,"I"_IBCOB)),U)
 S IBWW=""
 K ^TMP("IBXDATA",$J),^TMP("IBXEDIT",$J),IBXERR
 D FPRE^IBCEFG7(+IBSCRN,0,.IBXERR) ;Form pre-processor
 I $D(IBXERR) S IBANY=IBXERR
 I IBANY D
 .N VADM
 .S IBANY=$$EXTRACT^IBCEFG(IBSCRN,IBIFN,1,.IBPARMS) S:'IBANY IBANY="No local data fields are needed for this bill type/insurance company"
 I IBANY D
 .F Z0=1:1:$O(^TMP("IBXDATA",$J,1,1,""),-1) W ! S Z1="" F  S Z1=$O(^TMP("IBXDATA",$J,1,1,Z0,Z1)) Q:'Z1  S Z2=^(Z1),Z3="" S:$E(Z2)="[" Z3=+$P(Z2,"[",2),Z2=$P(Z2,"]",2,999) W ?Z1 W:Z3 "[",IBVI,Z3,IBVO,"]" W Z2
 .S IBV1=""
 .I $S($G(IBV)=1:0,1:$$STATOK^IBCEU4(IBIFN,"12")) S Z="" F  S Z=$O(^TMP("IBXEDIT",$J,Z)) Q:'Z  S $E(IBV1,Z)=0
 I 'IBANY S IBV1="1" W !!,IBANY
 G ^IBCSCP
 ;
EDIT ;
 N Z,DR,DA,DIE,FLDS,Z0,IBCUFT
 S IBCUFT=$P($G(^DGCR(399,IBIFN,0)),U,19)
 F Z=1:1:$L(IBDR20,",") S Z0=$P(IBDR20,",",Z) D
 .S DR=""
 .S IBGRP=Z0-90,Z0=0 F  S Z0=$O(^TMP("IBXEDIT",$J,IBGRP,Z0)) Q:'Z0  S DR=DR_$S($L(DR):";",1:"")_^(Z0)
 .I $L(DR) S DIE=+$G(^IBE(353,IBCUFT,2)),DA=IBIFN D ^DIE
 Q
 ;
LOCSCRN(IBIFN) ; Find the local screen from the bill form type
 Q $P($G(^IBE(353,+$P($G(^DGCR(399,IBIFN,0)),U,19),2)),U,9)
 ;
Q Q
 ;IBCSC9
 ;
