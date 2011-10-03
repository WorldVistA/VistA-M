PXRMP5I ; SLC/AGP - Patch 5 init routine. ;09/16/2005
 ;;2.0;CLINICAL REMINDERS;**5**;Feb 04, 2005
 ;Reminder Exchange install.
 Q
 ;
 ;===============================================================
ARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;
 S ARRAY(1,1)="VA-IRAQ & AFGHAN POST-DEPLOY SCREEN"
 I MODE S ARRAY(1,2)="09/20/2005@10:35:40"
 Q
 ;
 ;===============================================================
DELDD ;Delete the old data dictionaries.
 N DIU,TEXT
 D EN^DDIOL("Removing old data dictionaries.")
 S DIU(0)=""
 S DIU=811.6
 S TEXT=" Deleting data dictionary for file # "_DIU
 D EN^DDIOL(TEXT)
 D EN^DIU2
 Q
 ;===============================================================
DELEI ;If the Exchange File entry already exists delete it.
 N ARRAY,IC,IND,LIST,LUVALUE,NUM
 D ARRAY(1,.ARRAY)
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:'IC  D
 .S LUVALUE(1)=ARRAY(IC,1)
 .D FIND^DIC(811.8,"","","U",.LUVALUE,"","","","","LIST")
 .I '$D(LIST) Q
 .S NUM=$P(LIST("DILIST",0),U,1)
 .I NUM'=0 D
 ..F IND=1:1:NUM D
 ... N DA,DIK
 ... S DIK="^PXD(811.8,"
 ... S DA=LIST("DILIST",2,IND)
 ... D ^DIK
 Q
 ;
 ;===============================================================
EXFINC(Y) ;Return a 1 if the Exchange file entry is in the list to
 ;include in the build. This is used in the build to determine which
 ;entries to include.
 N ARRAY,FOUND,IEN,IC,LUVALUE
 D ARRAY(1,.ARRAY)
 S FOUND=0
 S IC=0
 F  S IC=+$O(ARRAY(IC)) Q:(IC=0)!(FOUND)  D
 . M LUVALUE=ARRAY(IC)
 . S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 . I IEN=Y S FOUND=1 Q
 Q FOUND
 ;
PRE ;
 D SSPC
 D DELDD
 D DELEI
 Q
POST ;
 D RSPC
 D SMEXINS
 Q
 ;===============================================================
RSPC ;Restore the sponser classes to the new location.
 N ARRAY,CLASS,IEN,NAME,TEMP
 S ARRAY("INFECTIOUS DISEASES PROGRAM OFFICE, VAHQ")="N"
 S ARRAY("JOHN D DEMAKIS")="N"
 S ARRAY("Mental Health and Behavioral Science Strategic Group")="N"
 S ARRAY("Mental Health and Behavioral Science Strategic Group and Women Veterans Health Program")="N"
 S ARRAY("National Clinical Practice Guideline Council")="N"
 S ARRAY("Office of Geriatric Extended Care")="N"
 S ARRAY("Office of Public Health and Environmental Hazards")="N"
 S ARRAY("Office of Quality & Performance")="N"
 S ARRAY("Women Veterans Health Program")="N"
 D BMES^XPDUTL("Restoring Sponsor Classes")
 S IEN=0
 F  S IEN=+$O(^XTMP("PXRMSPCS",IEN)) Q:IEN=0  D
 . S CLASS=^XTMP("PXRMSPCS",IEN)
 . S $P(^PXRMD(811.6,IEN,100),U,1)=CLASS
 S IEN=0
 F  S IEN=$O(^PXRMD(811.6,IEN)) Q:IEN'>0  D
 . S CLASS=$P($G(^PXRMD(811.6,IEN,100)),U)
 . I CLASS="" D
 . .S TEMP=$P($G(^PXRMD(811.6,IEN,0)),U,2)
 . .S NAME=$P($G(^PXRMD(811.6,IEN,0)),U) Q:NAME=""
 . .I TEMP="" S TEMP=$S($D(ARRAY(NAME))>0:ARRAY(NAME),1:"L")
 . .S $P(^PXRMD(811.6,IEN,100),U)=TEMP,CLASS=TEMP
 . I CLASS'="" D
 . .S TEMP=^PXRMD(811.6,IEN,0)
 . .S ^PXRMD(811.6,IEN,0)=$P(TEMP,U)
 Q
 ;===============================================================
SMEXINS ;Silent mode install.
 N ARRAY,IC,IEN,LUVALUE,PXRMINST
 S PXRMINST=1
 D ARRAY(1,.ARRAY)
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:'IC  D
 .M LUVALUE=ARRAY(IC)
 .S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 .I IEN'=0 D
 .. N TEXT
 .. I LUVALUE(1)["PARAMETER" S TEXT="Installing entry "_LUVALUE(1)
 .. E  S TEXT="Installing reminder "_LUVALUE(1)
 .. D BMES^XPDUTL(TEXT)
 .. D INSTALL^PXRMEXSI(IEN,1)
 Q
 ;
 ;===============================================================
SSPC ;Save the Sponsor classes.
 N CDATE,CLASS,IEN,PDATE
 D BMES^XPDUTL("Saving Sponsor Classes")
 S CDATE=$$NOW^XLFDT
 S PDATE=$$FMADD^XLFDT(CDATE,30)
 S ^XTMP("PXRMSPCS",0)=PDATE_U_CDATE_U_"SPONSOR CLASSES"
 S IEN=0
 F  S IEN=+$O(^PXRMD(811.6,IEN)) Q:IEN=0  D
 . S CLASS=$P($G(^PXRMD(811.6,IEN,0)),U,2)
 . ;CHECK FOR TEST SITES
 . I $G(CLASS)="" S CLASS=$P($G(^PXRMD(811.6,IEN,100)),U)
 . S ^XTMP("PXRMSPCS",IEN)=CLASS
 Q
