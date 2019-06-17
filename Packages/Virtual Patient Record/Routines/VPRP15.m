VPRP15 ;SLC/MKB -- SDA utilities for patch 15 ;11/8/18  14:11
 ;;1.0;VIRTUAL PATIENT RECORD;**15**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XUSAP                         4677
 ;
 ;
POST ; -- postinit tasks
 D PRXY,TASK
 Q
 ;
PRXY ; -- create proxy user
 I '$O(^VA(200,"B","VPRVDIF,APPLICATION PROXY",0)) D
 . N X S X=$$CREATE^XUSAP("VPRVDIF,APPLICATION PROXY","")
 Q
 ;
TASK ; -- task job to clean up ^VPR
 I '$D(^VPR("AVPR")),'$D(^VPR("ANEW")) D MES^XPDUTL("No task queued; no entries in update lists.") Q
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 S ZTRTN="LIST^VPRP15",ZTDTH=$$NOW^XLFDT,ZTIO=""
 S ZTDESC="Remove duplicate nodes from VPR update lists"
 D ^%ZTLOAD I '$G(ZTSK) D MES^XPDUTL("Unable to queue clean up task.") Q
 D MES^XPDUTL("Task #"_ZTSK_" was queued to clean up ^VPR")
 Q
 ;
LIST ; -- clean up ^VPR update lists
 N SEQ,DFN,TYPE,ID,X,XREF
 ;
 ; ANEW = patients to subscribe
 S SEQ=0 F  S SEQ=+$O(^VPR("ANEW",SEQ)) Q:SEQ<1  S DFN=+$O(^(SEQ,0)) D
 . S X=$G(^VPR(1,2,DFN,"ANEW"))
 . I X'>0 S ^VPR(1,2,DFN,"ANEW")=SEQ Q  ;create
 . I X,X'=SEQ K ^VPR("ANEW",SEQ,DFN) Q  ;duplicate, remove
 . I X,X=SEQ Q                          ;ok (if re-run)
 ;
 ; AVPR = data updates
 S SEQ=0 F  S SEQ=+$O(^VPR("AVPR",SEQ)) Q:SEQ<1  S DFN=+$O(^(SEQ,0)),XREF=$G(^(DFN)) D
 . S TYPE=$P(XREF,U,2) Q:TYPE=""
 . S ID=$P(XREF,U,3) S:ID="" ID="*"
 . ;
 . ; look for bad nodes
 . I TYPE="OtherOrder",ID,$$BADORD K ^VPR(1,2,DFN,"AVPR",TYPE,ID),^VPR("AVPR",SEQ,DFN) Q
 . I TYPE="Referral",ID,$$BADREF K ^VPR(1,2,DFN,"AVPR",TYPE,ID),^VPR("AVPR",SEQ,DFN) Q
 . ;
 . ; create patient node, or Q if exists (re-run)
 . S X=$G(^VPR(1,2,DFN,"AVPR",TYPE,ID))
 . I X'>0 S ^VPR(1,2,DFN,"AVPR",TYPE,ID)=SEQ_U_$P(XREF,U,4,5) Q
 . I X,+X=SEQ Q
 . ;
 . ; duplicate - keep first SEQ (+X) but update action^visit to latest
 . S ^VPR(1,2,DFN,"AVPR",TYPE,ID)=+X_U_$P(XREF,U,4,5)
 . S $P(^VPR("AVPR",+X,DFN),U,4,5)=$P(XREF,U,4,5)
 . K ^VPR("AVPR",SEQ,DFN)
 Q
 ;
BADORD() ; -- return 1 or 0, if not truly an Other order
 N X,Y,PKG
 S X=+$P($G(^OR(100,+$G(ID),0)),U,14),PKG=$$GET1^DIQ(9.4,X,1)
 S Y=$S($E(PKG,1,2)="LR":1,$E(PKG,1,2)="PS":1,$E(PKG,1,2)="RA":1,1:0)
 Q Y
 ;
BADREF() ; -- return 1 or 0, if bad Referral reference
 I $P(ID,";",2)=100 Q 1
 I '$D(^GMR(123,+ID,0)) Q 1
 I $P(^GMR(123,+ID,0),U,2)'=DFN Q 1
 Q 0
