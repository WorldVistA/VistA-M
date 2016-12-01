XUSKAAJ1 ;;12/15/15  08:54;10/19/2009
 ;;8.0;KERNEL;**504,659**;Jul 10, 1995;Build 22
 ;Per VA Directive 6402, this routine should not be modified.
 ;;
 QUIT
 ;
 ; ------------------------------------------------------------------------
 ;   SSO/UC KAAJEE RPCs
 ; ------------------------------------------------------------------------
 ;
CCOWIP(RET,CLIENTIP) ;rpc. CCOW Auto Signon Handle for middle tiered application servers
 N XUIOIP,XULOOPIP
 S XUIOIP=$G(IO("IP")) ; save original
 ; get actual ip address instead of localhost address if possible
 ;S IO("IP")=$S($G(CLIENTIP)="127.0.0.1":XUIOIP,$G(CLIENTIP)="":XUIOIP,1:$G(CLIENTIP))
 S XULOOPIP=$$CONVERT^XLFIPV("127.0.0.1")  ;p659
 S IO("IP")=$S($G(CLIENTIP)=XULOOPIP:XUIOIP,$G(CLIENTIP)="":XUIOIP,1:$G(CLIENTIP))  ;p659
 D CCOW^XUSRB4(.RET)
 S IO("IP")=XUIOIP ; revert to original
 Q
 ;
USERINFO(RET,CLIENTIP,SERVERNM,CCOWTOK) ; rpc, called by XUS KAAJEE GET USER INFO VIA PROXY
 ;
 N %,DUZ,XUF,XULOOPIP
 S XUF=$G(XUF,0)
 S %=$G(IO("IP")) ; save original
 ; get actual ip address instead of localhost address if possible
 ;S IO("IP")=$S($G(CLIENTIP)="127.0.0.1":%,$G(CLIENTIP)="":%,1:$G(CLIENTIP))
 S XULOOPIP=$$CONVERT^XLFIPV("127.0.0.1")  ;p659
 S IO("IP")=$S($G(CLIENTIP)=XULOOPIP:%,$G(CLIENTIP)="":%,1:$G(CLIENTIP))  ;p659
 S DUZ=$$CHECKAV^XUS($$DECRYP^XUSRB1(CCOWTOK))
 S IO("IP")=% ; revert to original
 D USERINFO^XUSKAAJ(.RET,CLIENTIP,SERVERNM)
 Q
 ;
