PSB381P ;MNT/BJR - Move Units Given field to Units Ordered ;
 ;;3.0;BAR CODE MED ADMIN;**81**;Mar 2004;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
EN ;This routine will delete any "AADT" indexes that do not have a corresponding 0 node for the last 60 days for patch PSB*3*81
 ;This routine will also delete any "AINFUSING" indexes for completed bags.
 D MES^XPDUTL("")
 D MES^XPDUTL("*** PSB*3*81 Post Install Running ***")
 D MES^XPDUTL("")
 N PSBDFN,PSBBEGIN,PSBSTRT,PSBIEN
 D NOW^%DTC S PSBBEGIN=$$FMADD^XLFDT(X,-60)
 S PSBDFN=0 F  S PSBDFN=$O(^PSB(53.79,"AADT",PSBDFN)) Q:'PSBDFN  D
 .S PSBSTRT=PSBBEGIN F  S PSBSTRT=$O(^PSB(53.79,"AADT",PSBDFN,PSBSTRT)) Q:'PSBSTRT  D
 ..S PSBIEN=0 F  S PSBIEN=$O(^PSB(53.79,"AADT",PSBDFN,PSBSTRT,PSBIEN)) Q:'PSBIEN  D
 ...I '$D(^PSB(53.79,PSBIEN,0)) K ^PSB(53.79,"AADT",PSBDFN,PSBSTRT,PSBIEN)  D MES^XPDUTL("AADT Index Deleted for record "_PSBIEN)
 S PSBDFN=0 F  S PSBDFN=$O(^PSB(53.79,"AINFUSING",PSBDFN)) Q:'PSBDFN  D
 .S PSBSTRT=0 F  S PSBSTRT=$O(^PSB(53.79,"AINFUSING",PSBDFN,PSBSTRT)) Q:'PSBSTRT  D
 ..S PSBIEN=0 F  S PSBIEN=$O(^PSB(53.79,"AINFUSING",PSBDFN,PSBSTRT,PSBIEN)) Q:'PSBIEN  D
 ...I $$GET1^DIQ(53.79,PSBIEN_",",.09,"I")="C" K ^PSB(53.79,"AINFUSING",PSBDFN,PSBSTRT,PSBIEN)  D MES^XPDUTL("AINFUSING Index Deleted for record "_PSBIEN)
 D MES^XPDUTL("")
 D MES^XPDUTL("*** PSB*3*81 Post Install Completed ***")
 D MES^XPDUTL("") 
 Q
