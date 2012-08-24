XUS1B ;ISCSF/RWF - Auto sign-on ;10/27/10  15:14
 ;;8.0;KERNEL;**59,337,395,469,543,594**;Jul 10, 1995;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
AUTOXUS() ;Do the check for XUS and Auto Sign-on
 N %,FG,Y
 I $G(XQXFLG("ASO")) Q 0 ;Already tried once.
 G AUTO
 ;
AUTOXWB() ;Do the check for XWB and Auto Sign-on
 N %,FG,Y,NUNOW
 I $G(XQXFLG("ASO")) Q 0 ;Already tried so skip.
 S XUNOW=$$NOW^XLFDT ;p543
AUTO ;Common code
 I ($T(^XWBCAGNT)="")!($P(XOPT,U,18)="d") S XQXFLG("ZEBRA")=-1 Q 0 ;Disabled
 S Y=$$CHKVIP(),%=0
 I Y>0 S %=$$PREF($P(XOPT,U,18),$P($G(^VA(200,Y,200)),U,18))
 I Y>0,'% S Y=0 ;No Auto signon
 ;check parameter, skip set if yes, default is no p594
 I Y>0,'$$GET^XPAR("SYS","XU594",1,"Q") S DUZ(2)=+FG ;Set Division p543
 Q Y
 ;
CHKVIP() ;Check for a Valid current IP
 N REF,XREF,IEN,R0,ENV,JOB,HNDL,XTMP
 ;D SETUP ;To log data for debug
 S IEN=0,ENV=$$ENV,REF=$G(IO("IP")) I $L(REF) D GETHNDL(.HNDL)
 ;Look thru the IP X-ref
 I $L(REF) D LKUP("AS1",$P(REF,":")) ;Will set IEN
 Q IEN
 ;
LKUP(XREF,LK) ;Check one X-ref
 N R0,R1,IX,D1,NM ;p543
 S IX=0,IEN=0
 F  S IX=$O(^XUSEC(0,XREF,LK,IX)) Q:'$L(IX)  D CHK Q:IEN>0
 Q
CHK ;Could this be a good one.
 S R0=$G(^XUSEC(0,IX,0))
 ;Check that IP really matches
 I $P(R0,U,11)'=REF Q  ;p543
 ;Check entry does not have sign-off D/T. p543
 I $P(R0,U,4) Q
 ;If have a Client name check that same as log.
 S NM=$$LOW^XLFSTR($P(R0,U,12))
 I $D(IO("CLNM")),$L(NM),NM'=$$LOW^XLFSTR(IO("CLNM")) Q
 ;Check date within 8 hours p543
 S D1=$$FMDIFF^XLFDT(XUNOW,IX,2) I (D1>28800)!(D1<-5) Q
 ;Check handle. Use timeout on Lock p543
 S R1=$P(R0,U,13) I $L(R1),$D(HNDL(R1)) D
 . L +^XWB("SESSION",IX_"~"_R1):DILOCKTM I $T L -^XWB("SESSION",IX_"~"_R1) Q
 . ;Remove D LOG after debug.
 . S IEN=+R0,FG=$P(R0,"^",17),XQXFLG("ASO")=IX ;D LOG Q  ;Found a match
 . Q
 Q
 ;
ENV() N Y D GETENV^%ZOSV
 Q Y
 ;
PREF(%1,%2) ;
 Q $S($L(%2):%2,1:%1)
 ;
GETHNDL(RET) ;Get the Handles from the Client
 N %,%1,X,XXX,TS
 ;Don't call Terminal servers/Proxy's
 S TS=$G(IO("IP"))
 I $L(TS),$O(^XTV(8989.3,1,405.2,"B",TS,0)) S XQXFLG("ZEBRA")=-1 Q  ;Disable to TS and Proxy's
 S %=$$CMD^XWBCAGNT(.XXX,"XWB GET HANDLES") I '% S XQXFLG("ZEBRA")=-1 Q  ;Disable on Timeout p543
 Q:'$O(XXX(0))
 ;build array
 S RET=0,%1=1 F %=1:1:$L(XXX(%1),"^") S X=$P(XXX(%1),"^",%) S:X]"" RET(X)="",RET=RET+1
 Q
 ;Temp for data collection
SETUP ;
 N N1,N2
 I '$D(^XTMP("XUSP543","CNT")) S ^XTMP("XUSP543",0)=$$HTFM^XLFDT($H+30)_"^"_XUNOW,^("CNT")=0
 S N1="XUSP543",N2="CNT"
 X "S XTMP=$INCREMENT(^XTMP(N1,N2))"
 S ^XTMP("XUSP543",XTMP,0)=$G(IO("IP"))_U_$G(IO("ZIO"))_U_XUNOW
 Q
 ;
LOG ;Log more data
 M ^XTMP("XUSP543",XTMP,"HNDL")=HNDL
 S ^XTMP("XUSP543",XTMP,"R0")=R0,^("R1")=R1,^("IX")=IX
 Q
