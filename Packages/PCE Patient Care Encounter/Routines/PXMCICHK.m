PXMCICHK ;SLC/PKR - Search for and display inactive mapped codes. ;04/12/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;==========================================
CSU(TYPE) ;Entry point for code set update, called by CPTE and ICDE^PXCSPE.
 N IND,NL,PTYPE,SUBJECT,TEXT,TMPNODE
 S PTYPE=$S(TYPE="CPT":"a CPT",TYPE="ICD":"an ICD")
 S TMPNODE="PXINMC"
 D MCICHK(TMPNODE,.TEXT)
 K ^TMP("PXXMZ",$J)
 S ^TMP("PXXMZ",$J,1,0)="There was "_PTYPE_" code set update on "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S ^TMP("PXXMZ",$J,2,0)="Please review the affected code mappings and take appropriate action."
 S ^TMP("PXXMZ",$J,3,0)=""
 S IND=0,NL=3
 F  S IND=+$O(TEXT(IND)) Q:IND=0  S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=TEXT(IND)
 S SUBJECT="PCE inactive mapped codes report"
 D SEND^PXMSG("PXXMZ",SUBJECT)
 Q
 ;
 ;==========================================
BROWSE ;Display the inactive mapped codes in the Browser.
 N TEXT,TMPNODE,X
 S TMPNODE="PXINMC"
 D MCICHK(TMPNODE,.TEXT)
 S X="IORESET"
 D ENDR^%ZISS
 D BROWSE^DDBR("TEXT","NR","Inactive Mapped Codes")
 W IORESET
 D KILL^%ZISS
 K ^TMP($J,TMPNODE)
 Q
 ;
 ;==========================================
EDU(NODE) ;Search Education Topics for mapped codes that are inactive and
 ;produce a list.
 N CODE,CODESYS,IEN,INACTDT,IND,NAME,TEMP
 S NAME=""
 F  S NAME=$O(^AUTTEDT("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTEDT("B",NAME,""))
 . I '$D(^AUTTEDT(IEN,210)) Q
 . S IND=0
 . F  S IND=+$O(^AUTTEDT(IEN,210,IND)) Q:IND=0  D
 .. S TEMP=^AUTTEDT(IEN,210,IND,0)
 .. S CODESYS=$P(TEMP,U,1),CODE=$P(TEMP,U,2)
 .. I CODE'="" D
 ... S INACTDT=$$INACTDT(CODESYS,CODE)
 ... I INACTDT'="" S ^TMP($J,NODE,"EDU",NAME,IEN,CODESYS,CODE)=INACTDT
 Q
 ;
 ;==========================================
EXAM(NODE) ;Search Exams for mapped codes that are inactive and produce a list.
 N CODE,CODESYS,IEN,INACTDT,IND,NAME,TEMP
 S NAME=""
 F  S NAME=$O(^AUTTEXAM("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTEXAM("B",NAME,""))
 . I '$D(^AUTTEXAM(IEN,210)) Q
 . S IND=0
 . F  S IND=+$O(^AUTTEXAM(IEN,210,IND)) Q:IND=0  D
 .. S TEMP=^AUTTEXAM(IEN,210,IND,0)
 .. S CODESYS=$P(TEMP,U,1),CODE=$P(TEMP,U,2)
 .. I CODE'="" D
 ... S INACTDT=$$INACTDT(CODESYS,CODE)
 ... I INACTDT'="" S ^TMP($J,NODE,"EXAM",NAME,IEN,CODESYS,CODE)=INACTDT
 Q
 ;
 ;==========================================
HF(NODE) ;Search Health Factors for mapped codes that are inactive and produce
 ;a list.
 N CODE,CODESYS,IEN,INACTDT,IND,NAME,TEMP
 S NAME=""
 F  S NAME=$O(^AUTTHF("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTHF("B",NAME,""))
 . I '$D(^AUTTHF(IEN,210)) Q
 . S IND=0
 . F  S IND=+$O(^AUTTHF(IEN,210,IND)) Q:IND=0  D
 .. S TEMP=^AUTTHF(IEN,210,IND,0)
 .. S CODESYS=$P(TEMP,U,1),CODE=$P(TEMP,U,2)
 .. I CODE'="" D
 ... S INACTDT=$$INACTDT(CODESYS,CODE)
 ... I INACTDT'="" S ^TMP($J,NODE,"HF",NAME,IEN,CODESYS,CODE)=INACTDT
 Q
 ;
 ;==========================================
IMM(NODE) ;Search Immunizations for mapped codes that are inactive and produce
 ;a list.
 N CODE,CODESYS,IEN,INACTDT,IND,JND,NAME,TEMP
 S NAME=""
 F  S NAME=$O(^AUTTIMM("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTIMM("B",NAME,""))
 . S IND=0
 . F  S IND=+$O(^AUTTIMM(IEN,3,IND)) Q:IND=0  D
 .. S CODESYS=^AUTTIMM(IEN,3,IND,0)
 .. S JND=0
 .. F  S JND=+$O(^AUTTIMM(IEN,3,IND,1,JND)) Q:JND=0  D
 ... S CODE=^AUTTIMM(IEN,3,IND,1,JND,0)
 ... S INACTDT=$$INACTDT(CODESYS,CODE)
 ... I INACTDT'="" S ^TMP($J,NODE,"IMM",NAME,IEN,CODESYS,CODE)=INACTDT
 Q
 ;
 ;==========================================
INACTDT(CODESYS,CODE) ;Given a coding system and a code, check and if the
 ;code is inactive return the inactivation date otherwise return null.
 N ACTDT,INACTDT,RESULT,PDATA
 S RESULT=$$PERIOD^LEXU(CODE,CODESYS,.PDATA)
 I +RESULT=-1 D
 .;DBIA #1997, #3991
 . I (CODESYS="CPC")!(CODESYS="CPT") D PERIOD^ICPTAPIU(CODE,.PDATA)
 . I (CODESYS="ICD")!(CODESYS="ICP") D PERIOD^ICDAPIU(CODE,.PDATA)
 S ACTDT=1000101,INACTDT=""
 F  S ACTDT=$O(PDATA(ACTDT)) Q:(ACTDT="")!(INACTDT'="")  D
 . S INACTDT=$P(PDATA(ACTDT),U,1)
 Q INACTDT
 ;
 ;==========================================
MCICHK(TMPNODE,TEXT) ;Search Education Topics, Exams, Health Factors,
 ;Immunizations, and Skin Tests for mapped codes that are inactive
 ;and produce a list.
 N CODE,CODESYS,FILE,FNAME,IEN,INACTDT,NAME,NL
 S FNAME("EDU")="EDUCATION TOPICS",FNAME("EXAM")="EXAM"
 S FNAME("HF")="HEALTH FACTORS",FNAME("IMM")="IMMUNIZATION"
 S FNAME("SKIN")="SKIN TEST"
 K ^TMP($J,TMPNODE)
 D EDU(TMPNODE),EXAM(TMPNODE),HF(TMPNODE),IMM(TMPNODE),SKIN(TMPNODE)
 ;Create the report.
 S FILE="",NL=0
 F  S FILE=$O(^TMP($J,TMPNODE,FILE)) Q:FILE=""  D
 . I NL>0 S NL=NL+1,TEXT(NL)="",NL=NL+1,TEXT(NL)="-----------------------------"
 . S NL=NL+1,TEXT(NL)=FNAME(FILE)_" inactive mapped codes."
 . S NAME=""
 . F  S NAME=$O(^TMP($J,TMPNODE,FILE,NAME)) Q:NAME=""  D
 .. S IEN=$O(^TMP($J,TMPNODE,FILE,NAME,""))
 .. S NL=NL+1,TEXT(NL)=""
 .. S NL=NL+1,TEXT(NL)=" "_NAME_" (IEN="_IEN_")"
 .. S CODESYS=""
 .. F  S CODESYS=$O(^TMP($J,TMPNODE,FILE,NAME,IEN,CODESYS)) Q:CODESYS=""  D
 ... S CODE=""
 ... F  S CODE=$O(^TMP($J,TMPNODE,FILE,NAME,IEN,CODESYS,CODE)) Q:CODE=""  D
 .... S INACTDT=^TMP($J,TMPNODE,FILE,NAME,IEN,CODESYS,CODE)
 .... S NL=NL+1,TEXT(NL)="  "_CODESYS_" "_CODE_", inactivated: "_$$FMTE^XLFDT(INACTDT,"5Z")
 K ^TMP($J,TMPNODE)
 Q
 ;
 ;==========================================
SKIN(NODE) ;Search Skin Tests for mapped codes that are inactive and produce
 ;a list.
 N CODE,CODESYS,IEN,INACTDT,IND,JND,NAME,TEMP
 S NAME=""
 F  S NAME=$O(^AUTTSK("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTSK("B",NAME,""))
 . S IND=0
 . F  S IND=+$O(^AUTTSK(IEN,3,IND)) Q:IND=0  D
 .. S CODESYS=^AUTTSK(IEN,3,IND,0)
 .. S JND=0
 .. F  S JND=+$O(^AUTTSK(IEN,3,IND,1,JND)) Q:JND=0  D
 ... S CODE=^AUTTSK(IEN,3,IND,1,JND,0)
 ... S INACTDT=$$INACTDT(CODESYS,CODE)
 ... I INACTDT'="" S ^TMP($J,NODE,"SKIN",NAME,IEN,CODESYS,CODE)=INACTDT
 Q
 ;
