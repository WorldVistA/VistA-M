RAIPST1 ;HISC/SWM - Post-init number one; 12/4/95 ;6/4/97  09:34
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
EN1 ; install signon-alert into XU Menu
 N DA,DIC,DLAYGO,D0,TXT,X
 S DA(1)=$O(^DIC(19,"B","XU USER SIGN-ON",0)) G:'DA(1) OUT1B
 G:$D(^DIC(19,DA(1),"B",$O(^DIC(19,"B","RA SIGN-ON MSG",0)))) OUT1C
 S DIC="^DIC(19,"_DA(1)_",10,",DIC(0)="L",DLAYGO=19,X="RA SIGN-ON MSG",D0=DA(1) D ^DIC
 S TXT(1)="Option 'RA SIGN-ON MSG' IS NOW UNDER option 'XU USER SIGN-ON'"
MES1 D MES^XPDUTL(.TXT)
 Q
OUT1B S TXT(1)="Option 'XU USER SIGN-ON'  is missing on your system !"
 S TXT(2)="Option 'RA SIGN-ON MSG' cannot be put under XU USER SIGN-ON'"
 G MES1
OUT1C S TXT(1)="You already have 'RA SIGN-ON MSG' put under 'XU USER SIGN-ON'"
 G MES1
EN2 ; delete obsolete *CREDIT CLINIC STOP data dictionary & descriptor nodes
 ; from the Rad/Nuc Med Amis Codes file (71.1)
 Q:'$D(^DD(71.13,0))  ; already deleted
 N DIU,TXT
 S DIU=71.13 ; subfile data dictionary number
 S DIU(0)="SD" ; S=del dict. of subfile, D=del data also
 D EN^DIU2
 S TXT(1)="Deleting obsolete *CREDIT CLINIC STOP data dictionary and"
 S TXT(2)="Descriptor nodes from Major Rad/Nuc Med AMIS Codes file"
 D MES^XPDUTL(.TXT)
 Q
EN3 ; Convert free-text Device file pointer data to conventional pointer
 ; data.  The following fields are impacted: '^DD(71,3,' '^DD(79.1,3,'
 ; '^DD(79.1,5,' '^DD(79.1,10,' & '^DD(79.1,16,'
 Q:'($D(^DD(79,.115,0))#2)  ; We've done this code in the past.
 N RACNVRT,RAERR,RAI,RAII,RALOCK,RAROOT,RATXT
 S RAI=+$$PARCP^XPDUTL("POST31")
 S (RAERR,RALOCK)="",RATXT(1)=" "
 S RATXT(2)="Converting free-text pointer data in the REQUIRED FLASH CARD PRINTER"
 S RATXT(3)="field of the Rad/Nuc Med Procedures file to regular pointers to the"
 S RATXT(4)="Device file."
 D MES^XPDUTL(.RATXT)
 F  S RAI=$O(^RAMIS(71,RAI)) Q:RAI'>0  D
 . S RAI(0)=$G(^RAMIS(71,RAI,0)) Q:RAI(0)']""
 . S RAI(3)=$P(RAI(0),"^",3) Q:RAI(3)']""
 . S RACNVRT=$$CVRT(RAI(3),71,3,RAI) Q:RACNVRT=""  ; converted in past
 . S RAROOT(71,+RAI_",",3)=RACNVRT
 . D FILE^DIE(RALOCK,"RAROOT",RAERR)
 . K RAROOT(71,+RAI_",",3)
 . S RAII=+$$UPCP^XPDUTL("POST31",RAI)
 . Q
 K RACNVRT,RAROOT S RAI=+$$PARCP^XPDUTL("POST311")
 S (RAERR,RALOCK)="",RATXT(1)=" "
 S RATXT(2)="Converting free-text pointer data for fields:"
 S RATXT(3)="FLASH CARD PRINTER NAME, JACKET LABEL PRINTER NAME,"
 S RATXT(4)="REPORT PRINTER NAME and REQUEST PRINTER NAME"
 S RATXT(5)="in the Imaging Locations file to regular pointers to the Device file."
 D MES^XPDUTL(.RATXT)
 F  S RAI=$O(^RA(79.1,RAI)) Q:RAI'>0  D
 . S RAI(0)=$G(^RA(79.1,RAI,0)) Q:RAI(0)']""
 . S RAI(3)=$P(RAI(0),"^",3),RAI(5)=$P(RAI(0),"^",5)
 . S RAI(10)=$P(RAI(0),"^",10),RAI(16)=$P(RAI(0),"^",16)
 . S RACNVRT(3)=$$CVRT(RAI(3),79.1,3,RAI)
 . S RACNVRT(5)=$$CVRT(RAI(5),79.1,5,RAI)
 . S RACNVRT(10)=$$CVRT(RAI(10),79.1,10,RAI)
 . S RACNVRT(16)=$$CVRT(RAI(16),79.1,16,RAI)
 . S:RACNVRT(3)]"" RAROOT(79.1,+RAI_",",3)=RACNVRT(3)
 . S:RACNVRT(5)]"" RAROOT(79.1,+RAI_",",5)=RACNVRT(5)
 . S:RACNVRT(10)]"" RAROOT(79.1,+RAI_",",10)=RACNVRT(10)
 . S:RACNVRT(16)]"" RAROOT(79.1,+RAI_",",16)=RACNVRT(16)
 . D FILE^DIE(RALOCK,"RAROOT",RAERR)
 . K RAROOT(79.1,+RAI_","),RACNVRT
 . S RAII=+$$UPCP^XPDUTL("POST311",RAI)
 Q
CVRT(X,Y,Z,Z1) ; Convert free-text pointer to its corresponding ien in
 ;         the Device file.
 ;
 ; INPUT: 'X'  is the external value (.01) of the device file
 ;        'Y'  is the Rad/Nuc Med file which has a field to be converted
 ;        'Z'  is the field in file 'Y' being converted
 ;        'Z1' is the ien on the entry in our file (file #='Y')
 ;
 Q:X=""!(Y="")!(Z="") "" ; all needed for the conversion
 N X1 S X1=$O(^%ZIS(1,"B",X,"")) ; DBIA# 10114 (supported)
 I 'X1 D
 . N RATXT S RATXT(1)=" "
 . S RATXT(2)="'"_X_"' could not be found in the ""B"" cross-reference"
 . S RATXT(3)="of the Device File (3.5)!  Deleting '"_X_"' from the"
 . S RATXT(4)="'"_$P($G(^DD(Y,Z,0)),"^")_"' field of "_$S(Y=71:"Rad/Nuc Med Procedure",1:"Imaging Location")
 . S RATXT(5)=$$GET1^DIQ($S(Y=71:71,1:79.1),Z1,.01)
 . S X1="@" D MES^XPDUTL(.RATXT)
 . Q
 Q X1
EN4 ; Convert the "Allow 'Released/Unverified'" data from the Rad/Nuc Med
 ; Division '^RA(79,' file to the new field, "Allow 'Released
 ; /Unverified'" in the Imaging Locations '^RA(79.1,' file.  When the
 ; data conversion is finished, delete the "Allow 'Released/Unverified'"
 ; field from the Rad/Nuc Med Division '^RA(79,' file.
 ;
 Q:'($D(^DD(79,.115,0))#2)  ; quit if previously converted.
 ;
 ; Convert the data from the old field to the new field.
 K RATXT S RATXT(1)=" "
 S RATXT(2)="Converting ALLOW 'RELEASED/UNVERIFIED' data from the Rad/"
 S RATXT(3)="Nuc Med Division file to the new ALLOW 'RELEASED/UNVERIFIED'."
 S RATXT(4)="field on the Imaging Locations file. "
 S RATXT(5)=" " D MES^XPDUTL(.RATXT)
 N RA79,RADBS,RADFN,RADIV,RAERR,RAILOC,RATXT
 S (RADIV,RAERR)=0
 F  S RADIV=$O(^RA(79,RADIV)) Q:RADIV'>0  D
 . S RA79(.1)=$G(^RA(79,RADIV,.1))
 . S RA79(.115)=$P(RA79(.1),"^",15) Q:RA79(.115)']""
 . S RAILOC=0
 . F  S RAILOC=$O(^RA(79,RADIV,"L","B",RAILOC)) Q:RAILOC'>0  D
 .. S RADFN(79.1,RAILOC_",",17)=RA79(.115)
 .. Q
 . Q
 D FILE^DIE("","RADFN","RADBS(""ERROR"")") ; move the data into 79.1!
 S RAERR=$S($D(RADBS("ERROR","DIERR"))#2:1,1:0)
 I RAERR D  Q:RAERR
 . K RATXT S RATXT(1)=" "
 . S RATXT(2)="Data conversion between the Rad/Nuc Med Division file"
 . S RATXT(3)="and the Imaging Locations file for the ALLOW 'RELEASED/"
 . S RATXT(3)="UNVERIFIED field has failed.  IRM and the Rad/Nuc Med"
 . S RATXT(4)="ADPAC should investigate!"
 . S RATXT(5)=" " D MES^XPDUTL(.RATXT)
 . Q
 ; Remove data & any crossreferences on field .115 in file 79!
 ; Delete field .115 (Allow 'Released/Unverified') from ^DD(79.
 K RA79 S RADIV=0 F  S RADIV=$O(^RA(79,RADIV)) Q:RADIV'>0  D
 . S RA79=$P($G(^RA(79,RADIV,.1)),"^",15) Q:RA79']""
 . D ENKILL^RAXREF(79,.115,RA79,.RADIV)
 . S $P(^RA(79,RADIV,.1),"^",15)=""
 . Q
 K RATXT S RATXT(1)=" "
 S RATXT(2)="Deleting obsolete ALLOW 'RELEASED/UNVERIFIED' field from"
 S RATXT(3)="Rad/Nuc Med Division file.",RATXT(4)=" "
 D MES^XPDUTL(.RATXT)
 N DA,DIC,DIK,X,Y
 S DA(1)=79,DA=.115,DIK="^DD(79," D ^DIK
 Q
