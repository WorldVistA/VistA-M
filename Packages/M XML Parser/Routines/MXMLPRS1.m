MXMLPRS1 ;SAIC/DKM - XML Parser ;12/04/2002  15:55
 ;;7.3;TOOLKIT;**58,67**;Apr 25, 1995
 ;=================================================================
 ; Initialize tables
INIT N X,Y,Z
 F X=0:1 S Y=$P($T(ENTITIES+X),";;",2,99) Q:'$L(Y)  D
 .D SETENT^MXMLPRSE($P(Y,";"),$P(Y,";",2,99))
 F X=0:1 S Y=$P($T(DTDTAG+X),";;",2,99) Q:'$L(Y)  D
 .S DTD($P(Y,";"))=$P(Y,";",2)
 F X=0:1 S Y=$P($T(TYPE+X),";;",2,99) Q:'$L(Y)  D
 .S ^TMP(ID,$J,"TYP",$P(Y,";",2))=+Y
 F X=0:1 S Y=$P($T(MOD+X),";;",2,99) Q:'$L(Y)  D
 .S ^TMP(ID,$J,"MOD",$P(Y,";",2))=+Y
 F X=0:1 S Y=$P($T(REF+X),";;",2,99) Q:'$L(Y)  D
 .S ^TMP(ID,$J,"REF",$P(Y,";",2))=+Y
 F X=0:1 S Y=$P($T(CBKARGS+X),";;",2,99) Q:'$L(Y)  D
 .S ^TMP(ID,$J,"CBK",$P(Y,";",2))=+Y
 F X=0:1 S Y=$P($T(PROLOG+X),";;",2,99) Q:'$L(Y)  D
 .S Z=$P(Y,";"),^TMP(ID,$J,"ATT","?xml",Z)="1^"_$S('X:1,1:2)
 .F  S Y=$P(Y,";",2,99) Q:'$L(Y)  S ^TMP(ID,$J,"ATT","?xml",Z,$P(Y,";"))=""
 Q
 ; Search parse tree for child element (CHILD) under parent element
 ; (ELEMENT) starting at specified node (NODE).
 ; Returns next node # in parse tree or 0
 ; If validation is disabled, the function always returns 1.
 ; If parent element is marked as EMPTY, 0 is returned.
 ; If parent element is marked as ANY, 1 is returned.
ISCHILD(ELEMENT,CHILD,NODE) ;
 N TRN
 S TRN=+$G(^TMP(ID,$J,"ELE",ELEMENT),2)
 Q $S(OPTION'["V"!'NODE:1,TRN=1:CHILD="*",TRN=2:1,1:$$IC(NODE))
IC(NODE) N X,Y
 S X=+$G(^TMP(ID,$J,"ELE",ELEMENT,NODE,CHILD)),Y=0
 I 'X D
 .F  S Y=$O(^TMP(ID,$J,"ELE",ELEMENT,NODE,Y)) Q:'Y  D  Q:X
 ..S:'$D(TRN(NODE,Y)) TRN(NODE,Y)="",X=$$IC(Y)
 Q X
 ; Check attribute value for validity
CHKVAL(ENAME,ANAME,VALUE) ;
 N TYPE,X,Y,Z
 Q:'$L(VALUE)
 I $D(^TMP(ID,$J,"ATT",ENAME,ANAME))>1 D:'$D(^(ANAME,VALUE)) ERROR(38,VALUE) Q
 S TYPE=+$G(^TMP(ID,$J,"ATT",ENAME,ANAME))
 Q:'TYPE
 I TYPE=5 D  Q                                                         ; ID type
 .I '$$ISNAME(VALUE) D ERROR(38,VALUE) Q
 .I '$D(^TMP(ID,$J,"ID",VALUE)) D
 ..S ^(VALUE)=""
 ..D NOFWD("ID",VALUE)
 .E  D ERROR(28,VALUE)
 I TYPE=9!(TYPE=10) D  Q                                               ; ENTITY/ENTITIES type
 .S X=$S(TYPE=9:"  ",1:" ")
 .F Z=1:1:$L(VALUE,X) D FWD("UNP",$P(VALUE,X,Z))
 I TYPE=3!(TYPE=4) D  Q                                                ; NMTOKEN/NMTOKENS type
 .S X=$S(TYPE=3:"  ",1:" ")
 .F Z=1:1:$L(VALUE,X) D
 ..S Y=$P(VALUE,X,Z)
 ..D:'$$ISNMTKN(Y) ERROR(38,Y)
 I TYPE=6!(TYPE=7) D  Q                                                ; IDREF/IDREFS type
 .S X=$S(TYPE=6:"  ",1:" ")
 .F Z=1:1:$L(VALUE,X) D
 ..S Y=$P(VALUE,X,Z)
 ..I '$$ISNAME(Y) D ERROR(38,Y) Q
 ..D FWD("ID",Y)
 Q
 ; Return true if valid name
ISNAME(VALUE) ;
 Q VALUE?1(1A,1"_",1":").(1AN,1".",1"-",1"_",1":")
 ; Return true if valid name token
ISNMTKN(VALUE) ;
 Q VALUE?1.(1AN,1".",1"-",1"_",1":")
 ; Log a forward reference
FWD(TYPE,VALUE) ;
 Q:'$L(VALUE)
 Q:$D(^TMP(ID,$J,TYPE,VALUE))
 N Z
 S Z=$O(^TMP(ID,$J,"REF",TYPE,VALUE,""),-1)+1
 M ^(Z)=ERR
 Q
 ; Resolve forward reference
NOFWD(TYPE,VALUE) ;
 K ^TMP(ID,$J,"REF",TYPE,VALUE)
 Q
 ; Signal unresolved references
UNRESLV N X,Y,Z,E
 F X=1:1:LVL D
 .K ERR
 .M ERR=LVL(X)
 .D ERROR(8,LVL(X))
 S X=""
 F  S X=$O(^TMP(ID,$J,"REF",X)),Y="" Q:'$L(X)  D                           ; Look for IDREF w/o corresponding ID value
 .S E=^(X)
 .F  S Y=$O(^TMP(ID,$J,"REF",X,Y)),Z=0 Q:'$L(Y)  D
 ..F  S Z=$O(^TMP(ID,$J,"REF",X,Y,Z)) Q:'Z  D
 ...K ERR
 ...M ERR=^(Z)
 ...D ERROR(E,Y)
 Q
 ; Log error
ERROR(X,Y) D ERROR^MXMLPRSE(.X,.Y) Q
 ; Predefined general entities
 ; Format=entity name;entity value
ENTITIES ;;amp;&#38;
 ;;lt;&#60;
 ;;gt;>
 ;;quot;&#34;
 ;;apos;'
 ;;
 ; Callback events
 ; Format=#args;event type
CBKARGS ;;0;STARTDOCUMENT
 ;;0;ENDDOCUMENT
 ;;3;DOCTYPE
 ;;1;CHARACTERS
 ;;2;STARTELEMENT
 ;;1;ENDELEMENT
 ;;3;NOTATION
 ;;2;PI
 ;;1;COMMENT
 ;;3;EXTERNAL
 ;;1;ERROR
 ;;
 ; Prolog attributes
 ; Format=attribute name;val1;val2;...;valn
PROLOG ;;version;1.0
 ;;encoding;UTF-8;utf-8
 ;;standalone;no;yes
 ;;
 ; Recognized DTD tags
 ; Format=tag name;state
DTDTAG ;;ENTITY;20
 ;;ELEMENT;30
 ;;ATTLIST;40
 ;;NOTATION;50
 ;;[;60
 ;;
 ; Attribute types
 ; Format=identifier;type
TYPE ;;1;(
 ;;2;CDATA
 ;;3;NMTOKEN
 ;;4;NMTOKENS
 ;;5;ID
 ;;6;IDREF
 ;;7;IDREFS
 ;;8;NOTATION
 ;;9;ENTITY
 ;;10;ENTITIES
 ;;
 ; Default modifiers
 ; Format=identifier;modifier
MOD ;;1;#REQUIRED
 ;;2;#IMPLIED
 ;;3;#FIXED
 ;;
 ; Forward references
 ; Format=type;error #;type
REF ;;49;UNP
 ;;46;NOT
 ;;26;ELE
 ;;47;ID
 ;;
