PSS243PI ;BIR/MFR - Post-install routine for patch PSS*1*243 ; 02 Feb 2020  10:06 AM
 ;;1.0;PHARMACY DATA MANAGEMENT;**243**;9/30/97;Build 3
 ;
EN ; Post-install Entry Point
 ; Kills and Rebuils AND, APN and APR
 N XREF,DRUG,NDNODE,VAGENIEN,VAPRDIEN,PRIMDRG
 ; Killing off entire x-ref nodes before rebuilding it
 D BMES^XPDUTL("Killing 'AND', 'APN' and 'APR' cross-referenes...")
 F XREF="AND","APN","APR" K ^PSDRUG(XREF)
 H 3 D BMES^XPDUTL("Done!")
 ;Re-Building x-ref nodes
 D BMES^XPDUTL("Re-building 'AND', 'APN' and 'APR' cross-referenes...")
 S DRUG=0 F  S DRUG=$O(^PSDRUG(DRUG)) Q:'DRUG  D
 . I '$D(^PSDRUG(DRUG,"ND")) Q
 . S NDNODE=$G(^PSDRUG(DRUG,"ND"))
 . S VAGENIEN=$P(NDNODE,"^",1)                 ; VA GENERIC (#50.6) Pointer
 . S VAPRDIEN=$P(NDNODE,"^",3)                 ; VA PRODUCT (#50.68) Pointer
 . S PRIMDRG=$P($G(^PSDRUG(DRUG,2)),"^",6)     ; PRIMARY DRUG (#50.3) Pointer
 . I PRIMDRG,VAPRDIEN,VAGENIEN S ^PSDRUG("APN",PRIMDRG,VAGENIEN_"A"_VAPRDIEN,DRUG)=""
 . I VAGENIEN S ^PSDRUG("AND",VAGENIEN,DRUG)=""
 . I VAPRDIEN S ^PSDRUG("APR",VAPRDIEN,DRUG)=""
 H 3 D BMES^XPDUTL("Done!")
 Q
