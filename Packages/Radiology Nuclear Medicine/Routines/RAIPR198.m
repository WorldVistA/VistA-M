RAIPR198 ;HISC/GJC - preinstall routine ; Mar 29, 2023@11:25:47
 ;;5.0;Radiology/Nuclear Medicine;**198**;Mar 16, 1998;Build 1
 ;
 ;Routine              File            IA          Type
 ;-----------------------------------------------------
 ;                     OPTION #19      10075       (S)
 ;                     OPTION #19      10156       (S)
 ;
 QUIT
 ;
UPDATE ;change option name/item text
 ;      ----------------------------
 ;From: 'RA COMPLETED EXAM ORDER SYNCH'
 ;  To: 'RA EXAM ORDER SYNCH'
 ;
 ; change item text
 ; ----------------
 ; From: 'Synch Completed Exams with CPRS & RIS Orders'
 ;   To: 'Synch Exams with CPRS & RIS Orders'
 ;
 ; finally update the description field.
 K RATXT,RAIEN
 S RAIEN=$$FIND1^DIC(19,,"B","RA COMPLETED EXAM ORDER SYNCH")
 I RAIEN=0 D  K RAIEN QUIT
 .S RATXT(1)="The option 'RA COMPLETED EXAM ORDER SYNCH' is missing."
 .S RATXT(2)="ADPAC(s): Contact the National Radiology Development Team."
 .D BMES^XPDUTL(.RATXT) K RATXT
 .Q
 K RAERR,RAFDA S RAIEN=RAIEN_","
 S RATXT(.01)="RA EXAM ORDER SYNCH",RATXT(1)="Synch Exams with CPRS & RIS Orders"
 ;set RAFDA array
 S RAFDA(19,RAIEN,.01)=RATXT(.01),RAFDA(19,RAIEN,1)=RATXT(1)
 D FILE^DIE("E","RAFDA","RAERR")
 ;Note: Do not update the DESCRIPTION unless the option is properly named.
 I $D(RAERR) D  D CLEANUP QUIT
 .S RATXT(1)="Could not update the 'RA COMPLETED EXAM ORDER SYNCH' option Name"
 .S RATXT(2)="& Item Text. ADPAC(s): Contact the National Radiology Development Team."
 .D MES^XPDUTL(.RATXT)
 .Q
 K RAFDA,RAR,RATXT,^TMP($J,"RA5P189","WP")
 ;first, delete the original description text...
 D WP^DIE(19,RAIEN,3.5,,"@")
 ;now update the 'RA EXAM ORDER SYNCH' option with the new description text...
 S RAR=$NA(^TMP($J,"RA5P189","WP"))
 S @RAR@(1,0)="The RA EXAM ORDER SYNCH option will allow the user to enter a patient name"
 S @RAR@(2,0)="to identify radiology exams in a CANCELLED or COMPLETE examination status"
 S @RAR@(3,0)="which are linked to an existing VistA Radiology (RIS) order that"
 S @RAR@(4,0)="references (points to) an ACTIVE CPRS order."
 D WP^DIE(19,RAIEN,3.5,,"^TMP($J,""RA5P189"",""WP"")","RAERR")
 I $D(RAERR) D
 .S RATXT(1)="Could not update the DESCRIPTION for the 'RA EXAM ORDER SYNCH' option."
 .S RATXT(2)="ADPAC(s): Contact the National Radiology Development Team."
 .D MES^XPDUTL(.RATXT)
 .Q
 K RAR,^TMP($J,"RA5P189","WP")
 ;
CLEANUP ;kill variables and exit.
 K DIERR,RAERR,RAFDA,RAIEN,RATXT
 Q
