IBD21P4 ;ALB/MAC - POST INIT - 6/11/96
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;**4**; 3-APR-96
 ; -- kill old synonym for Purge Conversion Log
EN1 D BMES^XPDUTL("Deleting old synonym for the Purge Conversion Log action..........")
 N IBDIFN,IBDORD,IBDFQUIT
 S IBDIFN=0
 S IBDIFN=$O(^ORD(101,"B","IBDFC PURGE CONVERSION LOG",IBDIFN)) I IBDIFN]"" D
 .S IBDORD=0
 .F  S IBDORD=$O(^ORD(101,IBDIFN,2,IBDORD)) Q:'IBDORD  I $P($G(^ORD(101,IBDIFN,2,IBDORD,0)),"^",1)'="PG" D
 ..S DIK="^ORD(101,"_IBDIFN_",2,",DA=IBDORD,DA(1)=IBDIFN D ^DIK K DA,DIK
 ..Q
EN2 D BMES^XPDUTL("Cleaning up corrupt second piece of global ^IBE(357,IFN,2,0)")
 W !,"                                   from 357.01 to 357.02.........."
 N IBDIFN
 S IBDIFN=0
 F  S IBDIFN=$O(^IBE(357,IBDIFN)) Q:'IBDIFN  I $D(^IBE(357,IBDIFN,2,0)) I ("^357.02I^")'[$P(^IBE(357,IBDIFN,2,0),"^",2) S $P(^IBE(357,IBDIFN,2,0),"^",2)="357.02I"
