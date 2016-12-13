IB2P562A ;ALB/BG - SPECIAL INP BILLING MENU OPTION;3/21/16
 ;;2.0;INTEGRATED BILLING;**562**;21-MAR-94;Build 10
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ;updating discharge dates missing in file IBE(351.2)
 ;
UPDATE ;file update
 N IBCT,IBPTF,IBDPTF,IBDDT
 S IBCT=0 F  S IBCT=$O(^IBE(351.2,IBCT)) Q:'IBCT  I $P($G(^IBE(351.2,IBCT,0)),"^",5)'=2 D
 .S IBPTF=$P($G(^IBE(351.2,IBCT,0)),"^",2) Q:'IBPTF
 .Q:$P($G(^DGPM(IBPTF,0)),"^",17)="" 
 .S IBDPTF=$P($G(^DGPM(IBPTF,0)),"^",17),IBDDT=$P($G(^DGPM(IBDPTF,0)),"^")
 .N DA,DIE,DR
 .S DR=".05////2;.06////"_IBDDT_";2.03////"_DUZ_";2.04///NOW"
 .S DA=IBCT,DIE="^IBE(351.2," D ^DIE
 W !,"File Update Complete"
 W !,"Please review records using the List Special Inpatient Billing Cases Menu Option",!!
 Q
 ;
