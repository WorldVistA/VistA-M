OOPSXV27 ;WIOFO/LLH-POST INIT ROUTINE, FILL FIELD 331 ;11/26/04
 ;;2.0;ASISTS;**7**;Jun 03, 2002
 ; Patch 7 - auto populate index "AF" from 1/1/2004 to date
 ;
ENT ;
 N IEN,FILE,FLD4,FLD88
 S FILE=2260,IEN=0
 D BMES^XPDUTL("Updating new index for OSHA 300 Log for cases created in 2004") H 1
 D MES^XPDUTL(" ")
 S FLD4=3040100
 F  S FLD4=$O(^OOPS(FILE,"AD",FLD4)) Q:FLD4'>0  D
 .S IEN=0 F   S IEN=$O(^OOPS(FILE,"AD",FLD4,IEN)) Q:IEN'>0  D
 ..S FLD88=$$GET1^DIQ(FILE,IEN,88,"I")
 ..I $G(FLD88)'="" S ^OOPS(FILE,"AF",FLD4,FLD88,IEN)=""
 D BMES^XPDUTL("Update Complete") H 1
 D MES^XPDUTL(" ")
 ;
 ; now update Type of Incident (FILE 2161.2)
 D BMES^XPDUTL("Updating ASISTS CRITICAL TRACKING ISSUES File (#2261.2)") H 1
 D MES^XPDUTL(" ")
 I $P(^OOPS(2261.2,15,0),U)'="Non Patient Care" D  Q
 .D BMES^XPDUTL("File not found as expected, update table manually")
 .D MES^XPDUTL(" ")
 I $P(^OOPS(2261.2,15,0),U)="Non Patient Care" D
 .S $P(^OOPS(2261.2,15,0),U)="Lifting (Non Patient Care)"
 .K ^OOPS(2261.2,"B","Non Patient Care",15)
 .S ^OOPS(2261.2,"B","Lifting (Non Patient Care)",15)=""
 .K ^OOPS(2261.2,"D","NON PATIENT CARE",15)
 .S ^OOPS(2261.2,"D","LIFTING (NON PATIENT CARE)",15)=""
 D BMES^XPDUTL("Table Update Complete"),MES^XPDUTL(" ")
 Q
