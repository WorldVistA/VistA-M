RA64PRE ;Hines OI/GJC - Pre-init Driver, patch 64 ;01/05/06  06:32
VERSION ;;5.0;Radiology/Nuclear Medicine;**64**;Mar 16, 1998;Build 5
 ;
EN ; entry point for the pre-install logic
 N RACHK
 S RACHK=$$NEWCP^XPDUTL("PRE1","EN1^RA64PRE")
 ; Change the Menu Text (#1) field for the following options:
 ;
 ;IA: 10075 Read OPTION (#19) file NAME (#.01) w/FileMan
 ;
 ;Option Name
 ;-----------
 ;RA WKLIPHY CPT ITYPE
 ; from: Physician CPT Report by I-Type
 ;   to: Physician CPT Report by Imaging Type
 ;RA WKLIPHY SWRVU ITYPE
 ; from: Physician scaled wRVU Report by I-Type
 ;   to: Physician scaled wRVU Report by Imaging Type
 ;RA WKLIPHY WRVU ITYPE
 ; from: Physician wRVU Report by I-Type
 ;   to: Physician wRVU Report by Imaging Type
 ;
 ;
EN1 ;Change the Menu Text for the options mentioned above.
 ;If RA*5.0*64 has not been installed, exit the pre-install routine. The
 ;exporting of the options with the install of RA*5.0*64 will lay in the
 ;correct MENU TEXT definitions.
 K RARVU D FIELD^DID(79.2,200,,"LABEL","RARVU")
 Q:'$D(RARVU("LABEL"))#2
 ;
 K RAI,RAFDA,RAIEN,RAMSG,RARVU,RATXT,RAX
 F RAI=1:1 S RAX=$T(MENUTXT+RAI) Q:$P(RAX,";",3)=""  D
 .S RAIEN=+$$FIND1^DIC(19,,"Q",$P(RAX,";",3))
 .I 'RAIEN D  Q
 ..S RATXT(1)="'"_$P(RAX,";",3)_"' not found in the OPTION (#19) file."
 ..S RATXT(2)=" " D BMES^XPDUTL(.RATXT) K RATXT
 ..Q
 .Q:$$GET1^DIQ(19,RAIEN,1)=$P(RAX,";",5)  ;MENU TEXT update in the past
 .S RATXT(1)="Changing the MENU TEXT (#1) field of OPTION: "_$P(RAX,";",3)
 .S RATXT(2)="From: "_$P(RAX,";",4)
 .S RATXT(3)="  To: "_$P(RAX,";",5),RATXT(4)=" "
 .D BMES^XPDUTL(.RATXT) K RATXT
 .S RAFDA(19,RAIEN_",",1)=$P(RAX,";",5)
 .D UPDATE^DIE("E","RAFDA","","RAMSG(1)") K RAFDA
 .S RATXT(1)="The MENU TEXT update was "_$S($D(RAMSG(1,"DIERR"))#2:"un",1:"")_"successful."
 .S RATXT(2)=" " D BMES^XPDUTL(.RATXT) K RAMSG,RATXT
 .Q
XIT ;clean up symbol table; exit
 K RAI,RAFDA,RAIEN,RAMSG,RATXT,RAX
 Q
 ;
MENUTXT ;option name; old menu type ; new menu type
 ;;RA WKLIPHY CPT ITYPE;Physician CPT Report by I-Type;Physician CPT Report by Imaging Type
 ;;RA WKLIPHY SWRVU ITYPE;Physician scaled wRVU Report by I-Type;Physician scaled wRVU Report by Imaging Type
 ;;RA WKLIPHY WRVU ITYPE;Physician wRVU Report by I-Type;Physician wRVU Report by Imaging Type
 ;;
