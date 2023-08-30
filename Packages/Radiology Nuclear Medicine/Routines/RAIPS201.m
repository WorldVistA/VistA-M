RAIPS201 ;WOIFO/KLM - PostInit 201 ; Mar 22, 2023@07:27:44
 ;;5.0;Radiology/Nuclear Medicine;**201**;Mar 16, 1998;Build 1
 ;
 ; This post-install routine will add a Supply Chain cancel/hold reason
 ; in the RAD/NUC MED REASON file (#75.2) and disable (remove 'TYPE OF REASON')
 ; the Global Contrast Shortage reason.
 ;
 ; Reference to UPDATE^DIE in ICR #2053
 ; Reference to MES^XPDUTL in ICR #10141
 ;
EN ;entry point
 N RAI,RAREA,RAMSG,RATXT,RAMSG,RA01,RA2,RA3
 F RAI=1:1 S RAREA=$T(REA+RAI) Q:RAREA=""  D
 .S RA01=$P(RAREA,";",3),RA3=$P(RAREA,";",4),RA2=$P(RAREA,";",5)
 .N RAFDA,RAR S RAR="RAFDA(75.2,""?+1,"")" ;FDA root - ? checks for existing record
 .S @RAR@(.01)=RA01 ;Reason
 .S @RAR@(2)=RA2    ;Type of reason (1=cancel,3=hold,9=general)
 .S @RAR@(3)=RA3    ;Synonym
 .S @RAR@(4)="i"    ;Nature of order activity=Policy
 .S @RAR@(5)="Y"    ;NATIONAL flag = YES
 .D UPDATE^DIE(,"RAFDA","","RAMSG(1)") K RAFDA
 .I $D(RAMSG(1,"DIERR"))#2 S RATXT="An error occured filing data for "_RA01
 .E  S RATXT=RA01_$S(RA2=9:" filed",1:" updated")
 .D MES^XPDUTL(RATXT)  K RATXT,RAMSG
 Q
REA     ;REASON;SYNONYM;TYPE OF REASON
 ;;SUPPLY CHAIN;SUPPLY CHAIN;9
 ;;GLOBAL CONTRAST SHORTAGE;SHORTAGE;@
