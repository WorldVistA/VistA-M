DG531011P ;OIT/KCL - PRE-INSTALL ROUTINE FOR DG*5.3*1011 ;3/27/2020
 ;;5.3;Registration;**1011**;Aug 13,1993;Build 4
 ;
 ;no direct entry
 Q
 ;
EP ;Entry Point
 ;
 D STORE
 ;
 Q
 ;
STORE ;Store patients with HURRICANE KATRINA indicator in ^XTMP global, then delete from patient record
 ;
 D BMES^XPDUTL(">>> Store patients (DFNs) with HURRICANE KATRINA indicator in")
 D MES^XPDUTL("    ^XTMP(""DG531011P"") global and delete indicator from the")
 D MES^XPDUTL("    EMERGENCY RESPONSE INDICATOR (#.181) field of those records")
 D MES^XPDUTL("    in PATIENT (#2) file.")
 ;
 ;quit if patch already installed and ^XTMP exists
 I $$PATCH^XPDUTL("DG*5.3*1011"),$D(^XTMP("DG531011P")) D BMES^XPDUTL("    Not needed since patch has been installed previously.") Q
 ;
 N %,DGDTS,DGDTE,DGCNT,DGIEN,DGFDA,DGERR,Y
 ;
 ;setup zero node of ^XTMP global (120 day expiration)
 K ^XTMP("DG531011P")
 S ^XTMP("DG531011P",0)=$$FMADD^XLFDT(DT,120)_U_DT_U_"EMERGENCY PATCH DG*5.3*1011"
 ;
 ;start time
 D NOW^%DTC S Y=% D DD^%DT
 S DGDTS=Y
 ;
 ;loop through "AERI" xref to retrieve patients with HURRICANE KATRINA indicator
 S (DGIEN,DGCNT)=0
 F  S DGIEN=$O(^DPT("AERI","K",DGIEN)) Q:'DGIEN  D
 . S DGCNT=DGCNT+1
 . ;place DFN in ^XTMP global
 . S ^XTMP("DG531011P",$J,"DFN",DGCNT)=DGIEN
 . ;
 . ;now delete HURRICANE KATRINA indicator from record in PATIENT (#2) file
 . S DGFDA(2,DGIEN_",",.181)="@"
 . D FILE^DIE("","DGFDA","DGERR")
 ;
 ;end time
 D NOW^%DTC S Y=% D DD^%DT
 S DGDTE=Y
 ;
 ;place statistics into ^XTMP global
 S ^XTMP("DG531011P",$J,"START")=$G(DGDTS) ;start date/time
 S ^XTMP("DG531011P",$J,"END")=$G(DGDTE) ;end date/time
 S ^XTMP("DG531011P",$J,"TOTAL")=DGCNT ;total records
 ;
 D BMES^XPDUTL("    Total records stored in ^XTMP(""DG531011P"") global: "_+$G(DGCNT))
 ;
 Q
