PXRMINQ ; SLC/PKR/PJH - Clinical Reminder inquiry routines. ;11/28/2008
 ;;2.0;CLINICAL REMINDERS;**4,12**;Feb 04, 2005;Build 73
 ;
 ;====================================================
CF ;Do computed finding inquiry.
 N FLDS,HEADER,PXRMROOT,STEXT
 S FLDS="[PXRM COMPUTED FINDING INQUIRY]"
 S HEADER="REMINDER COMPUTED FINDING INQUIRY"
 S PXRMROOT="^PXRMD(811.4,"
 S STEXT="Select COMPUTED FINDING: "
 D SELLOOP(PXRMROOT,FLDS,HEADER,STEXT)
 Q
 ;
 ;====================================================
DISP(DIC,FLDS) ;Display detail.
 N L
 S L=0
 D EN1^DIP
 Q
 ;
 ;====================================================
HEADER(TEXT) ;Display Header (see DHD variable).
 N TEMP,TEXTLEN,TEXTUND
 S TEXTUND=$TR($J("",IOM)," ","-")
 S TEMP=NOW_"  Page "_DC
 S TEXTLEN=$L(TEMP)
 W TEXT
 W ?(IOM-TEXTLEN),TEMP
 W !,TEXTUND,!!
 Q
 ;
 ;====================================================
LOCLIST ;Do location list inquiry.
 N FLDS,HEADER,PXRMEDOK,PXRMROOT,STEXT
 S PXRMEDOK=1
 S FLDS="[PXRM LOCATION LIST INQUIRY]"
 S HEADER="REMINDER LOCATION LIST INQUIRY"
 S PXRMROOT="^PXRMD(810.9,"
 S STEXT="Select LOCATION LIST: "
 D SELLOOP(PXRMROOT,FLDS,HEADER,STEXT)
 Q
 ;
 ;====================================================
REM ;Do reminder inquiry.
 N FLDS,HEADER,PXRMFVPL,PXRMROOT,STEXT
 ;Build the finding variable pointer information.
 D BLDRLIST^PXRMVPTR(811.902,.01,.PXRMFVPL)
 S FLDS="[PXRM DEFINITION INQUIRY]"
 S HEADER="REMINDER DEFINITION INQUIRY"
 S PXRMROOT="^PXD(811.9,"
 S STEXT="Select REMINDER DEFINITION: "
 D SELLOOP(PXRMROOT,FLDS,HEADER,STEXT)
 Q
 ;
 ;====================================================
REMVAR(VAR,IEN) ;Do reminder inquiry for reminder IEN, return formatted
 ;output in VAR. VAR can be either a local variable or a global.
 ;If it is a local it is indexed for the broker. If it is a global
 ;it should be passed in closed form i.e., ^TMP("PXRMTEST",$J).
 ;It will be returned formatted for ListMan i.e.,
 ;^TMP("PXRMTEST",$J,N,0).
 N %ZIS,BY,DC,DHD,DONE,FF,FILENAME,FILESPEC,FLDS,FR,GBL,HFNAME
 N IND,IOP,NOW,PATH,PXRMFVPL,PXRMROOT,SUCCESS,TO,UNIQN
 ;Build the finding variable pointer information.
 D BLDRLIST^PXRMVPTR(811.902,.01,.PXRMFVPL)
 S FLDS="[PXRM DEFINITION INQUIRY]"
 S PXRMROOT="^PXD(811.9,"
 D SET(IEN,"")
 ;Make sure the PXRM WORKSTATION device exists.
 D MKWSDEV^PXRMHOST
 ;Set up the output file before DIP is called.
 S PATH=$$PWD^%ZISH
 S NOW=$$NOW^XLFDT
 S NOW=$TR(NOW,".","")
 S UNIQN=$J_NOW
 S FILENAME="PXRMWSD"_UNIQN_".DAT"
 S HFNAME=PATH_FILENAME
 S IOP="PXRM WORKSTATION;80"
 S %ZIS("HFSMODE")="W"
 S %ZIS("HFSNAME")=HFNAME
 D DISP(PXRMROOT,FLDS)
 ;Move the host file into a global.
 S GBL="^TMP(""PXRMINQ"",$J,1,0)"
 S GBL=$NA(@GBL)
 K ^TMP("PXRMINQ",$J)
 S SUCCESS=$$FTG^%ZISH(PATH,FILENAME,GBL,3)
 ;Look for a form feed, remove it and all subsequent lines.
 S FF=$C(12)
 I $G(VAR)["^" D
 . S VAR=$NA(@VAR)
 . S VAR=$P(VAR,")",1)
 . S VAR=VAR_",IND,0)"
 . S (DONE,IND)=0
 . F  Q:DONE  S IND=$O(^TMP("PXRMINQ",$J,IND)) Q:+IND=0  D
 .. I ^TMP("PXRMINQ",$J,IND,0)=FF S DONE=1 Q
 .. S @VAR=^TMP("PXRMINQ",$J,IND,0)
 E  D
 . S (DONE,IND)=0
 . F  Q:DONE  S IND=$O(^TMP("PXRMINQ",$J,IND)) Q:+IND=0  D
 .. S VAR(IND)=^TMP("PXRMINQ",$J,IND,0)
 .. I VAR(IND)=FF S DONE=1
 K ^TMP("PXRMINQ",$J)
 ;Delete the host file.
 S FILESPEC(FILENAME)=""
 S SUCCESS=$$DEL^%ZISH(PATH,$NA(FILESPEC))
 Q
 ;
 ;====================================================
SELECT(ROOT,PROMPT,DEFAULT) ;Select the entry.
 N DIC,DTOUT,DUOUT,Y
 S DIC=ROOT
 S DIC(0)="AEMQ"
 S DIC("A")=PROMPT
 I $G(DEFAULT)'="" S DIC("B")=DEFAULT
 D ^DIC
 Q Y
 ;
 ;====================================================
SELLOOP(PXRMROOT,FLDS,HEADER,STEXT) ;Selection loop.
 N BY,DC,DHD,FR,IENN,NOW,TO
 S IENN=0
 F  Q:IENN=-1  D
 . S IENN=$$SELECT(PXRMROOT,STEXT,"")
 . I IENN=-1 Q
 . D SET(IENN,HEADER)
 . D DISP(PXRMROOT,FLDS)
 Q
 ;
 ;====================================================
SET(Y,TEXT) ;Set data for entry selection and the header.
 ;These variables need to be setup every time because DIP kills them.
 ;They are newed in the calling routine.
 S BY="NUMBER"
 S (FR,TO)=+$P(Y,U,1)
 ;If TEXT is null then no header.
 I $L(TEXT)>0 D
 . S NOW=$$NOW^XLFDT
 . S NOW=$$FMTE^XLFDT(NOW,"1P")
 . S DHD="W ?0 D HEADER^PXRMINQ("""_TEXT_""")"
 E  S DHD="@@"
 Q
 ;
 ;====================================================
SPONSOR ;Do sponsor inquiry.
 N FLDS,HEADER,PXRMEDOK,PXRMROOT,STEXT
 S PXRMEDOK=1
 S FLDS="[PXRM SPONSOR INQUIRY]"
 S HEADER="REMINDER SPONSOR INQUIRY"
 S PXRMROOT="^PXRMD(811.6,"
 S STEXT="Select REMINDER SPONSOR: "
 D SELLOOP(PXRMROOT,FLDS,HEADER,STEXT)
 Q
 ;
 ;====================================================
TAX ;Do taxonomy inquiry.
 N FLDS,HEADER,PXRMROOT,STEXT
 S FLDS="[PXRM TAXONOMY INQUIRY]"
 S HEADER="REMINDER TAXONOMY INQUIRY"
 S PXRMROOT="^PXD(811.2,"
 S STEXT="Select REMINDER TAXONOMY: "
 D SELLOOP(PXRMROOT,FLDS,HEADER,STEXT)
 Q
 ;
 ;====================================================
TERM ;Do term inquiry.
 N FLDS,HEADER,PXRMFVPL,PXRMROOT,STEXT
 ;Build the finding variable pointer information
 D BLDRLIST^PXRMVPTR(811.52,.01,.PXRMFVPL)
 S FLDS="[PXRM TERM INQUIRY]"
 S HEADER="REMINDER TERM INQUIRY"
 S PXRMROOT="^PXRMD(811.5,"
 S STEXT="Select REMINDER TERM: "
 D SELLOOP(PXRMROOT,FLDS,HEADER,STEXT)
 Q
 ;
