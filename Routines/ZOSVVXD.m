%ZOSV ;SFISC/AC - View commands & special functions. ;10/26/06  08:15
 ;;8.0;KERNEL;**13,65,71,94,107,118,136,215,284,425**;Jul 10, 1995;Build 18
ACTJ() ; # active jobs
 Q $P($$JOBS^%SY,",",2)
 ;
AVJ() ; # available jobs
 N Y S Y=$$JOBS^%SY Q +Y-$P(Y,",",2)
 ;
PASSALL ;
 S Y=$ZC(%SPAWN,"SET TERM/PASTHRU "_$I) U $I:NOTERM Q
NOPASS ;
 S Y=$ZC(%SPAWN,"SET TERM/NOPASTHRU "_$I) U $I:TERM="" Q
 ;
PRGMODE ;
 W ! S ZTPAC=$S($D(^VA(200,+DUZ,.1))#10:$P(^(.1),"^",5),1:""),XUVOL=^%ZOSF("VOL")
 S X="" X ^%ZOSF("EOFF") R:ZTPAC]"" !,"PAC: ",X:60 D LC^XUS X ^%ZOSF("EON") I X'=ZTPAC W "??",*7 Q
 K XMB,XMTEXT,XMY S XMB="XUPROGMODE",XMB(1)=DUZ,XMB(2)=$I D ^XMB:$L($T(^XMB)) D BYE^XUSCLEAN K ZTPAC,X,XMB
 I '$$PROGMODE() D UCI S XUCI=Y,XQZ="PRGM^ZUA[MGR]",XUSLNT=1 D DO^%XUCI ZESCAPE
 E  S $ECODE=",<<PROG>>,"
 ;
PROGMODE() ;
 Q ($V($V($V(0)))#2=0)
 ;
UCI ;
 S Y=$ZC(%UCI),Y=$P(Y,",",1)_","_$P(Y,",",4) Q
 ;
UCICHECK(X) ;
 N %,%1,U,V,Y
 I '(X?3U!(X?3U1","3U)) Q ""
 S U=$ZC(%UCI),V=$P(U,",",4),U=$P(U,","),%1=$P(X,",",2),%=$P(X,",")
 S Y=$ZC(%SETUCI,%,%1),Y=$S(Y:%_","_$S(%1]"":%1,1:V),1:""),V=$ZC(%SETUCI,U,V)
 Q Y
 ;
GETPEER() ;Get the PEER address
 N PEER,NL,$ET S NL="",$ET="S $EC=NL Q NL",PEER=""
 S PEER=$ZC(%TRNLNM,"VISTA$IP")
 I '$L(PEER) S PEER=$&%UCXGETPEER S PEER=$A(PEER,1)_"."_$A(PEER,2)_"."_$A(PEER,3)_"."_$A(PEER,4)
 Q PEER
 ;
SHARELIC(TYPE) ;See if can share a C/S license DSM
 Q  ;Cache only at this time.
 Q:$$VERSION<7.2
 N %,$ET S $ET="S $EC="""" Q"
 I TYPE S %=$$GetCSLic^%LICENSE Q
 I 'TYPE S %=$$ShareLic^%LICENSE
 S $EC=""
 Q
PRIORITY ;
 Q  ;Q:X>10!(X<1)  S X=(X+1)\2-1,Y=$ZC(%SETPRI,X) Q  ;Let VSM do it's thing.
 ;
PRIINQ() ;
 Q $ZC(%GETJPI,0,"PRIB")*2+2
 ;
BAUD S X="UNKNOWN" Q
 ;
LGR() Q $ZR ;Last global ref.
 ;
EC() Q $ZE ;Error code
 ;
DOLRO ;SAVE ENTIRE SYMBOL TABLE IN LOCATION SPECIFIED BY X
 S Y="%" F  S Y=$ZSORT(@Y) Q:Y=""  D  ;code from DEC
 . I $D(@Y)#2 S @(X_"Y)="_Y)
 . I $D(@Y)>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 K %X,%Y,Y Q
 ;
ORDER ;SAVE PARTS OF SYMBOL TABLE IN LOCATION SPECIFIED BY X
 S (Y,Y1)=$P(Y,"*") I $D(@Y)=0 F  S Y=$ZSORT(@Y) Q:Y=""!(Y[Y1)
 Q:Y=""  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 F  S Y=$ZSORT(@Y) Q:Y=""!(Y'[Y1)  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 K %,%X,%Y,Y,Y1
 Q
 ;
PARSIZ ;
 S X=3 Q
 ;
NOLOG ;
 S Y=0 Q
 ;
GETENV ;Get environment Return Y='UCI^VOL/DIR^NODE^BOX LOOKUP'
 S Y=$P($ZU(0),",",1)_"^"_$P($ZU(0),",",2)_"^"_$P($ZC(%GETSYI),",",4)
 S $P(Y,"^",4)=$P(Y,"^",2)_":"_$P(Y,"^",3)
 Q
VERSION(X) ;return DSM version, X=1 - return OS
 N % S %=$ZV
 I %[" V" Q $S($G(X):$P($ZV," V"),1:$P($ZV," V",2))
 Q $S($G(X):$P($ZV," ",1,2),1:$P($ZV," ",3))
 ;
SETNM(X) ;Set name, Trap dup's, Fall into SETENV
 N $ETRAP S $ETRAP="S $ECODE="""" Q"
SETENV ;Set environment X='PROCESS NAME^ '
 S %=$ZC(%SETPRN,$P(X,"^")) Q
 ;
 ;Code moved to %ZOSVKR, Comment out if needed.
LOGRSRC(OPT,TYPE,STATUS) ;record resource usage in ^XTMP("KMPR"
 Q:'$G(^%ZTSCH("LOGRSRC"))  ; quit if RUM not turned on.
 ; call to RUM routine.
 D RU^%ZOSVKR($G(OPT),$G(TYPE),$G(STATUS))
 Q
 ;
SETTRM(X) ;Turn on specified terminators.
 U $I:TERM=X
 Q 1
 ;
DEVOK ;Check Device Availability.  (not complete)
 ;INPUT:  X=Device $I, X1=IOT -- X1 needed for resources
 ;OUTPUT: Y=0 if available, Y=job # if owned, Y=-1 if device does not exists.
 S Y=0 Q:X["::"  I $G(X1)="RES" G RESOK^%ZIS6
 S Y=$ZC(%GETDVI,X,"EXISTS")
 G DV1:Y D DV2 Q:Y=-1  I Y="TERM" S Y=-1 Q
 S Y=-2 Q
DV1 S Y=$ZC(%GETDVI,X,"PID") I Y=$J!($ZC(%GETDVI,X,"SPL")) S Y=0 Q
 I Y,$ZC(%GETJPI,X,"MASTER_PID")=Y G DVOPN
 Q:Y>0  D DV2 G DVOPN:Y="TERM" S Y=$S(Y="DISK":0,Y="MAILBOX":0,Y="TAPE":0,1:-1) Q
DV2 S Y=$ZC(%PARSE,X) I Y="" S Y=-1 Q
 I X]"" S Y=$ZC(%GETDVI,$S(Y]"":Y,1:X),"DEVCLASS") Q
 Q
DVOPN S $ZT="DVERR",Y=0 Q:$D(%ZTIO)
 L:$D(%ZISLOCK) +@%ZISLOCK:60
 O X::$S($D(%ZISTO):%ZISTO,1:0) E  S Y=999 L:$D(%ZISLOCK) -@%ZISLOCK:60 Q
 L:$D(%ZISLOCK) -@%ZISLOCK
 S Y=0 I '$D(%ZISCHK)!$S($D(%ZIS)#2:(%ZIS["T"),1:0) C X Q
 S:X]"" IO(1,X)="" Q
DVERR I $ZE["OPENERR" S Y=-1 Q
 ZQ
 ;
SID() ;Build a System ID
 N J1,J2,J3,T S T="~"
 S J1=$P($ZC(%GETSYI),",",4) ;NODE NAME
 S J2=$ZU(0) ;UCI
 S J3=$ZC(%ENVIDNM) ;Enviroment number,name
 ;S ^RWF("SID",$J,1)=J1,^(2)=J2,^(3)=J3
 Q "1~"_(+J3)_T_$P(J3,",",2)_T_J2_T
 ;
T0 ; start RT clock
 ;S %ZH0=$ZH,%=$P(%ZH0,",",3) S:$E($ZV,10,12)>5.1 %=$E(%,13,23) S XRT0=+$H_","_($P(%,":")*3600+($P(%,":",2)*60)+$P(%,":",3))
 Q
 ;
T1 ; store RT datum w/ZHDIF
 ;S %ZH1=$ZH,%=$P(%ZH1,",",3) S:$E($ZV,10,12)>5.1 %=$E(%,13,23) S XRT1=+$H_","_($P(%,":")*3600+($P(%,":",2)*60)+$P(%,":",3))
 ;S ^%ZRTL(3,XRTL,+XRT1,XRTN,$P(XRT1,",",2))=XRT0_"^^"_($P(%ZH1,",")-$P(%ZH0,","))_"^"_($P(%ZH1,",",7)-$P(%ZH0,",",7))_"^"_($P(%ZH1,",",8)-$P(%ZH0,",",8)) K XRT0,%ZH0,%ZH1
 Q
 ;
ZHDIF ;Display dif of two $ZH's
 W !," CPU=",$J($P(%ZH1,",")-$P(%ZH0,","),6,2),?14," ET=",$J($P(%ZH1,",",2)-$P(%ZH0,",",2),6,1),?27," DIO=",$J($P(%ZH1,",",7)-$P(%ZH0,",",7),5),?40," BIO=",$J($P(%ZH1,",",8)-$P(%ZH0,",",8),5),! Q
 ;
DEVOPN ;List devices opened.
 N %,%B,%I,%L,%X,%X1,%X2,%Y
 S %X1=$V($V(0)+8),%X2=$V(%X1),Y=""
 F %I=1:1 D D1 S %X2=$V(%X2) Q:%X2=%X1
 Q
D1 S %X=$V(%X2+8)
 S %L=$V(%X+4,-1,1),%B=$V(%X+8)
 S %Y=""
 F %=1:1:%L S %Y=%Y_$C($V(%B,-1,1)) S %B=%B+1
 S Y=Y_%Y_"," Q
 ;
