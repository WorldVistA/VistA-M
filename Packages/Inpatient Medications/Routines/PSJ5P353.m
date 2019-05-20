PSJ5P353 ;BIRMINGHAM/GN-POST INSTALL TO REBUILD PARENT PROTOCOL MENU ;1/16/18 10:00am
 ;;5.0;INPATIENT MEDICATIONS ;**353**;16 DEC 97;Build 49
 ;
 ; Routine should be deleted after install.
 ; Routine can be re-run as needed.
 Q
EN ; ENTRY POINT
 N PSJPIEN,XQORM
 D MES^XPDUTL("")
 D MES^XPDUTL("Rebuild Hidden Action protocols")
 D MES^XPDUTL("")
 ; Recompile menus that contain new items
 S PSJPIEN=$O(^ORD(101,"B","PSJ LM ORDER VIEW HIDDEN ACTIONS",0))
 S XQORM=PSJPIEN_";ORD(101," D XREF^XQORM
 Q
