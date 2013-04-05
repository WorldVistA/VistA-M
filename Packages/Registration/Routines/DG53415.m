DG53415 ;BPFO/JRP - PRE/POST INITS FOR PATCH 415;7/11/2002 ; 11/5/02 12:45pm
 ;;5.3;Registration;**415**;Aug 13, 1993
 ;
 Q
 ;
PRE ;Pre-init entry point
 N JUNK1,JUNK2,SUBFILE
 ;Delete obsolete sub-files
 F SUBFILE=2.02,2.06 I $D(^DD(SUBFILE)) D
 .;Don't delete if the obsolete sub-file isn't there
 .N DEL,X
 .S DEL=0
 .S X=0 F  S X=+$O(^DD(2,"SB",SUBFILE,X)) Q:'X  D  Q:DEL
 ..I SUBFILE=2.02 S:(X'=2) DEL=1
 ..I SUBFILE=2.06 S:(X'=6) DEL=1
 .Q:'DEL
 .;Remove reference to correct sub-file
 .S X=$S(SUBFILE=2.02:2,1:6) K ^DD(2,"SB",SUBFILE,X)
 .;Delete sub-file
 .S JUNK1(1)=" "
 .S JUNK1(2)="The new "_$S(SUBFILE=2.02:"RACE",1:"ETHNICITY")_" INFORMATION multiple is contained in"
 .S JUNK1(3)="an obsolete sub-file that still exists on your system."
 .S JUNK1(4)="The obsolete sub-file (#"_SUBFILE_") will now be deleted."
 .S JUNK1(5)=" "
 .D MES^XPDUTL(.JUNK1) K JUNK1
 .N DIU
 .S DIU=SUBFILE
 .S DIU(0)="DST"
 .D EN^DIU2
 ;Delete "bad" B x-reference on RACE file (patch brings in "good" one)
 S JUNK1(1)=" "
 S JUNK1(2)="The B cross reference on the RACE file (#10) may be listed"
 S JUNK1(3)="as the second cross reference of the NAME field (#.01)"
 S JUNK1(4)="instead of the first.  To ensure that the B cross"
 S JUNK1(5)="reference is listed as the first cross reference, the"
 S JUNK1(6)="second cross reference of the NAME field will now be"
 S JUNK1(7)="deleted."
 S JUNK1(8)=" "
 D MES^XPDUTL(.JUNK1) K JUNK1
 D DELIX^DDMOD(10,.01,2,"W","JUNK1","JUNK2")
 Q
 ;
POST ;Post-init entry point
 N JUNK,DIK,RACES,IEN
 ;Rebuild B x-reference on RACE file
 S JUNK(1)=" "
 S JUNK(2)="The incorrect B cross reference on the RACE file (#10),"
 S JUNK(3)="which was removed by the pre-init, placed the entire value"
 S JUNK(4)="of the NAME field (#.01) into the cross reference.  The"
 S JUNK(5)="correct logic for the B cross reference only places the"
 S JUNK(6)="first thirty characters into the cross reference.  To"
 S JUNK(7)="ensure that the cross referenced values are correct, the"
 S JUNK(8)="entire B cross reference will now be deleted and then"
 S JUNK(9)="reindexed."
 S JUNK(10)=" "
 D MES^XPDUTL(.JUNK) K JUNK
 K ^DIC(10,"B")
 S DIK="^DIC(10,"
 S DIK(1)=".01^B"
 D ENALL^DIK K DIK
 ;Inactivate all races
 S JUNK(1)=" "
 S JUNK(2)="Marking all entries in the RACE file (#10) as inactive"
 S JUNK(3)=" "
 D MES^XPDUTL(.JUNK) K JUNK
 S IEN=0
 F  S IEN=+$O(^DIC(10,IEN)) Q:'IEN  D
 .N FDAROOT,MSGROOT,IENS
 .S IENS=IEN_","
 .S FDAROOT(10,IENS,200)=1
 .S FDAROOT(10,IENS,202)=$P($$NOW^XLFDT(),".",1)
 .D FILE^DIE("K","FDAROOT","MSGROOT")
 .I $D(MSGROOT) D
 ..S JUNK(1)="  **"
 ..S JUNK(2)="  ** ERROR"
 ..S JUNK(3)="  ** Unable to inactivate entry number "_IEN
 ..S JUNK(4)="  ** Entry should be inactivated via FileMan"
 ..S JUNK(5)="  **"
 ..D MES^XPDUTL(.JUNK) K JUNK
 ;Create/update national entries
 S JUNK(1)=" "
 S JUNK(2)="Creating/updating nationally supported entries in the RACE"
 S JUNK(3)="file (#10)"
 S JUNK(4)=" "
 D MES^XPDUTL(.JUNK) K JUNK
 D BLDLST(.RACES)
 S IEN=0
 F  S IEN=+$O(RACES("FDA",IEN)) Q:'IEN  D
 .N FDAROOT,IENROOT,MSGROOT,IENS,TMP
 .S TMP=RACES("FDA",IEN,.01)
 .S IENS=+$O(^DIC(10,"B",$E(TMP,1,30),0)) S:'IENS IENS="+1"
 .S IENS=IENS_","
 .M FDAROOT(10,IENS)=RACES("FDA",IEN)
 .D UPDATE^DIE("","FDAROOT","IENROOT","MSGROOT")
 .I $D(MSGROOT) D
 ..S JUNK(1)="  **"
 ..S JUNK(2)="  ** ERROR"
 ..S JUNK(3)="  ** Unable to create entry for "_RACES("FDA",IEN,.01)
 ..S JUNK(4)="  ** Entry should be created via FileMan"
 ..S JUNK(5)="  **    Name  (.01): "_RACES("FDA",IEN,.01)
 ..S JUNK(6)="  **    Abbrev  (2): "_RACES("FDA",IEN,2)
 ..S JUNK(7)="  **    HL7 Val (3): "_RACES("FDA",IEN,3)
 ..S JUNK(8)="  **    CDC Val (4): "_RACES("FDA",IEN,4)
 ..S JUNK(9)="  **    PTF Val (5): "_RACES("FDA",IEN,5)
 ..S JUNK(10)="  **"
 ..D MES^XPDUTL(.JUNK) K JUNK
 ;Delete RACE identifier
 S JUNK(1)=" "
 S JUNK(2)="Removing old RACE field (#.06) as an identifier of the"
 S JUNK(3)="PATIENT file (#2)."
 S JUNK(4)=" "
 D MES^XPDUTL(.JUNK) K JUNK
 K ^DD(2,0,"ID",.06)
 Q
 ;
BLDLST(ARRAY)   ;Build list of valid races
 ;Input  : ARRAY - Array to place values into (pass by value)
 ;Output : ARRAY("FDA",X,Field) = Value
 ;Notes  : ARRAY will be initiallized (killed) on entry
 ;       : Assumes ARRAY is input
 ;
 N LOOP,TEXT,STOP,X
 K ARRAY
 S (STOP,LOOP)=0
 F  S LOOP=LOOP+1 D  Q:STOP
 .S TEXT=$P($T(RACES+LOOP),";;",2)
 .S X=$P(TEXT,"^",1)
 .I X="" S STOP=1 Q
 .S ARRAY("FDA",LOOP,.01)=X
 .F X=2:1:5 S ARRAY("FDA",LOOP,X)=$P(TEXT,"^",X)
 .S ARRAY("FDA",LOOP,200)="@"
 .S ARRAY("FDA",LOOP,202)="@"
 Q
 ;
RACES ;RACE (#.01)^ABBREVIATION (#2)^HL7 (#3)^CDC (#4)^PTF (#5)
 ;;AMERICAN INDIAN OR ALASKA NATIVE^3^1002-5^1002-5^3
 ;;ASIAN^A^2028-9^2028-9^8
 ;;BLACK OR AFRICAN AMERICAN^B^2054-5^2054-5^9
 ;;DECLINED TO ANSWER^D^0000-0^^C
 ;;NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER^H^2076-8^2076-8^A
 ;;UNKNOWN BY PATIENT^U^9999-4^^D
 ;;WHITE^W^2106-3^2106-3^B
 ;;
