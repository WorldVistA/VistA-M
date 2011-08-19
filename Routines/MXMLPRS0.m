MXMLPRS0 ;SAIC/DKM - XML Parser ;03/09/2005  12:57
 ;;7.3;TOOLKIT;**58,89**;Apr 25, 1995
 ;=================================================================
 ; State 0: Prolog
0 N ATTR
 S ST=1
 D WS()
 I '$$NEXT("<?xml") D ERROR(31) Q
 D WS(1),ATTRIBS("?xml",.ATTR),WS()
 I $$NEXT("?>",3)
 D:$G(ATTR("version"))'="1.0" ERROR(10,$G(ATTR("version")))
 Q
 ; State 1: Document type declaration
1 N PUB,SYS
 D WS()
 Q:$$COMMENT
 S ST=2
 I '$$NEXT("<!DOCTYPE") D ERROR(32) Q
 D WS(1)
 S LVL(0)=$$NAME(2),DTD=""
 D WS(),SYSPUB(.SYS,.PUB)
 I OPTION["V",$L(SYS)!$L(PUB) D
 .S DTD=$$EXTRNL(SYS,PUB)
 D WS(),CBK("DOCTYPE",LVL(0),PUB,SYS)
 I $$NEXT("[") S ST=5
 E  S:$$NEXT(">",3) ST=6
 Q
 ; State 2: Non-markup text
2 N TXT,CHR
 D:'LVL WS()
 S TXT=""
 F  S CHR=$E(XML,CPOS) Q:"<"[CHR!EOD  D
 .I $$NEXT("&") S TXT=TXT_$$ENTITY
 .E  S TXT=TXT_CHR,CPOS=CPOS+1
 S:CHR="<" ST=3
 I $L(TXT) D
 .I 'LVL D ERROR(6) Q
 .I '$$ISCHILD(LVL(LVL),"#PCDATA",1) D:$L($TR(TXT,WS)) ERROR(27) Q
 .D CBK("CHARACTERS",TXT)
 Q
 ; State 3: Markup text
3 N END,ENAME,ATTR
 S ST=2
 Q:$$COMMENT
 Q:$$CDATA
 Q:$$PI
 Q:'$$NEXT("<",3)
 S END=$$NEXT("/"),ENAME=$$NAME(2)
 Q:'$L(ENAME)
 I 'END D
 .S:LVL LVL(LVL,"N")=$$ISCHILD(LVL(LVL),ENAME,LVL(LVL,"N"))
 .D:'LVL(LVL,"N") ERROR(24,ENAME)
 .D ATTRIBS(ENAME,.ATTR),CBK("STARTELEMENT",ENAME,.ATTR),WS()
 .D READ ;*89 Check for more data
 .S END=$$NEXT("/"),LVL=LVL+1
 .M LVL(LVL)=ERR
 .S LVL(LVL)=ENAME,LVL(LVL,"N")=1
 .I LVL=1 D
 ..I $D(LVL(0))#2,LVL(0)'=ENAME D ERROR(15,ENAME) Q
 ..I '$D(LVL(-1)) S LVL(-1)=""
 ..E  D ERROR(45,ENAME)
 I END D
 .I LVL>0,$G(LVL(LVL))=ENAME D
 ..D:'$$ISCHILD(ENAME,"*",LVL(LVL,"N")) ERROR(25)
 ..D CBK("ENDELEMENT",ENAME)
 ..K LVL(LVL)
 ..S LVL=LVL-1
 .E  D ERROR(5,ENAME)
 I $$NEXT(">",3)
 Q
 ; State 5: Internal or external DTD
5 N X,Y
 D DOPARAM
 Q:$$COMMENT
 I CS,$$NEXT("]]>") S CS=CS-1 Q
 I $$NEXT("]") D  Q
 .S ST=6
 .D WS()
 .I $$NEXT(">",3)
 Q:'$$NEXT("<!",3)
 S X=$S($$NEXT("["):"[",1:$$NAME(2))
 Q:'$L(X)
 I $G(DTD(X)) S ST=$$WS(X'="["),ST=DTD(X)
 E  D ERROR(16,X)
 Q
 ; State 6: Check for external DTD
6 S ST=2
 Q:OPTION'["V"
 I $G(DTD)'="" D  Q
 .D OPNDOC(DTD,,"]>"),0
 .S ST=5,DTD=""
 D:CS ERROR(42)
 Q
 ; State 8: End of DTD declaration
8 D WS()
 I $$NEXT(">",3)
 S ST=5
 Q
 ; State 20: DTD ENTITY declaration
20 N SYS,PUB,ENAME,TYP,DUP,Z
 I $$NEXT("%"),$$WS(1) S TYP=2
 E  S TYP=1
 S ENAME=$$NAME(2)
 Q:'$L(ENAME)
 S ST=8,ENAME=$S(TYP=2:"%",1:"")_ENAME,DUP=$D(^TMP(ID,$J,"ENT",ENAME))
 D NOFWD("UNP",ENAME),ERROR(18,ENAME):DUP,WS(1)
 I $$SYSPUB(.SYS,.PUB) D
 .D WS()
 .I TYP=1,$$NEXT("NDATA") D
 ..D WS(1)
 ..S Z=$$NAME(2)
 ..Q:'$L(Z)
 ..D FWD("NOT",Z)
 ..S:'DUP ^TMP(ID,$J,"ENT",ENAME)="",^TMP(ID,$J,"UNP",ENAME)=Z
 .E  D:'DUP
 ..S Z=$$EXTRNL(SYS,PUB)
 ..S:$L(Z) ^TMP(ID,$J,"ENT",ENAME)=Z
 E  D
 .S Z=$$VALUE(1,TYP)
 .D:'DUP SETENT(ENAME,Z)
 Q
 ; State 30: DTD ELEMENT declaration
 ; Builds a parse tree for child elements
30 N STK,ELEMENT,CHILD,START,END,MIXED,X,Z
 D DOPARAM
 S ELEMENT=$$NAME(2),ST=8
 Q:'$L(ELEMENT)
 Q:'$$WS(1)
 I $D(^TMP(ID,$J,"ELE",ELEMENT)) D ERROR(20,ELEMENT) Q
 D NOFWD("ELE",ELEMENT)
 S Z=$S($$NEXT("EMPTY"):1,$$NEXT("ANY"):2,1:0),^TMP(ID,$J,"ELE",ELEMENT)=Z
 Q:Z
 S STK=0,MIXED=0,START=1,END=2
 ; Check for opening parenthesis
LPAREN D DOPARAM
 I MIXED<2 D
 .F  D WS() Q:'$$NEXT("(",$S(STK:0,1:3))  S STK(STK)=START,STK=STK+1
 ; Element name, parameter entity, or #PCDATA
 D DOPARAM
 I 'MIXED,$$NEXT("#PCDATA") S CHILD="#PCDATA",MIXED=2
 E  S CHILD=$$NAME(2),MIXED=$S('MIXED:1,MIXED=2:3,1:MIXED) Q:'$L(CHILD)  D FWD("ELE",CHILD)
 I $D(STK(-1,CHILD)) D ERROR(23,CHILD) Q
 S STK(-1,CHILD)="",^TMP(ID,$J,"ELE",ELEMENT,START,CHILD)=END
 S:CHILD="#PCDATA" ^(END)=""
 G:MIXED>1 SEQOPR
 ; Check for repetition modifier
REPMOD S X=$S($$NEXT("*",$S(MIXED=3:3,1:0)):2,MIXED>1:0,$$NEXT("+"):1,$$NEXT("?"):3,1:0)
 S:X=1 ^TMP(ID,$J,"ELE",ELEMENT,END,START)=""
 S:X=2 ^TMP(ID,$J,"ELE",ELEMENT,END,START)="",^TMP(ID,$J,"ELE",ELEMENT,START,END)=""
 S:X=3 ^TMP(ID,$J,"ELE",ELEMENT,START,END)=""
 ; Check for sequence operator
SEQOPR D WS()
 S X=$S($$NEXT("|"):2,MIXED=2:0,$$NEXT(","):1,1:0)
 I X D  G LPAREN
 .S:'$D(STK(STK,0)) STK(STK,0)=X
 .D:STK(STK,0)'=X ERROR(22,$E(",|",X))
 .S:X=1 START=END,END=END+1
 D WS()
 I '$$NEXT(")",$S(STK:3,1:0)) D  Q
 .S ^TMP(ID,$J,"ELE",ELEMENT,END,"*")=-1
 I 'STK D ERROR(21) Q
 K STK(STK)
 S STK=STK-1,START=STK(STK)
 G REPMOD
 ; State 40: DTD ATTLIST declaration
40 N ELEMENT,ATTRIB,TYPE,DFLT,DUP,X,Y
 D DOPARAM
 S ELEMENT=$$NAME(2)
 Q:'$L(ELEMENT)
 Q:'$$WS(1)
 D FWD("ELE",ELEMENT)
 ; Attribute name
ATTNAME D DOPARAM
 S ATTRIB=$$NAME(2)
 Q:'$L(ATTRIB)
 S DUP=$D(^TMP(ID,$J,"ATT",ELEMENT,ATTRIB))
 D ERROR(4,ATTRIB):DUP,WS(1)
 ; Attribute type
 S TYPE=$$FNDTKN("TYP")
 I 'TYPE D ERROR(33) Q
 S:'DUP ^TMP(ID,$J,"ATT",ELEMENT,ATTRIB)=TYPE
 D WS(TYPE'=1),NOTN:TYPE=8,ENUM:TYPE=1,WS()
 ; Default modifier
 S DFLT=$$FNDTKN("MOD")
 S:'DUP $P(^TMP(ID,$J,"ATT",ELEMENT,ATTRIB),"^",2)=DFLT,Y=$G(^("#ID"))
 I TYPE=5 D                                                            ; If ID type
 .D:DFLT=3 ERROR(34)
 .I '$L(Y) S:'DUP ^TMP(ID,$J,"ATT",ELEMENT,"#ID")=ATTRIB
 .E  D ERROR(35,Y)
 ; Default value
 I DFLT=3!'DFLT D
 .D:DFLT WS(1)
 .S X=$$VALUE(1)
 .Q:DUP
 .S $P(^TMP(ID,$J,"ATT",ELEMENT,ATTRIB),"^",3)=X
 .D CHKVAL(ELEMENT,ATTRIB,X)
 ; Next attribute or end of declaration
 D WS()
 G:'$$NEXT(">") ATTNAME
 S ST=5
 Q
 ; Search for a token of the specified group
 ; GRP=Group id
 ; Returns token id within group or 0 if none found
FNDTKN(GRP) ;
 N TKN
 S TKN=""
 F  S TKN=$O(^TMP(ID,$J,GRP,TKN),-1) Q:$$NEXT(TKN)
 Q $S($L(TKN):^TMP(ID,$J,GRP,TKN),1:0)
 ; Enumerated attribute type
ENUM F  D WS() S X=$$NAMETKN(3) Q:'$L(X)  D  Q:'$$NEXT("|")
 .D:TYPE=8 FWD("NOT",X)
 .S ^TMP(ID,$J,"ATT",ELEMENT,ATTRIB,X)=""
 .D WS()
 I $$NEXT(")",3)
 Q
 ; NOTATION attribute type
NOTN D ENUM:$$NEXT("(",3)
 Q
 ; State 50: DTD NOTATION declaration
50 N NAME,SYS,PUB,DUP
 S NAME=$$NAME(3),ST=8
 Q:'$L(NAME)
 Q:'$$WS(1)
 S DUP=$D(^TMP(ID,$J,"NOT",NAME))
 D NOFWD("NOT",NAME),ERROR(48,NAME):DUP
 I '$$SYSPUB(.SYS,.PUB,1) D ERROR(39) Q
 Q:DUP
 S ^TMP(ID,$J,"NOT",NAME,1)=SYS,^(2)=PUB
 D CBK("NOTATION",NAME,SYS,PUB)
 Q
 ; State 60: Conditional sections
60 N CSTYPE,CSCNT,DLM
 D DOPARAM
 S CSTYPE=$S($$NEXT("INCLUDE"):1,$$NEXT("IGNORE"):2,1:0),ST=5
 I 'CSTYPE D ERROR(41) Q
 I DOCSTK=1 D ERROR(44) Q
 D WS()
 Q:'$$NEXT("[",3)
 I CSTYPE=1 S CS=CS+1 Q
 S CSCNT=1,DLM=""
 F  D  Q:'CSCNT!EOD
 .I $L(DLM),$$NEXT(DLM) S DLM=""
 .E  I $L(DLM) S CPOS=CPOS+1
 .E  I $$NEXT(QT) S DLM=QT
 .E  I $$NEXT("'") S DLM="'"
 .E  I $$NEXT("<![") S CSCNT=CSCNT+1
 .E  I $$NEXT("]]>") S CSCNT=CSCNT-1
 .E  S CPOS=CPOS+1
 .D:CPOS>LLEN READ
 D:CSCNT ERROR(42)
 Q
 ;Local Functions moved from MXMLPRSE
 ; Execute event callback (if defined)
 ; EVT=Event name
 ; Pn=Parameters
CBK(EVT,P1,P2,P3,P4) ;
 Q:EOD<0
 N EN,PNUM
 S EN=$G(CBK(EVT))
 Q:EN=""
 S PNUM=^TMP(ID,$J,"CBK",EVT)
 D @(EN_$P("(.P1,.P2,.P3,.P4",",",1,PNUM)_$S('PNUM:"",1:")"))
 Q
 ; Save current document location for error reporting
 ; See EPOS^MXMLPRSE
EPOS S ERR("XML")=XML,ERR("POS")=CPOS,ERR("LIN")=LPOS
 Q
 ; Check next characters
 ; SEQ=character sequence
 ; ERN=Error to signal if not found (optional)
NEXT(SEQ,ERN) ;
 I SEQ=$E(XML,CPOS,CPOS+$L(SEQ)-1) S CPOS=CPOS+$L(SEQ) Q 1
 D:$G(ERN) EPOS^MXMLPRSE,ERROR(ERN,SEQ)
 Q 0
 ; Skip whitespace
 ; ERN=Error to signal if not found (optional)
 ; Optional return value =1 if whitespace found, 0 if not.
WS(ERN) N CHR,FND
 D EPOS^MXMLPRSE
 S FND=0
 F  D:CPOS>LLEN READ S CHR=$E(XML,CPOS) Q:WS'[CHR!EOD  D
 .S ERN=0,CPOS=CPOS+1,FND=1
 D:$G(ERN) ERROR(ERN)
 Q:$Q FND
 Q
 ; Shortcuts to functions/procedures defined elsewhere
ATTRIBS(X,Y) D ATTRIBS^MXMLPRSE(.X,.Y) Q
CDATA() Q $$CDATA^MXMLPRSE
CHKVAL(X,Y,Z) D CHKVAL^MXMLPRS1(.X,.Y,.Z) Q
COMMENT() Q $$COMMENT^MXMLPRSE
DOPARAM G DOPARAM^MXMLPRSE
ENTITY(X) Q $$ENTITY^MXMLPRSE(.X)
ERROR(X,Y) D ERROR^MXMLPRSE(.X,.Y) Q
EXTRNL(X,Y,Z) Q $$EXTRNL^MXMLPRSE(.X,.Y,.Z)
FWD(X,Y) D FWD^MXMLPRS1(.X,.Y) Q
ISCHILD(X,Y,Z) Q $$ISCHILD^MXMLPRS1(.X,.Y,.Z)
NAME(X) Q $$NAME^MXMLPRSE(.X)
NAMETKN(X) Q $$NAMETKN^MXMLPRSE(.X)
NOFWD(X,Y) D NOFWD^MXMLPRS1(.X,.Y) Q
OPNDOC(X,Y,Z) D OPNDOC^MXMLPRSE(.X,.Y,.Z) Q
PI() Q $$PI^MXMLPRSE
SETENT(X,Y) D SETENT^MXMLPRSE(.X,.Y) Q
SYSPUB(X,Y,Z) Q:$Q $$SYSPUB^MXMLPRSE(.X,.Y,.Z)
 D SYSPUB^MXMLPRSE(.X,.Y) Q
READ G READ^MXMLPRSE
VALUE(X,Y) Q $$VALUE^MXMLPRSE(.X,.Y)
