XWBSEC ;ISF/VYD,ISD/HGW - RPC BROKER ; 7/21/16 4:34pm
 ;;1.1;RPC BROKER;**3,6,10,35,53,64**;Mar 28, 1997;Build 12
 ;Per VA Directive 6402, this routine should not be modified.
 ;
CHKPRMIT(XWBRP) ;checks to see if remote procedure is permitted to run
 ;Input:  XWBRP  - Remote procedure to check
 ;Output: XWBSEC - Error message if RPC cannot be run
 ; ZEXCEPT: XQY0,XWBSEC - Kernel exemption for global variables
 N ERR,XWBPRMIT,XWBALLOW
 S U="^",XWBSEC="" ;Return XWBSEC="" if OK to run RPC
 Q:$$KCHK^XUSRB("XUPROGMODE")
 ;
 ;In the beginning, when no DUZ is defined and no context exist, setup
 ;default signon context
 S:'$G(DUZ) DUZ=0,XQY0="XUS SIGNON"   ;set up default context
 ;
 ;These RPC's are allowed in any context, so we can just quit
 I "^XWB IM HERE^XWB CREATE CONTEXT^XWB RPC LIST^XWB IS RPC AVAILABLE^XUS GET USER INFO^XUS GET TOKEN^XUS SET VISITOR^"[(U_XWBRP_U) Q  ;p53
 I "^XUS IAM BIND USER^XUS CVC^XUS KEY CHECK^XUS BSE TOKEN^"[(U_XWBRP_U) Q  ;p64
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
 . I 'XWBALLOW S XWBSEC=XWBALLOW                       ;no access to RPC
 E  S XWBSEC="Application context has not been created!"
 Q
 ;
CRCONTXT(RESULT,OPTION,APPLCODE) ;creates context for the passed in option
 ; ZEXCEPT: XQY,XQY0,XWBSEC - Kernel exemption for global variables
 K XQY0,XQY
 N XWB1,XWB2,XABPGMOD,XWBPGMOD,XWBCODE
 S RESULT=0
 I $D(APPLCODE) D         ;Assign an optional secondary menu option for user (SSOi, SSOe)
 . S XWBCODE=$$AESDECR^XUSHSH($$B64DECD^XUSHSH(APPLCODE),"tHiZZfnmYjkFinis")
 . S XWB2=$$SETCNTXT^XUESSO2(DUZ,XWBCODE)
 S OPTION=$$DECRYP^XUSRB1(OPTION)
 I OPTION="" S XQY=0,XQY0="",RESULT=1 Q  ;delete context if "" passed in.
 S XWB1=$$OPTLK^XQCS(OPTION)
 I XWB1="" S (XWBSEC,RESULT)="The context '"_OPTION_"' does not exist on server." Q  ;P10
 ;Check Access (User with XUPROGMODE security key always has access)
 S RESULT=$$CHK^XQCS(DUZ,XWB1)
 S XWBPGMOD=$$KCHK^XUSRB("XUPROGMODE")
 I RESULT!XWBPGMOD S XQY0=OPTION,XQY=XWB1,RESULT=1
 E  S XWBSEC=RESULT
 Q
 ;
STATE(%) ;Return a state value
 ; ZEXCEPT: XWBSTATE - Kernel exemption for global variable
 Q:'$L($G(%)) $G(XWBSTATE)
 Q $G(XWBSTATE(%))
 ;
SET(%,VALUE) ;Set the state variable
 ; ZEXCEPT: XWBSTATE - Kernel exemption for global variable
 I $G(%)="" S XWBSTATE=VALUE
 S XWBSTATE(%)=VALUE
 Q
 ;
KILL(%) ;Kill state variable
 ; ZEXCEPT: XWBSTATE - Kernel exemption for global variable
 I $L($G(%)) K XWBSTATE(%)
 Q
