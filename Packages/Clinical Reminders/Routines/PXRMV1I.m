PXRMV1I ; SLC/PJH,PKR - Inits for new REMINDER package. ;06/08/2000
 ;;1.5;CLINICAL REMINDERS;;Jun 19, 2000
 ;
 Q
 ;
 ;------------------------
BLDLSTR ;Make sure all the logic strings get built.
 D BMES^XPDUTL("Building logic strings")
 N IEN
 S IEN=0
 F  S IEN=$O(^PXD(811.9,IEN)) Q:+IEN=0  D
 . I $P(^PXD(811.9,IEN,0),U,1)["VA-" Q
 . D BLDPCLS^PXRMLOGX(IEN,"")
 . D BLDRESLS^PXRMLOGX(IEN,"")
 . D BLDAFL^PXRMLOGX(IEN,"")
 . D BLDINFL^PXRMLOGX(IEN,"")
 Q
 ;
 ;----------------------------------------------------------------
CHECK(ROUTINE) ;Search for routine entry point in the new computed findings
 ;file
 N SUB,TAG,FOUND
 S SUB=0,FOUND=""
 F  S SUB=$O(^PXRMD(811.4,SUB)) Q:'SUB  D  Q:FOUND]""
 .S TAG=$P($G(^PXRMD(811.4,SUB,0)),U,2,3)
 .I $P(TAG,U,2)_";"_$P(TAG,U)=ROUTINE S FOUND=SUB
 Q FOUND
 ;
 ;--------------------------------------
COMP ;Computed findings - set up file #811.4
 N ARRAY,DATA,DESC,IEN,STRING,SUB,TAG,FDA,FDAIEN
 ;Get each reminder in turn
 S STRING="Building Computed Findings file"
 D BMES^XPDUTL(STRING)
 ;Make sure any converted computed findings go into the site's
 ;number space.
 D SETSTART^PXRMCOPY("^PXRMD(811.4,",0)
 S IEN=0
 F  S IEN=$O(^PXD(811.9,IEN)) Q:'IEN  D
 .;Skip VA- reminders
 .I $P(^PXD(811.9,IEN,0),U,1)["VA-" Q
 .I $D(REDO) Q:IEN'=REMINDER
 .S SUB=0
 .;Get computed findings records
 .F  S SUB=$O(^PXD(811.9,IEN,10,SUB)) Q:'SUB  D
 ..S DATA=$G(^PXD(811.9,IEN,10,SUB,0)) Q:DATA=""
 ..;Extract description and routine entry point
 ..S TAG=$P(DATA,U),DESC=$P(DATA,U,5)
 ..;Ignore null Computed findings
 ..I TAG="" Q
 ..;Default null name to routine name
 ..I DESC="" S DESC=TAG
 ..;Create ARRAY of routine entry points
 ..;(using first short description found)
 ..I '$D(ARRAY(TAG)) S ARRAY(TAG)=DESC Q
 ..;If already set-up ignore
 ..I ARRAY(TAG)=DESC Q
 ..;Otherwise log duplication
 ..S STRING="The following CF's use the same routine"
 ..D BMES^XPDUTL(STRING)
 ..D BMES^XPDUTL(ARRAY(TAG)_" (retained)")
 ..D BMES^XPDUTL(DESC_" (replaced)")
 ;
 ;Create FDA for each entry in ARRAY
 S TAG=""
 F  S TAG=$O(ARRAY(TAG)) Q:TAG=""  D  Q:$D(MSG)
 .S DESC=ARRAY(TAG)
 .;Check if entry already exists
 .I $$CHECK(TAG) D  Q
 ..S STRING="Skipping update - CF "_DESC
 ..D BMES^XPDUTL(STRING)
 .;Build FDA array
 .K FDAIEN,FDA
 .;Description
 .S FDA(811.4,"+1,",.01)=DESC
 .;Routine
 .S FDA(811.4,"+1,",.02)=$P(TAG,";",2)
 .;Entry Point
 .S FDA(811.4,"+1,",.03)=$P(TAG,";")
 .;Print name, default to the .01 field
 .S FDA(811.4,"+1,",.04)=DESC
 .D UPDATE^DIE("","FDA","FDAIEN","MSG")
 .I $D(MSG) D ERR
 Q
 ;
 ;------------------------
DELCF ;Delete any existing entries in the computed findings file.
 ;Skip those in a site number space. This will apply to test
 ;sites only.
 N DA,DIK,SNUMS
 S SNUMS=100000
 S DIK="^PXRMD(811.4,"
 S DA=0
 F  S DA=$O(^PXRMD(811.4,DA)) Q:(+DA=0)!(+DA>SNUMS)  D
 . D ^DIK
 Q
 ;
 ;------------------------
DELDD ;Delete data dictionaries
 N DIU,FILENUM
 S DIU(0)=""
 F FILENUM=800,801.41,801.42,801.43,801.45,801.9,801.95,810.1,811.2,811.3,811.4,811.5,811.6,811.7,811.9 D
 . S DIU=FILENUM
 . D EN^DIU2
 Q
 ;
 ;------------------------
DELMH ;Delete any existing MH result entries in dialog file.
 ;Skip those in a site number space. This will apply to test
 ;sites only.
 N DA,DIK,DTYP,SNUMS
 S SNUMS=100000
 S DIK="^PXRMD(801.41,"
 S DA=0
 F  S DA=$O(^PXRMD(801.41,DA)) Q:(+DA=0)!(+DA>SNUMS)  D
 .;Dialog type
 .S DTYP=$P($G(^PXRMD(801.41,DA,0)),U,4)
 .;Delete only result groups and result elements
 .I (DTYP="T")!(DTYP="S") D ^DIK
 Q
 ;
 ;------------------------
DELORD ;Delete obsolete reminder definitions.
 N DA,DIK
 S DIK="^PXD(811.9,"
 S DA=+$O(^PXD(811.9,"B","VA-*SEAT BELT AND ACCIDENT SCREEN",""))
 I DA>0 D ^DIK
 S DA=+$O(^PXD(811.9,"B","VA-SEAT BELT EDUCATION",""))
 I DA>0 D ^DIK
 S DA=+$O(^PXD(811.9,"B","VA-*TETANUS DIPTHERIA IMMUNIZATION",""))
 I DA>0 D ^DIK
 Q
 ;
 ;------------------------
DELXTAX ;Delete all expanded taxonomies
 N DA,DIK
 S DIK="^PXD(811.3,"
 S DA=0
 F  S DA=$O(^PXD(811.3,DA)) Q:+DA=0  D
 . D ^DIK
 Q
 ;
 ;----------------------------------
DPCACHE ;Delete any existing patient caches
 N IND
 S IND="PXRMDFN"
 F  S IND=$O(^XTMP(IND)) Q:IND'["PXRMDFN"  D
 . K ^XTMP(IND)
 Q
 ;
 ;-------------
ERR ;Error Handler
 N ERROR,IC,REF
 S ERROR(1)="Unable to convert computed finding : "_DESC
 S ERROR(2)="Reminder conversion abandoned"
 S ERROR(3)="Error in UPDATE^DIE, needs further investigation"
 ;Move MSG into ERROR
 S REF="MSG"
 F IC=4:1 S REF=$Q(@REF) Q:REF=""  S ERROR(IC)=REF_"="_@REF
 ;Screen message
 D BMES^XPDUTL(.ERROR)
 ;Mail Message
 D ERR^PXRMV1IE(.ERROR)
 Q
 ;
 ;----------------------------------
NEWB ;Get ready for new style B cross-references.
 N FILE
 F FILE=801.41,811.9 D
 . D RMDUP^PXRMV1IG(FILE)
 . D TMPB^PXRMV1IG(FILE)
 Q
 ;
 ;----------------------------------
PARM ;Copy site disclaimer from PCE file
 S STRING="Saving site disclaimer"
 D BMES^XPDUTL(STRING)
 M ^PXRM(800,1,"DISC2")=^PX(815,1,"HS2")
 Q
 ;
 ;-------------------------------------
PRE ;These are the pre-installation actions
 ;Get ready for new style B cross-references.
 D NEWB
 ;Save inactive statuses of VA reminders
 D INSAV^PXRMV1IG
 ;Rename menu options
 D CHANGE^PXRMV1IG
 ;Delete any existing entries in the computed findings file.
 D DELCF
 ;Delete any existing MH test result groups or elements
 D DELMH
 ;Delete data dictionaries for all files with a new DD or DD changes.
 D DELDD
 Q
 ;
 ;---------------------------------------
POST ;These are the post-installation actions
 N MSG
 ;Parameters
 D PARM
 ;Parameter Definitions
 D ^PXRMV1X
 ;Computed Findings
 D COMP Q:$D(MSG)
 ;Reminders
 D RBLD^PXRMV1IA Q:$D(MSG)
 D DELXTAX
 D DPCACHE
 ;Taxonomy selectable codes
 D ^PXRMV1ID
 ;Make sure all the logic strings get built.
 D BLDLSTR
 ;Rebuild indexes.
 D REINDEX
 ;Make sure no spurious duplicate entries were created with the
 ;new B cross-reference.
 D RMDUP
 ;Delete obsolete reminder definitions.
 D DELORD
 ;Restore VA reminder inactive statuses.
 D INRES^PXRMV1IG
 ;Connect the findings to the terms for the VA-HEP C RISK ASSESSMENT
 ;reminder
 D CTERMS^PXRMV1IH
 ;Set starting ien to site number space.
 D SETSTART
 Q
 ;
 ;------------------------
REDO ;Reset Selected Reminders
 N MSG,PXRMREM,REDO,REMINDER
 D REM(.PXRMREM)
 S REMINDER=$P($G(PXRMREM(1)),U)
 I REMINDER D
 . S REDO=1
 . D COMP Q:$D(MSG)
 . D RBLD^PXRMV1IA
 Q
 ;
 ;------------------
REINDEX ;Rebuild all cross-references that have been changed to the new style
 N FILE
 F FILE=801.41,811.2,811.4,811.5,811.6,811.7,811.9 D
 . D REINDEX^PXRMV1IG(FILE)
 Q
 ;
 ;------------------
REM(REM) ;Reminder Selection
 N LIT,LIT1,DIC
 S DIC("A")="REMINDER to convert: "
 S LIT1="You must select a reminder!"
 D SEL(811.9,"AEQMZ",.REM)
 Q
 ;
 ;-------------------------
RMDUP ;Remove duplicate entries
 N FILE
 F FILE=801.41,811.9 D
 . D RMDUP^PXRMV1IG(FILE)
 Q
 ;
 ;Repeated Prompt using DIC
 ;-------------------------
SEL(FILE,MODE,ARRAY) ;
 N X,Y,CNT
 K DIROUT,DIRUT,DTOUT,DUOUT
 S CNT=0
 W !
 F  D  Q:$D(DTOUT)  Q:$D(DUOUT)  Q:CNT>0  Q:(Y=-1)&(CNT>0)
 .S DIC=FILE,DIC(0)=MODE
 .D ^DIC
 .I X=(U_U) S DTOUT=1
 .I '$D(DTOUT),('$D(DUOUT)) D
 ..I +Y'=-1 D  Q
 ...S CNT=CNT+1,ARRAY(CNT)=Y_U_Y(0,0)_U_$P(Y(0),U,3)
 ..W:CNT=0 !,LIT1
 .K DIC
 Q
 ;-------------------------
SETSTART ;Set starting ien to site number space.
 N FILE,ROOT
 F FILE=811.2,811.4,811.5,811.6,811.9 D
 . S ROOT=$$ROOT^DILFD(FILE)
 . D SETSTART^PXRMCOPY(ROOT,0)
 F FILE=801.41 D
 . S ROOT=$$ROOT^DILFD(FILE)
 . D SETSTART^PXRMDCPY(ROOT,0)
 Q
 ;
