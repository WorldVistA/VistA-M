XUS1B ;ISCSF/RWF - Auto sign-on ;1/30/08  11:37
 ;;8.0;;**59,337,395,469**;Jul 10, 1995;Build 7
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
AUTOXUS() ;Do the check for XUS and Auto Sign-on
 N %,FG,Y
 I $G(XQXFLG("ASO")) Q 0 ;Already tried once.
 G AUTO
 ;
AUTOXWB() ;Do the check for XWB and Auto Sign-on
 N %,FG,Y
 I $G(XQXFLG("ASO")) Q 0 ;Already tried so skip.
AUTO ;Common code
 I ($T(^XWBCAGNT)="")!($P(XOPT,U,18)="d") S XQXFLG("ZEBRA")=-1 Q 0 ;Disabled
 S Y=$$CHKVIP(),%=0
 I Y>0 S XQXFLG("ASO")=1,%=$$PREF($P(XOPT,U,18),$P($G(^VA(200,Y,200)),U,18))
 I Y>0,'% S Y=0 ;No Auto signon
 I Y>0 S DUZ("DIV")=+FG ;Set Division p469
 Q Y
 ;
CHKVIP() ;Check for a Valid current IP
 N REF,XREF,IEN,R0,ENV,JOB,HNDL
 S IEN=0,ENV=$$ENV,REF=$G(IO("IP")) I $L(REF) D GETHNDL(.HNDL)
 I $L(REF) D LKUP("AS1",$P(REF,":")) Q:IEN>0 IEN
 Q 0
 ;
LKUP(XREF,LK) ;Check one X-ref
 S IX=0
 F  S IX=$O(^XUSEC(0,XREF,LK,IX)) Q:'$L(IX)  D CHK Q:IEN>0
 Q
CHK ;Could this be a good one.
 N R0,R1,JOB
 S R0=$G(^XUSEC(0,IX,0))
 ;Check handle.
 S R1=$P(R0,U,13) I R1]"",$D(HNDL(R1)) D  Q:IEN>0
 . L +^XWB("SESSION",IX_"~"_R1):0 I $T L -^XWB("SESSION",IX_"~"_R1) Q
 . S IEN=+R0,FG=$P(R0,"^",17) Q  ;Found a match
 Q
 ;
ENV() N Y D GETENV^%ZOSV
 Q Y
 ;
PREF(%1,%2) ;
 Q $S($L(%2):%2,1:%1)
 ;
GETHNDL(RET) ;Get the Handles from the Client
 N %,%1,X,XXX
 ;I '$D(XWBUSRNM) Q  ;JLI
 S %=$$CMD^XWBCAGNT(.XXX,"XWB GET HANDLES") Q:'%
 Q:'$O(XXX(0))
 ;build array
 S RET=0,%1=1 F %=1:1:$L(XXX(%1),"^") S X=$P(XXX(%1),"^",%) S:X]"" RET(X)="",RET=RET+1
 Q
