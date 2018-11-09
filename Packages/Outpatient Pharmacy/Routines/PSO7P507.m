PSO7P507 ;BIRMINGHAM/GN-POST INSTALL TO REBUILD PARENT PROTOCOL MENU ;1/16/18 10:00am
 ;;7.0;OUTPATIENT PHARMACY;**507**;13 Feb 97;Build 28
 ;
 ; Routine should be deleted after install.
 ; Routine can be re-run as needed.
 Q
EN ; ENTRY POINT
 N PSOPIEN,XQORM
 D MES^XPDUTL("")
 D MES^XPDUTL("Rebuild Hidden Action protocols")
 D MES^XPDUTL("")
 ; Recompile menus that contain new items
 S PSOPIEN=$O(^ORD(101,"B","PSO HIDDEN ACTIONS #3",0))
 S XQORM=PSOPIEN_";ORD(101," D XREF^XQORM
 Q
