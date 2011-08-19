PSJ007 ;BIR/RSB-UTILITY ROUTINE FOR PATCH PSJ*5*7 ; 16 Jun 98 / 12:28 PM
 ;;5.0; INPATIENT MEDICATIONS ;**7**; 16 DEC 97
 ;
 Q
EN ;  QUEUE UP 53.1 CLEANUP
 S ZTIO="",ZTDTH=$$CON(XPDQUES("POS ONE"))
 S ZTDESC="Inpatient Medications Patch PSJ*5*7 Unit Dose Non-Verified Orders File Cleanup"
 S ZTRTN="START^PSJ007" D ^%ZTLOAD
 I $D(ZTSK) D MES^XPDUTL(" ") D MES^XPDUTL("Task #"_ZTSK_" is queued to run"_$S($D(PSJCONV):" NOW",1:" at "_XPDQUES("POS ONE")))
TEST ; Test text creation.    
 N PM S PM="This task will find and delete entries the NON-VERIFIED/PENDING ORDERS" D MES^XPDUTL(PM)
 S PM="file (#53.1) that have no zero node." D MES^XPDUTL(PM)
 Q
START ;
 N PSJ
 F PSJ=0:0 S PSJ=$O(^PS(53.1,PSJ)) Q:'PSJ  K:'$D(^PS(53.1,PSJ,0)) ^PS(53.1,PSJ)
 S ZTREQ="@"
 Q
 ;
GETDT ; check date/time for job to run
 N %DT,Y S %DT="NRS"
 D ^%DT I Y=-1 K X
 E  S X=Y
 Q
CON(X) ;
 N %DT S %DT="NRS" D ^%DT
 Q Y
