XOBVRMX ;mjk/alb - VistaLink Request Manager - Parse XML Requests using SAX interface ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; -- parse xml
EN(DOC,XOBOPT,XOBDATA,XOBHDLR) ; -- uses SAX parser
 NEW XOBCBK,XOBICBK
 DO SET(.XOBCBK)
 DO EN^MXMLPRSE(DOC,.XOBCBK,.XOBOPT)
ENQ QUIT
 ;
SET(XOBCBK) ; -- set the event interface entry points
 SET XOBCBK("STARTELEMENT")="ELEST^XOBVRMX"
 SET XOBCBK("ENDELEMENT")="ELEND^XOBVRMX"
 SET XOBCBK("CHARACTERS")="CHR^XOBVRMX"
 QUIT
 ;
ELEST(ELE,ATR) ; -- element start callback
 IF ELE="VistaLink" DO
 . SET XOBDATA("VL VERSION")=$GET(ATR("version"),"1.0")
 . ;
 . ; -- set up request handler for message type
 . SET XOBHDLR=+$$MSGTYPE^XOBVRH($GET(ATR("messageType"),"[unknown]"),.XOBHDLR)
 ;
 ; -- do start element callback for request handler
 IF $GET(XOBHDLR(XOBHDLR)) XECUTE $GET(XOBHDLR(XOBHDLR,"CB","ELEST"))
 QUIT
 ;
ELEND(ELE) ; -- element end callback
 ; -- do end element callback for request handler
 IF $GET(XOBHDLR(XOBHDLR)) XECUTE $GET(XOBHDLR(XOBHDLR,"CB","ELEND"))
 QUIT
 ;
CHR(TXT) ; -- handler characters callback
 ; -- do character callback for request handler
 IF $GET(XOBHDLR(XOBHDLR)) XECUTE $GET(XOBHDLR(XOBHDLR,"CB","CHR"))
 QUIT
 ;
ESC(X) ; -- convert special characters to \x format ; not currently used -- note QUIT at start
 QUIT X
 ;
 NEW C,Y,Z
 FOR Z=1:1 SET C=$EXTRACT(X,Z) QUIT:C=""  DO
 .SET Y=$TRANSLATE(C,$CHAR(9,10,13,92),"tnc")
 .SET:C'=Y $EXTRACT(X,Z)="" ;$S(Y="":"\\",1:"\"_Y),Z=Z+1
 QUIT X
 ;
