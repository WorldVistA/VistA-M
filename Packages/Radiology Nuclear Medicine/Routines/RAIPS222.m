RAIPS222 ;HISC/GJC - Post-init Driver, patch 222 ; Jan 03, 2025@08:56:22
 ;;5.0;Radiology/Nuclear Medicine;**222**;Mar 16, 1998;Build 1
 ;
 ;IA          Type    File         Routine     Tag
 ;-----------------------------------------------------
 ;1157        (S)                  XPDMENU     LOCK
 ;1157        (S)                  XPDMENU     LKOPT
 ;2056        (S)                  DIQ         GET1
 ;10141       (S)                  XPDUTL      BMES
 ;
 Q
 ;
EN ;The called tag referenced in the RA*5.0*222 build description.
 ;
KEY2OPT ;Add the RA DELETEXAM key to the RA DELETEXAM 'Exam Deletion' option.
 N RAIEN,RAKEYNM,RAKEY,RAOPT,RATXT
 S (RAKEY,RAOPT)="RA DELETEXAM"
 S RAIEN=$$LKOPT^XPDMENU(RAOPT)_"," ;IEN of 'Exam Deletion' option
 I +RAIEN=0 D  Q
 .S RATXT="'"_RAOPT_"' option not found. Contact the national radiology developers."
 .Q
 ;associate the new key to our option
 D LOCK^XPDMENU(RAOPT,RAKEY)
 ;did the key to option association succeed or fail?
 S RAKEYNM=$$GET1^DIQ(19,RAIEN,3)
 I RAKEYNM=RAKEY D  ;success
 .S RATXT=RAKEY_" has been assigned as the key for option '"_RAOPT_"'."
 .D BMES^XPDUTL(RATXT)
 .Q
 E  D  ;failure
 .S RATXT=RAKEY_" has NOT been assigned as the key for option '"_RAOPT_"'."
 .D BMES^XPDUTL(RATXT)
 .Q
 ;
OPT ; *** Now update the DESCRIPTION (#3.5) field for the RA EXAM ORDER SYNCH option record in the OPTION (#19) file. ***
 ;find the option record IEN
 S RAIEN=$$FIND1^DIC(19,"","CX","RA EXAM ORDER SYNCH","B","","RAERR(19)")
 ;if RAIEN is null likely an error, Display error and quit.
 I $D(RAERR(19,"DIERR"))#2 DO  QUIT
 .N RAI,RAJ,RATXT S RAJ=$P(RAERR(19,"DIERR"),U,2)
 .F RAI=1:1:RAJ S RATXT(RAI)=$G(RAERR(19,"DIERR",RAI,"TEXT",1))
 .D BMES^XPDUTL(.RATXT)
 .Q
 I RAIEN'>0 D BMES^XPDUTL("Option: RA EXAM ORDER SYNCH was not found.") QUIT
 ;
 ;we know the IEN, time to update the DESCRIPTION (#3.5) field!
 K RATXT(19,"SYNCH")
 S RATXT(19,"SYNCH",1,0)="The RA EXAM ORDER SYNCH option will allow the user to enter a patient name"
 S RATXT(19,"SYNCH",2,0)="to identify radiology exams in a CANCELLED or COMPLETE examination status"
 S RATXT(19,"SYNCH",3,0)="which are linked to an existing VistA Radiology (RIS) order that"
 S RATXT(19,"SYNCH",4,0)="references (points to) a CPRS order in a status other than DISCONTINUED"
 S RATXT(19,"SYNCH",5,0)="(paired with the CANCELLED exam status) or COMPLETE."
 S RAIEN=RAIEN_"," D WP^DIE(19,RAIEN,3.5,"K","RATXT(19,""SYNCH"")","RAERR(19)")
 K RATXT(19,"SYNCH")
 I $D(RAERR(19)) DO  QUIT
 .K RATXT S RATXT(1)="Error: The DESCRIPTION field for the option RA EXAM ORDER SYNCH was not updated."
 .S RATXT(2)="Contact the VistA RIS National Development team regarding this error with RA*5.0*222."
 .D BMES^XPDUTL(.RATXT) K RATXT
 .QUIT
 E  D BMES^XPDUTL("The DESCRIPTION field for the option RA EXAM ORDER SYNCH was updated.")
 Q
 ;
