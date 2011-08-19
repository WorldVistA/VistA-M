PXRMP12I ; SLC/PKR - Inits for PXRM*2.0*12. ;08/03/2009
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 Q
 ;===============================================================
BRGXREF ;Build the new RG cross-reference for file 801.41
 N ERRMSG,OUTPUT,RESULT,XRARRAY
 I $D(^PXRMD(801.41,"RG")) D
 .D DELIXN^DDMOD(801.41,"RG","K","OUTPUT","ERRMSG")
 .I $D(ERRMSG) D
 ..D EN^DDIOL("Error deleting 'RG' Cross-reference.")
 ..D AWRITE^PXRMUTIL("ERRMSG")
 ;Set xref specification for a new style regular xref
 S XRARRAY("FILE")=801.41,XRARRAY("ROOT FILE")=801.41121
 S XRARRAY("NAME")="RG",XRARRAY("USE")="LS",XRARRAY("TYPE")="REGULAR"
 S XRARRAY("EXECUTION")="FIELD",XRARRAY("ACTIVITY")="IR"
 S XRARRAY("VAL",1)=.01,XRARRAY("VAL",1,"SUBSCRIPT")=1
 ;S XRARRAY("SET CONDITION")="S X=1"
 ;S XRARRAY("KILL CONDITION")="S X=1"
 ;S XRARRAY("SET")="S ^PXRMD(801.41,""RG"",X,DA(1),DA)="""""
 ;S XRARRAY("KILL")="K ^PXRMD(801.41,""RG"",X,DA(1),DA)"
 ;S XRARRAY("WHOLE KILL")="K ^PXRMD(801.41,""RG"")"
 ;set description text
 S XRARRAY("SHORT DESCR")="Whole-file regular 'RG' index"
 S XRARRAY("DESCR",1)="This RG cross-reference is created when a result group is assigned "
 S XRARRAY("DESCR",2)="to a parent element. It is killed when a result group is deleted "
 S XRARRAY("DESCR",3)="from a parent element. This cross-reference is used to determine "
 S XRARRAY("DESCR",4)="if a result group is used by a parent element for reporting "
 S XRARRAY("DESCR",5)="purposes. If a result group is included in this cross-reference then "
 S XRARRAY("DESCR",6)="it is assigned to a parent element and accordingly the result group "
 S XRARRAY("DESCR",7)="cannot be deleted."
 ;
 D CREIXN^DDMOD(.XRARRAY,"S",.RESULT,"OUTPUT","ERRMSG")
 I +RESULT>0 D EN^DDIOL("Cross-reference 'RG' created.")
 I RESULT="" D 
 .D EN^DDIOL("Error while building 'RG' cross-reference on file 801.41")
 .I $D(ERRMSG) D AWRITE^PXRMUTIL("ERRMSG")
 Q
 ;
 ;===============================================================
CFINC(Y) ;List of computed findings to include in the build.
 N CFLIST,CFNAME
 S CFLIST("VA-ADMISSIONS FOR A DATE RANGE")=""
 S CFLIST("VA-BMI")=""
 S CFLIST("VA-BSA")=""
 S CFLIST("VA-COMBAT VET ELIGIBILITY")=""
 S CFLIST("VA-CURRENT INPATIENTS")=""
 S CFLIST("VA-DATE FOR AGE")=""
 S CFLIST("VA-DISCHARGES FOR A DATE RANGE")=""
 S CFLIST("VA-EMPLOYEE")=""
 S CFLIST("VA-IS INPATIENT")=""
 S CFLIST("VA-PROGRESS NOTE")=""
 S CFNAME=$P(^PXRMD(811.4,Y,0),U,1)
 Q $S($D(CFLIST(CFNAME)):1,1:0)
 ;
 ;===============================================================
DELDD ;Delete the old data dictionaries.
 N DIU,TEXT
 D EN^DDIOL("Removing old data dictionaries.")
 S DIU(0)=""
 F DIU=801.41,810.1,810.2,810.4,810.5,810.7,810.8,810.9,811.2,811.4,811.5,811.6,811.8,811.9 D
 . S TEXT=" Deleting data dictionary for file # "_DIU
 . D EN^DDIOL(TEXT)
 . D EN^DIU2
 Q
 ;
 ;===============================================================
EXINI ;Inits for the Exchange File.
 ;Delete the EXCHANGE TYPE field from file #811.8; it is no longer
 ;needed. Delete the 120 node so it will be rebuilt in the new format.
 N DA,DIK,DPACKED,IEN,NAME
 ;Delete entry with misspelled name.
 S NAME="VA-TBI/POLY IDT EVAULATIONS ELEMENT UPDATE"
 S DPACKED=""
 F  S DPACKED=$O(^PXD(811.8,"B",NAME,DPACKED)) Q:DPACKED=""  D
 . S DA=$O(^PXD(811.8,"B",NAME,DPACKED,""))
 . W !,"DA FOR DELETION IS ",DA
 . D DELETE^PXRMEXFI(811.8,DA)
 S IEN=0
 F  S IEN=+$O(^PXD(811.8,IEN)) Q:IEN=0  D
 . K ^PXD(811.8,IEN,115)
 . K ^PXD(811.8,IEN,120)
 I '$D(^DD(811.8,115)) Q
 K DA
 S DIK="^DD(811.8,",DA=115,DA(1)=811.8
 D ^DIK
 Q
 ;
 ;===============================================================
GTDISDLG ;
 N CNT,DIEN,DISTXT,FLDTYP,PXRMXTMP
 D FIELD^DID(801.41,3,"","TYPE","FLDTYP","")
 ;Prevent re-run if after first install
 I FLDTYP("TYPE")="SET" Q
 S PXRMXTMP="PXRM PATCH 12"
 K ^XTMP(PXRMXTMP)
 S ^XTMP(PXRMXTMP,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"PXRM PATCH 12 CONVERSION"
 S DIEN=0,CNT=0 F  S DIEN=$O(^PXRMD(801.41,DIEN)) Q:DIEN'>0  D
 .S DISTXT=$P($G(^PXRMD(801.41,DIEN,0)),U,3)
 .I DISTXT="" Q
 .S CNT=CNT+1,^XTMP(PXRMXTMP,"DISABLE",CNT)=DIEN_U_DISTXT
 .S $P(^PXRMD(801.41,DIEN,0),U,3)=""
 Q
 ;
 ;==========================================
INILT ;Initialize list templates
 N IEN,IND,LIST,TEMP0
 D LTL^PXRMP12I(.LIST)
 S IND=0
 ;IA #4123
 F  S IND=$O(LIST(IND)) Q:IND=""  D
 . S IEN=$O(^SD(409.61,"B",LIST(IND),"")) Q:IEN=""
 . S TEMP0=$G(^SD(409.61,IEN,0))
 . K ^SD(409.61,IEN)
 . S ^SD(409.61,IEN,0)=TEMP0
 Q
 ;
 ;==========================================
LLFIX ;Fix any bad nodes in location lists.
 N IEN,IND,JND,NONE
 D MES^XPDUTL("Fixing bad Location List nodes.")
 S IEN=0,NONE=1
 F  S IEN=+$O(^PXRMD(810.9,IEN)) Q:IEN=0  D
 . I '$D(^PXRMD(810.9,IEN,40.7,IEN)) Q
 . S IND=0
 . F  S IND=+$O(^PXRMD(810.9,IEN,40.7,IEN,IND)) Q:IND=0  D
 .. S JND=0
 .. F  S JND=+$O(^PXRMD(810.9,IEN,40.7,IEN,IND,JND)) Q:JND=0  D
 ... I $G(^PXRMD(810.9,IEN,40.7,IEN,IND,JND,0))="^" D
 ... K ^PXRMD(810.9,IEN,40.7,IEN,IND,JND,0)
 ... D MES^XPDUTL("Fixed node "_IEN_",40.7,"_IEN_","_IND_","_JND)
 ... S NONE=0
 I NONE D MES^XPDUTL("No bad nodes were found.")
 Q
 ;
 ;==========================================
LTL(LIST) ;This is the list of list templates that being distributed
 ;in the patch.
 S LIST(1)="PXRM EX LIST COMPONENTS"
 S LIST(2)="PXRM EX REMINDER EXCHANGE"
 Q
 ;
 ;===============================================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 I '$$PATCH^XPDUTL("PXRM*2.0*12") D GTDISDLG
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP12E")
 D INILT^PXRMP12I
 D DELDD^PXRMP12I
 Q
 ;
 ;===============================================================
POST ;Post-init
 D EXINI^PXRMP12I
 D RENGECHF^PXRMP12I
 D STDISDLG^PXRMP12I
 D UPDPARF^PXRMP12I
 D UPDRTMP^PXRMP12I
 D LLFIX^PXRMP12I
 D RTAXEXP^PXRMP12I
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP12E")
 ;Make double sure any newly install taxonomies are expanded.
 D RTAXEXP^PXRMP12I
 ;Build new RG cross-reference entry for file 801.41
 D BRGXREF^PXRMP12I
 Q
 ;
 ;===============================================================
RENGECHF ;Correct a typo in the name of a GEC health factor.
 N DA,DIE,DR
 S DA=$O(^AUTTHF("B","GEC RECENT CHANGE IN IADL RX-NO",""))
 I DA="" Q
 S DIE="^AUTTHF(",DR=".01////GEC RECENT CHANGE IN IADL FX-NO"
 D ^DIE
 Q
 ;
 ;===============================================================
RTAXEXP ;Rebuild taxonomy expansions.
 ;Make sure the 0 node is properly defined.
 S ^PXD(811.3,0)="EXPANDED TAXONOMIES^811.3OP^1^1"
 D EXPALL^PXRMBXTL
 Q
 ;
 ;===============================================================
STDISDLG ;
 N CNT,DIEN,DISTXT,FDA,MSG,NODE,PXRMXTMP
 S PXRMXTMP="PXRM PATCH 12"
 K ^TMP($J,"PXRM DISABLE REASON")
 I '$D(^XTMP(PXRMXTMP)) Q
 S CNT=0 F  S CNT=$O(^XTMP(PXRMXTMP,"DISABLE",CNT)) Q:CNT'>0  D
 .S NODE=$G(^XTMP(PXRMXTMP,"DISABLE",CNT))
 .S DIEN=$P(NODE,U),DISTXT=$P(NODE,U,2)
 .S $P(^PXRMD(801.41,DIEN,0),U,3)=1
 .S ^TMP($J,"PXRM DISABLE REASON",1,0)=DISTXT
 .S FDA(801.44,"+2,"_DIEN_",",.01)=DT
 .S FDA(801.44,"+2,"_DIEN_",",1)=DUZ
 .S FDA(801.44,"+2,"_DIEN_",",2)="^TMP($J,""PXRM DISABLE REASON"")"
 .D UPDATE^DIE("","FDA","","MSG")
 .I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 K ^TMP($J,"PXRM DISABLE REASON")
 K ^XTMP(PXRMXTMP)
 Q
 ;
 ;===============================================================
UPDPARF ;
 N DA,DIE,DR
 S DIE="^PXRM(800,",DA=1,DR="5////2.0P12"
 D ^DIE
 Q
 ;
 ;===============================================================
UPDRTMP ;
 N DA,DIE,DR
 S DIE="^PXRMPT(810.1,",DR="1.8////0"
 S DA=0 F  S DA=$O(^PXRMPT(810.1,DA)) Q:DA'>0  D
 .I +$P($G(^PXRMPT(810.1,DA,0)),U,10)=1 Q
 .D ^DIE
 Q
 ;
