PSSCKOS ;BP/AGV - Returns order status for OP pharmacy using the CK option ;12/14/12
 ;;1.0;PHARMACY DATA MANAGEMENT;**175**;9/30/97;Build 9
 ;
 ; @Author  - Alberto Vargas
 ; @Date    - December 14, 2012
 ; @Version - 1.0
 ; @CCRs    - 5828, 6450, 6600
 ;
THOSTAT(DRG,THR,TCTR) ;**Add order status to THERAPY order check messages while using the hidden CK option
 NEW DRGN,PSOSTA,PSONM,PSOPON,PSOCFLG,PSOFLG SET DRGN="",PSOSTA="",PSONM="",PSOPON="",PSOCFLG="",PSOFLG=""
 ;**Retrieve and extract associated order number
 SET DRGN=DRG,PSOPON=$P($G(^TMP($J,LIST,"OUT","THERAPY",THR,"DRUGS",TCTR)),U,1),PSOCFLG=$P(PSOPON,";",1),PSOPON=$P(PSOPON,";",2)
 ;**Check for a clinic order
 IF PSOCFLG["C" SET DRGN=DRG_" (Clinic order)" Q DRGN
 ;**Order through PSOSD array to retrieve associated order statuses from patient's profile
 FOR  SET PSOSTA=$O(PSOSD(PSOSTA)) Q:(PSOSTA="")!($G(PSOFLG))  D
 .IF '$D(PSOSD(PSOSTA,DRG)),DRG=PSODRUG("NAME") SET DRGN=DRG_" (Prospective)",PSOFLG=1
 .FOR  SET PSONM=$O(PSOSD(PSOSTA,PSONM)) Q:(PSONM="")!($G(PSOFLG))  D
 ..IF DRG=$P(PSONM,U,1)  D
 ...IF PSOSTA="ACTIVE",PSOPON=$P(PSOSD(PSOSTA,PSONM),U,1) SET DRGN=DRG_" (Local Rx)",PSOFLG=1
 ...IF PSOSTA="ZNONVA",PSOPON=$P(PSOSD(PSOSTA,PSONM),U,10) SET DRGN=DRG_" (Non-VA)",PSOFLG=1
 ...IF PSOSTA="DISCONTINUED",PSOPON=$P(PSOSD(PSOSTA,PSONM),U,1) SET DRGN=DRG_" (Discontinued)",PSOFLG=1
 ...IF PSOSTA="PENDING",PSOPON=$P(PSOSD(PSOSTA,PSONM),U,10) SET DRGN=DRG_" (Pending)",PSOFLG=1
 Q DRGN
 ;
OSTAT(DRG,ON) ;**Add order status to DRUG order check messages while using the hidden CK option
 NEW DRGN,PSOSTA,PSONM,PSOPON,PSOCFLG,PSOFLG SET DRGN="",PSOSTA="",PSONM="",PSOPON="",PSOCFLG="",PSOFLG=""
 ;**Retrieve and extract associated order number
 SET DRGN=DRG,PSOCFLG=$P(ON,";",1),PSOPON=$P(ON,";",2)
 ;**Check for a clinic order
 IF PSOCFLG["C" SET DRGN=DRG_" (Clinic order)" Q DRGN
 ;**Order through PSOSD array to retrieve associated order statuses from patient's profile
 FOR  SET PSOSTA=$O(PSOSD(PSOSTA)) Q:(PSOSTA="")!($G(PSOFLG))  D
 .IF '$D(PSOSD(PSOSTA,DRG)),DRG=PSODRUG("NAME") SET DRGN=DRG_" (Prospective)",PSOFLG=1
 .FOR  SET PSONM=$O(PSOSD(PSOSTA,PSONM)) Q:(PSONM="")!($G(PSOFLG))  D
 ..IF DRG=$P(PSONM,U,1)  D
 ...IF PSOSTA="ACTIVE",PSOPON=$P(PSOSD(PSOSTA,PSONM),U,1) SET DRGN=DRG_" (Local Rx)",PSOFLG=1
 ...IF PSOSTA="ZNONVA",PSOPON=$P(PSOSD(PSOSTA,PSONM),U,10) SET DRGN=DRG_" (Non-VA)",PSOFLG=1
 ...IF PSOSTA="PENDING",PSOPON=$P(PSOSD(PSOSTA,PSONM),U,10) SET DRGN=DRG_" (Pending)",PSOFLG=1
 Q DRGN
 ;
POSTAT(DRG,PDRG,SV,ON,CT) ;**Add order status to PDRUG order check messages while using the hidden CK option
 NEW PDRGN,PSOSTA,PSONM,PSOPON,PSOCFLG,PSOFLG SET PDRGN="",PSOSTA="",PSONM="",PSOPON="",PSOCFLG="",PSOFLG=""
 ;**Retrieve and extract associated order number
 SET PDRGN=PDRG,PSOPON=$P($G(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT)),U,1),PSOCFLG=$P(PSOPON,";",1),PSOPON=$P(PSOPON,";",2)
 ;**Check for a clinic order
 IF PSOCFLG["C" SET PDRGN=PDRG_" (Clinic order)" Q PDRGN
 ;**Order through PSOSD array to retrieve associated order statuses from patient's profile
 FOR  SET PSOSTA=$O(PSOSD(PSOSTA)) Q:(PSOSTA="")!($G(PSOFLG))  D
 .IF '$D(PSOSD(PSOSTA,PDRG)),PDRG=PSODRUG("NAME") SET PDRGN=PDRG_" (Prospective)",PSOFLG=1
 .FOR  SET PSONM=$O(PSOSD(PSOSTA,PSONM)) Q:(PSONM="")!($G(PSOFLG))  D
 ..IF PDRG=$P(PSONM,U,1)  D
 ...IF PSOSTA="ACTIVE",PSOPON=$P(PSOSD(PSOSTA,PSONM),U,1) SET PDRGN=PDRG_" (Local Rx)",PSOFLG=1
 ...IF PSOSTA="ZNONVA",PSOPON=$P(PSOSD(PSOSTA,PSONM),U,10) SET PDRGN=PDRG_" (Non-VA)",PSOFLG=1
 ...IF PSOSTA="PENDING",PSOPON=$P(PSOSD(PSOSTA,PSONM),U,10) SET PDRGN=PDRG_" (Pending)",PSOFLG=1
 Q PDRGN
