%ZOSV ;ISF/STAFF - View commands & special functions (GT.M). ;09/15/08  14:45
 ;;8.0;KERNEL;**275,425,499**;Jul 10, 1995;Build 14
 ; for GT.M for VMS, version 4.3
 ;
ACTJ() ; # active jobs
 ;Keep active count in global
 Q $G(^XUTL("XUSYS","CNT"))
 ;Long way that would work
 ;N %IMAGE S %IMAGE=$ZGETJPI($J,"IMAGNAME")
 ;N Y S Y=0
 ;N %PID S %PID=0
 ;F  S %PID=$ZPID(%PID) Q:'%PID  I $ZGETJPI(%PID,"IMAGNAME")=%IMAGE S Y=Y+1
 ;Q Y
 ;
AVJ() ; # available jobs, Limit is in the OS.
 N V,J
 S V=^%ZOSF("VOL"),J=$O(^XTV(8989.3,1,4,"B",V,0)),J=$P($G(^XTV(8989.3,1,4,J,0),"^^1000"),"^",3)
 Q J-$$ACTJ ;Use signon Max
 ;
PASSALL ;
 U $I:(PASTHRU) Q
NOPASS ;
 U $I:(NOPASTHRU) Q
 ;
GETPEER() ;Get the IP address of a connection peer
 N PEER
 S PEER=$ZTRNLNM("VISTA$IP")
 I $G(^XTV(8989.3,1,"PEER"))[PEER S PEER="" ;p499
 Q $S($L(PEER):PEER,$L($G(IO("GTM-IP"))):IO("GTM-IP"),1:"")
 ;
PRGMODE ;
 N X,XUCI,XUSLNT
 W ! S ZTPAC=$P($G(^VA(200,+DUZ,.1)),"^",5),XUVOL=^%ZOSF("VOL")
 S X="" X ^%ZOSF("EOFF") R:ZTPAC]"" !,"PAC: ",X:60 D LC^XUS X ^%ZOSF("EON") I X'=ZTPAC W "??",$C(7) Q
 N XMB,XMTEXT,XMY S XMB="XUPROGMODE",XMB(1)=DUZ,XMB(2)=$I D ^XMB:$L($T(^XMB)) D BYE^XUSCLEAN K ZTPAC,X,XMB
 D UCI S XUCI=Y D PRGM^ZUA
 F  BREAK
 HALT
 ;
PROGMODE() ; In Application mode
 Q 0 ; This was used to control UCI switching, has no meaning in GT.M
 ;
UCI ;
 S Y="VAH,"_^%ZOSF("VOL") Q
 ;
UCICHECK(X) ;
 Q 1
 ;
TEMP() ; Return path to temp directory
 ;N %TEMP S %TEMP=$P($$RTNDIR," "),%TEMP=$P(%TEMP,"/",1,$L(%TEMP,"/")-2)_"/t/"
 Q $G(^%ZOSF("TMP"),$G(^XTV(8989.3,1,"DEV"),"USER$:[TEMP]"))
 ;
JOBPAR ;is job X valid on system, return UCI in Y.
 N $ES,$ET,J S $ET="Q:$ES>0  S Y="""" G JOBPX^%ZOSV"
 S Y=""
 S J=$ZGETJPI(X,"PRI")
 I $L(J) S Y=$P(^%ZOSF("PROD"),",")
JOBPX S $EC=""
 Q
 ;
SHARELIC(TYPE) ;Used by Cache implementations
 Q
 ;
PRIORITY ;The VA has this disabled in general.
 Q
 ;
PRIINQ() ;
 N PRI S PRI=$ZGETJPI($J,"PRI")
 Q $S(PRI=0:1,PRI=1:3,PRI=2:5,PRI=3:7,PRI=4:9,1:10)
 ;
BAUD S X="UNKNOWN" Q
 ;
LGR() Q $R ; Last global reference ($REFERENCE)
 ;
EC() ; Error Code: returning $ZS in format more like $ZE from DSM
 N %ZE
 I $ZS="" Q ""
 S %ZE=$P($ZS,",",2)_","_$P($ZS,",",4)_","_$P($ZS,",")_",-"_$P($ZS,",",3)
 Q %ZE
 ;
DOLRO ;SAVE ENTIRE SYMBOL TABLE IN LOCATION SPECIFIED BY X
 ;S Y="%" F  S Y=$O(@Y) Q:Y=""  D
 ;. I $D(@Y)#2 S @(X_"Y)="_Y)
 ;. I $D(@Y)>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 S Y="%" F  M:$D(@Y) @(X_"Y)="_Y) S Y=$O(@Y) Q:Y=""
 Q
 ;
ORDER ;SAVE PART OF SYMBOL TABLE IN LOCATION SPECIFIED BY X
 N %
 S (Y,%)=$P(Y,"*",1) ;I $D(@Y)=0 F  S Y=$O(@Y) Q:Y=""!(Y[Y1)
 Q:Y=""
 ;S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 ;F  S Y=$O(@Y) Q:Y=""!(Y'[Y1)  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 F  M:$D(@Y) @(X_"Y)="_Y) S Y=$O(@Y) Q:Y=""!(Y'[%)
 Q
 ;
PARSIZ ;
 S X=3 Q
 ;
NOLOG ;
 S Y=0 Q
 ;
GETENV ;Get environment Return Y='UCI^VOL^NODE^BOX LOOKUP'
 N %V,%HOST S %HOST=$ZGETSYI("NODENAME"),%V=^%ZOSF("PROD")
 S Y=$TR(%V,",","^")_"^"_%HOST_"^"_$P(%V,",",2)_":"_%HOST
 Q
 ;
VERSION(X) ;return OS version, X=1 - return OS
 Q $S($G(X):$P($ZV," V"),1:+$P($ZV," V",2))
 ;
OS() ;
 Q "VMS"
 ;
RTNDIR() ;primary routine source directory
 ;Assume dat1$:[gtm.o]/src=(dat1$:[gtm.r]),gtm$dist
 N % S %=$P($ZRO,",")
 I %["/SRC" S %=$P($P($P(%,"(",2),")",1),",")
 Q %
 ;
SETNM(X) ;Set name, Trap dup's, Fall into SETENV
 N $ETRAP S $ETRAP="S $ECODE="""" Q"
 ;
SETENV ;Set environment X='PROCESS NAME^ '
 ;workaround for GT.M
 S ^XUTL("XUSYS",$J,0)=$H,^("NM")=X,^("PID")=$$FUNC^%DH($J)
 Q
 ;
SID() ;System ID
 N J1,T S T="~"
 S J1(1)=$ZROUTINES
 S J1(2)=$ZGBLDIR
 Q "1~"_J1(1)_T_J1(2)
 ;
PRI() ;Check if a mixed OS enviroment.
 ;Default return 1 unless we are on the secondary OS.
 ;Only Cache on a VMS/Linux mix is supported now.
 Q 1
 ;
T0 ; start RT clock
 Q
 ;
T1 ; store RT datum, Obsolete
 Q
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
DEVOK ;
 ;INPUT:  X=Device $I, X1=IOT -- X1 needed for resources
 ;OUTPUT: Y=0 if available, Y=job # if owned
 ; Y=-1 if device does not exists.
 ; return Y=0 if not owned, Y=$J of owning job, Y=999 if dev cycling
 ;
 S Y=0,X1=$G(X1) Q:(X1="HFS")!(X1="MT")!(X1="CHAN")
 I X1="RES" G RESOK^%ZIS6
 S Y=0
 Q  ;Let ZIS deal with it.
 ;
 Q
LPC(X) ;ZCRC(X)
 N R,I
 S R=$ZBITSTR(8,0)
 F I=1:1:$L(X) S R=$ZBITXOR(R,$C(0)_$E(X,I))
 Q $A(R,2)
