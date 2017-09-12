PRCA280 ;ALB/CXW - POST INIT, Type of Care correction; 14-SEP-2011
 ;;4.5;Accounts Receivable;**280**;Mar 20, 1995;Build 12
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
POST ; 
 D MSG("    PRCA*4.5*280 Post-Install .....")
 D UPACT
 D MSG("    PRCA*4.5*280 Post-Install Complete")
 D MSG("")
 Q
 ;
UPACT ;Update to Type of Care #15.1 in file #430
 N IBI,IBDG,IBAT,IBAIEN,IBCEN,IBNCC,PRCAX,PRCATC,PRCACNT,DIE,DA,DR,X
 S IBNCC="HOSPITAL CARE (NSC)"
 S IBCEN=$O(^PRCA(430.2,"B",IBNCC,0))
 I 'IBCEN D MSG(">>> "_IBNCC_" not defined on file #430.2, no update on file #430") Q
 ; update if patient charges in these type events
 S IBDG="^DG FEE SERVICE (INPT) CANCEL^DG FEE SERVICE (INPT) NEW^DG FEE SERVICE (INPT) UPDATE^"
 ;
 D MSG(">>> Updating Type of Care to file #430...")
 S IBI="",PRCACNT=0
 F  S IBI=$O(^IB("ABIL",IBI)) Q:IBI=""  D
 . S IBAIEN=$O(^IB("ABIL",IBI,0)) Q:'IBAIEN
 . S IBAT=$P($G(^IB(IBAIEN,0)),"^",3) Q:'IBAT
 . S IBAT=$P(^IBE(350.1,IBAT,0),"^")
 . ; no update if none of 3 dg fee service (inpt)
 . I '$F(IBDG,"^"_IBAT_"^") Q
 . S PRCAX=$O(^PRCA(430,"B",IBI,0)) Q:'PRCAX
 . S PRCATC=$P(^PRCA(430,PRCAX,0),"^",16)
 . ; no update if exists or null
 . I ('PRCATC)!(PRCATC=IBCEN) Q
 . S PRCATC=$P(^PRCA(430.2,PRCATC,0),"^")
 . S DA=+PRCAX,DIE="^PRCA(430,",DR="15.1///"_IBCEN D ^DIE K DA,DIE,DR
 . D MSG(" >> "_PRCATC_" on "_IBI_" changed to "_IBNCC)
 . S PRCACNT=PRCACNT+1
 D MSG(">>> The type of care on total "_PRCACNT_$S(PRCACNT=1:" bill has",1:" bills have")_" been updated")
 Q
 ;
MSG(X) ;
 D MES^XPDUTL(X)
 Q
 ;
