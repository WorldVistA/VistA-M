XWBTCPM2 ;ISF/RWF - BROKER Other Service ;06/28/2012
 ;;1.1;RPC BROKER;**43,45,53,59**;Mar 28, 1997;Build 2
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ;
OTH ;Check if some other special service.
 ; ZEXCEPT: XWB - set prior to call from CONNTYPE^XWBTCPM
 S $ETRAP="D ERR^XWBTCPM2"
 I XWB="~EAC~" G EAC
 I XWB="~BSE~" G BSE
 I XWB="~SVR~" G SVR
 D LOG("In 0TH^XWBTCPM2 - Prefix not known: "_XWB)
 Q
 ;
SVR ;Handle
 Q
EAC ;Enterprise Access
 Q
 ;
BSE ;Broker Security Enhancement
 D LOG("BSE msg")
 N L,HDL,RET,XWBSBUF
 S XWBSBUF="",RET="",HDL=""
 S L=$$BREAD^XWBRW(3) I L S HDL=$$BREAD^XWBRW(L)
 I $E(HDL,1,3)="PUT" D
 . ;D RPUT^XUSBSE1(.RET,HDL) ;p59(REM)-RPUT^XUSBSE1 does not exsist.
 . Q
 ;Check IT
 I $E(HDL,1,3)'="PUT" D GETVISIT^XUSBSE1(.RET,HDL)
 D WRITE(RET),WBF
 Q
 ;
ERR ;Error Trap
 D ^%ZTER
 G H2^XUSCLEAN
 ;
LOG(%) ;Link to logger
 Q:'$G(XWBDEBUG)
 D LOG^XWBTCPM(%)
 Q
 ;
WRITE(M,F) ;Write
 N L S L="" I '$G(F) S L=$E(1000+$L(M),2,4)
 D WRITE^XWBRW(L_M)
 Q
WBF ;Buffer Flush
 D WBF^XWBRW
 Q
 ;
OPEN(P1,P2) ;Open the device and set the variables
 D CALL^%ZISTCP(P1,P2) Q:POP
 S XWBTDEV=IO
 Q
 ;
CALLBSE(SERVER,PORT,TOKEN,STN) ;Special Broker service
 N XWBDEBUG,XWBOS,XWBRBUF,XWBSBUF,XWBT,XWBTIME,IO
 N DEMOSTR,XWBTDEV,RET,X,POP
 S IO(0)=$P
 D INIT^XWBTCPM,LOG("CALLBSE")
 D OPEN(SERVER,PORT)
 ; if initial failure try to get web address
 I POP,$G(STN)'="" S SERVER=$$WEBADDRS^XUSBSE1(STN) I SERVER'="" D OPEN(SERVER,PORT)
 I POP Q "Didn't open connection."
 S XWBSBUF="",XWBRBUF=""
 U XWBTDEV
 D WRITE("~BSE~",1),WRITE(TOKEN),WBF^XWBRW
 S X=$$BREAD^XWBRW(3),RET="No Response" I X S RET=$$BREAD^XWBRW(X)
 D CLOSE^%ZISTCP,LOG("FINISH")
 Q RET
