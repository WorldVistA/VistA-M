PXRMV2I ; SLC/PKR - Version 2.0 init routine. ;11/05/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 Q
 ;
 ;===============================================================
CPCL ;Convert the internal patient cohort logic to the new form that
 ;includes sex and age.
 N CPCL,IEN
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . S CPCL=$G(^PXD(811.9,IEN,30))
 . I CPCL'="" D CPPCLS^PXRMLOGX(IEN,CPCL)
 . E  D BLDPCLS^PXRMLOGX(IEN,"","")
 Q
 ;
 ;===============================================================
CRXTYPE ;Convert the RXTYPE to the new form.
 N FI,IND,RXTYPE
 D BMES^XPDUTL("Converting definition RXTYPES to new form.")
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . S FI=0
 . F  S FI=+$O(^PXD(811.9,IEN,20,FI)) Q:FI=0  D
 .. S RXTYPE=$P(^PXD(811.9,IEN,20,FI,0),U,13)
 .. I RXTYPE="B" S $P(^PXD(811.9,IEN,20,FI,0),U,13)="A"
 D BMES^XPDUTL("Converting term RXTYPES to new form.")
 S IEN=0
 F  S IEN=+$O(^PXRMD(811.5,IEN)) Q:IEN=0  D
 . S FI=0
 . F  S FI=+$O(^PXRMD(811.5,IEN,20,FI)) Q:FI=0  D
 .. S RXTYPE=$P(^PXRMD(811.5,IEN,20,FI,0),U,13)
 .. I RXTYPE="B" S $P(^PXRMD(811.5,IEN,20,FI,0),U,13)="A"
 Q
 ;
 ;===============================================================
CSVPE ;Execute the CSV protocol event points.
 D ICDPE^PXRMCSPE
 D CPTPE^PXRMCSPE
 Q
 ;
 ;===============================================================
DELCF ;Delete erroneous computed finding entries.
 N DA,DIK,NAME
 S DIK="^PXRMD(811.4,"
 F NAME="VA-WH MAMMOGRAM REV IN WH PKG","VA-WH PAP SMEAR REV IN WH PKG","VA-WH REVIEW OR RESULT","VA-WH ULTRASOUND","VA-WH ULTRASOUND REVIEW" D
 . S DA=+$O(^PXRMD(811.4,"B",NAME,"")) Q:DA'>0
 . D BMES^XPDUTL("Deleting Computed Finding: "_NAME)
 . D ^DIK
 Q
 ;
 ;===============================================================
DELDD ;Delete the old data dictionaries.
 N DIU,TEXT
 D EN^DDIOL("Removing old data dictionaries.")
 S DIU(0)=""
 F DIU=800,801.3,801.41,801.42,801.43,801.45,801.5,801.9,801.95,802.4,810.1,810.2,810.3,810.4,810.5,810.6,810.7,810.8,810.9,811.2,811.3,811.4,811.5,811.6,811.7,811.8,811.9 D
 . S TEXT=" Deleting data dictionary for file # "_DIU
 . D EN^DDIOL(TEXT)
 . D EN^DIU2
 Q
 ;
 ;===============================================================
EXTRACT ;
 N DA,DIE,DR,NAME,PERIOD
 S PERIOD="M1/2005",DIE="^PXRM(810.2,"
 F NAME="VA-IHD QUERI","VA-MH QUERI" D
 . S DA=$O(^PXRM(810.2,"B",NAME,"")) Q:DA'>0
 . S DR="4///^S X=PERIOD" D ^DIE
 Q
 ;
 ;===============================================================
FFFIX ;Clean up the function finding file at test sites.
 N DA,DIK,NAME
 S DIK="^PXRMD(802.4,"
 F NAME="FND","FI","DUR" D
 . S DA=+$O(^PXRMD(802.4,"B",NAME,"")) Q:DA'>0
 . D BMES^XPDUTL("Deleting Function Finding: "_NAME)
 . D ^DIK
 Q
 ;
 ;===============================================================
FIXTERM ;
 N IEN,TEMP0
 S IEN=0 F  S IEN=$O(^PXRMD(811.5,IEN)) Q:IEN'>0  D
 . S TEMP0=$P($G(^PXRMD(811.5,IEN,0)),U,1,4)
 . S $P(TEMP0,U,2)="",$P(TEMP0,U,3)=""
 . S ^PXRMD(811.5,IEN,0)=TEMP0
 Q
 ;
 ;===============================================================
FOMRD ;Flag all definitions using the old-style MRD.
 N CPCL,IEN,NAME,NL,XMSUB
 K ^TMP("PXRMXMZ",$J)
 S XMSUB="Old-style MRD obsolete"
 S ^TMP("PXRMXMZ",$J,1,0)="The old-style MRD function is obsolete and will be removed in a subsequent"
 S ^TMP("PXRMXMZ",$J,2,0)="patch. Please do not use it anymore; use a function finding instead."
 S ^TMP("PXRMXMZ",$J,3,0)="The following reminder definitions use the old-style MRD function;"
 S ^TMP("PXRMXMZ",$J,4,0)="please change them to use a function finding."
 S NL=4
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . S CPCL=$G(^PXD(811.9,IEN,30))
 . I CPCL'["MRD" Q
 . S NAME=$P(^PXD(811.9,IEN,0),U,1)
 . S NL=NL+1
 . S ^TMP("PXRMXMZ",$J,NL,0)=" "
 . S NL=NL+1
 . S ^TMP("PXRMXMZ",$J,NL,0)="Reminder: "_NAME_", ien - "_IEN
 . S NL=NL+1
 . S ^TMP("PXRMXMZ",$J,NL,0)="Custom cohort logic: "_CPCL
 I NL=4 K ^TMP("PXRMXMZ",$J,3,0),^TMP("PXRMXMZ",$J,4,0)
 D SEND^PXRMMSG(XMSUB)
 Q
 ;===============================================================
 ;
MAIL ;Add remote member to mail group IHD SEND
 D ADDMBRS^XMXAPIG(DUZ,"IHD SEND","XXX@Q-IHD.MED.VA.GOV")
 D ADDMBRS^XMXAPIG(DUZ,"IHD","S.HL MS SERVER")
 D INIT^PXRMGECW
 Q
 ;
 ;===============================================================
PRE ;
 D RENAMIR
 D RENAMTRM
 D DELCF
 D FFFIX
 D DELETE^PXRMV2IL
 D DELEI^PXRMV2IE
 D DELDD
 Q
 ;
 ;===============================================================
POST ;
 D SVRSN
 D DELEXB^PXRMV2IE
 D CNAK^PXRMV2IE
 D SMEXINS^PXRMV2IE
 D FOMRD
 D RTAXEXP
 D MAIL
 ;D XPARAMS
 D CPCL
 D CEFFDATE^PXRMV2ID
 D CFDATE^PXRMV2ID
 D CSVPE
 D WEB
 D COND^PXRMV2IC
 D SFNFTC^PXRMV2IA
 D DELGEC^PXRMV2IE
 D EN^PXRMV2IR
 D CRXTYPE^PXRMV2I
 D FIXTERM
 D EXTRACT
 Q
 ;
 ;===============================================================
RENAMIR ;If the VA-IRAQ &AFGHAN POST-DEPLOY SCREEN reminder exists rename it.
 N DA,DIE,DR,PXRMINST,TEXT
 S DA=$O(^PXD(811.9,"B","VA-IRAQ &AFGHAN POST-DEPLOY SCREEN",""))
 I DA="" Q
 S TEXT="Renaming reminder VA-IRAQ &AFGHAN POST-DEPLOY SCREEN to VA-IRAQ & AFGHAN POST-DEPLOY SCREEN"
 D BMES^XPDUTL(TEXT)
 S DIE=811.9,DR=".01///VA-IRAQ & AFGHAN POST-DEPLOY SCREEN",PXRMINST=1
 D ^DIE
 Q
 ;
 ;===============================================================
RENAMTRM ;Rename all national terms so they start with VA-
 N DA,DIE,DR,IEN,OLDNAME,NEWNAME,X
 D BMES^XPDUTL("Renaming National Terms:")
 S IEN=0 F  S IEN=$O(^PXRMD(811.5,IEN)) Q:IEN'>0  D
 . I $P($G(^PXRMD(811.5,IEN,100)),U)'="N" Q
 . S OLDNAME=$P($G(^PXRMD(811.5,IEN,0)),U,1)
 . I OLDNAME["VA-" Q
 . D BMES^XPDUTL("Renaming Term: "_OLDNAME)
 . S NEWNAME="VA-"_OLDNAME,DIE="^PXRMD(811.5,",DA=IEN,DR=".01///^S X=NEWNAME"
 .;lock record
 . L +^PXRMD(811.5,IEN):0 I $T D ^DIE L -^PXRMD(811.5,IEN)
 S DIE="^PXRMD(811.4,"
 S DA=$O(^PXRMD(811.4,"B","VA-IRAQ & AFGHAN SEP. DATE",""))
 I $G(DA)="" Q
 S DR=".01////VA-DISCHARGE DATE" D ^DIE
 Q
 ;===============================================================
RTAXEXP ;Rebuild all taxonomy expansions.
 N ALOW,AHIGH,FILENUM,HIGH,LOW,IEN,IND,TEMP,TEXT,X,X1,X2
 S (X1,X2)="TAX"
 D BMES^XPDUTL("Rebuilding taxonomy expansions and setting adjacent values.")
 S IEN=0
 F  S IEN=+$O(^PXD(811.2,IEN)) Q:IEN=0  D
 . S TEXT=" Working on taxonomy "_IEN
 . D BMES^XPDUTL(TEXT)
 . D DELEXTL^PXRMBXTL(IEN)
 . D EXPAND^PXRMBXTL(IEN,"")
 . F FILENUM=80,80.1,81 D
 .. S IND=0
 .. F  S IND=+$O(^PXD(811.2,IEN,FILENUM,IND)) Q:IND=0  D
 ... S TEMP=^PXD(811.2,IEN,FILENUM,IND,0)
 ... S LOW=$P(TEMP,U,1),HIGH=$P(TEMP,U,2)
 ... S ALOW=$S(FILENUM=80:$$PREV^ICDAPIU(LOW),FILENUM=80.1:$$PREV^ICDAPIU(LOW),FILENUM=81:$$PREV^ICPTAPIU(LOW))
 ... S AHIGH=$S(FILENUM=80:$$NEXT^ICDAPIU(HIGH),FILENUM=80.1:$$NEXT^ICDAPIU(HIGH),FILENUM=81:$$NEXT^ICPTAPIU(HIGH))
 ... S $P(^PXD(811.2,IEN,FILENUM,IND,0),U,3,4)=ALOW_U_AHIGH
 D BMES^XPDUTL(" DONE")
 Q
 ;
 ;===============================================================
SENODE ;Rebuild the "E" index on definitions and terms.
 ;This code probably does not need to be run, keep it in case there
 ;is a problem at test sites.
 N DA,DIK,IND,TEXT
 S TEXT="Rebuilding E index for reminder definitions"
 D BMES^XPDUTL(TEXT)
 S IND=0
 F  S IND=+$O(^PXD(811.9,IND)) Q:IND=0  D
 . S TEXT=" Working on reminder "_IND
 . D BMES^XPDUTL(TEXT)
 . K ^PXD(811.9,IND,20,"E")
 . S DIK="^PXD(811.9,"_IND_",20,"
 . S DA(1)=IND,DIK(1)=".01^E"
 . D ENALL^DIK
 S TEXT="Rebuilding E index for terms"
 D BMES^XPDUTL(TEXT)
 S IND=0
 F  S IND=+$O(^PXRMD(811.5,IND)) Q:IND=0  D
 . S TEXT=" Working on term "_IND
 . D BMES^XPDUTL(TEXT)
 . K ^PXRMD(811.5,IND,20,"E")
 . S DIK="^PXRMD(811.5,"_IND_",20,"
 . S DA(1)=IND,DIK(1)=".01^E"
 . D ENALL^DIK
 Q
 ;
 ;===============================================================
SVRSN ;Set the package version number.
 N VRSN
 S VRSN=$P($T(+2^PXRM),";",3)
 S ^PXRM(800,1,"VERSION")=VRSN
 Q
 ;
 ;===============================================================
WEB ;Change the default web page from the prevention handbook
 ;to the oqp page.
 N IND,NEW,OLD
 S OLD="http://vaww.va.gov/publ/direc/health/handbook/1120-2hk.htm"
 S NEW="http://www.oqp.med.va.gov/cpg/cpg.htm"
 S IND=$O(^PXRM(800,1,1,"B",$E(OLD,1,30),""))
 I IND="" Q
 K ^PXRM(800,1,1,IND,0)
 K ^PXRM(800,1,1,"B",$E(OLD,1,30),IND)
 S ^PXRM(800,1,1,"B",$E(NEW,1,30),IND)=""
 S $P(^PXRM(800,1,1,IND,0),U,1)=NEW
 S $P(^PXRM(800,1,1,IND,0),U,2)="OQP Clinical Guidelines"
 Q
 ;
 ;===============================================================
XPARAMS ;Set the next extract date in the IHD QUERI parameters
 ;
 ;Site must schedule extract with XU OPTION SCHEDULE option when ready
 N IEN,LUVALUE
 ;
 ;IHD QUERI
 S LUVALUE(1)="VA-IHD QUERI"
 S IEN=+$$FIND1^DIC(810.2,"","KU",.LUVALUE)
 ;Update next extract period as current period
 I IEN S $P(^PXRM(810.2,IEN,0),U,6)=$$PERIOD^PXRMEUT("M")
 ;
 ;MH QUERI
 S LUVALUE(1)="VA-MH QUERI"
 S IEN=+$$FIND1^DIC(810.2,"","KU",.LUVALUE)
 ;Update next extract period as current period
 I IEN S $P(^PXRM(810.2,IEN,0),U,6)=$$PERIOD^PXRMEUT("M")
 ;
 Q
 ;
