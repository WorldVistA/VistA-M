RA98PST ;Hines OI/RTK - Post-install routine, patch 98 ;10/15/08  08:37
VERSION ;;5.0;Radiology/Nuclear Medicine;**98**;Mar 16, 1998;Build 2
 ;
 ;Integration Agreements
 ;----------------------
 ;^DIE(2053); BMES^XPDUTL(10141)
 ;
EN ;Entry point
 ;
 N RAAODT,RAOIEN,RARFSV1,RARFSVX,RARFSV2
 S RAAODT=3080819  ;start date=CPRSv27 release date-1
 D BMES^XPDUTL("Performing clean-up of Reason For Study data...")
 F  S RAAODT=$O(^RAO(75.1,"AO",RAAODT)) Q:RAAODT=""  D
 .F RAOIEN=0:0 S RAOIEN=$O(^RAO(75.1,"AO",RAAODT,RAOIEN)) Q:RAOIEN'>0  D
 ..S RARFSV1=$G(^RAO(75.1,RAOIEN,.1))
 ..I RARFSV1'[$C(10),RARFSV1'[$C(13) Q
 ..S RARFSVX=$TR(RARFSV1,$C(10)," ")
 ..S RARFSV2=$TR(RARFSVX,$C(13)," ")
 ..S RARFSV2=$E(RARFSV2,1,64)
 ..S DIE=75.1,DA=RAOIEN,DR="1.1///^S X=RARFSV2" D ^DIE
 ..K DIE,DA,DR Q
 .Q
 Q
