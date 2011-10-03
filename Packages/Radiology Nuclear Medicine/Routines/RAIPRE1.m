RAIPRE1 ;HIRMFO/GJC- Pre-init routine ;4/19/97  12:05
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
EN1 ; Delete the Stop Codes multiple (field: 160 <|> sub-file: 71.06)
 ; and associated data from the Rad/Nuc Med Procedures file (71).
 Q:'($D(^DD(71.06,0))#2)  ; has been deleted in the past!
 N DIC,DIU,RATXT S RATXT(1)=" "
 S RATXT(2)="Deleting obsolete Stop Codes multiple from Rad/Nuc Med Procedures"
 S RATXT(3)="data dictionary.  Deleting Stop Code data from the Rad/Nuc Med"
 S RATXT(4)="Procedures file.  Please be patient, this may take a while."
 D BMES^XPDUTL(.RATXT)
 S DIU=71.06,DIU(0)="DS" D EN^DIU2
 Q
EN2 ; Delete the Principal Clinic field from the Imaging Locations file.
 Q:'($D(^DD(79.1,75,0))#2)  ; has been deleted in the past
 N %,DA,DIC,DIK,RAD0,RADD,RAFLD,RAPC,RATXT,X,Y
 S RATXT(1)=" ",RAD0=0,RADD=79.1,RAFLD=75
 S RATXT(2)="Deleting obsolete Principal Clinic field from Imaging Locations data"
 S RATXT(3)="dictionary.  Deleting Principal Clinic data from the "
 S RATXT(3)=$G(RATXT(3))_"Imaging Locations file."
 D BMES^XPDUTL(.RATXT)
 F  S RAD0=$O(^RA(79.1,RAD0)) Q:RAD0'>0  D
 . S RAPC=$P($G(^RA(79.1,RAD0,"PC")),"^")
 . D:RAPC]"" ENKILL^RAXREF(RADD,RAFLD,RAPC,.RAD0)
 . K ^RA(79.1,RAD0,"PC") ; delete the data node!
 . Q
 S DIK="^DD(79.1,",DA(1)=RADD,DA=RAFLD D ^DIK ; delete field from DD!
 Q
EN4 ; Delete the Common Procedure Group field from the Rad/Nuc Med
 ; Common Procedure data dictionary.  Delete Common Procedure
 ; Group data from the Rad/Nuc Med Common Procedure file.
 Q:'($D(^DD(71.3,2,0))#2)  ; deleted in the past.
 N %,DA,DIC,DIK,RACPG,RAD0,RADD,RAFLD,RATXT,X,Y
 S RATXT(1)=" ",RAD0=0,RADD=71.3,RAFLD=2
 S RATXT(2)="Deleting obsolete Common Procedure Group field from Rad/Nuc Med"
 S RATXT(3)="Common Procedure data dictionary.  Deleting Common Procedure"
 S RATXT(4)="Group data from the Rad/Nuc Med Common Procedure file."
 D BMES^XPDUTL(.RATXT)
 F  S RAD0=$O(^RAMIS(RADD,RAD0)) Q:RAD0'>0  D
 . S RACPG=$P($G(^RAMIS(RADD,RAD0,0)),"^",3)
 . D:RACPG]"" ENKILL^RAXREF(RADD,RAFLD,RACPG,.RAD0)
 . S:RACPG]"" $P(^RAMIS(RADD,RAD0,0),"^",3)=""
 . Q
 S DIK="^DD(71.3,",DA(1)=RADD,DA=RAFLD D ^DIK ; delete field from DD!
 Q
EN10 ; Delete the Input Devices multiple (field: 50 <|> sub-file: 79.11)
 ; and associated data from the Imaging Locations file (79.1).
 Q:'($D(^DD(79.11,0))#2)  ; has been deleted in the past!
 N DIC,DIU,RATXT S RATXT(1)=" "
 S RATXT(2)="Deleting obsolete Input Devices multiple from Imaging Locations"
 S RATXT(3)="data dictionary.  Deleting Imaging Devices data from the"
 S RATXT(4)="Imaging Locations file."
 D BMES^XPDUTL(.RATXT)
 S DIU=79.11,DIU(0)="DS" D EN^DIU2
 K ^RA(79.1,"AD") ; delete the file-wide xref DIU2 misses!
 Q
EN11 ; Delete the Device Assignment Explanation word processing field (75)
 ; from the Imaging Type file (79.2).  All associated data will be
 ; deleted
 Q:'($D(^DD(79.22,0))#2)  ; has been deleted in the past!
 N DIC,DIU,RATXT S RATXT(1)=" "
 S RATXT(2)="Deleting obsolete Device Assignment Explanation word processing field"
 S RATXT(3)="from Imaging Type data dictionary.  Deleting Device Assignment"
 S RATXT(4)="Explanation data from the Imaging type file."
 D BMES^XPDUTL(.RATXT)
 S DIU=79.22,DIU(0)="DS" D EN^DIU2
 Q
