XOBSRA1 ;mjk,esd/alb - VistALink Reauthentication Code ; 05/22/2003  07:00
 ;;1.6;VistALink Security;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
KILL ; -- clean up partition's local symbol table ; called from INIT^XOBSRA
 ;SET AAXOB="before" DO ^%ZTER ; -- used to view symbol table 'before' state
 ;
 IF XOBOS["OpenM" DO
 . ; -- Stack: CACHEVMS^XOBVTCP
 . ;           SPAWN^XOBVLL
 . ;           NXTCALL^XOBVLL
 . ;           EN^XOBVRM
 . ;           EN^XOBVRPC()
 . ;           SETUPDUZ^XOBSRA()
 . ;           
 . ; -- NEW non-XOB variables created in above stack
 . NEW DIQUIET,DX,DY,RPC0,RPCNAME,RPCIEN,TAG,ROU,METHSIG,XRTN
 . DO CACHE("XOB")
 ELSE  DO
 . DO OTHER
 ;
 ;SET AAXOB="after" DO ^%ZTER ; -- used to view symbol table 'after' state
 QUIT
 ;
CACHE(%NS) ; -- KILL all 'L'ocal 'VAR'iables except for a 'N'ame'S'pace (%NS) and Kernel for Cache systems
 NEW %LVAR,%NSLEN
 SET %NSLEN=$LENGTH(%NS)
 SET %LVAR=%NS
 FOR  SET %LVAR=$ORDER(@%LVAR) QUIT:%LVAR=""!($EXTRACT(%LVAR,1,%NSLEN)'=%NS)  NEW @%LVAR
 ; -- NEW Kernel variables and do the big KILL
 DO KILL^XUSCLEAN
 QUIT
 ;
OTHER ; -- explicit NEW'ing for other for non-Cache M implementations
 ; -- The following are NEW'ed as part KILL^XOBVLL call:
 ;    XOBPORT,XOBSTOP,XOBNULL,XOBOS,XOBSYS,XOBHDLR,XOBOK
 ; -- additional NEW'ing needed to preserve for CACHEVMS^XOBVTCP
 NEW XOBEC
 ; -- additional NEW'ing needed to preserve for SPAWN^XOBVLL
 NEW XOBLASTR
 ; -- additional NEW'ing needed to preserve for NXTCALL^XOBVLL
 NEW XOBROOT,XOBREAD,XOBTO,XOBFIRST,XOBDATA,DIQUIET
 ; -- additional NEW'ing needed to preserve for EN^XOBVRM
 NEW XOBOPT
 ; -- additional NEW'ing needed to preserve for EN^XOBVRPC()
 NEW DX,DY,RPC0,RPCNAME,RPCIEN,TAG,ROU,METHSIG,XOBERR,XOBR,XOBSEC,XOBWRAP,XRTN,XOBRA,XOBVER,XOBPTYPE
 ; -- additional NEW'ing needed to preserve for SETUPDUZ^XOBSRA()
 NEW XOBERR,XOBID,XOBTYPE
 ; -- call KILL^XOBVLL to finish NEW'ing and execute Kernel call to kill
 DO KILL^XOBVLL
 QUIT
 ;
