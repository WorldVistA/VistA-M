PXRMEXU4 ; SLC/PJH,PKR - Reminder Exchange #4, dialog changes. ;06/30/2009
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ;===============================================
DLG(FDA,NAMECHG) ;Check the dialog for renamed entries, called by
 ;silent installer. KIDSDONE is newed in INSDLG^PXRMEXSI.
 N ABBR,ACTION,ALIST,DNAM,IEN,IENS,ISACT,FILENUM,FINDING,NEWNAM,OFINDING
 N ORITEM,OORITEM,PT01,RESULT,RRG,SRC,TEXT,WP
 S IENS=$O(FDA(801.41,""))
 ;Definition .01
 S (PT01,DNAM)=FDA(801.41,IENS,.01)
 I $D(NAMECHG(801.41,PT01)) D
 .S (FDA(801.41,IENS,.01),DNAM)=NAMECHG(801.41,PT01)
 ;
 ;Build list of finding types
 D BLDALIST^PXRMVPTR(801.4118,.01,.ALIST)
 ;Plus field 15 files
 ;S ALIST("MH")=601,ALIST("TX")=811.2
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
 ;Process FINDING ITEM
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
 .I IEN>0,$$VDLGFIND^PXRMEXIU(ABBR,IEN,.ALIST)=0 D
 ..S IEN=0
 ..S TEXT="FINDING  entry "_FINDING_" is inactive."
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
 .I $P(FINDING,".")="ICD9" S FDA(801.41,IENS,15)="ICD9."_$$ICD9(FINDING)
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
 .I IEN>0,$$VDLGFIND^PXRMEXIU(ABBR,IEN,.ALIST)=0 D
 ..S IEN=0
 ..S TEXT="ADDITIONAL FINDING  entry "_FINDING_" is inactive."
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
 . I $P(FINDING,".")="ICD9" S FDA(801.4118,IENS,.01)=$$ICD9(FINDING)
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
 Q "`"_IEN
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
