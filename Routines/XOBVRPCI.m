XOBVRPCI ;; ld,mjk/alb - VistaLink Interface Implementation for RPCs; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 ;
CALLBACK(CB) ; -- init callbacks implementation
 SET CB("STARTELEMENT")="ELEST^XOBVRPCI"
 SET CB("ENDELEMENT")="ELEND^XOBVRPCI"
 SET CB("CHARACTERS")="CHR^XOBVRPCI"
 QUIT
 ;
READER(XOBUF,XOBDATA) ; -- proprietary format reader implementation
 DO START^XOBVRPCX(.XOBUF,.XOBDATA)
 QUIT
 ;
REQHDLR(XOBDATA) ; -- request handler implementation
 DO EN^XOBVRPC(.XOBDATA)
 QUIT
 ;
 ; ------------------------------------------------------------------------
 ;             RPC Server: Request Message XML SAX Parser Callbacks         
 ; ------------------------------------------------------------------------
ELEST(ELE,ATR) ; -- element start event handler
 IF ELE="VistaLink" DO  QUIT
 . KILL XOBPARAM,XOBCTXT,XOBPN,XOBPTYPE
 . ; -- if called from VL v1.0 client then set up J2SE defaults
 . IF $GET(XOBDATA("VL VERSION"))="1.0" DO V1^XOBVRPCX
 ;
 IF ELE="RpcHandler" SET XOBDATA("XOB RPC","RPC HANDLER VERSION")=$GET(ATR("version")) QUIT
 ;
 IF ELE="Request" DO  QUIT
 . SET XOBDATA("XOB RPC","RPC NAME")=$$ESC^XOBVRMX($GET(ATR("rpcName"),"##Unkown RPC##"))
 . NEW X
 . SET X=$$SETTO^XOBVLIB($GET(ATR("rpcClientTimeOut"),9000))
 . SET X=$$SETVER^XOBVRPCX($GET(ATR("rpcVersion"),0))
 ;
 IF ELE="RpcContext" SET XOBCTXT="" QUIT
 ;
 ; --------------------  Param Node Start Event Processing  ---------------------------
 ; 
 IF ELE="Param" DO  QUIT
 . SET XOBPARAM=""
 . SET XOBPN="XOBP"_ATR("position")
 . SET XOBDATA("XOB RPC","PARAMS",ATR("position"))=XOBPN
 . SET XOBPTYPE=ATR("type")
 . SET:XOBPTYPE="array" @XOBPN=""
 ;
 IF ELE="Index" DO  QUIT
 . KILL XOBPARAM
 . IF $DATA(ATR("name"))&$DATA(ATR("value")) DO
 . . SET @XOBPN@($$ESC^XOBVRMX(ATR("name")))=$$ESC^XOBVRMX(ATR("value"))
 ;
 IF ELE="Name" DO  QUIT
 . SET XOBPARNM=""
 ;
 IF ELE="Value" DO  QUIT
 . SET XOBPARVL=""
 ;
 ; --------------------  Security Node Start Event Processing  ---------------------------
 ; 
 IF ELE="Security" DO  QUIT
 . SET XOBDATA("XOB RPC","SECURITY","TYPE")=$GET(ATR("type"))
 . SET XOBDATA("XOB RPC","SECURITY","DIV")=$GET(ATR("division"))
 . SET XOBDATA("XOB RPC","SECURITY","STATE")=$GET(ATR("state"),"notauthenticated")
 . KILL XOBSECFL
 . ;
 . ; -- use to make sure child nodes are from Security
 . ;    parent when processing child node names
 . SET XOBSECFL=1
 ;
 IF ELE="AccessVerify",$GET(XOBSECFL),$EXTRACT($GET(XOBDATA("XOB RPC","SECURITY","TYPE")),1,2)="av" DO  QUIT
 . SET XOBAVCOD=""
 ;
 IF ELE="KernelCcowToken",$GET(XOBSECFL),$GET(XOBDATA("XOB RPC","SECURITY","TYPE"))="ccow" DO  QUIT
 . SET XOBCCOWT=""
 ;
 IF ELE="Duz",$GET(XOBSECFL),$GET(XOBDATA("XOB RPC","SECURITY","TYPE"))="duz" DO  QUIT
 . SET XOBDATA("XOB RPC","SECURITY","TYPE","VALUE")=$GET(ATR("value"))
 ;
 IF ELE="Vpid",$GET(XOBSECFL),$GET(XOBDATA("XOB RPC","SECURITY","TYPE"))="vpid" DO  QUIT
 . SET XOBDATA("XOB RPC","SECURITY","TYPE","VALUE")=$GET(ATR("value"))
 ;
 IF ELE="ApplicationProxyName",$GET(XOBSECFL),$GET(XOBDATA("XOB RPC","SECURITY","TYPE"))="appproxy" DO  QUIT
 . SET XOBDATA("XOB RPC","SECURITY","TYPE","VALUE")=$GET(ATR("value"))
 ;
 ; ---------------------------------------------------------------------------
 ;
 QUIT
 ;
ELEND(ELE) ; -- element end event handler
 IF ELE="VistaLink" DO  QUIT
 . SET XOBDATA("MODE")=$GET(ATR("mode"),"singleton")
 . KILL XOBPOS,XOBPARAM,XOBCTXT,XOBPN,XOBPTYPE
 ;
 IF ELE="RpcContext" DO  QUIT
 . SET XOBDATA("XOB RPC","RPC CONTEXT")=$GET(XOBCTXT)
 ;
 IF ELE="Param" DO  KILL XOBPARAM QUIT
 . IF XOBPTYPE="string" SET @XOBPN=$$ESC^XOBVRMX(XOBPARAM) QUIT
 . IF XOBPTYPE="ref" SET @XOBPN=$GET(@$$ESC^XOBVRMX(XOBPARAM)) QUIT
 ;
 IF ELE="Params" DO  QUIT
 . NEW POS,PARAMS
 . SET PARAMS="",POS=0
 . FOR  SET POS=$ORDER(XOBDATA("XOB RPC","PARAMS",POS)) QUIT:'POS  SET PARAMS=PARAMS_",."_XOBDATA("XOB RPC","PARAMS",POS)
 . SET XOBDATA("XOB RPC","PARAMS")=PARAMS
 ;
 IF ELE="Index" DO  QUIT
 . IF $DATA(XOBPARNM)&$DATA(XOBPARVL) DO
 . . KILL XOBPARAM
 . . IF $EXTRACT(XOBPARNM,1)=$CHAR(13) DO
 . . . SET @("@XOBPN@("_$$ESC^XOBVRMX($EXTRACT(XOBPARNM,2,$LENGTH(XOBPARNM)))_")=$$ESC^XOBVRMX(XOBPARVL)")
 . . ELSE  DO
 . . . SET @XOBPN@($$ESC^XOBVRMX(XOBPARNM))=$$ESC^XOBVRMX(XOBPARVL)
 . . KILL XOBPARNM,XOBPARVL
 ;
 IF ELE="Name" DO  QUIT
 . SET XOBPARNM("DONE")=1
 ;
 IF ELE="Value" DO  QUIT
 . SET XOBPARVL("DONE")=1
 ;
 IF ELE="AccessVerify",$GET(XOBSECFL),$EXTRACT($GET(XOBDATA("XOB RPC","SECURITY","TYPE")),1,2)="av" DO  QUIT
 . SET XOBDATA("XOB RPC","SECURITY","TYPE","AVCODE")=XOBAVCOD KILL XOBAVCOD
 IF ELE="KernelCcowToken",$GET(XOBSECFL),$GET(XOBDATA("XOB RPC","SECURITY","TYPE"))="ccow" DO  QUIT
 . SET XOBDATA("XOB RPC","SECURITY","TYPE","CCOW")=XOBCCOWT KILL XOBCCOWT
 IF ELE="Security" KILL XOBSECFL QUIT
 ;
 QUIT
 ;
CHR(TEXT) ; -- character value event handler <tag>TEXT</tag)
 ; -- need to concatenate because MXML parses on ENTITY characters (<>& etc.) and
 ;    callback gets hit multiple times even though the tag text value is just one piece of data.
 ;    (Yes, this seems kludgie!)
 IF $DATA(XOBPARAM) SET XOBPARAM=XOBPARAM_TEXT
 IF $DATA(XOBPARNM),'+$GET(XOBPARNM("DONE")) SET XOBPARNM=XOBPARNM_TEXT QUIT
 IF $DATA(XOBPARVL),'+$GET(XOBPARVL("DONE")) SET XOBPARVL=XOBPARVL_TEXT QUIT
 IF $DATA(XOBCTXT) SET XOBCTXT=XOBCTXT_TEXT QUIT
 IF $DATA(XOBAVCOD) SET XOBAVCOD=XOBAVCOD_TEXT QUIT
 IF $DATA(XOBCCOWT) SET XOBCCOWT=XOBCCOWT_TEXT QUIT
 QUIT
 ;
