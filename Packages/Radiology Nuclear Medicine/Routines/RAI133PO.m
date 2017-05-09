RAI133PO ;WOIFO/KLM-Rad/NM Post-init Driver, patch 133;11/03/16
 ;;5.0;Radiology/Nuclear Medicine;**133**;November 3, 2016;Build 4
 ;New standardized reasons to be used for updating 
 ;requests in a HOLD status. Standardized reasons
 ;provided here will not be editable by the site.
 ;
EN      ;Entry pt for post-install
 N RACHK
 ;
 ;Load new reasons file 75.2
 S RACHK=$$NEWCP^XPDUTL("POST1","EN1^RAI133PO")
 ;
 ;Check Rad/Nuc Med Divisions for request/exam status tracking
 S RACHK=$$NEWCP^XPDUTL("POST2","EN2^RAI133PO")
 Q
EN1     ;Load national entries into RAD/NUC MED REASON file #75.2
 N RAI,RAREA,RAMSG
 F RAI=1:1 S RAREA=$T(REA+RAI) Q:RAREA=""  D
 .S RA01=$P(RAREA,";",3),RA3=$P(RAREA,";",4)
 .N RAFDA,RAR S RAR="RAFDA(75.2,""?+1,"")" ;FDA root -Check for existing entry
 .S @RAR@(.01)=RA01 ;Reason
 .S @RAR@(2)=3      ;Type of reason=hold request
 .S @RAR@(3)=RA3    ;Synonym
 .S @RAR@(4)="i"    ;Nature of order activity=Policy
 .S @RAR@(5)="Y"    ;NATIONAL flag = YES prevents local modifications
 .D UPDATE^DIE(,"RAFDA","","RAMSG(1)") K RAFDA
 .I $D(RAMSG(1,"DIERR"))#2 S RATXT="An error occured filing data for "_RA01
 .E  S RATXT=RA01_" filed"
 .D MES^XPDUTL(RATXT)  K RATXT,RAMSG
 Q
EN2     ;Check all divisions to be sure Request / Exam Status Tracking is enabled
 N RADIV,RAFDA,RACHK
 S RADIV="" F  S RADIV=$O(^RA(79,"B",RADIV)) Q:'RADIV  D
 .I $P($G(^RA(79,RADIV,.1)),"^",19)'="y"!($P($G(^RA(79,RADIV,.1)),"^",10)'="Y") D
 ..S RAFDA(79,RADIV_",",.119)="y"
 ..S RAFDA(79,RADIV_",",.11)="Y"
 ..D FILE^DIE("","RAFDA","RAMSG(1)") K RAFDA
 ..I $D(RAMSG(1,"DIERR"))#2 S RATXT="Problem updating Rad/Nuc Med Division data"
 ..E  S RATXT="Rad/Nuc Med Divisions updated"
 ..S RACHK=$$UPCP^XPDUTL("POST2",RADIV)
 I '$D(RATXT) S RATXT="No Rad/Nuc Med Divisions updates needed"
 D BMES^XPDUTL(RATXT)  K RATXT,RAMSG
 Q
REA     ;REASON;SYNONYM
 ;;CALLED VETERAN FOR APPT;CALL
 ;;MYHEALTHYVET CONTACT;MHV
 ;;LETTER SENT TO CALL VA;LETTER
 ;;RESCHED CALL BY VETERAN;RESCHED
 ;;MRI SAFETY REVIEW;MRISAFETY
 ;;RADIOLOGIST REVIEW;RADREV
 ;;COMMUNITY CARE APPT;COMCARE
 ;;WAITING ON OUTSIDE IMAGES;OUTIMAGE
 ;;FUTURE APPOINTMENT;FUTUREAPT
 ;;NON RADIOLOGY CONSULT;NONRADCON
