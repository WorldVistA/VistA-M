XUSKAAJ1 ;; ISF/JLG - KAAJEE Utilities ;10/19/2009
 ;;8.0;KERNEL;**504**;Jul 10, 1995;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;;
 QUIT
 ;
 ; ------------------------------------------------------------------------
 ;   SSO/UC KAAJEE RPCs
 ; ------------------------------------------------------------------------
 ;
CCOWIP(RET,CLIENTIP) ;rpc. CCOW Auto Signon Handle for middle tiered application servers
 N XUIOIP
 S XUIOIP=$G(IO("IP")) ; save original
 ; get actual ip address instead of localhost address if possible
 S IO("IP")=$S($G(CLIENTIP)="127.0.0.1":XUIOIP,$G(CLIENTIP)="":XUIOIP,1:$G(CLIENTIP))
 D CCOW^XUSRB4(.RET)
 S IO("IP")=XUIOIP ; revert to original
 Q
 ;
USERINFO(RET,CLIENTIP,SERVERNM,CCOWTOK) ; rpc, called by XUS KAAJEE GET USER INFO VIA PROXY
 ;
 N %,DUZ,XUF
 S XUF=$G(XUF,0)
 S %=$G(IO("IP")) ; save original
 ; get actual ip address instead of localhost address if possible
 S IO("IP")=$S($G(CLIENTIP)="127.0.0.1":%,$G(CLIENTIP)="":%,1:$G(CLIENTIP))
 S DUZ=$$CHECKAV^XUS($$DECRYP^XUSRB1(CCOWTOK))
 S IO("IP")=% ; revert to original
 D USERINFO^XUSKAAJ(.RET,CLIENTIP,SERVERNM)
 Q
 ;
