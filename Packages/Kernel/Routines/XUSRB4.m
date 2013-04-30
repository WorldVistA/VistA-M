XUSRB4 ;ISF/RWF - Build a temporary sign-on token ;10/12/11  14:53
 ;;8.0;KERNEL;**150,337,395,419,437,499,523,573,596**;Jul 10, 1995;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
ASH(RET) ;rpc. Auto Signon Handle
 N HDL
 S HDL=$$HANDLE("XWBAS",1),RET="~1"_HDL
 ;Now place user info in it.
 D TOK(HDL)
 Q
 ;
CCOW(RET) ;rpc. CCOW Auto Signon Handle
 N HDL,HDL2,X
 S RET(0)="NO PROXY USER",RET(1)="ERROR"
 I $$USERTYPE^XUSAP(DUZ,"APPLICATION PROXY") Q  ;No Proxy
 I $$USERTYPE^XUSAP(DUZ,"CONNECTOR PROXY") Q  ;No Proxy
 S X=$$ACTIVE^XUSER(DUZ) I 'X S RET(0)=X Q  ;User must be active
 S HDL=$$HANDLE("XWBCCW",1)
 ;Return RET(0) the CCOW token, RET(1) the domain name and the Station #
 S RET(0)="~2"_$$LOW^XLFSTR(HDL),RET(1)=$G(^XMB("NETNAME"))_"^"_$$STA^XUAF4(DUZ(2))
 ;Now place user info in it.
 D TOK(HDL)
 S ^XUTL("XQ",$J,"HDL")=HDL ;Save handle with job
 Q
 ;
HANDLE(NS,LT) ;Return a unique handle into ^XTMP (ef. sup)
 ;NS is the namespace, LT is the Handle Lifetime in days
 N %H,A,J,HL
 I $G(NS)="" Q "" ;Return null if no namespace
 S LT=$G(LT,1) S:LT>7 LT=7 ;Default to 1
 S %H=$H,J=NS_($J#2048)_"-"_(%H#7*86400+$P(%H,",",2))_"_",A=$R(10)
 F  S HL=J_A,A=A+1 L +^XTMP(HL):1 I $T Q:'$D(^XTMP(HL))  L -^XTMP(HL)
 S ^XTMP(HL,0)=$$HTFM^XLFDT(%H+LT)_"^"_$$DT^XLFDT()
 ;L -^XTMP(HL) Leave the unLock to tha caller
 Q HL
 ;
TOK(H) ;Store a Token
 ;H is handle into XTMP
 N J,T,R,%
 S T=$$H3^%ZTM($H)
 S R=$J_"|"_T_"|"_$G(DUZ)_"|"_H
 S ^XTMP(H,"D",0)="|"_$$ENCRYP^XUSRB1(R)_"|"
 S ^XTMP(H,"D2")=$G(DUZ(2))
 S %=$G(IO("IP")) I $L(%),%'?1.3N1P1.3N1P1.3N1P1.3N S %=$P($$ADDRESS^XLFNSLK(%),",")
 S ^XTMP(H,"D3")=%
 S ^XTMP(H,"CLNM")=$G(IO("CLNM"))
 S ^XTMP(H,"JOB",$J)=$G(IO("IP"))
 S ^XTMP(H,"STATUS")="0^New",^("CNT")=0
 L -^XTMP(H) ;Clear Lock
 Q
 ;
REMOVE(HL) ;Remove (kill) a Handle. p523
 I $L($G(HL)) K ^XTMP(HL)
 Q
 ;
CHKASH(HL) ;rpc. Check a Auto Signon Handle
 N HDL,RET,FDA,IEN S HDL=$E(HL,3,999)
 S RET=$$CHECK(HDL)
 I RET>0 D
 . S DUZ("ASH")=1,IEN=DUZ_","
 . I $$GET1^DIQ(200,IEN,7,"I") S FDA(200,DUZ_",",7)=0 D FILE^DIE("K","FDA") ;rwf 403
 D REMOVE(HDL) ;Token only good for one try.
 Q RET
 ;
CHKCCOW(HL) ;rpc. Check a CCOW Auto Signon Handle
 N HDL,RET,T
 S HDL=$$UP^XLFSTR($E(HL,3,999)),T=$P($G(^XTV(8989.3,1,30),5400),U)
 S RET=$$CHECK(HDL,T)
 I RET>0 D
 . ;This CCOW Token good for more that one try.
 . S ^XTMP(HDL,"JOB",$J)=$G(IO("IP"))
 . S ^XTMP(HDL,"STATUS")=(^XTMP(HDL,"STATUS")+1)_"^Active"
 . S ^XUTL("XQ",$J,"HDL")=HDL ;Save handle with job
 . S DUZ("CCOW")=1 ;Flag a CCOW sign-on.
 Q RET
 ;
CHECK(HL,TOUT) ;Check a Token
 N %,J,D,L,M,S,T,CLNM
 S S=$G(^XTMP(HL,0)) I '$L(S) Q "0^Bad Handle"
 S S=$G(^XTMP(HL,"D",0)) I '$L(S) Q "0^Bad Handle" ;Now have real token
 I $E(S)'="|" Q "0^Bad Token"
 S S=$$DECRYP^XUSRB1($E(S,2,$L(S)-1)) I S="" Q "0^Bad Token"
 S J=$P(S,"|"),T=$P(S,"|",2),D=$P(S,"|",3),M=$P(S,"|",4)
 ;Check token time
 S %=$$H3^%ZTM($H),TOUT=$G(TOUT,90) ; P573 changed 20 to 90 JLI
 I T+TOUT<% D REMOVE(HL) Q "0^Token Expired" ;Token good for TOUT or 90 seconds
 ;Check job
 ;Check that token has handle
 I M'=HL Q "0^Bad Token"
 ;Check User
 I $G(^VA(200,D,0))="" Q "0^Bad User"
 ;Do IP check
 S %=$G(IO("IP")),T=0,CLNM=""
 I $L(%),%'?1.3N1P1.3N1P1.3N1P1.3N S CLNM=%,%=$P($$ADDRESS^XLFNSLK(%),",")
 S CLNM=$S($L($G(IO("CLNM"))):IO("CLNM"),$L(CLNM):CLNM,1:"") ;p499
 I $L($G(^XTMP(HL,"D3"))),^XTMP(HL,"D3")=% S T=1
 I 'T,$L(CLNM),$G(^XTMP(HL,"CLNM"))=IO("CLNM") S T=1
 I 'T,$$LOW^XLFSTR($S($L($G(IO("ZIO"))):IO("ZIO"),1:$G(IO)))[$P($G(^XTMP(HL,"CLNM")),".") S T=1  ;ram p596
 I 'T Q "0^Different IP" ;p499
 I $D(^XTMP(HL,"D2")),D>0 S DUZ(2)=^XTMP(HL,"D2")
 D USER^XUS(D)
 Q D
 ;
 ;
CCOWPC(RET) ;Return ap
 N I,XU4
 S RET(0)="" I '$$BROKER^XWBLIB Q
 D GETLST^XPAR(.XU4,"SYS","XUS CCOW VAULT PARAM","Q")
 F I=0,1 S RET(I)=$P($G(XU4(I+1)),"^",2,99)
 Q
 ;
 ;p500
CCOWIP(RET,CLIENTIP) ;rpc. CCOW Auto Signon Handle for middle tiered application servers
 N %
 S %=$G(IO("IP")) ; save original
 ; get actual ip address instead of localhost address if possible
 S IO("IP")=$S($G(CLIENTIP)="127.0.0.1":%,$G(CLIENTIP)="":%,1:$G(CLIENTIP))
 D CCOW(.RET)
 S IO("IP")=% ; revert to original
 Q
 ;
