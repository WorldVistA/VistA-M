RAIPST3 ;HIRMFO/GJC - Clean-up of the v5.0 environment ;10/9/97  14:40
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 S ZTREQ="@" ; delete from the task global
 I +$G(DIFROM)'=+$P($T(VERSION),";",3) S XPDABORT=2 Q
 N RAIPST
 ;
 S RAIPST=$$NEWCP^XPDUTL("PST31","NUMLIN^RAIPST3")
 ;        This subroutine will delete the Number Of Lines field (12)
 ;        and all associated data from the Rad/Nuc Med Reports file (74)
 ;
 S RAIPST=$$NEWCP^XPDUTL("PST32","TCOMNTS^RAIPST3")
 ;        This subroutine will delete the Transfer Comment field (150)
 ;        and all associated data from the Examinations Sub-Field
 ;        (70.03)
 ;
 S RAIPST=$$NEWCP^XPDUTL("PST33","DISTQ^RAIPST3")
 ;        This subroutine will delete the following fields from the
 ;        Report Distribution (74.4) file: Hospital Division (5)
 ;        Imaging Location (7), Patient (9) and SSN (10).  All data
 ;        associated with these fields will be deleted.
 ;
 S RAIPST=$$NEWCP^XPDUTL("PST34","TIMOUT^RAIPST3")
 ;        This subroutine will delete the '*Timeout After How
 ;        Many Second' field from the Imaging Type (79.2) file.
 ;        All data associated with this field will be deleted.
 ;
 S RAIPST=$$NEWCP^XPDUTL("PST35","AOXREF^RAIPST3")
 ;        This subroutine will delete corrupted "AO" cross-
 ;        reference data from the Rad/Nuc Med Patient file.
 ;        Only the "AO" cross-reference will be deleted.  Data
 ;        in the Rad/Nuc Med Patient file and the Rad/Nuc Med
 ;        Orders file will remain intact.
 ;
NUMLIN ; This subroutine will delete the Number Of Lines field (12)
 ; and all associated data in the Rad/Nuc Med Reports file (74)
 Q:'($D(^DD(74,12,0))#2)  ; Done in the past
 N %,DA,DIC,DIK,RA1,RACNT,RAD0,RALNUM,RATXT,X,Y
 S RATXT(1)=" ",RAD0=+$$PARCP^XPDUTL("PST31")
 S RATXT(2)="Deleting obsolete NUMBER OF LINES field from Rad/Nuc Med"
 S RATXT(3)="Reports data dictionary.  Deleting Number of Lines data"
 S RATXT(4)="from the Rad/Nuc Med Reports file.  Please be patient,"
 S RATXT(5)="this may take awhile." D BMES^XPDUTL(.RATXT)
 F  S RAD0=$O(^RARPT(RAD0)) Q:RAD0'>0  D
 . S RALNUM=$P($G(^RARPT(RAD0,"T")),"^",2)
 . D:RALNUM]"" ENKILL^RAXREF(74,12,RALNUM,.RAD0)
 . S:RALNUM]"" $P(^RARPT(RAD0,"T"),"^",2)=""
 . S RACNT=+$G(RACNT)+1
 . W:'(RACNT#500)&('$D(ZTQUEUED)) "."
 . S RA1=+$$UPCP^XPDUTL("PST31",RAD0)
 . Q
 S DIK="^DD(74,",DA(1)=74,DA=12 D ^DIK ; delete from data dictionary
 Q
TCOMNTS ; This subroutine will delete the Transfer Comment field (150)
 ; and all associated data from the Examinations Sub-Field (70.03)
 Q:'($D(^DD(70.03,150,0))#2)  ; Done in the past
 N %,DA,DIC,DIK,RA1,RACNI,RACNT,RADA,RADFN,RADTI,RATCOM,RATXT,X,Y
 S RATXT(1)=" ",RADFN=+$$PARCP^XPDUTL("PST32")
 S RATXT(2)="Deleting obsolete TRANSFER COMMENT field from Examinations sub-file"
 S RATXT(3)="data dictionary.  Deleting the Transfer Comment data from the Rad/Nuc"
 S RATXT(4)="Med Patient file.  Please be patient, this may take awhile."
 D BMES^XPDUTL(.RATXT)
 F  S RADFN=$O(^RADPT(RADFN)) Q:RADFN'>0  D
 . S RADTI=0 F  S RADTI=$O(^RADPT(RADFN,"DT",RADTI)) Q:RADTI'>0  D
 .. S RACNI=0
 .. F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D
 ... S RATCOM=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TFR")),"^")
 ... I RATCOM]"" D
 .... S RADA(2)=RADFN,RADA(1)=RADTI,RADA=RACNI
 .... D ENKILL^RAXREF(70.03,150,RATCOM,.RADA)
 .... Q
 ... K ^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TFR")
 ... Q
 .. Q
 . S RACNT=+$G(RACNT)+1
 . W:'(RACNT#500)&('$D(ZTQUEUED)) "."
 . S RA1=+$$UPCP^XPDUTL("PST32",RADFN)
 . Q
 S DIK="^DD(70.03,",DA(1)=70.03,DA=150
 D ^DIK ; delete the data dictionary
 Q
DISTQ ; This subroutine will delete the following fields from the
 ; Report Distribution (74.4) file: Hospital Division (5)
 ; Imaging Location (7), Patient (9) and SSN (10).  All data
 ; associated with these fields will be deleted.
 Q:'($D(^DD(74.4,10,0))#2)  ; Done in the past, this is the last field
 ; deleted.
 N %,DA,DIC,DIK,RA1,RA744,RACNT,RAD0,RAHD,RAIL,RAPAT,RASSN,RATXT,X,Y
 S RATXT(1)=" ",RAD0=+$$PARCP^XPDUTL("PST33")
 S RATXT(2)="Deleting the following obsolete fields and data from the"
 S RATXT(3)="Report Distribution data dictionary:"
 S RATXT(4)="HOSPITAL DIVISION, IMAGING LOCATION, PATIENT and SSN."
 D BMES^XPDUTL(.RATXT)
 F  S RAD0=$O(^RABTCH(74.4,RAD0)) Q:RAD0'>0  D
 . S RA744=$G(^RABTCH(74.4,RAD0,0)),RAHD=$P(RA744,"^",5)
 . S RAIL=$P(RA744,"^",7),RAPAT=$P(RA744,"^",9),RASSN=$P(RA744,"^",10)
 . I RAHD]"" D
 .. D ENKILL^RAXREF(74.4,5,RAHD,.RAD0)
 .. S $P(^RABTCH(74.4,RAD0,0),"^",5)=""
 .. Q
 . I RAIL]"" D
 .. D ENKILL^RAXREF(74.4,7,RAIL,.RAD0)
 .. S $P(^RABTCH(74.4,RAD0,0),"^",7)=""
 .. Q
 . I RAPAT]"" D
 .. D ENKILL^RAXREF(74.4,9,RAPAT,.RAD0)
 .. S $P(^RABTCH(74.4,RAD0,0),"^",9)=""
 .. Q
 . I RASSN]"" D
 .. D ENKILL^RAXREF(74.4,10,RASSN,.RAD0)
 .. S $P(^RABTCH(74.4,RAD0,0),"^",10)=""
 .. Q
 . S RACNT=+$G(RACNT)+1
 . W:'(RACNT#500)&('$D(ZTQUEUED)) "."
 . S RA1=+$$UPCP^XPDUTL("PST33",RAD0)
 . Q
 ; delete the fields one at a time.
 S DIK="^DD(74.4,",DA(1)=74.4,DA=5 D ^DIK K %,DA,DIC,DIK
 S DIK="^DD(74.4,",DA(1)=74.4,DA=7 D ^DIK K %,DA,DIC,DIK
 S DIK="^DD(74.4,",DA(1)=74.4,DA=9 D ^DIK K %,DA,DIC,DIK
 S DIK="^DD(74.4,",DA(1)=74.4,DA=10 D ^DIK K %,DA,DIC,DIK
 Q
TIMOUT ; This subroutine will delete the '*Timeout After How
 ; Many Second' field from the Imaging Type (79.2) file.
 ; All data associated with this field will be deleted.
 Q:'($D(^DD(79.2,2,0))#2)  ; Done in the past
 N %,DA,DIC,DIK,RAD0,RASEC,RATXT,X,Y S RATXT(1)=" "
 S RATXT(2)="Deleting obsolete *TIMEOUT AFTER HOW MANY SECOND field and data from"
 S RATXT(3)="the Imaging Type file."
 D MES^XPDUTL(.RATXT) S RAD0=0
 F  S RAD0=$O(^RA(79.2,RAD0)) Q:RAD0'>0  D
 . S RASEC=$P($G(^RA(79.2,RAD0,0)),"^",2)
 . D:RASEC]"" ENKILL^RAXREF(79.2,2,RASEC,.RAD0)
 . S:RASEC]"" $P(^RA(79.2,RAD0,0),"^",2)=""
 . Q
 S DIK="^DD(79.2,",DA(1)=79.2,DA=2 D ^DIK K %,DA,DIC,DIK ; remove field
 Q
AOXREF ; This subroutine will delete corrupted "AO" cross-
 ; reference data from the Rad/Nuc Med Patient file.
 ; Only the "AO" cross-reference will be deleted.  Data
 ; in the Rad/Nuc Med Patient file and the Rad/Nuc Med
 ; Orders file will remain intact.
 ;
 ; Hmm, how do we know if we've done this in the past???
 ;
 N RA1,RACNI,RADFN,RADTI,RAORD,RATXT S RATXT(1)=" "
 S RAORD=+$$PARCP^XPDUTL("PST35")
 S RATXT(2)="Delete corrupted ""AO"" cross-reference data from the"
 S RATXT(3)="Rad/Nuc Med Patient file.  Only the ""AO"" cross-reference"
 S RATXT(4)="will be deleted.  Data in the Rad/Nuc Med Patient file"
 S RATXT(5)="and the Rad/Nuc Med Orders file will remain intact."
 D MES^XPDUTL(.RATXT)
 F  S RAORD=$O(^RADPT("AO",RAORD)) Q:RAORD'>0  D
 . S RADFN=0
 . F  S RADFN=$O(^RADPT("AO",RAORD,RADFN)) Q:RADFN'>0  D
 .. S RADTI=0
 .. F  S RADTI=$O(^RADPT("AO",RAORD,RADFN,RADTI)) Q:RADTI'>0  D
 ... S RACNI=0
 ... F  S RACNI=$O(^RADPT("AO",RAORD,RADFN,RADTI,RACNI)) Q:RACNI'>0  D
 .... K:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ^RADPT("AO",RAORD,RADFN,RADTI,RACNI) ; if an exam is deleted, the "AO" xref for that exam should also be deleted
 .... K:'$D(^RAO(75.1,"B",RADFN,RAORD)) ^RADPT("AO",RAORD,RADFN) ; if an order is deleted, the "AO" xref for that order should also be deleted
 .... Q
 ... Q
 .. Q
 . S RA1=+$$UPCP^XPDUTL("PST35",RAORD)
 . Q
 Q
