XWBSEC ;SFISC/VYD - RPC BROKER ;02/03/10  11:37
 ;;1.1;RPC BROKER;**3,6,10,35,53**;Mar 28, 1997;Build 4
CHKPRMIT(XWBRP) ;checks to see if remote procedure is permited to run
 ;Input:  XWBRP - Remote procedure to check
 Q:$$KCHK^XUSRB("XUPROGMODE")
 N ERR,XWBPRMIT,XWBALLOW
 S U="^",XWBSEC="" ;Return XWBSEC="" if OK to run RPC
 ;
 ;In the beginning, when no DUZ is defined and no context exist, setup
 ;default signon context
 S:'$G(DUZ) DUZ=0,XQY0="XUS SIGNON"   ;set up default context
 ;
 ;These RPC's are allowed in any context, so we can just quit
 I "^XWB IM HERE^XWB CREATE CONTEXT^XWB RPC LIST^XWB IS RPC AVAILABLE^XUS GET USER INFO^XUS GET TOKEN^XUS SET VISITOR^"[(U_XWBRP_U) Q  ;p53
 ;VistAlink RPC's that are always allowed.
 I "^XUS KAAJEE GET USER INFO^XUS KAAJEE LOGOUT^"[(U_XWBRP_U) Q
 ;
 ;If in Signon context, only allow XUS and XWB rpc's
 I $G(XQY0)="XUS SIGNON","^XUS^XWB^"'[(U_$E(XWBRP,1,3)_U) S XWBSEC="Application context has not been created!" Q
 ;XQCS allows all users access to the XUS SIGNON context.
 ;Also to any context in the XUCOMMAND menu.
 ;
 I $G(XQY0)'="" D  ;1.1*6. XQY0="" after XUS SIGNON context deleted.
 . S XWBALLOW=$$CHK^XQCS(DUZ,$P(XQY0,U),XWBRP)         ;do the check
 . S:'XWBALLOW XWBSEC=XWBALLOW
 E  S XWBSEC="Application context has not been created!"
 Q
 ;
 ;
CRCONTXT(RESULT,OPTION) ;creates context for the passed in option
 K XQY0,XQY N XWB1,XABPGMOD,XWBPGMOD S RESULT=0
 S OPTION=$$DECRYP^XUSRB1(OPTION) ;S:OPTION="" OPTION="\"
 I OPTION="" S XQY=0,XQY0="",RESULT=1 Q  ;delete context if "" passed in.
 S XWB1=$$OPTLK^XQCS(OPTION)
 I XWB1="" S (XWBSEC,RESULT)="The context '"_OPTION_"' does not exist on server." Q  ;P10
 S RESULT=$$CHK^XQCS(DUZ,XWB1)
 ;Access or programmer
 S XWBPGMOD=$$KCHK^XUSRB("XUPROGMODE")
 I RESULT!XWBPGMOD S XQY0=OPTION,XQY=XWB1,RESULT=1
 E  S XWBSEC=RESULT
 Q
 ;
 ;
STATE(%) ;Return a state value
 Q:'$L($G(%)) $G(XWBSTATE)
 Q $G(XWBSTATE(%))
 ;
 ;
SET(%,VALUE) ;Set the state variable
 I $G(%)="" S XWBSTATE=VALUE
 S XWBSTATE(%)=VALUE
 Q
KILL(%) ;Kill state variable
 I $L($G(%)) K XWBSTATE(%)
 Q
