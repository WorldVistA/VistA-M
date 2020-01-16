RAIPS163 ;WOIFO/KLM-Rad/NM Post-init Driver, patch 163; Oct 10, 2019@09:30:04
 ;;5.0;Radiology/Nuclear Medicine;**163**;Mar 16, 1998;Build 1
 ;New standardized Cancel/Hold reasons
 ;
EN      ;Entry pt for post-install
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
 ;;PATIENT DECEASED;DECEASED;1
 ;;REQUESTING PHYSICIAN CANCELLED;REQ MD CX'D;1
 ;;CONTRAINDICATION;CONTRAINDICATED;1
 ;;PATIENT DECLINED TO SCHEDULE;DECLINED TO SCHED;1
 ;;INCORRECT PATIENT CONTACT INFORMATION;INCORRECT CONTACT;1
 ;;CANCELLED BY PATIENT;CX'D BY PT;1
 ;;INCLEMENT WEATHER;WEATHER;3
 ;;NEEDS TO CONSULT WITH PROVIDER;CONSULT W/PROVIDER;3
 ;;CANCELLED BY CLINIC;CX'D BY CLIN;3
 ;;OTHER;OTHER;9
