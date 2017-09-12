PX91P ;ALB/DW - Post install routine ; 5/2/2000
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**91**;Aug 12, 1996
 ;Post installation routine of patch PX*1.0*91.
 ;Clean up PATIENT/IHS entries that point to non-existing patients.
 ;Problematic entries pointed to by other files are not 
 ;deleted and are reported by the routine.
 Q
 ;
EN ;Entry point.
 N PXIEN,PXPOINT,DA,DIK
 S (PXIEN,PXPOINT)=0
 K ^TMP("PX91P",$J)
 F  S PXIEN=$O(^AUPNPAT("B",PXIEN)) Q:PXIEN=""  D
 . I PXIEN?.N,'$D(^DPT(PXIEN)) S PXPOINT=0 D
 .. ;Check if file #839.01 points to the entry:
 .. I $D(^PX(839.01,"C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#839.01")
 .. ;Check if file #8925 points to the entry:
 .. I $D(^TIU(8925,"C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#8925")
 .. ;Check if file #9000010 points to the entry:
 .. I $D(^AUPNVSIT("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#9000010")
 .. ;;;Check if file #9000010.01 points to the entry:
 .. ;;;I $D(^AUPNVMSR("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#9000010.01")
 .. ;Check if file #9000010.06 points to the entry:
 .. I $D(^AUPNVPRV("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#9000010.06")
 .. ;Check if file #9000010.07 points to the entry:
 .. I $D(^AUPNVPOV("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#9000010.07")
 .. ;Check if file #9000010.11 points to the entry:
 .. I $D(^AUPNVIMM("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#9000010.11")
 .. ;Check if file #9000010.12 points to the entry:
 .. I $D(^AUPNVSK("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#9000010.12")
 .. ;Check if file #9000010.13 points to the entry:
 .. I $D(^AUPNVXAM("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#90000010.13")
 .. ;Check if file #9000010.15 points to the entry:
 .. I $D(^AUPNVTRT("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#9000010.15")
 .. ;Check if file #9000010.16 points to the entry:
 .. I $D(^AUPNVPED("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#900010.16")
 .. ;Check if file #9000010.18 points to the entry:
 .. I $D(^AUPNVCPT("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#9000010.18")
 .. ;Check if file #9000010.23 points to the entry:
 .. I $D(^AUPNVHF("C",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#9000010.23")
 .. ;Check if file #9000011 points to the entry:
 .. I $D(^AUPNPROB("AC",PXIEN)) S PXPOINT=1 D LIST(PXIEN,"#9000011")
 .. ;Delete the problematic entry if no other files points to it:
 .. I PXPOINT=0 S DA=PXIEN,DIK="^AUPNPAT(" D ^DIK D LISTD(PXIEN)
 D REPORT
 K ^TMP("PX91P",$J)
 Q
 ;
LIST(PXIEN,FILE) ;List problematic entries not deleted.
 S ^TMP("PX91P",$J,"NOK",PXIEN,FILE)=""
 Q
 ;
LISTD(PXIEN) ;List problematic entries deleted.
 S ^TMP("PX91P",$J,"KIL",PXIEN)=""
 Q
 ;
REPORT ;Report problematic entries and their status.
 D BMES^XPDUTL("PATIENT/IHS entries that point to non-existing patient but not deleted:")
 N NM,FL
 S NM="" F  S NM=$O(^TMP("PX91P",$J,"NOK",NM)) Q:NM=""  D
 . D MES^XPDUTL("  Entry#"_NM)
 . S FL="" F  S FL=$O(^TMP("PX91P",$J,"NOK",NM,FL)) Q:FL=""  D
 .. D MES^XPDUTL("     Pointed to by file "_FL)
 ;
 D BMES^XPDUTL("Entries deleted from the PATIENT/IHS file:")
 S NM="" F  S NM=$O(^TMP("PX91P",$J,"KIL",NM)) Q:NM=""  D
 . D MES^XPDUTL(" Entry#"_NM_" is deleted.")
 Q
 ;
