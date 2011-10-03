RA56PST ;HISC/SM Post-init ; 11/23/07
 ;;5.0;Radiology/Nuclear Medicine;**56**;Mar 16, 1998;Build 3
 ;This is the post-install routine for patch RA*5.0*56
 ;Private IA #5155 Remove Rad/Nuc Med dd Screen from Subfield #70.03
 ;Private IA #5156 Remove Rad/Nuc Med dd Screen from File #79.1
 Q
EN1 ;reset file 78.7's field MUMPS CODE TO SET VARIABLE
 ;  for the PRINT FIELD: REPORT STATUS
 I '$D(XPDNM)#2 D EN^DDIOL("This entry point must be called from the KIDS installation -- Nothing Done.",,"!!,$C(7)") Q
 N RAIEN
 S RAIEN=$O(^RA(78.7,"B","REPORT STATUS",0))
 I 'RAIEN D ERR1 G CONT1
 I '$D(^RA(78.7,RAIEN,"E")) D ERR2 G CONT1
 ; must use hard set instead of silent FM due uneditable data
 S ^RA(78.7,RAIEN,"E")="S RARST=$$GET1^DIQ(74,+$P(RAY3,""^"",17)_"","",5)"
 D BMES^XPDUTL("File 78.7's REPORT STATUS record has been successfully updated.")
 ;
CONT1 ;kill stray 9.2 nodes for two CREDIT METHOD fields
 ;  in subfile 70.03 and file 79.1
 I $D(^DD(70.03,26,9.2)) D
 .K ^DD(70.03,26,9.2)
 .D BMES^XPDUTL("Cleaned up stray 9.2 node for the CREDIT METHOD field in subfile 70.03.")
 .Q
 I $D(^DD(79.1,21,9.2)) D
 .K ^DD(79.1,21,9.2)
 .D BMES^XPDUTL("Cleaned up stray 9.2 node for the CREDIT METHOD field in file 79.1.")
 .Q
 Q
ERR1 ;
 D BMES^XPDUTL("File 78.7 doesn't have the REPORT STATUS record, so REPORT STATUS record is not updated.")
 Q
ERR2 ;
 D BMES^XPDUTL("File 78.7 has no data for field 100, so REPORT STATUS record is not updated.")
 Q
