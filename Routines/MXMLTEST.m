MXMLTEST ;SAIC/DKM - Test XML SAX interface ;01/31/2002  17:11
 ;;7.3;TOOLKIT;**58**;Apr 25, 1995
 ;=================================================================
 ; This application acts as a client to the XML parser.  It displays
 ; parsing events as they occur and generates a summary at the end.
EN(DOC,OPTION) ;
 N CBK,CNT
 W !!!,"Invoking XML Parser...",!!!
 D SET(.CBK),EN^MXMLPRSE(DOC,.CBK,.OPTION)
 S CNT=""
 W !!!,"Parser Summary:",!!
 F  S CNT=$O(CNT(CNT)) Q:CNT=""  W CNT,":",?25,CNT(CNT),!
 Q
 ; Direct entry of XML text from keyboard
 ; Terminate text entry with a solitary '^'
PASTE(OPTION) ;
 N X,Y,GBL
 S GBL=$NA(^TMP("MXMLTEST",$J))
 K @GBL
 F X=1:1 D  Q:Y="^"
 .W X,"> "
 .R Y:$G(DTIME,600),!
 .E  S Y="^"
 .S:Y'="^" @GBL@(X)=Y
 D EN(GBL,.OPTION)
 K @GBL
 Q
 ; Set the event interface entry points
SET(CBK) N X,Y
 K CBK
 F X=0:1 S Y=$P($T(SETX+X),";;",2) Q:Y=""  D
 .S CBK(Y)=$E(Y,1,8)_"^MXMLTEST"
 Q
 ; Convert special characters to \x format
ESC(X) N C,Y,Z
 F Z=1:1 S C=$E(X,Z) Q:C=""  D
 .S Y=$TR(C,$C(9,10,13,92),"tnc")
 .S:C'=Y $E(X,Z)=$S(Y="":"\\",1:"\"_Y),Z=Z+1
 Q X
SETX ;;STARTDOCUMENT
 ;;ENDDOCUMENT
 ;;DOCTYPE
 ;;STARTELEMENT
 ;;ENDELEMENT
 ;;CHARACTERS
 ;;PI
 ;;ERROR
 ;;COMMENT
 ;;EXTERNAL
 ;;NOTATION
 ;;
 ; Event interface callbacks
STARTDOC ;
ENDDOCUM W EVT,"()",!
 Q
DOCTYPE(P1,P2,P3) ;
 W EVT,"(""",P1,""",""",P2,""",""",P3,""")",!
 Q
STARTELE(ELE,ATR) ;
 D ARGS(ELE,.ATR),COUNT("Elements")
 Q
ARGS(ELE,ATR) ;
 N X,Y
 W EVT,"(""",ELE,""""
 S X="",Y=","""
 F  S X=$O(ATR(X)) Q:X=""  W Y,X,"=",$$ESC(ATR(X)) S Y=";"
 W $S($L(Y)=1:""")",1:")"),!
 Q
ENDELEME(ELE) ;
 W EVT,"(""",ELE,""")",!
 Q
CHARACTE(TXT) ;
 D COUNT("Non-markup Content",$L(TXT))
 W EVT,"(""",$$ESC(TXT),""")",!
 Q
PI(TGT,TXT) ;
 D ARGS(TGT,.TXT)
 D COUNT("Processing Instructions")
 Q
COMMENT(TXT) ;
 W EVT,"(""",TXT,""")",!
 D COUNT("Comments")
 Q
EXTERNAL(SYS,PUB,GBL) ;
 W EVT,"(""",SYS,""",""",PUB,""")",!
 D COUNT("External Entities")
 Q
NOTATION(NAME,SYS,PUB) ;
 W EVT,"(""",NAME,""",""",SYS,""",""",PUB,""")",!
 D COUNT("Notation Declarations")
 Q
COUNT(TYPE,INC) ;
 S CNT(TYPE)=$G(CNT(TYPE))+$G(INC,1)
 Q
ERROR(ERR) ;
 N X
 S X=$P("Warning^Validation Error^Conformance Error","^",ERR("SEV")+1)
 D COUNT(X_"s")
 W X,": ",ERR("MSG")
 W:$G(ERR("ARG"))'="" " (",ERR("ARG"),")"
 W ".  ","Line ",ERR("LIN"),", Position ",ERR("POS"),!
 W $TR(ERR("XML"),$C(9,10,13)," "),!,$$REPEAT^XLFSTR("-",ERR("POS")-1),"^",!!
 Q
