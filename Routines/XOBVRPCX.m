XOBVRPCX ;; mjk/alb - VistaLink RPC Formatter Sink ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; -- unwrap stream
START(XOBUF,XOBDATA) ;
 NEW PARAMS,POS,TYP,PCNT,CNTP,ICNT,CNTI,XOBPN,SUB,VAL,DEBUG,EOT,RESV,LENSIZE,X
 ;
 ; -- get debugging byte
 SET DEBUG=$$GETSTR(1)
 ;
 ; -- get size of length chunk
 SET LENSIZE=$$GETSTR(1)
 ;
 ; -- get VistaLink version
 SET XOBDATA("VL VERSION")=$$GETVAL()
 ;
 ; -- get RpcHandler version
 SET XOBDATA("XOB RPC","RPC HANDLER VERSION")=$$GETVAL()
 ;
 ; -- Set basic constant attributes
 SET XOBDATA("MODE")="singleton"
 ;
 ; -- get RPC info from stream
 IF XOBDATA("XOB RPC","RPC HANDLER VERSION")>1.0 SET X=$$SETVER($$GETVAL())
 SET XOBDATA("XOB RPC","RPC NAME")=$$GETVAL()
 SET XOBDATA("XOB RPC","RPC CONTEXT")=$$GETVAL()
 ;
 ; -- set RPC time out
 SET X=$$SETTO^XOBVLIB($$GETVAL())
 ;
 ; -- set security info
 DO SECURITY
 ;
 ; -- set RPC parameters
 DO PARMS
 ;
 ; -- read end of text character EOT to empty buffer
 SET EOT=$$GETSTR(1)
 QUIT
 ;
GETVAL() ; -- get next VALue from stream buffer
 QUIT $$GETSTR($$GETLEN())
 ;
GETLEN() ; -- get the length of the next value
 IF 'DEBUG QUIT +$$GETSTR(LENSIZE)
 ; -- Ex. of why 4: VAL=00001
 QUIT +$PIECE($$GETSTR(LENSIZE+4),"=",2)
 ;
GETSTR(LEN) ; -- extracts string of length, LEN, from stream buffer and returns extracted string 
 NEW X
 FOR  QUIT:($LENGTH(XOBUF)'<LEN)  DO READ(LEN-$LENGTH(XOBUF))
 SET X=$EXTRACT(XOBUF,1,LEN)
 SET XOBUF=$EXTRACT(XOBUF,LEN+1,999)
 QUIT X
 ;
READ(LEN) ; -- read more from stream buffer but only needed amount
 NEW X
 FOR  QUIT:LEN<512  SET LEN=LEN-511 READ X#511:1 SET XOBUF=XOBUF_X
 IF LEN>0 READ X#LEN:1 SET XOBUF=XOBUF_X
 QUIT
 ;
 ;
 ; ----------------  Security Information Processing ----------------
SECURITY ;
 ;
 ; -- if called from VL v1.0 client then set up J2SE defaults
 IF $GET(XOBDATA("VL VERSION"))="1.0" DO V1 QUIT
 ;
 ; -- set security info
 SET XOBDATA("XOB RPC","SECURITY","TYPE")=$$GETVAL()
 SET XOBDATA("XOB RPC","SECURITY","DIV")=$$GETVAL()
 SET XOBDATA("XOB RPC","SECURITY","STATE")=$$GETVAL()
 ;
 ; -- get needed type vars if not authenticated
 IF XOBDATA("XOB RPC","SECURITY","STATE")'="authenticated" DO
 . DO @($$UP^XLFSTR($GET(XOBDATA("XOB RPC","SECURITY","TYPE"))))
 ;
 QUIT
 ;
AV ; -- access and verify code type (KAAJEE)
 SET XOBDATA("XOB RPC","SECURITY","TYPE","AVCODE")=$$GETVAL()
 QUIT
 ;
CCOW ; -- CCOW type (FatKAAT)
 SET XOBDATA("XOB RPC","SECURITY","TYPE","CCOW")=$$GETVAL()
 QUIT
 ;
DUZ ; -- simple duz type
 SET XOBDATA("XOB RPC","SECURITY","TYPE","VALUE")=$$GETVAL()
 QUIT
 ;
VPID ; -- vpid type
 SET XOBDATA("XOB RPC","SECURITY","TYPE","VALUE")=$$GETVAL()
 QUIT
 ;
APPPROXY ; -- application proxy type
 SET XOBDATA("XOB RPC","SECURITY","TYPE","VALUE")=$$GETVAL()
 QUIT
 ;
J2SE ; -- c/s type
 ; -- this line should never be executed since state will
 ;    always be authenticated ; entered for completeness
 QUIT
 ;
V1 ; -- set up security compatibility for VL v1.0 client
 ;      (tag also called by ELST^XOBRPCI)
 ;     
 SET XOBDATA("XOB RPC","SECURITY","TYPE")="j2se"
 SET XOBDATA("XOB RPC","SECURITY","DIV")=""
 SET XOBDATA("XOB RPC","SECURITY","STATE")="authenticated"
 QUIT
 ; ---------------------   RPC Parameter Processing  -----------------
PARMS ;
 ;
 ; -- get how many parameters to expect
 SET XOBDATA("XOB RPC","PARAMS")=""
 SET PCNT=+$$GETVAL()
 ;
 ; -- get the parameters
 IF PCNT>0 FOR CNTP=1:1:PCNT DO
 . SET TYP=$$GETVAL()
 . SET POS=+$$GETVAL()
 . SET XOBPN="XOBP"_POS
 . SET XOBDATA("XOB RPC","PARAMS",POS)=XOBPN
 . ;
 . ; -- get single value 
 . IF TYP'="array" DO  QUIT
 . . ; -- get value for ref type
 . . IF TYP="ref" SET @XOBPN=@$$GETVAL() QUIT
 . . ;
 . . ; -- get value for other non-array types
 . . SET @XOBPN=$$GETVAL()
 . ;
 . ; -- get how many subscripts to expect for an array
 . SET ICNT=+$$GETVAL()
 . ;
 . ; -- set root node of array to ""
 . SET @XOBPN=""
 . ;
 . ; -- get the subscripts and values for the array
 . IF ICNT>0 FOR CNTI=1:1:ICNT DO
 . . SET SUB=$$GETVAL()
 . . SET VAL=$$GETVAL()
 . . IF $EXTRACT(SUB,1)=$CHAR(13) DO
 . . . SET @("@XOBPN@("_$EXTRACT(SUB,2,$LENGTH(SUB))_")=VAL")
 . . ELSE  DO
 . . . SET @XOBPN@(SUB)=VAL
 ;
 ; -- build parameter signature for RPC call
 SET PARAMS="",POS=0
 FOR  SET POS=$ORDER(XOBDATA("XOB RPC","PARAMS",POS)) QUIT:'POS  SET PARAMS=PARAMS_",."_XOBDATA("XOB RPC","PARAMS",POS)
 SET XOBDATA("XOB RPC","PARAMS")=PARAMS
 ;
 QUIT
 ;
 ; ------------------------------------------------------------------
 ;
GETVER() ; -- get rpc version
 QUIT $GET(XOBDATA("XOB RPC","VERSION"),0)
 ;
SETVER(VERSION) ; -- set rpc version
 SET XOBDATA("XOB RPC","VERSION")=VERSION
 QUIT 1
 ;
