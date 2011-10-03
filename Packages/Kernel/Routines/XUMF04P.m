XUMF04P ;BP/RAM - INSTITUTION CLEANUP ;06/28/00
 ;;8.0;KERNEL;**549**;Jul 10, 1995;Build 9
 ;
 ;
 Q
 ;
MAIN ; -- post init entry point
 ;
 Q:$$KSP^XUPARAM("INST")=12000
 Q:$P($$PARAM^HLCS2,U,3)="T"
 ;
 M ^TMP("XUMF 04",$$NOW^XLFDT,$J,4)=^DIC(4)
 ;
 S XUMF=1
 ;
 D P101,PHARM,LP1,LP2,NPI,TAX,EN^XUMF04Q,BK
 ;
 Q
 ;
KT ; -- kill temp node / file backup
 ;
 K ^TMP("XUMF 04")
 ;
 Q
 ;
BK ; -- background job to kill temp node in 30 days
 ;
 N ZTRTN,ZTDESC,ZTDTH
 ;
 S ZTRTN="KT^XUMF04P"
 S ZTDESC="XUMF kill temp backup of file 4 - patch xu549"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,30,0,0,0)
 S ZTIO=""
 ;
 D ^%ZTLOAD
 ;
 Q
 ;
P101 ; -- add subscriber protocols to event protocols
 ;
 N IEN,FDA,IENS
 ;
 ; mfp
 K FDA
 S IEN=$$FIND1^DIC(101,,"B","XUMF 04 MFQ")
 S IENS=IEN_","
 S FDA(101.0775,"?+1,"_IENS,.01)="XUMF 04 MFR"
 D UPDATE^DIE("E","FDA","IENS")
 ;
 ; mfq
 K FDA
 S IEN=$$FIND1^DIC(101,,"B","XUMF 04 MFN")
 S IENS=IEN_","
 S FDA(101.0775,"?+1,"_IENS,.01)="XUMF 04 MFK"
 D UPDATE^DIE("E","FDA","IENS")
 ;
 Q
 ;
LP1 ; -- loop file
 ;
 W !!!,"CHECKING IDENTIFIER MULTIPLE",!!!
 ;
 N IEN,STA,IEN,DA
 ;
 S STA="" F  S STA=$O(^DIC(4,"XUMFIDX","VASTANUM",STA)) Q:STA=""  D
 . S IEN=$O(^DIC(4,"XUMFIDX","VASTANUM",STA,0)) Q:'IEN
 . S DA=$O(^DIC(4,"XUMFIDX","VASTANUM",STA,IEN,0)) Q:'DA
 . D CLN
 ;
 Q
 ;
LP2 ; -- loop file
 ;
 N IEN,NPI,IEN,DA
 ;
 S NPI="" F  S NPI=$O(^DIC(4,"XUMFIDX","NPI",NPI)) Q:NPI=""  D
 . S IEN=$O(^DIC(4,"XUMFIDX","NPI",NPI,0)) Q:'IEN
 . S DA=$O(^DIC(4,"XUMFIDX","NPI",NPI,IEN,0)) Q:'DA
 . D CLN
 ;
 Q
 ;
CLN ; -- clean up id mult
 ;
 N IENS,ROOT,DIK,DIC
 ;
 S IENS=IEN_","
 ;
 S ROOT=$$ROOT^DILFD(4.9999,","_IENS,1)
 S DA(1)=+IENS,DIK=$P(ROOT,")")_"," D ^DIK
 ;
 Q
 ;
NPI ; -- clean npi
 ;
 N IEN,NPI,IEN,ROOT,IENS
 ;
 S IEN=0 F  S IEN=$O(^DIC(4,IEN)) Q:'IEN  D
 . S NPI=$G(^DIC(4,IEN,"NPI")) Q:'NPI
 . S IDX=0 F  S IDX=$O(^DIC(4,IEN,"NPISTATUS",IDX)) Q:'IDX  D
 .. Q:$P(^DIC(4,IEN,"NPISTATUS",IDX,0),U,3)=NPI
 .. S IENS=IEN_",",ROOT=$$ROOT^DILFD(4.042,","_IENS,1)
 .. N DA,DIK,DIC S DA(1)=+IENS,DA=IDX,DIK=$P(ROOT,")")_"," D ^DIK
 ;
 Q
 ;
PHARM ; REMOVE DUPLICATE PHARM
 ;
 W !!!,"CLEANING UP DUPLICATE PHARMACY ENTRIES",!!!
 ;
 N NAME,IEN,IENS,FDA,XUMF
 ;
 S NAME=""
 F  S NAME=$O(^DIC(4,"B",NAME)) Q:NAME=""  Q:$E(NAME,1,2)="ZZ"  D
 .Q:NAME'[" PHARM"
 .S IEN=0 F  S IEN=$O(^DIC(4,"B",NAME,IEN)) Q:'IEN  D
 ..Q:+$G(^DIC(4,IEN,"NPI"))
 ..Q:+$G(^DIC(4,IEN,99))
 ..Q:$P($G(^DIC(4,IEN,0)),U,11)="L"
 ..S XUMF=1
 ..S IENS=IEN_","
 ..K FDA
 ..S FDA(4,IENS,.01)=$E("ZZ DUP "_NAME,1,30)
 ..S FDA(4,IENS,101)="INACTIVE"
 ..D FILE^DIE("E","FDA")
 ;
 Q
 ;
TAX ;
 ;
 S IEN=0 F  S IEN=$O(^DIC(4,IEN)) Q:'IEN  D
 .Q:'$D(^DIC(4,IEN,"TAXONOMY"))
 .N ROOT,IDX,IENS
 .S IENS=IEN_",",ROOT=$$ROOT^DILFD(4.043,","_IENS,1)
 .S IDX=$O(@ROOT@(0)) Q:'IDX
 .F  S IDX=$O(@ROOT@(IDX)) Q:'IDX  D
 ..D
 ...N DA,DIK,DIC S DA(1)=+IENS,DA=IDX,DIK=$P(ROOT,")")_"," D ^DIK
 ;
 Q
 ;
EXIT ; -- cleanup, and quit
 ;
 Q
 ;
