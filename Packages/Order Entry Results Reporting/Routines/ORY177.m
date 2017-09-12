ORY177 ;SLC/DAN - Clean up broken pointer to deleted parameters ;4/3/03  12:03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**177**;Dec 17, 1997
 ;Remove entries from file 8989.5 that were left over after
 ;improper deletion of parameters
 ;
 ;DBIA Section
 ;3985  - allows direct read of XTV(8989.5 and XTV(8989.51
 ;10013 - DIK
 ;10141 - XPDUTL
 ;
 N IEN,ENT,PAR,DA,DIK
 D BMES^XPDUTL("Cleaning up broken pointers...")
 S ENT="" F  S ENT=$O(^XTV(8989.5,"B",ENT)) Q:ENT=""  D
 .Q:ENT'["DIC(4.2"  ;Quit if not a system level entity
 .S IEN=0 F  S IEN=$O(^XTV(8989.5,"B",ENT,IEN)) Q:'+IEN  D
 ..S PAR=$P($G(^XTV(8989.5,IEN,0)),"^",2) Q:'+PAR  ;Stop if no parameter
 ..I '$D(^XTV(8989.51,PAR)) S DIK="^XTV(8989.5,",DA=IEN D ^DIK
 D BMES^XPDUTL("Finished cleaning up broken pointers...")
 Q
