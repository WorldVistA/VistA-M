MXMLDOM ;SAIC/DKM - XML Parser - DOM model ;02/27/2002  13:24
 ;;7.3;TOOLKIT;**58**;Apr 25, 1995
 ;=================================================================
 ; This acts as an intermediate client between the event-based XML
 ; parser and a client requiring an in-memory document model.
EN(DOC,OPTION) ;
 N CBK,SUCCESS,LEVEL,NODE,HANDLE
 K ^TMP("MXMLERR",$J)
 L +^TMP("MXMLDOM",$J):5
 E  Q 0
 S HANDLE=$O(^TMP("MXMLDOM",$J,""),-1)+1,^(HANDLE)=""
 L -^TMP("MXMLDOM",$J)
 S CBK("STARTELEMENT")="STARTELE^MXMLDOM"
 S CBK("ENDELEMENT")="ENDELE^MXMLDOM"
 S CBK("COMMENT")="COMMENT^MXMLDOM"
 S CBK("CHARACTERS")="CHAR^MXMLDOM"
 S CBK("ENDDOCUMENT")="ENDDOC^MXMLDOM"
 S CBK("ERROR")="ERROR^MXMLDOM"
 S (SUCCESS,LEVEL,LEVEL(0),NODE)=0,OPTION=$G(OPTION,"V1")
 D EN^MXMLPRSE(DOC,.CBK,OPTION)
 D:'SUCCESS DELETE(HANDLE)
 Q $S(SUCCESS:HANDLE,1:0)
 ; Start element
 ; Create new child node and push info on stack
STARTELE(ELE,ATTR) ;
 N PARENT
 S PARENT=LEVEL(LEVEL),NODE=NODE+1
 S:PARENT ^TMP("MXMLDOM",$J,HANDLE,PARENT,"C",NODE)=ELE
 S LEVEL=LEVEL+1,LEVEL(LEVEL)=NODE,LEVEL(LEVEL,0)=ELE
 S ^TMP("MXMLDOM",$J,HANDLE,NODE)=ELE,^(NODE,"P")=PARENT
 M ^("A")=ATTR
 Q
 ; End element
 ; Pops element stack
ENDELE(ELE) ;
 K LEVEL(LEVEL)
 S LEVEL=LEVEL-1
 Q
 ; Comment data
COMMENT(TXT) ;
 D TXT("X")
 Q
 ; Character data
CHAR(TXT) ;
 D TXT("T")
 Q
 ; Store comment or character data
TXT(SUB) N X,Y,Z
 S Y=$O(^TMP("MXMLDOM",$J,HANDLE,LEVEL(LEVEL),SUB,""),-1)
 I Y>0,($L($G(^(Y)))+$L(TXT)>200)!($G(BGN)["CDATA") S Y=Y+1 ;*rwf
 S:'Y Y=1
 F Z=$L(TXT,$C(10)):-1:1 Q:TXT=""  D
 .S X=$P(TXT,$C(10)),TXT=$P(TXT,$C(10),2,9999)
 .S ^(Y)=$G(^(Y))_X
 .S:Z>1 Y=Y+1 ;*rwf old .S:Z>1 Y=Y+1,^(Y)=""
 Q
 ; End of document
ENDDOC S SUCCESS=1
 Q
 ;Error reporting
ERROR(ERR) ;
 N CNT
 S CNT=1+$G(^TMP("MXMLERR",$J)),^($J)=CNT
 M ^TMP("MXMLERR",$J,CNT)=ERR
 Q
 ;
 ; Below are the external API calls for the interface
 ;
 ; Delete document instance
DELETE(HANDLE) ;
 K ^TMP("MXMLDOM",$J,HANDLE)
 Q
 ; Name of element at node
NAME(HANDLE,NODE) ;
 Q $G(^TMP("MXMLDOM",$J,HANDLE,NODE))
 ; Node of next child
CHILD(HANDLE,PARENT,CHILD) ;
 Q +$O(^TMP("MXMLDOM",$J,HANDLE,PARENT,"C",+$G(CHILD)))
 ; Node of next sibling
SIBLING(HANDLE,NODE) ;
 Q +$O(^TMP("MXMLDOM",$J,HANDLE,$$PARENT(HANDLE,NODE),"C",NODE))
 ; Parent of node
PARENT(HANDLE,NODE) ;
 Q +$G(^TMP("MXMLDOM",$J,HANDLE,NODE,"P"))
 ; Text associated with node
TEXT(HANDLE,NODE,RTN) ;
 D GETTXT("T")
 Q:$Q $D(@RTN)>1
 Q
 ; Comment associate with node
CMNT(HANDLE,NODE,RTN) ;
 D GETTXT("X")
 Q:$Q $D(@RTN)>1
 Q
 ; Retrieve text or comment
GETTXT(SUB) ;
 K @RTN
 M @RTN=^TMP("MXMLDOM",$J,HANDLE,NODE,SUB)
 Q
 ; Retrieve next attribute
ATTRIB(HANDLE,NODE,ATTR) ;
 Q $O(^TMP("MXMLDOM",$J,HANDLE,NODE,"A",$G(ATTR)))
 ; Retrieve attribute value
VALUE(HANDLE,NODE,ATTR) ;
 Q $G(^TMP("MXMLDOM",$J,HANDLE,NODE,"A",ATTR))
