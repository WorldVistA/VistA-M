RAIPR135 ;HISC/GJC pre-install routine ;26 Jan 2018 12:14 PM
 ;;5.0;Radiology/Nuclear Medicine;**135**;Mar 16, 1998;Build 7
 ;
 ;Routine              IA          Type
 ;-------------------------------------
 ; UPDATE^DIE          2053        (S)
 ;
 N RACHX1,RACHX2
 S RACHX1=$$NEWCP^XPDUTL("PRE1","EN1^RAIPR135")
 Q
 ;
EN1 ;Add "OBSOLETE ORDER-P135 (automated)" to the 'RAD/NUC MED REASON'
 ;   #75.2 file.
 ;
 N RAERR,RAFDA,RAIEN,RAR,RATXT,RAX
 S RAX="OBSOLETE ORDER-P135 (automated)"
 S RAR=$NA(RAFDA(75.2,"?+1,")) ;RAFDA root
 ;.01 - NAME
 S @RAR@(.01)=RAX
 ;field #: 5 - NATIONAL
 S @RAR@(5)="Y"
 ;field #: 4 - NATURE OF ORDER ACTIVITY
 S @RAR@(4)="i"
 ;field #: 2 - TYPE OF REASON
 S @RAR@(2)=""
 D UPDATE^DIE("E","RAFDA","RAIEN","RAERR")
 I $D(RAERR) D
 .S RATXT(1)="Error: """_RAX_""" could not be added."
 .S RATXT(2)="Contact the developers of RA*5.0*135 to address this issue."
 .D BMES^XPDUTL(.RATXT)
 .Q
 Q
 ;
