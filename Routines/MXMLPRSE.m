MXMLPRSE ;SAIC/DKM - XML Parser ;09/08/08  11:50
 ;;7.3;TOOLKIT;**58,67,89,116**;Apr 25, 1995;Build 1
 ;=================================================================
 ; Main entry point.
 ; DOC = Closed reference to global array containing document
 ; CBK = Local array containing entry points for callback interface
 ; OPTION = Option flags; expected values are:
 ;   D = Debug mode
 ;   W = Do not report warnings
 ;   V = Validate (checks only well-formedness by default)
 ;   0,1 = Terminate on encountering error at specified level
EN(DOC,CBK,OPTION) ;
 N WS,ID,QT,EDC,DTD,LVL,CS,DOCSTK,LLEN,LPOS,CPOS,LCUR,ERR,XML,PFX,SFX,EOD,EOG,ST,PATH,OFX
 S ID=$T(+0),WS=$C(9,10,13,32),QT="""",(DOCSTK,EOG,EOD,LVL,CS,ST,LPOS,LLEN,LCUR)=0,(CPOS,LVL(0,"N"))=1,OPTION=$G(OPTION),(XML,PFX,SFX)="",PATH=$$PATH(DOC)
 K ^TMP(ID,$J)
 I $L($T(TOUCH^XUSCLEAN)) D TOUCH^XUSCLEAN ;Set the keepalive node
 D INIT^MXMLPRS1,EPOS,CBK("STARTDOCUMENT"),OPNDOC(DOC)
 F  Q:EOD  D READ,EPOS,@ST^MXMLPRS0:'EOD
 D UNRESLV^MXMLPRS1,ERROR(17):ST'=2,CBK("ENDDOCUMENT")
 K ^TMP(ID,$J)
 Q
 ; Open a document
 ; Saves state of current document on stack.
 ; DOCREF=Closed reference to array containing document
 ; PREFIX=Optional prefix to prepend to document
 ; SUFFIX=Optional suffix to append to document
OPNDOC(DOCREF,PREFIX,SUFFIX) ;
 S:$E(DOCREF)'="^" DOCREF=$$EXTRNL(DOCREF)
 Q:'$L(DOCREF)
 D SAVRES(1)
 S DOC=$NA(@DOCREF)
 I '$D(^TMP(ID,$J,"DOC",DOC)) S ^(DOC)=""
 E  D ERROR(43)
 S (LPOS,LLEN,LCUR)=0,CPOS=1,(OFX,XML)="",PFX=$G(PREFIX),SFX=$G(SUFFIX)
 S LCUR=DOC,DOC=$E(DOC,1,$L(DOC)-1) ;*rwf
 Q
 ; Close current document
 ; Restores state of previous document from stack.
CLSDOC K ^TMP(ID,$J,"DOC",DOC_")") ;*rwf
 D SAVRES(0)
 Q
 ; Extract path from filespec
PATH(DOC) ;
 N X
 Q:U[$E(DOC) ""
 F X="\","/","]",":","" Q:DOC[X
 Q $P(DOC,X,1,$L(DOC,X)-1)_X
 ; Save or restore document state
SAVRES(SAVE) ;
 N X
 S:'SAVE DOCSTK=DOCSTK-1,EOD=DOCSTK=0
 I DOCSTK F X="LLEN","LPOS","CPOS","LCUR","XML","PFX","SFX","OFX","DOC" D
 .I SAVE S DOCSTK(DOCSTK,X)=@X
 .E  S @X=DOCSTK(DOCSTK,X)
 I SAVE S DOCSTK=DOCSTK+1
 E  K DOCSTK(DOCSTK)
 Q
 ; Retrieve text from document
READ Q:((LLEN-CPOS)>50)!EOD  ;Quit if still have 50 char or EOD
 I (CPOS'<LLEN)&EOG D CLSDOC S EOG=0 Q  ;At end of text in file
 N TMP,X
 D SHIFT Q:$L(XML)>50
 I EOG!EOD Q  ;Quit at end of document
 S LPOS=LPOS+1,LCUR=$Q(@LCUR) ;Get next node
 I LCUR'[DOC S EOG=1 Q  ;At end of global
 S TMP=@LCUR ;Get next data chunk
 W:OPTION["D" !,$J(LPOS,3)_":",TMP,!
 S OFX=OFX_TMP
 D SHIFT
 I LLEN<50 G READ
 Q
 ;Shift OFX to XML
SHIFT ;
 S XML=$E(XML,CPOS,9999),CPOS=1 ;Drop old
 I $L(PFX) S OFX=XML_OFX,XML=PFX,PFX=""
 I $L(OFX) S X=511-$L(XML),XML=XML_$E(OFX,1,X),OFX=$E(OFX,X+1,99999)
 S LLEN=$L(XML)
 Q
 ; Parse name
 ; ERN=Error to signal if invalid (optional)
NAME(ERN) ;
 N X
 D EPOS
 S X=$E(XML,CPOS)
 I X'?1A,"_:"'[X D:$G(ERN) ERROR(ERN,X) Q ""
 Q $$NAMETKN(.ERN)
 ; Parse name token
 ; ERN=Error to signal if invalid (optional)
NAMETKN(ERN) ;
 N X,Y
 D EPOS
 F X=CPOS:1:LLEN+1 S Y=$E(XML,X) I Y'?1AN,".-_:"'[Y Q
 S Y=$E(XML,CPOS,X-1),CPOS=X
 I '$L(Y),$G(ERN) D ERROR(ERN,Y)
 Q Y
 ; Parse quote-enclosed value
 ; ERF=If set, signal error if not found
 ; FLG=Special flag: 0=attribute literal, 1=general entity literal
 ;     2=parameter entity literal
 ; Returns value less quotes with normalized whitespace
VALUE(ERF,FLG) ;
 N DLM,CHR,RTN,EXC
 D WS()
 S DLM=$S($$NEXT(QT):QT,$$NEXT("'"):"'",1:""),RTN="",FLG=+$G(FLG),EXC=$S(FLG=2:"",1:"<")
 I DLM="" D:$G(ERF) EPOS,ERROR(11) Q RTN
 F  S CHR=$E(XML,CPOS) Q:DLM=CHR!(EXC[CHR)!EOD  D
 .I $$NEXT("&#") S RTN=RTN_$$CHENTITY
 .E  I 'FLG,$$NEXT("&") S RTN=RTN_$$ENTITY
 .E  S RTN=RTN_CHR,CPOS=CPOS+1
 .D:CPOS>LLEN READ
 I DLM=CHR S CPOS=CPOS+1
 E  D EPOS,ERROR($S('$L(CHR):12,EXC[CHR:13,1:12)) Q ""
 Q $$NMLWS(RTN)
 ; Normalize whitespace
 ; Note: used as input transform for Entity Catalog, so can't depend
 ; on any environment variables.
 ; TXT=Text to normalize
 ; Returns text stripped of leading and trailing whitespace and with
 ; imbedded contiguous whitespace reduced to single space.
NMLWS(TXT,FG) ;
 N Z,CRLF
 S CRLF=$C(13,10)
 ;Normalize CRLF to one SP first
 F  S Z=$F(TXT,CRLF) Q:'Z  S TXT=$P(TXT,CRLF,1)_" "_$P(TXT,CRLF,2,999)
 S TXT=$TR(TXT,$C(9,10,13,32),"    ")
 ;For CDATA or unk, this is where we should stop
 Q:'$G(FG) TXT
 F Z=1:1 Q:$E(TXT,Z)'=" "
 S TXT=$E(TXT,Z,9999)
 F Z=$L(TXT):-1 Q:$E(TXT,Z)'=" "
 S TXT=$E(TXT,1,Z)
 F Z=1:1:$L(TXT) D:$E(TXT,Z)=" "
 .F  Q:$E(TXT,Z+1)'=" "  S $E(TXT,Z+1)=""
 Q TXT
 ; Process parameter entity if found
DOPARAM F  D WS() Q:EOD!'$$NEXT("%")  I $$ENTITY(1)
 Q
 ; Resolve general/parameter/character entity
 ; PARAM=1: parameter; PARAM=0: general or character (default)
ENTITY(PARAM) ;
 N NAME,APND
 S PARAM=+$G(PARAM)
 I 'PARAM,$$NEXT("#") Q $$CHENTITY
 S NAME=$S(PARAM:"%",1:"")_$$NAME(2)
 Q:'$$NEXT(";",3) ""
 ;Handle the common ones inline
 S APND=$S(NAME="amp":"&",NAME="lt":"<",NAME="gt":">",NAME="quot":$C(34),NAME="apos":"'",1:"")
 Q:$L(APND) APND
 I $D(^TMP(ID,$J,"UNP",NAME)) D ERROR(40,NAME) Q ""
 I '$D(^TMP(ID,$J,"ENT",NAME)) D ERROR(14,NAME) Q ""
 S APND=$S(PARAM:" ",1:"")
 D OPNDOC(^TMP(ID,$J,"ENT",NAME),APND,APND)
 Q ""
 ; Parse character entity reference
 ; Returns character equivalent
CHENTITY() ;
 N DIGIT,BASE,DIGITS,VAL
 S BASE=$S($$NEXT("x"):16,1:10),DIGITS="0123456789"_$S(BASE=16:"ABCDEF",1:""),VAL=0
 F CPOS=CPOS:1:LLEN+1 Q:$$NEXT(";")!EOD  D
 .S DIGIT=$F(DIGITS,$$UP^XLFSTR($E(XML,CPOS)))-2,VAL=VAL*BASE+DIGIT
 .D:DIGIT<0 ERROR(19)
 I VAL<32,WS'[$C(VAL) D ERROR(19)
 Q $C(VAL)
 ; Set an entity value
SETENT(NAME,VAL) ;
 K ^TMP(ID,$J,"ENT",NAME)
 S ^(NAME)=$NA(^(NAME)),^(NAME,1)=VAL
 Q
 ; Process all attributes
ATTRIBS(ENAME,ATTR) ;
 N TYP,MOD,DEF,ANAME
 K ATTR
 F  Q:'$$ATTRIB(ENAME,.ATTR)
 I OPTION["V" D
 .S ANAME="$"
 .F  S ANAME=$O(^TMP(ID,$J,"ATT",ENAME,ANAME)) Q:'$L(ANAME)  D
 ..S TYP=^(ANAME),MOD=$P(TYP,"^",2),DEF=$P(TYP,"^",3,9999),TYP=+TYP
 ..I MOD=1!(MOD=3),'$D(ATTR(ANAME)) D ERROR(36,ANAME) Q
 ..I MOD=3,ATTR(ANAME)'=DEF D ERROR(37,ATTR(ANAME)) Q
 ..I MOD=2,'$D(ATTR(ANAME)) Q
 ..S:'$D(ATTR(ANAME)) ATTR(ANAME)=DEF
 Q
 ; Parse attribute=value sequence
 ; ENAME=Element name to which attribute belongs
 ; ATTR=Local array (by reference) to receive attribute value.
 ;      Format is ATTR("<attribute name>")="<attribute value>"
 ; Returns 1 if successful, 0 if not.
ATTRIB(ENAME,ATTR) ;
 N ANAME
 D READ,WS() ;p116
 S ANAME=$$NAME
 Q:ANAME="" 0
 I $D(ATTR(ANAME)) D ERROR(4,ANAME) Q 0
 D:'$D(^TMP(ID,$J,"ATT",ENAME,ANAME)) ERROR(29,ANAME)
 D READ,WS() ;p116
 Q:'$$NEXT("=",3) 0
 D WS()
 S ATTR(ANAME)=$$VALUE(1)
 D CHKVAL^MXMLPRS1(ENAME,ANAME,ATTR(ANAME))
 Q 1
 ; Parse a processing instruction
 ; Returns 1 if PI found, 0 if not.
PI() N PNAME,ARGS,DONE
 Q:'$$NEXT("<?") 0
 S PNAME=$$NAME(2),ARGS=0
 I $$UP^XLFSTR(PNAME)="XML" D ERROR(9) Q 0
 D WS(1)
 F  S DONE=$F(XML,"?>",CPOS) D  Q:DONE!EOD
 .S ARGS=ARGS+1,ARGS(ARGS)=$E(XML,CPOS,$S(DONE:DONE-3,1:LLEN))
 .S CPOS=$S(DONE:DONE,1:LLEN+1)
 .D READ
 I EOD D ERROR(7) Q 0
 D CBK("PI",PNAME,.ARGS)
 Q 1
 ; Parse a comment
 ; Returns 1 if comment found, 0 if not.
COMMENT() Q $$PARSCT("<!--","--",">","COMMENT")
 ; Parse a CDATA section
 ; Returns 1 if found, 0 if not.
CDATA() Q $$PARSCT("<![CDATA[","]]>","","CHARACTERS")
 ; Parse a section (for CDATA and COMMENT)
 ; BGN=Beginning delimiter
 ; END=Ending delimiter
 ; TRL=Trailing delimiter
 ; TYP=Event type
PARSCT(BGN,END,TRL,TYP) ;
 N X
 Q:'$$NEXT(BGN) 0
 D EPOS
 I 'LVL,TYP'="COMMENT" D ERROR(6) Q 0
 F  S X=$F(XML,END,CPOS) D  Q:X!EOD
 .D CBK(TYP,$E(XML,CPOS,$S(X:X-$L(END)-1,1:LLEN)))
 .S CPOS=$S(X:X,1:LLEN+1)
 .D READ,EPOS
 I EOD D ERROR(7) Q 0
 I $L(TRL),$$NEXT(TRL,3)
 Q 1
 ; Fetch an external entity from file or entity catalog
 ; SYS=System identifier (i.e., a URL)
 ; PUB=Public identifier (i.e., Entity Catalog ID) - optional
 ; GBL=Optional global root to receive entity content
 ; Returns global reference or null if error
EXTRNL(SYS,PUB,GBL) ;
 N X,Y
 S PUB=$$NMLWS($G(PUB)),GBL=$G(GBL)
 I '$L(GBL) D CBK("EXTERNAL",.SYS,.PUB,.GBL) Q:$L(GBL) GBL
 I $L(PUB) D  Q:X $NA(^MXML(950,X,1))
 .S Y=$E(PUB,1,30),X=0
 .F  S X=$O(^MXML(950,"B",Y,X)) Q:'X  Q:$G(^MXML(950,X,0))=PUB
 S:'$L(GBL) GBL=$$TMPGBL
 S:$$PATH(SYS)="" SYS=PATH_SYS
 S X=$S($$FTG^%ZISH(SYS,"",$NA(@GBL@(1)),$QL(GBL)+1):GBL,1:"")
 D:'$L(X) ERROR(30,$S($L(SYS):SYS,1:PUB))
 Q X
 ; Return a unique scratch global reference
TMPGBL() N SUB
 S SUB=$O(^TMP(ID,$J,$C(1)),-1)+1,^(SUB)=""
 Q $NA(^(SUB))
 ; Returns a SYSTEM and/or PUBLIC id
 ; SYS=Returned SYSTEM id
 ; PUB=Returned PUBLIC id
 ; FLG=If set, SYSTEM id is optional after PUBLIC id
 ; Optional return value: 0=neither, 1=PUBLIC, 2=SYSTEM
SYSPUB(SYS,PUB,FLG) ;
 N RTN
 I $$NEXT("PUBLIC") D
 .D WS(1)
 .S PUB=$$VALUE(1),SYS=$$VALUE('$G(FLG)),RTN=1
 E  I $$NEXT("SYSTEM") D
 .D WS(1)
 .S PUB="",SYS=$$VALUE(1),RTN=2
 E  S (SYS,PUB)="",RTN=0
 Q:$Q RTN
 Q
 ; Save current document location for error reporting
 ; See EPOS^MXMLPRS0
EPOS S ERR("XML")=XML,ERR("POS")=CPOS,ERR("LIN")=LPOS
 Q
 ; Setup error information
ERROR(ERN,ARG) ;
 N DIHELP,DIMSG,DIERR,MSG
 D BLD^DIALOG(9500000+ERN,"","","MSG","")
 S ERR("NUM")=ERN
 S ERR("SEV")=$S($G(DIHELP):0,$G(DIMSG):1,1:2)
 S ERR("MSG")=$G(MSG(1))
 S ERR("ARG")=$G(ARG)
 I OPTION'["W"!ERR("SEV"),OPTION["V"!(ERR("SEV")'=1) D CBK("ERROR",.ERR)
 S:ERR("SEV")=2!(OPTION[ERR("SEV")) EOD=-1                             ; Stop parsing on severe error
 Q
 ; Shortcuts to functions/procedures defined elsewhere
WS(X) Q:$Q $$WS^MXMLPRS0(.X)
 D WS^MXMLPRS0(.X) Q
CBK(X,Y1,Y2,Y3,Y4) D CBK^MXMLPRS0(.X,.Y1,.Y2,.Y3,.Y4) Q
NEXT(X,Y) Q $$NEXT^MXMLPRS0(.X,.Y)
