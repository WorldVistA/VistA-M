XWBLIB ;SFISC/VYD - Various remote procedure library ;06/16/2004  17:53
 ;;1.1;RPC BROKER;**6,10,26,35**;Mar 28, 1997
 Q
 ;
BROKER() ;EF. Running under the Broker or Vlink
 Q $D(XWBOS)!$D(XOBDATA)
 ;
RTRNFMT(X,WRAP) ;EF. set the RPC return type and wrap flag
 N Y
 S:$D(WRAP) XWBWRAP=+WRAP
 S X=$G(X)
 IF X=+X,X>0,X<6 S XWBPTYPE=X Q X
 S X=$$UP^XLFSTR(X)
 S X=$S(X="SINGLE VALUE":1,X="ARRAY":2,X="WORD PROCESSING":3,X="GLOBAL ARRAY":4,X="GLOBAL INSTANCE":5,1:0)
 IF X=0 Q 0
 S XWBPTYPE=X
 Q X
 ;
VARVAL(RESULT,VARIABLE) ;returns value of passed in variable
 S RESULT=VARIABLE ;can do this with the REFERENCE type parameter
 Q
 ;See GETV^XWBBRK for how we get the REFERENCE type parameter
 ;
IMHERE(RESULT) ;P6
 ;Entry point for XWB IM HERE remote procedure
 S RESULT=1
 Q
 ;
BRKRINFO(RESULT) ;P6
 ;Entry point for XWB GET BROKER INFO RPC.
 ;R(0) = Length of handler read timeout
 S RESULT(0)=$$BAT^XUPARAM
 Q
 ;
CKRPC(RESULT,RPCNAME,RPCUSE,VERNUM) ;P10
 ;Entry point for "XWB IS RPC AVIALABLE" RPC.
 ;RPCUSE("L" or "R") and VERNUM are optional.
 ;Checks if RPC exists and if INACTIVE flag is set for specified use.
 ;Also checks version number if passed.
 ;Result = 1 for can be run; 0 for can't be run.
 N RPCIEN
 S RESULT=0
 S RPCIEN=$$RPCIEN($G(RPCNAME))
 I RPCIEN,$$RPCAVAIL(RPCIEN,$G(RPCUSE),$G(VERNUM)) S RESULT=1
 Q
 ;
CKRPCS(RESULT,RPCUSE,RPC) ;P10
 ;Entry point for "XWB ARE RPCS AVIALABLE" RPC.
 ;RPCUSE("L" or "R") and VERNUM are optional.
 ;RPC() array has format RPCName^RPCVersionNumber.
 ;Checks if RPC exists and version number (if not null).
 ;Check INACTIVE flag if set for specified use.
 ;Result(I) = 1 for can be run; 0 for can't be run.
 N I
 S I=""
 F  S I=$O(RPC(I)) Q:I=""  D
 . N RPCNAME,VERNUM,RPCIEN
 . S RESULT(I)=0
 . S RPCNAME=$P(RPC(I),U)
 . S VERNUM=$P(RPC(I),U,2)
 . S RPCIEN=$$RPCIEN($G(RPCNAME))
 . I RPCIEN,$$RPCAVAIL(RPCIEN,$G(RPCUSE),$G(VERNUM)) S RESULT(I)=1
 Q
 ;
RPCIEN(RPCNAME) ;P10
 ;Function that returns IEN of RPC based on name.
 ;Returns 0 if RPC does not exist.
 I RPCNAME="" Q 0
 Q +$O(^XWB(8994,"B",RPCNAME,0))
 ;
RPCAVAIL(RPCIEN,RPCUSE,VERNUM) ;P10
 ;Boolean function, identifies if RPC is active and correct version.
 ;RPCUSE (optional) = L check local use; R check remote use.
 ;VERNUM (optional) only checked for remote RPCs.
 N RPC0,INACT
 S RPC0=$G(^XWB(8994,+RPCIEN,0))
 Q:RPC0="" 0
 S INACT=+$P(RPC0,U,6)
 I INACT=1 Q 0 ;RPC marked inactive.
 S RPCUSE=$G(RPCUSE)
 I RPCUSE="" Q 1 ;Local and remote check not needed.
 I RPCUSE="L",INACT=2 Q 0 ;Local use, RPC is remote only.
 I RPCUSE="R",INACT=3 Q 0 ;Remote use, RPC is local only.
 I RPCUSE="R",+$G(VERNUM),'$$CKVERNUM(VERNUM,+$P(RPC0,U,9)) Q 0 ;Failed version # check.
 Q 1 ;Must be ok.
 ;
CKVERNUM(VERNUM,RPCVER,RPCIEN) ;P10
 ;Boolean function. Returns 1 if RPC verion is > or = version number to be checked.
 ;VERNUM = version number passed in (i.e., from client ap) to be checked.
 ;RPCVER = version number in Remote Procedure file. (optional)
 ;RPCIEN of RPC being checked. Needed if RPCVER not sent.
 I +$G(RPCIEN),'+$G(RPCVER) S RPCVER=$P($G(^XWB(8994,RPCIEN,0)),U,9)
 I +RPCVER<+VERNUM Q 0
 Q 1
 ;
VARLST ;;XWB,XWBAPVER,XWBCLMAN,XWBNULL,XWBODEV,XWBOS,XWBP,XWBPTYPE,XWBR,XWBSEC,XWBSTATE,XWBTBUF,XWBTDEV,XWBTIME,XWBTIP,XWBTOS,XWBTSKT,XWBVER,XWBWRAP,XWBY,DEBUG,XWBSHARE,XWBDEBUG,XWBT
 ;P10.  Variable for exclusive NEW in KILL^XUSCLEAN
 ;P26.  Added XWBSHARE
 ;P35.  Added XWBDEBUG,XWBT
