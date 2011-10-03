XOBSRAKJ ;kc/oak - VistALink Reauthentication Code, SSO/UC KAAJEE ; 03/02/2004  07:00
 ;;1.6;VistALink Security;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; ------------------------------------------------------------------------
 ;       RPC Server: Reauthentication subroutines for SSO/UC KAAJEE
 ; ------------------------------------------------------------------------
 ;
CCOW(XOBID,XOBERR) ; -- CCOW connection type
 NEW XOBOUT,T,HDL
 SET XOBID=0
 ;
 ;get DUZ using Kernel CCOW Token xref
 SET HDL=$GET(XOBDATA("XOB RPC","SECURITY","TYPE","CCOW"))
 SET HDL=$$DECRYP^XUSRB1(HDL)
 ;
 IF $EXTRACT(HDL,1,2)'="~2" DO  QUIT
 . SET XOBERR=182301_U_"CCOW"_U_"[token does not match CCOW handle format.]"
 . SET XOBID=0
 ;
 ; TODO: need IP address, then need to do $$IPLOCKED(IP)?
 ; 
 ; since bypassing CHKCCOW^XUSRB4, need to extract true handle, expiry here
 SET HDL=$$UP^XLFSTR($EXTRACT(HDL,3,99)),T=$PIECE($GET(^XTV(8989.3,1,30),5400),U)
 ; call Kernel to resolve CCOW handle into user ID
 SET XOBOUT=$$CHECK^XUSRB4(HDL,T)
 IF (+XOBOUT)<1 DO  QUIT
 . SET XOBERR=182301_U_"CCOW"_U_"["_$PIECE(XOBOUT,U,2)_"]"
 . SET XOBID=0
 ; 
 ; need to get set XOBID=DUZ, save off DUZ(2) and anything else held in the token for XOBSRA
 SET XOBID=+XOBOUT
 ;
 ; Save the division station# into $GET(XOBDATA("XOB RPC","SECURITY","DIV")) -- that
 ; is where the XOBSRA division check is looking for it
 SET:+DUZ(2) XOBDATA("XOB RPC","SECURITY","DIV")=$$STA^XUAF4(DUZ(2))
 ;
 IF XOBID<1 DO  QUIT
 . SET XOBERR=182305_U_"CCOW"
 . SET XOBID=0
 ;
 ; probably can run MORECHKS as is?
 ; SET XOBERR=$$MORECHKS(XOBID)
 ; 
 IF XOBERR SET XOBID=0 QUIT
 ;
 ; TODO: POST(IP)
 ;
 QUIT
 ;
AV(XOBID,XOBERR) ; -- AV connection type
 NEW AC,AVCODE,VC,X,XOBCLIP,XOBTYPE
 SET XOBID=0
 ;
 ; -- get DUZ using access and verify codes
 SET AVCODE=$GET(XOBDATA("XOB RPC","SECURITY","TYPE","AVCODE"))
 ;
 SET AVCODE=$$DECRYP^XUSRB1(AVCODE)
 SET AC=$PIECE(AVCODE,";",1),VC=$PIECE(AVCODE,";",2),XOBCLIP=$PIECE(AVCODE,";",3)
 ;
 ; -- convert AC, VC into hashed versions
 SET X=AC,AC=$$EN^XUSHSH($$UP^XLFSTR(X))
 SET X=VC,VC=$$EN^XUSHSH($$UP^XLFSTR(X))
 ;
 ; -- check if exceeded multiple signon attempts
 SET XOBERR=$$IPLOCKED(XOBCLIP) IF XOBERR SET XOBID=0 QUIT
 ;
 ; -- look up AC
 SET XOBID=+$ORDER(^VA(200,"A",AC,0))
 IF XOBID<1 DO  QUIT
 . SET XOBERR=182305_U_"AV"
 . SET XOBID=0
 ;
 ; -- check VC
 IF $PIECE($GET(^VA(200,XOBID,.1)),U,2)'=VC DO  QUIT
 . SET XOBERR=182305_U_"AV"
 . SET XOBID=0
 ;
 ; -- check user access and whether verify code needs changing
 SET XOBERR=$$MORECHKS(XOBID)
 IF XOBERR SET XOBID=0 QUIT
 ;
 ; login succeeded
 DO POST(XOBCLIP)
 ;
 ; NOTE: AV doesn't need to check $$PERSON for AV because our source was file 200, not a separate index
 ;
 QUIT
 ;
MORECHKS(XOBID) ; -- More separate checks
 NEW XOBERR
 SET XOBERR=0
 ;
 ; -- check user access
 SET XOBERR=$$NOACCESS^XOBSRA(XOBID)
 IF XOBERR SET XOBID=0 QUIT XOBERR
 ;
 ; -- check if verify code needs changing
 SET XOBERR=$$VCHG^XOBSRA(XOBID)
 IF XOBERR SET XOBID=0 QUIT XOBERR
 ;
 QUIT XOBERR
 ;
IPLOCKED(XOBCLIP) ; -- check if IP address is locked, increment if not
 ;
 ; Implements the script-inhibiting lock-by-IP-address Kernel function.
 ; Does not lock user out for long, but does slow down scripts.
 ; 
 ; Return:
 ;   182306^XOBID : if too many invalid login attempts
 ;   0 : not too many login attempts
 ;
 IF $$LKCHECK^XUSTZIP(XOBCLIP) DO  QUIT XOBERR
 . SET XOBERR="182306^Too many invalid signon attempts."
 ;
 NEW XOBERR,XUFAC SET XOBERR=0
 ;
 IF $$FAIL^XUS3(XOBCLIP) SET XOBERR="182306^"_$$RA^XUSTZ(XOBCLIP)
 QUIT XOBERR
 ;
POST(XOBCLIP) ; post-successful tasks
 DO CLRFAC^XUS3(XOBCLIP)
 QUIT
