RAIPS168 ;WOIFO/KLM-PostInit 168; Mar 20, 2020@15:38:35
 ;;5.0;Radiology/Nuclear Medicine;**168**;Mar 16, 1998;Build 1
 ;
 ;This post-install routine will add/update the COVID cancel/hold reasons
 ;in the RAD/NUC MED REASON file (#75.2)
EN ;entry point
 N RAI,RAREA,RAMSG
 F RAI=1:1 S RAREA=$T(REA+RAI) Q:RAREA=""  D
 .S RA01=$P(RAREA,";",3),RA3=$P(RAREA,";",4),RA2=$P(RAREA,";",5)
 .N RAFDA,RAR S RAR="RAFDA(75.2,""?+1,"")" ;FDA root -Check for existing entry
 .S @RAR@(.01)=RA01 ;Reason
 .S @RAR@(2)=RA2    ;Type of reason (1=cancel,3=hold,9=general)
 .S @RAR@(3)=RA3    ;Synonym
 .S @RAR@(4)="i"    ;Nature of order activity=Policy
 .S @RAR@(5)="Y"    ;NATIONAL flag = YES prevents local modifications
 .D UPDATE^DIE(,"RAFDA","","RAMSG(1)") K RAFDA
 .I $D(RAMSG(1,"DIERR"))#2 S RATXT="An error occured filing data for "_RA01
 .E  S RATXT=RA01_" filed"
 .D MES^XPDUTL(RATXT)  K RATXT,RAMSG
 Q
REA     ;REASON;SYNONYM;TYPE OF REASON
 ;;COVID-19 CONCERNS;COVID-19;1
 ;;COVID-19  CONCERNS;COVID-19;3
