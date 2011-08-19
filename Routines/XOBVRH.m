XOBVRH ;mjk/alb - VistaLink Request Handler Utilities ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; ------------------------------------------------------------------
 ;                       Message Type Handler Utilities
 ; ------------------------------------------------------------------
 ; 
 ; -- set up msg type info using message name
MSGNAME(XOBMSG,XOBHDLR) ; -- set up msg type info
 QUIT $$SETMSG(XOBMSG,"NAME",.XOBHDLR)
 ;
 ; -- set up msg type info using message type
MSGTYPE(XOBMSG,XOBHDLR) ; -- set up msg type info
 QUIT $$SETMSG(XOBMSG,"MSGTYPE",.XOBHDLR)
 ;
 ; -- set up msg type info using proprietary string
MSGSINK(XOBMSG,XOBHDLR) ; -- set up msg type info
 QUIT $$SETMSG(XOBMSG,"D",.XOBHDLR)
 ;
CACHE(XOBHDLR) ; -- cache req handlers
 NEW TYPE,TYPE0,XOBOK
 SET TYPE=0
 SET XOBOK=1
 ;
 ; -- load request handler info
 FOR  SET TYPE=$ORDER(^XOB(18.05,"AS",1,TYPE)) QUIT:'TYPE  DO  QUIT:'XOBOK
 . SET TYPE0=$GET(^XOB(18.05,TYPE,0))
 . DO SET(TYPE,TYPE0,.XOBHDLR)
 . SET XOBOK=$GET(XOBHDLR(TYPE))
 . IF 'XOBOK SET XOBOK=XOBOK_U_$GET(XOBHDLR,"ERROR")
 QUIT XOBOK
 ;
 ;  -- set up msg type info
SETMSG(XOBMSG,XOBXREF,XOBHDLR) ;
 NEW TYPE,TYPEO
 KILL XOBHDLR(0)
 ;
 ; -- bad message type (empty)
 IF $GET(XOBMSG)="" DO  QUIT TYPE
 . SET TYPE=0
 . SET XOBHDLR(0)=0
 . SET XOBHDLR(0,"ERROR")="No message type defined"
 ;
 ; -- already cached?
 SET TYPE=$ORDER(XOBHDLR(XOBXREF,XOBMSG,""))
 IF TYPE QUIT TYPE
 ;
 ; -- load req handler
 SET TYPE=+$ORDER(^XOB(18.05,XOBXREF,XOBMSG,""))
 IF TYPE DO
 . SET TYPE0=$GET(^XOB(18.05,TYPE,0))
 . DO SET(.TYPE,.TYPE0,.XOBHDLR)
 IF 'TYPE DO
 . SET XOBHDLR(0)=0
 . SET XOBHDLR(0,"ERROR")="No message type defined"
 QUIT TYPE
 ;
SET(TYPE,TYPE0,XOBHDLR) ; -- set nodes
 NEW IRTN,XOBICBK
 KILL XOBHDLR(TYPE)
 SET IRTN=$$IRTN(TYPE0)
 IF IRTN="" DO  GOTO SETQ
 . SET XOBHDLR(TYPE)=0
 . IF TYPE0="" SET XOBHDLR(TYPE,"ERROR")="No entry for message type ["_TYPE_"]" QUIT
 . IF IRTN="" SET XOBHDLR(TYPE,"ERROR")="Invalid interface routine specified ["_$PIECE(TYPE0,U,5)_"]" QUIT
 ;
 SET XOBHDLR(TYPE)=1
 SET XOBHDLR(TYPE,"AUTHENTICATE")=+$PIECE(TYPE0,U,4)
 SET XOBHDLR(TYPE,"REQHDLR")="DO REQHDLR^"_IRTN_"(.XOBDATA)"
 SET XOBHDLR(TYPE,"READER")="DO READER^"_IRTN_"(.XOBX,.XOBDATA)"
 IF $PIECE(TYPE0,U,1)]"" SET XOBHDLR("NAME",$PIECE(TYPE0,U,1),TYPE)=""
 IF $PIECE(TYPE0,U,2)]"" SET XOBHDLR("MSGTYPE",$PIECE(TYPE0,U,2),TYPE)=""
 IF $PIECE(TYPE0,U,7)]"" SET XOBHDLR("D",$PIECE(TYPE0,U,7),TYPE)=""
 ;
 ; -- set up SAX callbacks
 SET XOBHDLR(TYPE,"CB","ELEST")="QUIT"
 SET XOBHDLR(TYPE,"CB","ELEND")="QUIT"
 SET XOBHDLR(TYPE,"CB","CHR")="QUIT"
 ;
 XECUTE "DO CALLBACK^"_IRTN_"(.XOBICBK)"
 IF $DATA(XOBICBK("STARTELEMENT")) SET XOBHDLR(TYPE,"CB","ELEST")="DO "_XOBICBK("STARTELEMENT")_"(.ELE,.ATR)"
 IF $DATA(XOBICBK("ENDELEMENT")) SET XOBHDLR(TYPE,"CB","ELEND")="DO "_XOBICBK("ENDELEMENT")_"(.ELE)"
 IF $DATA(XOBICBK("CHARACTERS")) SET XOBHDLR(TYPE,"CB","CHR")="DO "_XOBICBK("CHARACTERS")_"(.TXT)"
SETQ ;
 QUIT
 ;
 ; -- get interface routine and test for existence
IRTN(XOBTYPE0) ;
 NEW X,RTN
 SET RTN=""
 SET X=$PIECE(XOBTYPE0,"^",5)
 IF X]"" DO
 . XECUTE ^%ZOSF("TEST")
 . IF $TEST SET RTN=X
 QUIT RTN
 ;
