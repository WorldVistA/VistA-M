PXRMEXU4 ;SLC/PJH,PKR - Reminder Exchange #4, dialog changes. ;05/07/2014
 ;;2.0;CLINICAL REMINDERS;**6,12,22,26**;Feb 04, 2005;Build 404
 ;===============================================
DLG(FDA,NAMECHG) ;Check the dialog for renamed entries, called by
 ;silent installer. KIDSDONE is newed in INSDLG^PXRMEXSI.
 N ABBR,ACTION,ALIST,DNAM,IEN,IENS,ISACT,FILENUM,FINDING,NEWNAM,OFINDING
 N ORITEM,OORITEM,PT01,RESULT,RRG,SRC,TEMP,TEXT,WP
 S IENS=$O(FDA(801.41,""))
 ;Definition .01
 S (PT01,DNAM)=FDA(801.41,IENS,.01)
 I $D(NAMECHG(801.41,PT01)) D
 .S (FDA(801.41,IENS,.01),DNAM)=NAMECHG(801.41,PT01)
 ;
 ;Build list of finding types
 D BLDALIST^PXRMVPTR(801.4118,.01,.ALIST)
 ;Plus field 15 files
 S ALIST("MH")=601.71,ALIST("TX")=811.2
 S ALIST("WH")=790.404
 ;Plus field 17 file
 S ALIST("OI")=101.43
 ;
 ;Process SOURCE REMINDER
 S SRC=$G(FDA(801.41,IENS,2))
 I SRC]"" D
 .S IEN=$$EXISTS^PXRMEXIU(811.9,SRC)
 .I IEN=0 K FDA(801.41,IENS,2)
 ;
 ;Clear RESULT if not defined
 S RESULT=$G(FDA(801.41,IENS,55))
 I RESULT]"" D
 .S IEN=$$EXISTS^PXRMEXIU(801.41,RESULT)
 .I IEN=0 K FDA(801.41,IENS,55)
 ;
 ;Process ORDERABLE ITEM
 S (ORITEM,OORITEM)=$G(FDA(801.41,IENS,17)),ACTION=""
 I ORITEM'="" D  I ACTION="Q" K FDA S PXRMDONE=1 Q
 .S TEXT=""
 .S PT01=ORITEM
 .S ABBR="OI",FILENUM=$P(ALIST(ABBR),U)
 .I $D(NAMECHG(FILENUM,PT01)) D
 ..S ORITEM=NAMECHG(FILENUM,PT01)
 ..S FDA(801.41,IENS,17)=ORITEM
 .S IEN=+$$VFIND1^PXRMEXIU(ABBR_"."_ORITEM,.ALIST)
 .I IEN>0,$$VDLGFIND^PXRMEXIU(ABBR,ORITEM,.ALIST)=0 D
 ..S IEN=0
 ..S TEXT="ORDERABLE ITEM  entry "_ORITEM_" is inactive."
 .I IEN>0 S FDA(801.41,IENS,17)="`"_IEN
 .I IEN=0 D
 ..;Get replacement
 ..I TEXT="" S TEXT="ORDERABLE ITEM  entry "_ORITEM_" does not exist."
 ..N DIC,DIR,DUOUT,MSG,X,Y
 ..S MSG(1)=" "
 ..S MSG(2)=TEXT
 ..D MES^XPDUTL(.MSG)
 ..S ACTION=$$GETACT^PXRMEXIU("DPQ",.DIR) I ACTION="S" S ACTION="Q"
 ..I ACTION="Q" Q
 ..I ACTION="D" K FDA(801.41,IENS,17) Q
 ..S DIC=FILENUM
 ..S DIC(0)="AEMNQ"
 ..S DIC("S")="I $$FILESCR^PXRMDLG6(Y,FILENUM)=1"
 ..S Y=-1
 ..F  Q:+Y'=-1  D
 ...;If this is being called during a KIDS install we need echoing on.
 ...I $D(XPDNM) X ^%ZOSF("EON")
 ...D ^DIC
 ...I $D(XPDNM) X ^%ZOSF("EOFF")
 ...;If this is being called during a KIDS install we need echoing on.
 ...I $D(DUOUT) S Y="" Q
 ...I Y=-1 D BMES^XPDUTL("You must input a replacement!")
 ..I Y="" S ACTION="Q" Q
 ..S ORITEM=$P(Y,U,2)
 ..S FDA(801.41,IENS,17)=ORITEM
 .;Save the finding information for the history.
 .I ORITEM'=OORITEM D
 .. S ^TMP("PXRMEXIA",$J,"DIAF",$P(IENS,",",1),ABBR_"."_OORITEM)=ABBR_"."_ORITEM
 ;
 ;check for pre-packed patch 26 codes and taxonomy.
 D TAXCONV(.FDA,IENS)
 ;Process FINDING ITEM
 ;S TAXCONVD=0
 S (FINDING,OFINDING)=$G(FDA(801.41,IENS,15)),ACTION=""
 I FINDING'="" D  I ACTION="Q" K FDA S PXRMDONE=1 Q
 .S TEXT=""
 .S ABBR=$P(FINDING,".",1)
 .S PT01=$P(FINDING,".",2)
 .S FILENUM=$P(ALIST(ABBR),U,1)
 .I $D(NAMECHG(FILENUM,PT01)) D
 ..S FINDING=ABBR_"."_NAMECHG(FILENUM,PT01)
 ..S FDA(801.41,IENS,15)=FINDING
 .S IEN=+$$VFIND1^PXRMEXIU(FINDING,.ALIST)
 .I IEN>0 S TEMP=$$VDLGFIND^PXRMEXIU(ABBR,IEN,.ALIST) I TEMP<1 D
 ..S IEN=0
 ..S TEXT="FINDING  entry "_FINDING_" "_$S(TEMP=0:"is inactive.",1:" does not have codes marked to be used in a dialog.")
 .I IEN>0 S FDA(801.41,IENS,15)=ABBR_".`"_IEN
 .I IEN=0 D
 ..I TEXT="" S TEXT="FINDING entry "_FINDING_" does not exist."
 ..;Get replacement
 ..N DIC,DIR,DUOUT,MSG,X,Y
 ..S MSG(1)=" "
 ..S MSG(2)=TEXT
 ..D MES^XPDUTL(.MSG)
 ..S ACTION=$$GETACT^PXRMEXIU("DPQ",.DIR) I ACTION="S" S ACTION="Q"
 ..I ACTION="Q" Q
 ..I ACTION="D" K FDA(801.41,IENS,15) Q
 ..S DIC=FILENUM
 ..S DIC(0)="AEMNQ"
 ..S DIC("S")="I $$FILESCR^PXRMDLG6(Y,FILENUM)=1"
 ..S Y=-1
 ..F  Q:+Y'=-1  D
 ...;If this is being called during a KIDS install we need echoing on.
 ...I $D(XPDNM) X ^%ZOSF("EON")
 ...D ^DIC
 ...I $D(XPDNM) X ^%ZOSF("EOFF")
 ...;If this is being called during a KIDS install we need echoing on.
 ...I $D(DUOUT) S Y="" Q
 ...I Y=-1 D BMES^XPDUTL("You must input a replacement!")
 ..I Y="" S ACTION="Q" Q
 ..S FINDING=ABBR_"."_$P(Y,U,2)
 ..S FDA(801.41,IENS,15)=FINDING
 .;Save the finding information for the history.
 .I FINDING'=OFINDING D
 .. S ^TMP("PXRMEXIA",$J,"DIAF",$P(IENS,",",1),OFINDING)=FINDING
 .;Convert ICD9 codes to `ien format
 .;I $P(FINDING,".")="ICD9" S FDA(801.41,IENS,15)="ICD9."_$$ICD9(FINDING)
 ;
 ;Look for replacements of TIU templates.
 I $D(NAMECHG(8927.1)) D
 .S WP=$G(FDA(801.41,IENS,25))
 .I WP'="" D TIURPL("{FLD:",WP,.NAMECHG,8927.1)
 .S WP=$G(FDA(801.41,IENS,35))
 ;
 ;Process ADDITIONAL FINDINGS
 S IENS="",ACTION=""
 F  S IENS=$O(FDA(801.4118,IENS)) Q:IENS=""  D  I ACTION="Q" K FDA S PXRMDONE=1 Q
 . S TEXT=""
 . S (FINDING,OFINDING)=FDA(801.4118,IENS,.01)
 . S ABBR=$P(FINDING,".",1)
 . S PT01=$P(FINDING,".",2)
 . S FILENUM=$P(ALIST(ABBR),U,1)
 . I $D(NAMECHG(FILENUM,PT01)) D
 .. S FINDING=ABBR_"."_NAMECHG(FILENUM,PT01)
 .. S FDA(801.4118,IENS,.01)=FINDING
 . S IEN=+$$VFIND1^PXRMEXIU(FINDING,.ALIST)
 .I IEN>0 S TEMP=$$VDLGFIND^PXRMEXIU(ABBR,IEN,.ALIST) I TEMP<1 D
 ..S IEN=0
 ..S TEXT="ADDITIONAL FINDING  entry "_FINDING_" "_$S(TEMP=0:"is inactive.",1:" does not have codes marked to be used in a dialog.")
 .I IEN>0 S FDA(801.4118,IENS,.01)=ABBR_".`"_IEN
 . I IEN=0 D  Q:ACTION="Q"
 ..;Get replacement
 .. I TEXT="" S TEXT="ADDITIONAL FINDING entry "_FINDING_" does not exist."
 .. N DIC,DIR,DUOUT,MSG,X,Y
 .. S MSG(1)=" "
 .. S MSG(2)=TEXT
 .. D MES^XPDUTL(.MSG)
 .. S ACTION=$$GETACT^PXRMEXIU("DPQ",.DIR)
 .. I ACTION="S" S ACTION="Q"
 .. I ACTION="Q" Q
 .. I ACTION="D" K FDA(801.4118,IENS) Q
 .. S DIC=FILENUM
 .. S DIC(0)="AEMNQ"
 .. S DIC("S")="I $$FILESCR^PXRMDLG6(Y,FILENUM)=1"
 .. S Y=-1
 .. F  Q:+Y'=-1  D
 ...;If this is being called during a KIDS install we need echoing on.
 ... I $D(XPDNM) X ^%ZOSF("EON")
 ... D ^DIC
 ... I $D(XPDNM) X ^%ZOSF("EOFF")
 ... I $D(DUOUT) S Y="" Q
 ... I Y=-1 D BMES^XPDUTL("You must input a replacement!")
 .. I Y="" S ACTION="Q" Q
 .. S FINDING=ABBR_"."_$P(Y,U,2)
 .. S FDA(801.4118,IENS,.01)=FINDING
 . ;Save the finding information for the history.
 . I FINDING'=OFINDING D
 .. S ^TMP("PXRMEXIA",$J,"DIAF",$P(IENS,",",1),OFINDING)=FINDING
 . ;Convert ICD9 codes to `ien format
 . ;I $P(FINDING,".")="ICD9" S FDA(801.4118,IENS,.01)="ICD9."_$$ICD9(FINDING)
 ;
 I ACTION="Q" S PXRMDONE=1 Q
 ;Process DIALOG COMPONENT
 S IENS="",ACTION=""
 F  S IENS=$O(FDA(801.412,IENS)) Q:IENS=""  D  I ACTION="Q" K FDA S PXRMDONE=1 Q
 . S PT01=$G(FDA(801.412,IENS,2)) Q:PT01=""
 . S FILENUM=801.41,NEWNAM=$G(NAMECHG(FILENUM,PT01))
 .I NEWNAM'="" D
 .. S FDA(801.412,IENS,2)=NEWNAM,PT01=NEWNAM
 .S IEN=$$EXISTS^PXRMEXIU(FILENUM,PT01)
 .I IEN=0 D
 ..;Get replacement
 .. N DIC,DIR,DUOUT,MSG,X,Y
 .. S MSG(1)=" "
 .. S MSG(2)="COMPONENT DIALOG entry "_PT01_" does not exist."
 .. D MES^XPDUTL(.MSG)
 .. S ACTION=$$GETACT^PXRMEXIU("DPQ",.DIR)
 .. I ACTION="S" S ACTION="Q"
 .. I ACTION="Q" Q
 .. I ACTION="D" K FDA(801.412,IENS) Q
 .. S DIC=FILENUM
 .. S DIC(0)="AEMNQ"
 .. S DIC("S")="I ""EG""[$P(^PXRMD(801.41,Y,0),U,4)"
 .. S Y=-1
 .. F  Q:+Y'=-1  D
 ...;If this is being called during a KIDS install we need echoing on.
 ... I $D(XPDNM) X ^%ZOSF("EON")
 ... D ^DIC
 ... I $D(XPDNM) X ^%ZOSF("EOFF")
 ... I $D(DUOUT) S Y="" Q
 ... I Y=-1 D BMES^XPDUTL("You must input a replacement!")
 .. I Y="" S ACTION="Q" Q
 .. I Y'="" S FDA(801.412,IENS,2)=$P(Y,U,2)
 ;Process Result Groups
 F  S IENS=$O(FDA(801.41121,IENS)) Q:IENS=""  D  I ACTION="Q" K FDA S PXRMDONE=1 Q
 . S PT01=$G(FDA(801.41121,IENS,.01)) Q:PT01=""
 . S FILENUM=801.41,NEWNAM=$G(NAMECHG(FILENUM,PT01))
 .I NEWNAM'="" D
 .. S FDA(801.41121,IENS,2)=NEWNAM,PT01=NEWNAM
 .S IEN=$$EXISTS^PXRMEXIU(FILENUM,PT01)
 .I IEN=0 D
 ..;Get replacement
 .. N DIC,DIR,DUOUT,MSG,X,Y
 .. S MSG(1)=" "
 .. S MSG(2)="RESULT GROUP entry "_PT01_" does not exist."
 .. D MES^XPDUTL(.MSG)
 .. S ACTION=$$GETACT^PXRMEXIU("DPQ",.DIR)
 .. I ACTION="S" S ACTION="Q"
 .. I ACTION="Q" Q
 .. I ACTION="D" K FDA(801.41121,IENS) Q
 .. S DIC=FILENUM
 .. S DIC(0)="AEMNQ"
 .. S DIC("S")="I ""S""[$P(^PXRMD(801.41,Y,0),U,4)"
 .. S Y=-1
 .. F  Q:+Y'=-1  D
 ...;If this is being called during a KIDS install we need echoing on.
 ... I $D(XPDNM) X ^%ZOSF("EON")
 ... D ^DIC
 ... I $D(XPDNM) X ^%ZOSF("EOFF")
 ... I $D(DUOUT) S Y="" Q
 ... I Y=-1 D BMES^XPDUTL("You must input a replacement!")
 .. I Y="" S ACTION="Q" Q
 .. I Y'="" S FDA(801.41121,IENS,.01)=$P(Y,U,2)
 Q
 ;
 ;===============================================
 ;Convert ICD9 codes to `ien format
ICD9(CODE) ;
 N IEN
 S IEN=$$FIND1^DIC(80,"","AMX",$P(CODE,".",2,99))
 I 'IEN Q ""
 Q IEN
 ;
SETWARN(TEXT) ;
 S TEXT(1)="PREVIOUSLY THE DIALOG WAS SET TO BOTH CURRENT AND HISTORICAL ENCOUNTERS."
 S TEXT(2)="DIALOG IS NOW SET TO CURRENT ENCOUNTER ONLY."
 S TEXT(3)="REVIEW THE DIALOG BEFORE USING IN CPRS."
 Q
 ;
TAXARRAY(FINDING,CNT,ARRAY) ;
 ; add to code list to create a new taxonomy
 N CODE,CODESYS,IEN
 S CODESYS=$P(FINDING,"."),CODE=$P(FINDING,".",2,99)
 I $P(CODESYS,".")'["ICD9",$P(CODESYS,".")'["CPT" Q
 S CODESYSN=$S(CODESYS[9:"ICD",1:"CPT")
 S IEN=$$EXISTS^PXRMEXIU($S(CODESYSN="ICD":80,1:81),CODE)
 S CNT=CNT+1,ARRAY("CODE",CODESYSN,IEN)="I"_U_1
 Q
 ;
TAXCONV(FDA,IENS) ;
 ; FINDING ITEM FDA(801.41,IENS,15)
 ; ADDITIONAL FINDINGS FDA(801.4118,IENS)
 N ADDIENS,ARRAY,CNT,ERROR,FINDING,FINDS,ISFNDFLD,LAST,NAME,OCNT,TAX,TAXNAME,TEMP,TFINDS
 S ISFNDFLD=0,CNT=0
 ;if finding is taxonomy add the correct fields to the element
 S FINDING=$G(FDA(801.41,IENS,15))
 I $P(FINDING,".")="TX" D TAXCONV1(.FDA,IENS,FINDING) Q
 ;
 I FINDING'="" D
 .D TAXARRAY(FINDING,.CNT,.ARRAY)
 .;if array defined then finding has a code kill the node off.
 .I $D(ARRAY) S ISFNDFLD=1 K FDA(801.41,IENS,15)
 ;loop through additional findings
 S FINDS="" F  S FINDS=$O(FDA(801.4118,FINDS)) Q:FINDS=""  D
 . S FINDING=FDA(801.4118,FINDS,.01)
 . S OCNT=CNT D TAXARRAY(FINDING,.CNT,.ARRAY) I CNT>OCNT S TFINDS(FINDS)=""
 ;kill off additional findings that are codes
 S ADDIENS=""
 S FINDS="" F  S FINDS=$O(TFINDS(FINDS)) Q:FINDS=""  D
 .K FDA(801.4118,FINDS)
 .I ADDIENS="" S ADDIENS=FINDS
 I '$D(ARRAY) Q
 ;build values to crate a new taxonomy
 S NAME=$G(FDA(801.41,IENS,.01))
 S TEMP=$$RTAXNAME^PXRMDUTL(NAME)
 S ARRAY("NAME")=TEMP
 S ARRAY("COUNT")=CNT
 S ARRAY("CLASS")=$G(FDA(801.41,IENS,100))
 S ARRAY("SOURCE")="Exchange installed of dialog "_NAME
 ;create new taxonomy API
 S TAX=$$CRETAX^PXRMTXIM("E",.ARRAY,.ERROR)
 I $D(ERROR) D  Q
 .I $G(TAX)=0 D BMES^XPDUTL("ERROR: Taxonomy could not be created for dialog "_NAME_".") H 1 Q
 .D BMES^XPDUTL("ERROR: failed to add all the codes to the Taxonomy "_TEMP_". The codes that could not be added are:")
 .D BMES^XPDUTL(.ERROR)
 .H 1
 S TAXNAME=$P($G(^PXD(811.2,TAX,0)),U)
 D BMES^XPDUTL("Taxonomy "_TAXNAME_" created") H 1
 I ISFNDFLD=1 D  Q
 .S FDA(801.41,IENS,15)="TX.`"_TAX
 .S FDA(801.41,IENS,123)="NO PICK LIST"
 S FINDS=$O(FDA(801.4118,""),-1)
 S LAST=$O(FDA(801.44,""),-1) I LAST="" Q
 S TEMP=$P($P(LAST,"+",2),",")+1,TEMP="+"_TEMP
 S FDA(801.4118,ADDIENS,.01)="TX.`"_TAX
 Q
 ;
TAXCONV1(FDA,IENS,FINDING) ;
 N CNT,CPTSTATUS,DEFAULT,ENC,ENCTYPE,IEN,NODECNT,PROMPTS,POVSTATUS,START,TAX,TEXT,TAXIEN,TDX,TPR,TYPE,VALUE,X
 ;if taxonomy fields defined then quit
 I ($G(FDA(801.41,IENS,123))'="") Q
 ;if group set to not display a pick list.
 I FDA(801.41,IENS,4)["group" S FDA(801.41,IENS,123)="N" Q
 S TAX=$P(FINDING,".",2)
 S FDA(801.41,IENS,123)="ALL"
 ;
 S TAXIEN=$O(^PXD(811.2,"B",TAX,"")) I TAXIEN'>0 Q
 ;determine Taxonomy Type
 S TDX=$$TOK^PXRMDTAX(TAXIEN,"POV")
 S TPR=$$TOK^PXRMDTAX(TAXIEN,"CPT")
 D SETWARN(.TEXT)
 ;build default array for taxonomy
 S CPTSTATUS=$$GETSTAT^PXRMDTAX("CPT"),POVSTATUS=$$GETSTAT^PXRMDTAX("POV")
 I TDX=1 D GETTAXDF^PXRMDTAX(.DEFAULT,"POV",$S(POVSTATUS=2:1,1:0))
 I TPR=1 D GETTAXDF^PXRMDTAX(.DEFAULT,"CPT",$S(CPTSTATUS=2:1,1:0))
 I TDX,TPR D
 .I CPTSTATUS=POVSTATUS,POVSTATUS=2 S FDA(801.41,IENS,13)="2" Q
 .S FDA(801.41,IENS,13)="@"
 .I CPTSTATUS=0!(POVSTATUS=0) D BMES^XPDUTL(.TEXT)
 I TDX,TPR=0 D
 .I POVSTATUS=2 S FDA(801.41,IENS,13)="2" Q
 .S FDA(801.41,IENS,13)="@" I POVSTATUS=0 D BMES^XPDUTL(.TEXT)
 I TDX=0,TPR=1 D
 .I CPTSTATUS=2 S FDA(801.41,IENS,13)="2" Q
 .S FDA(801.41,IENS,13)="@" I CPTSTATUS=0 D BMES^XPDUTL(.TEXT)
 S NODECNT=$O(FDA(801.44,""),-1) I NODECNT="" Q
 ;
 ;build encounter tax field
 F TYPE="POV","CPT" D
 .I TYPE="POV",TDX=0 Q
 .I TYPE="CPT",TPR=0 Q
 .I TYPE="POV" S X=141
 .I TYPE="CPT" S X=142
 .S VALUE=$$ADDTAXF1^PXRMDTAX(TYPE,.DEFAULT)
 .S FDA(801.41,IENS,X)=VALUE
 .;
 .;build prompt array from default list
 .S TYPE="" F  S TYPE=$O(DEFAULT(TYPE)) Q:TYPE=""  D
 ..;I TPR=0,CODE="CPT" Q
 ..;I TDX=0,CODE="POV" Q
 ..S CNT=0 F  S CNT=$O(DEFAULT(TYPE,"ADDFIND",CNT)) Q:CNT'>0  D
 ...S NODE=DEFAULT(TYPE,"ADDFIND",CNT),IEN=$P(NODE,U)
 ...I $D(PROMPTS(IEN))>0 I $L(PROMPTS(IEN),U)<$L(NODE,U) S PROMPTS(IEN)=NODE
 ...S PROMPTS(IEN)=NODE
 ;
 I $G(FDA(801.41,IENS,122))="YES" K FDA(801.41,IENS,122) Q
 I $D(FDA(801.412)) Q
 ;
 ;add prompts to the dialog element.
 S START=0,IEN=0,CNT=0,DNUM=0
 S IEN=0,CNT=0 F  S IEN=$O(PROMPTS(IEN)) Q:IEN'>0  D
 .S START=START+1,DNUM=DNUM+1
 .S NAME=$P($G(^PXRMD(801.41,IEN,0)),U)
 .S NODE=PROMPTS(IEN),CNT=$L(NODE,U)
 .I $P(NODE,U,3)>0 Q
 .S NODECNT=NODECNT+1
 .S FDA(801.412,"+"_NODECNT_","_IENS,.01)=START
 .S FDA(801.412,"+"_NODECNT_","_IENS,2)="`"_IEN
 .I CNT=1 Q
 .F NUM=2:1:CNT D
 ..S VALUE=$P(NODE,U,NUM) I $G(VALUE)="" Q
 ..S FIELD=$S(NUM=2:9,NUM=4:.01,NUM=5:6,NUM=6:7,NUM=7:8,1:"") I $G(FIELD)="" Q
 ..I FIELD>6 S VALUE=$S(VALUE=1:"YES",1:"NO")
 ..S FDA(801.412,"+"_NODECNT_","_IENS,FIELD)=VALUE
 Q
 ;
 ;===============================================
TIURPL(SRCH,WP,NAMEGHC,FILENUM) ;Replace TIU templates whose names have
 ;changed.
 N IND,RS,TEXT,TS,TYPE
 I FILENUM=8927.1 S TYPE="TIU TEMPLATE"
 E  S TYPE="TIU OBJECT"
 S IND=1
 F  S TEXT=$G(@WP@(IND)) Q:TEXT=""  D
 .I TEXT[SRCH D
 ..S TS=""
 ..F  S TS=$O(NAMECHG(FILENUM,TS)) Q:TS=""  D
 ...S RS=NAMECHG(FILENUM,TS) Q:TEXT'[TS
 ...S @WP@(IND)=$$STRREP^PXRMUTIL(TEXT,TS,RS)
 ...;Save the replacement information for the history.
 ...S ^TMP("PXRMEXIA",$J,"DIATIU",TYPE,TS)=RS
 ...S ^TMP("PXRMEXIA",$J,"DIATIU",TYPE,TS,DNAM)=""
 .S IND=IND+1
 Q
 ;
