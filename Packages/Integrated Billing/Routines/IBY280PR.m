IBY280PR ;ALB/TMK - IB*2*280 PRE-INSTALL ;12-AUG-04
 ;;2.0;INTEGRATED BILLING;**280**;21-MAR-94
 ;
 N INS,IBX,DIC,DIE,DIK,DA,DR,Y,X
 D BMES^XPDUTL("Pre-Installation Updates")
 ;
 D BMES^XPDUTL("Restore remote member in mail group MCR")
 N IBMCR,IBMCH,DLAYGO,DIC,DIK,DA,DO,DD,Z,Z0 ; IA 4439
 S IBMCR=+$O(^XMB(3.8,"B","MCR",0)),IBMCH=+$O(^XMB(3.8,"B","MCH",0)) S Z=0 F  S Z=$O(^XMB(3.8,IBMCH,6,Z)) Q:'Z  S Z0=$P($G(^XMB(3.8,IBMCH,6,Z,0)),U) I Z0'="" D
 . I '$D(^XMB(3.8,IBMCR,6,"B",$E(Z0,1,30))) D
 .. S DLAYGO=3.812,DIC(0)="L",X=Z0,DA(1)=IBMCR,DIC="^XMB(3.8,"_DA(1)_",6," D FILE^DICN K DO,DD,DA,DLAYGO,DIC
 ;
 D BMES^XPDUTL("Updating/removing output formatter records")
 ;
 ; Make CI1-7 data element allow local override
 S DA=1316,DIE="^IBA(364.6,",DR=".07////1" D ^DIE
 ;
 ; Delete entries 158/210 left over from changes to patch 232
 F DA=158,210 S DIK="^IBA(364.7," D ^DIK
 ;
 ; Remove FL56 data from transmission file
 F DA=906:1:910 D
 . S DIE="^IBA(364.7,",DR=".03////5;1///K IBXDATA" D ^DIE
 . S IBX(1)="Data is no longer transmitted."
 . D WP^DIE(364.7,DA_",",3,"","IBX")
 ;
 D ENDST
 ;
 D BMES^XPDUTL("Update Provider ID types")
 ; Correct X12 codes for provider ID types
 S IBX=0
 F  S IBX=$O(^IBE(355.97,IBX)) Q:+IBX=0  D
 . Q:'$D(^IBE(355.97,IBX,0))
 . S INS=$P(^IBE(355.97,IBX,0),"^",1)
 . Q:INS=""
 . I INS["CROSS" S $P(^IBE(355.97,IBX,0),"^",3)="1A"
 . I INS["SHIELD" S $P(^IBE(355.97,IBX,0),"^",3)="1B"
 . I INS["CHAMPUS"!(INS["TRICARE") S $P(^IBE(355.97,IBX,0),"^",3)="1H" I INS["CHAMPUS" S DA=IBX,DR=".01////TRICARE ID",DIE="^IBE(355.97," D ^DIE
 . I INS["COMMER" S $P(^IBE(355.97,IBX,0),"^",3)="G2"
 . I INS["CLIA" S $P(^IBE(355.97,IBX,0),"^",3)="X4"
 . I INS["MEDICARE" S $P(^IBE(355.97,IBX,0),"^",3)="1C"
 . I INS["TAX" S $P(^IBE(355.97,IBX,0),"^",3)="24"
 . I INS["NETWORK" S $P(^IBE(355.97,IBX,0),"^",3)="N5"
 . I INS["UPIN" S $P(^IBE(355.97,IBX,0),"^",3)="1G",$P(^(0),U,2)=0
 . I INS["PPO" S $P(^IBE(355.97,IBX,0),"^",3)="B3"
 . I INS["HMO" S $P(^IBE(355.97,IBX,0),"^",3)="BQ"
 . I INS["SOCIAL" S $P(^IBE(355.97,IBX,0),"^",3)="SY"
 . I INS["STATE" S $P(^IBE(355.97,IBX,0),"^",3)=$S(INS["LICENSE":"0B",1:"X5")
 ;
 D ENDST
 ;
 D BMES^XPDUTL("Remove xref on INSURANCE CO file, field 4.1 and delete bad values")
 D DELIX^DDMOD(36,4.1,1,"","")
 I $G(^IBA(364.7,1015,1))'["4010" S INS=0 F  S INS=$O(^DIC(36,INS)) Q:'INS  D
 . S DR="4.01///@;4.02///@",DA=INS,DIE="^DIC(36," D ^DIE
 ;
 D ENDST
 ;
 D END
 Q
 ;
ENDST ;
 D BMES^XPDUTL("Step complete")
 Q
 ;
END ;
 D BMES^XPDUTL("Pre-install complete")
 Q
 ;
