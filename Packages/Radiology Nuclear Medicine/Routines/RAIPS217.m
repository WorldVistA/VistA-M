RAIPS217 ;WOIFO/KLM - Post-init Driver ; Jul 16, 2024@12:50:46
 ;;5.0;Radiology/Nuclear Medicine;**217**;Mar 16, 1998;Build 1
 ;
 ;This patch will check/update the modality code on the recently added liver studies. 
 ;
EN ;entry point
 N RAPROC,RAPIEN,RAMDL,RAI
 F RAI=1:1 S RAPROC=$P($T(PROCS+RAI),";",3) Q:RAPROC=""  D
 .S RAPIEN=$$FIND1^DIC(71,,"X",RAPROC) Q:RAPIEN=0
 .N RAMODA S RAMODA=0 F  S RAMODA=$O(^RAMIS(71,RAPIEN,"MDL",RAMODA)) Q:RAMODA="B"  D
 ..S RAMDL=$G(^RAMIS(71,RAPIEN,"MDL",RAMODA,0)) Q:RAMDL'=$E(RAPROC,1,2)
 ..S RAIENS=RAMODA_","_RAPIEN_","
 ..S RAFDA(71.0731,RAIENS,.01)=RAMDL
 ..D FILE^DIE("E","RAFDA","RAERR")
 ..I $D(RAERR(1,"DIERR"))#2 D MES^XPDUTL("An error occured filing the Modality data for "_RAPROC)
 ..I '$D(RAERR) D MES^XPDUTL(RAPROC_" Updated")
 ..;No need to send to OE/RR - we do not send them modality
 ..Q
 .Q
 Q
PROCS ;Liver Procedures
 ;;MRI LIVER W/WO IV CONTRAST HCC
 ;;CT LIVER W/ IV CONTRAST 3 PHASE HCC
 ;;CT LIVER W/WO IV CONTRAST 4 PHASE HCC
 ;;US LIVER HCC SCREENING
 ;;US LIVER W/CONTRAST HCC
