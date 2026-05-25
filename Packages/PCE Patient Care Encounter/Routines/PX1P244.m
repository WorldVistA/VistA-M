PX1P244 ;SLC/GN - Post/Pre install code;Oct 06, 2025@08:59:52
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**244**;Aug 12, 1996;Build 37
 ;
 ; This routine updates Post code to init a new Parameter
 ;
 Q
 ;
DELDD ;
 N DIU,TEXT
 D BMES^XPDUTL("Removing old data dictionaries.")
 S DIU(0)=""
 F DIU=820 D
 . S TEXT=" Deleting data dictionary for file # "_DIU
 . D MES^XPDUTL(TEXT)
 . D EN^DIU2
 Q
 ;
PRE ;
 D DELDD
 Q
POST ;Init PKG (7) value for New parameter to No, init SYS (6) to null, as an answer will always override the PKG setting, leaving SYS available for future override decision.
 D EN^XPAR("PKG","PX SA USE LOC FOR ENCOUNTERS",1,"n")   ;n/0
 D EN^XPAR("SYS","PX SA USE LOC FOR ENCOUNTERS",1,"@")   ;unanswered
 Q
 ;
