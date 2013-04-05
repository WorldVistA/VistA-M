DG53856P ;BIR/CKN-PATCH DG*5.3*856 POST INSTALLATION ROUTINE ; 5/15/12 6:12pm
 ;;5.3;Registration;**856**;Aug 13, 1993;Build 5
 Q
EP ;**856 (ckn)
 ;Do not run module if patch DG*5.3*856 previously installed.
 I $$PATCH^XPDUTL("DG*5.3*856") D BMES^XPDUTL("The AISS cross-reference previously created; no action needed.") Q
AGN D BMES^XPDUTL("Creating AISS cross-reference on the TREATING FACILITY LIST #391.91 file.")
 N ZTRTN,ZTDESC,ZTSK
 S ZTRTN="EN^DG53856P",ZTDESC="DG53856P - INDEX TREATING FACILITY FILE"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 I $D(ZTSK) D BMES^XPDUTL("Look for the completion of task #"_ZTSK_" in Taskman.") D MES^XPDUTL("When the task finishes, the AISS cross-reference has been created.")
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
EN ;
 N SID,TFIEN,AA,IDTYP,SITE,SITEN,NODE0,NODE2
 S TFIEN=0
 F  S TFIEN=$O(^DGCN(391.91,TFIEN)) Q:'TFIEN  D
 . S NODE0=$G(^DGCN(391.91,TFIEN,0))
 . S SITE=$P(NODE0,"^",2)
 . S IDTYP=$P(NODE0,"^",9)
 . S NODE2=$G(^DGCN(391.91,TFIEN,2))
 . S AA=$P(NODE2,"^"),SID=$P(NODE2,"^",2)
 . S SITEN=$$STA^XUAF4(SITE)
 . I SITEN="200DOD" D
 .. N FDA
 .. I AA'="USDOD" S AA="USDOD",FDA(1,391.91,+TFIEN_",",10)=AA
 .. I IDTYP'="NI" S IDTYP="NI",FDA(1,391.91,+TFIEN_",",.09)=IDTYP
 .. I $D(FDA) D FILE^DIE("K","FDA(1)","ERR")
 .. K FDA
 . I SITEN["200N" D
 .. N FDA
 .. I IDTYP="" S IDTYP="NI"
 .. I AA'="" S FDA(1,391.91,+TFIEN_",",.09)=IDTYP
 .. I $D(FDA) D FILE^DIE("K","FDA(1)","ERR")
 .. K FDA
 . I AA'="",IDTYP'="",SITE'="",SID'="" D
 .. S ^DGCN(391.91,"AISS",$E(SID,1,150),$E(AA,1,70),$E(IDTYP,1,10),$E(SITE,1,10),TFIEN)=""
 Q
 ;
RERUN ;If the AISS cross-reference must be deleted and recreated
 ;by Product Support, use this line tag.
 K ^DGCN(391.91,"AISS")
 D AGN^DG53856P
 Q
 ;
