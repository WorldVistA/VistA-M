PXRMP4I ; SLC/PKR - PXRM*2.0*4 init routine. ;07/24/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 Q
 ;
 ;==========================================
CFTINC(IEN) ;Return true if the computed finding should be included
 ;in the build.
 N NAME
 S NAME=$P(^PXRMD(811.4,IEN,0),U,1)
 I NAME="VA-APPOINTMENTS FOR A PATIENT" Q 1
 I NAME="VA-DATE OF BIRTH" Q 1
 I NAME="VA-DATE OF DEATH" Q 1
 I NAME="VA-HOSPITAL DISCHARGE DATE" Q 1
 I NAME="VA-PATIENT TYPE" Q 1
 I NAME="VA-PATIENTS WITH APPOINTMENTS" Q 1
 I NAME="VA-PROGRESS NOTE" Q 1
 I NAME="VA-PTF HOSPITAL DISCHARGE DATE" Q 1
 I NAME="VA-REMINDER DEFINITION" Q 1
 I NAME="VA-TREATING FACILITY LIST" Q 1
 Q 0
 ;
 ;==========================================
DELDD ;Delete the old data dictionaries.
 N DIU,TEXT
 D EN^DDIOL("Removing old data dictionaries.")
 S DIU(0)=""
 F DIU=800,801.41,801.5,801.55,802.4,810.1,810.2,810.3,810.4,810.5,810.7,810.8,810.9,811.5,811.9 D
 . S TEXT=" Deleting data dictionary for file # "_DIU
 . D EN^DDIOL(TEXT)
 . D EN^DIU2
 Q
 ;
 ;==========================================
DELEI ;If the Exchange File entry already exists delete it.
 N ARRAY,IC,IND,LIST,LUVALUE,NUM
 D EXARRAY^PXRMP4IW(1,.ARRAY)
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:'IC  D
 . S LUVALUE(1)=ARRAY(IC,1)
 . D FIND^DIC(811.8,"","","U",.LUVALUE,"","","","","LIST")
 . I '$D(LIST) Q
 . S NUM=$P(LIST("DILIST",0),U,1)
 . I NUM'=0 D
 .. F IND=1:1:NUM D
 ... N DA,DIK
 ... S DIK="^PXD(811.8,"
 ... S DA=LIST("DILIST",2,IND)
 ... D ^DIK
 Q
 ;
 ;==========================================
DELLT ;Delete list templates
 N IEN,IND,LIST,TEMP0
 D LTL^PXRMP4IW(.LIST)
 S IND=0
 F  S IND=$O(LIST(IND)) Q:IND=""  D
 . S IEN=$O(^SD(409.61,"B",LIST(IND),"")) Q:IEN=""
 . S TEMP0=$G(^SD(409.61,IEN,0))
 . K ^SD(409.61,IEN)
 . S ^SD(409.61,IEN,0)=TEMP0
 Q
 ;
 ;==========================================
EXFINC(Y) ;Return a 1 if the Exchange file entry is in the list to
 ;include in the build. This is used in the build to determine which
 ;entries to include.
 N EXARRAY,FOUND,IEN,IC,LUVALUE
 D EXARRAY^PXRMP4IW(1,.EXARRAY)
 S FOUND=0
 S IC=0
 F  S IC=+$O(EXARRAY(IC)) Q:(IC=0)!(FOUND)  D
 . M LUVALUE=EXARRAY(IC)
 . S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 . I IEN=Y S FOUND=1 Q
 Q FOUND
 ;
 ;==========================================
OVLCHECK ;Check existing reminder definitions for baseline age range
 ;overlaps.
 D BMES^XPDUTL("Checking reminder definitions for baseline age range overlap")
 N DA,TEST
 S DA=0
 F  S DA=+$O(^PXD(811.9,DA)) Q:DA=0  D
 . S TEST=$$OVLAP^PXRMAGE
 . I TEST W !,"Reminder ",$P(^PXD(811.9,DA,0),U,1),"; IEN= ",DA,!
 Q
 ;
 ;==========================================
PRE ;
 D SLLC
 D DELDD
 D DELEI
 D DELLT
 D RELTEMP^PXRMP4I1
 D REOPTS^PXRMP4I1
 D REPROTS^PXRMP4I1
 N PXRMINST S PXRMINST=1
 D RENAME^PXRMP4I1(811.4,"VA-DISCHARGE DATE","VA-LAST SERVICE SEPARATION DATE")
 Q
 ;
 ;==========================================
POST ;
 D FORMAT^PXRMDISC
 D OVLCHECK
 D RLLC
 D RTAXEXP
 D RRSVC
 D SPLT
 D SAUTOP
 D SLABENOD^PXRMP4I1
 D SMEXINS
 D POST^PXRMGECL
 D MHVWEB^PXRMP4IW
 D GECDIA^PXRMP4I1
 D SNEXTIP^PXRMP4I1
 Q
 ;
 ;==========================================
RLLC ;Restore the Location List classes to the new location and delete
 ;the old location.
 N CLASS,IEN,TEMP
 D BMES^XPDUTL("Restoring Location List Classes")
 S IEN=0
 F  S IEN=+$O(^XTMP("PXRMLLCS",IEN)) Q:IEN=0  D
 . S CLASS=^XTMP("PXRMLLCS",IEN)
 . S $P(^PXRMD(810.9,IEN,100),U,1)=CLASS
 S IEN=0
 F  S IEN=+$O(^PXRMD(810.9,IEN)) Q:IEN=0  D
 . S CLASS=$P(^PXRMD(810.9,IEN,100),U,1)
 . I CLASS="" D
 .. S TEMP=$P(^PXRMD(810.9,IEN,0),U,2)
 .. I TEMP'="" S $P(^PXRMD(810.9,IEN,100),U,1)=TEMP
 .. S CLASS=TEMP
 . I CLASS'="" D
 .. S TEMP=^PXRMD(810.9,IEN,0)
 .. S ^PXRMD(810.9,IEN,0)=$P(TEMP,U,1)
 Q
 ;
 ;==========================================
RRSVC ;Reformat reminder report template service categories.
 N IEN,IND,SVCL
 D BMES^XPDUTL("Reformatting reminder report service categories")
 S IEN=0
 F  S IEN=+$O(^PXRMPT(810.1,IEN)) Q:IEN=0  D
 . S SVCL="",IND=0
 . F  S IND=+$O(^PXRMPT(810.1,IEN,8,IND)) Q:IND=0  D
 .. I SVCL="" S SVCL=^PXRMPT(810.1,IEN,8,IND,0)
 .. E  S SVCL=SVCL_","_^PXRMPT(810.1,IEN,8,IND,0)
 . I SVCL="" Q
 . K ^PXRMPT(810.1,IEN,8)
 . S ^PXRMPT(810.1,IEN,8)=SVCL
 Q
 ;
 ;==========================================
RSPC ;Restore the Sponsor classes to the new location.
 N CLASS,IEN
 D BMES^XPDUTL("Restoring Sponsor Classes")
 S IEN=0
 F  S IEN=+$O(^XTMP("PXRMSPCS",IEN)) Q:IEN=0  D
 . S CLASS=^XTMP("PXRMSPCS",IEN)
 . S $P(^PXRMD(811.6,IEN,100),U,1)=CLASS
 Q
 ;
 ;==========================================
RTAXEXP ;Rebuild all taxonomy expansions.
 N ALOW,AHIGH,FILENUM,HIGH,LOW,IEN,IND,TEMP,TEXT,X,X1,X2
 S (X1,X2)="TAX"
 D BMES^XPDUTL("Rebuilding taxonomy expansions and setting adjacent values.")
 S IEN=$O(^PXD(811.2,"B","VA-WH BILATERAL MASTECTOMY",""))
 S TEXT=" Working on taxonomy "_IEN
 D BMES^XPDUTL(TEXT)
 D DELEXTL^PXRMBXTL(IEN)
 D EXPAND^PXRMBXTL(IEN,"")
 F FILENUM=80,80.1,81 D
 . S IND=0
 . F  S IND=+$O(^PXD(811.2,IEN,FILENUM,IND)) Q:IND=0  D
 .. S TEMP=^PXD(811.2,IEN,FILENUM,IND,0)
 .. S LOW=$P(TEMP,U,1),HIGH=$P(TEMP,U,2)
 .. S ALOW=$S(FILENUM=80:$$PREV^ICDAPIU(LOW),FILENUM=80.1:$$PREV^ICDAPIU(LOW),FILENUM=81:$$PREV^ICPTAPIU(LOW))
 .. S AHIGH=$S(FILENUM=80:$$NEXT^ICDAPIU(HIGH),FILENUM=80.1:$$NEXT^ICDAPIU(HIGH),FILENUM=81:$$NEXT^ICPTAPIU(HIGH))
 .. S $P(^PXD(811.2,IEN,FILENUM,IND,0),U,3,4)=ALOW_U_AHIGH
 D BMES^XPDUTL(" DONE")
 Q
 ;
 ;==========================================
SAUTOP ;Make sure the class field is "N" for national Extract Summary and
 ;Reminder Patient List entries. For these entries set the field
 ;AUTOMATICALLY PURGE to true. Set INCLUDE PCMM INSTITUTION to true
 ;for all VA-*IHD QUERI and VA-*MH QUERI lists.
 D BMES^XPDUTL("Setting AUTOMATICALLY PURGE for national Extract Summaries and Patient Lists")
 N IEN,NAME
 S IEN=0 F  S IEN=$O(^PXRMXT(810.3,IEN)) Q:IEN'>0  D
 . S NAME=$P($G(^PXRMXT(810.3,IEN,0)),U)
 . I NAME'["VA-",NAME'["LREPI" Q
 . S $P(^PXRMXT(810.3,IEN,100),U)="N"
 . S ^PXRMXT(810.3,IEN,50)=1
 ;
 S IEN=0 F  S IEN=$O(^PXRMXP(810.5,IEN)) Q:IEN'>0  D
 . S NAME=$P($G(^PXRMXP(810.5,IEN,0)),U)
 . I NAME["QUERI" S $P(^PXRMXP(810.5,IEN,0),U,10)=1
 . I NAME'["VA-",NAME'["LREPI" Q
 . S $P(^PXRMXP(810.5,IEN,100),U)="N"
 . S ^PXRMXP(810.5,IEN,50)=1
 Q
 ;
 ;==========================================
SLLC ;Save the Location List classes.
 N CDATE,CLASS,IEN,PDATE
 D BMES^XPDUTL("Saving Location List Classes")
 S CDATE=$$NOW^XLFDT
 S PDATE=$$FMADD^XLFDT(CDATE,30)
 S ^XTMP("PXRMLLCS",0)=PDATE_U_CDATE_U_"LOCATION LIST CLASSES"
 S IEN=0
 F  S IEN=+$O(^PXRMD(810.9,IEN)) Q:IEN=0  D
 . S CLASS=$P(^PXRMD(810.9,IEN,0),U,2)
 . I CLASS'="" S ^XTMP("PXRMLLCS",IEN)=CLASS
 Q
 ;
 ;==========================================
SMEXINS ;Silent mode install.
 N EXARRAY,IC,IEN,LUVALUE,PXRMINST,TEXT
 S PXRMINST=1
 D EXARRAY^PXRMP4IW(1,.EXARRAY)
 S IC=0
 F  S IC=$O(EXARRAY(IC)) Q:'IC  D
 .M LUVALUE=EXARRAY(IC)
 .S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 .I IEN'=0 D
 .. N TEXT
 .. I LUVALUE(1)["PARAMETER" S TEXT="Installing entry "_LUVALUE(1)
 .. E  S TEXT="Installing reminder "_LUVALUE(1)
 .. D BMES^XPDUTL(TEXT)
 .. D INSTALL^PXRMEXSI(IEN,1)
 Q
 ;
 ;==========================================
SPLT ;Set the Patient List Type field. In the original version the list
 ;was private only if the creator was stored. In the new version the
 ;TYPE field will be used to mark a list as public or private and
 ;the creator will be stored for all lists.
 N CREATOR,IEN,TYPE
 D BMES^XPDUTL("Setting Patient List TYPE field")
 S IEN=0
 F  S IEN=+$O(^PXRMXP(810.5,IEN)) Q:IEN=0  D
 . S CREATOR=$P(^PXRMXP(810.5,IEN,0),U,7)
 . S TYPE=$S(CREATOR="":"PUB",1:"PVT")
 . S $P(^PXRMXP(810.5,IEN,0),U,8)=TYPE
 Q
 ;
 ;==========================================
SRSVC ;Save reminder report template service categories.
 N CDATE,IEN,IND,PDATE,SVCL
 D BMES^XPDUTL("Saving reminder report service categories")
 S CDATE=$$NOW^XLFDT
 S PDATE=$$FMADD^XLFDT(CDATE,30)
 S ^XTMP("PXRMRSVC",0)=PDATE_U_CDATE_U_"SERVICE CATEGORIES"
 S IEN=0
 F  S IEN=+$O(^PXRMPT(810.1,IEN)) Q:IEN=0  D
 . S SVCL="",IND=0
 . F  S IND=+$O(^PXRMPT(810.1,IEN,8,IND)) Q:IND=0  D
 .. I SVCL="" S SVCL=^PXRMPT(810.1,IEN,8,IND,0)
 .. E  S SVCL=SVCL_","_^PXRMPT(810.1,IEN,8,IND,0)
 . I SVCL'="" S ^XTMP("PXRMRSVC",IEN)=SVCL
 Q
 ;
 ;==========================================
SSPC ;Save the Sponsor classes.
 N CDATE,CLASS,IEN,PDATE
 D BMES^XPDUTL("Saving Sponsor Classes")
 S CDATE=$$NOW^XLFDT
 S PDATE=$$FMADD^XLFDT(CDATE,30)
 S ^XTMP("PXRMSPCS",0)=PDATE_U_CDATE_U_"SPONSOR CLASSES"
 S IEN=0
 F  S IEN=+$O(^PXRMD(811.6,IEN)) Q:IEN=0  D
 . S CLASS=$P(^PXRMD(811.6,IEN,0),U,2)
 . S ^XTMP("PXRMSPCS",IEN)=CLASS
 Q
 ;
