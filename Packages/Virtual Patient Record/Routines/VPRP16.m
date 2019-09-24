VPRP16 ;SLC/MKB -- SDA utilities for patch 16 ;11/8/18  14:11
 ;;1.0;VIRTUAL PATIENT RECORD;**16**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; %ZTLOAD                      10063
 ; XLFDT                        10103
 ; XPDUTL                       10141
 ; XUPROD                        4440
 ;
 ;
POST ; -- postinit tasks
 D TASK
 Q
 ;
TASK ; -- task job to clean up ^VPR
 I '$$PROD^XUPROD D MES^XPDUTL("No task queued: not a production system") Q
 I '$D(^VPR("AVPR")),'$D(^VPR("ANEW")) D MES^XPDUTL("No task queued: no entries in update lists.") Q
 ;
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 S ZTRTN="LIST^VPRP16",ZTDTH=$$NOW^XLFDT,ZTIO=""
 S ZTDESC="Remove test patients from VPR update lists"
 D ^%ZTLOAD I '$G(ZTSK) D MES^XPDUTL("Unable to queue clean up task.") Q
 D MES^XPDUTL("Task #"_ZTSK_" was queued to clean up ^VPR")
 Q
 ;
LIST ; -- clean up ^VPR update lists for TEST and MERGED patients
 N DFN,SEQ,TYPE,ID
 ;
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:DFN<1  D
 . I '$D(^VPR(1,2,DFN)) Q  ;not subscribed
 . I '$$TESTPAT^VADPT(DFN),'$$MERGED^VPRHS(DFN) Q  ;ok
 . ; remove entries for test or merged patients
 . D ANEW,AVPR
 Q
 ;
ANEW ; ANEW = new subscribe
 S SEQ=$G(^VPR(1,2,DFN,"ANEW"))
 I SEQ K ^VPR("ANEW",SEQ,DFN),^VPR(1,2,DFN,"ANEW")
 Q
 ;
AVPR ; AVPR = data updates
 S TYPE="" F  S TYPE=$O(^VPR(1,2,DFN,"AVPR",TYPE)) Q:TYPE=""  D
 . S ID="" F  S ID=$O(^VPR(1,2,DFN,"AVPR",TYPE,ID)) Q:ID=""  S SEQ=+$G(^(ID)) D
 .. K ^VPR("AVPR",SEQ,DFN)
 .. K ^VPR(1,2,DFN,"AVPR",TYPE,ID)
 Q
