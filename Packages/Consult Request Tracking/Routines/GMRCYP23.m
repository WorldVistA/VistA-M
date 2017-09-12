GMRCYP23 ;SLC/MA - Post Install for patch 23 ;1/10/02  14:27
 ;;3.0;CONSULT/REQUEST TRACKING;**23**;DEC 27, 1997
EN ; Main entry point for post-install
 ; Routine will populate the new xref (AP,AL) for global
 ; ^GMR(123) REQUEST/CONSULTATION
 ; DBIA 10013 call ENALL^DIK
 S DIK="^GMR(123,",DIK(1)="4^AP"  ;XREF for Procedures
 D ^XQDATE
 D BMES^XPDUTL("START OF BUILDING ""AP"" XREF @ "_%Y)
 D ENALL^DIK
 D ^XQDATE
 D BMES^XPDUTL("END OF BUILDING ""AP"" XREF @   "_%Y)
 D ^XQDATE
 D BMES^XPDUTL("START OF BUILDING ""AL"" XREF @ "_%Y)
 S DIK(1)=".04^AL"                  ;XREF for patient location
 D ENALL^DIK
 D ^XQDATE
 D BMES^XPDUTL("END OF BUILDING ""AL"" XREF @   "_%Y)
 K DIK
 Q
