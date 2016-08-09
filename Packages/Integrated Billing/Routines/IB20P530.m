IB20P530 ;ALB/TJB - IB*2.0*530 FY-14 Updates to FILE 361.1 ;04/02/2015 
 ;;2.0;INTEGRATED BILLING;**530**;21-MAR-94;Build 71
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ; Post-install of patch installation 
 D MES^XPDUTL("IB*2.0*530 Post-Install starts...")
 D RIDX
 D MES^XPDUTL("IB*2.0*530 Post-Install is complete.")
 Q
 ;
RIDX ; Index ^IBM(361.1) for the new index on field .03 (PAYER ID),
 ; field .06 (EOB PAID DATE) and the fixed "ATRID" index on .03, .04 and .07 fields
 N DIK
 ;
 D MES^XPDUTL("      >> Removing old ""D"", ""E"", ""ATRID"" and ""AD"" xref for file 361.1 ...")
 K ^IBM(361.1,"D") ; Remove PAYER ID index
 K ^IBM(361.1,"E") ; Remove EOB PAID DATE index
 K ^IBM(361.1,"ATRID") ; Remove ATRID compound index
 K ^IBM(361.1,"AD") ; Remove AD index
 D MES^XPDUTL("      >> Rebuilding ""D"" xref for file 361.1 ...")
 ; Now index EOB PAID DATE, PAYER ID, ATRID and AD (.05) index
 S DIK(1)=".03^D",DIK="^IBM(361.1," D ENALL^DIK
 D MES^XPDUTL("      >> Completed Rebuilding ""D"" xref for file 361.1 ...")
 D MES^XPDUTL("      >> Rebuilding ""E"" xref for file 361.1 ...")
 S DIK(1)=".06^E",DIK="^IBM(361.1," D ENALL^DIK
 D MES^XPDUTL("      >> Completed Rebuilding ""E"" xref for file 361.1 ...")
 D MES^XPDUTL("      >> Rebuilding ""ATRID"" xref for file 361.1 ...")
 S DIK(1)=".03^ATRID",DIK="^IBM(361.1," D ENALL^DIK
 D MES^XPDUTL("      >> Completed Rebuilding ""ATRID"" xref for file 361.1 ...")
 S DIK(1)=".05^AD",DIK="^IBM(361.1," D ENALL^DIK
 D MES^XPDUTL("      >> Completed Rebuilding ""AD"" xref for file 361.1 ...")
 Q
 ;
