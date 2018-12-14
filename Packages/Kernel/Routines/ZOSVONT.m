%ZOSV ;SFISC/AC - $View commands for Open M for NT.  ;Dec 06, 2018@11:52
 ;;8.0;KERNEL;**34,94,107,118,136,215,293,284,385,425,440,499,10002,10005**;Jul 10, 1995;Build 24
 ;
 ; *10002,*10005 changes (c) 2018 Sam Habiel
 ; Licensed under Apache 2
 ;
ACTJ() ;# Active jobs
 N %,V,Y S V=$$VERSION()
 I V<5 D  Q Y
 . S %=0 F Y=0:1 S %=$ZJOB(%) Q:%=""
 S Y=$system.License.LUConsumed() ;Cache 5 up
 Q Y
AVJ() ;# available jobs
 N %,AVJ,V,ZOSV,$ET
 S V=+$$VERSION()
 ;Cache 3 and 4
 ;maxpid: from %SS
 I V<5 D  Q AVJ
 . N PORT,T,X,MAXPID,LMFLIM
 . S $ET="",MAXPID=$V($ZU(40,2,118),-2,4)
 . X "S ZOSV=$ZU(5),%=$ZU(5,""%SYS"") S LMFLIM=$$inquire^LMFCLI,%=$ZU(5,ZOSV)" ;Get the license info
 . ;Add together the enterprise and division licenses avaliable
 . S X=$P(LMFLIM,";",2)+$P($P(LMFLIM,"|",2),";",2)
 . S T=+LMFLIM+$P(LMFLIM,"|",2) ;Check the license total
 . S AVJ=$S(T<MAXPID:X,1:MAXPID-$$ACTJ) ;Return the smaller of license or pid
 ;To get available jobs from Cache 5.0 up
 I V'<5 D  Q AVJ
 . X "S AVJ=$system.License.LUAvailable()"
 ;Return fixed value not known version
 Q 15
 ;
PRIINQ() ;
 Q 8
 ;
UCI ;Current UCI,VOL
 S Y=$ZU(5)_","_^%ZOSF("VOL") Q
 ;
UCICHECK(X) ;Check if valid namespace (UCI)
 N Y,%
 S %=$P(X,",",1),Y=0 I $ZU(90,10,%) S Y=%
 Q Y
 ;
GETPEER() ;Get the PEER tcp/ip address
 N PEER,NL,$ET S NL="",PEER="",$ET="S $EC=NL Q NL"
 I $$OS="VMS" S PEER=$ZF("TRNLNM","VISTA$IP")
 I '$L(PEER) S PEER=$ZU(111,0) S:$L(PEER) PEER=$A(PEER,1)_"."_$A(PEER,2)_"."_$A(PEER,3)_"."_$A(PEER,4)
 I $G(^XTV(8989.3,1,"PEER"))[PEER S PEER="" ;p499
 Q PEER
 ;
SHARELIC(TYPE) ;See if can share a C/S license
 ;Per Sandy Waal 10/18/2003: With Cache 5.0, your telnet and IP connections are now handled properly.
 ;N %,%N,%2,UID,%V,$ET S $ET="S $EC="""" Q",%V=$$VERSION()
 ;I %V'<5 Q
 ;Type is 1 for C/S and 0 for Telnet
 ;I %V<3.1 X:TYPE "S %N=$ZU(5),%2=$ZU(5,""%SYS""),%2=$$GetLic^LMFCLI,%N=$ZU(5,%N)" Q
 ;I %V<5 S:TYPE %=$$GetCSLic^%LICENSE S:'TYPE %=$$ShareLic^%LICENSE
 ;S $EC=""
 Q
 ;
JOBPAR ;See if X points to a valid Job. Return its UCI.
 N NL,$ET S Y="",NL="",$ET="S $EC=NL Q"
 I $D(^$JOB(X)) S Y=$V(-1,X),Y=$P(Y,"^",14)_","_^%ZOSF("VOL")
 Q
 ;
NOLOG ;4096 is switch 12 - sign on inhibited.
 S Y="$V(0,-2,4)\4096#2" Q
 ;
PROGMODE() ;Check if in PROG mode
 Q $ZJOB#2
 ;
PRGMODE ;
 N X,XMB,XQZ,XUCI,XUSLNT,XUVOL,Y,ZTPAC
 W ! S ZTPAC=$S('$D(^VA(200,+DUZ,.1)):"",1:$P(^(.1),U,5)),XUVOL=^%ZOSF("VOL")
 S X="" X ^%ZOSF("EOFF") R:ZTPAC]"" !,"PAC: ",X:60 D LC^XUS X ^%ZOSF("EON") I X'=ZTPAC W "??"_$C(7) Q
 S XMB="XUPROGMODE",XMB(1)=DUZ,XMB(2)=$I D ^XMB:$L($T(^XMB)) D BYE^XUSCLEAN K ZTPAC,X,XMB
 D UCI S XUCI=Y,XQZ="PRGM^ZUA[MGR]",XUSLNT=1 D DO^%XUCI D ^%PMODE U $I:(:"+B+C+R") S $ZT="" Q
 Q
LGR() ;Last Global ref.
 N $ET,NL S NL="",$ET="S $EC=NL Q NL"
 Q $ZR
 ;
EC() ;Error code
 Q $ZE
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
PARSIZ ;Old and not used.
 S X=3
 Q
 ;
DEVOPN ;List of Devices opened, Not used
 ;Returns variable Y. Y=Devices owned separated by a comma
 Q
 ;
DEVOK ;
 S Y=0,X1=$G(X1) Q:X=2  Q:(X1="HFS")!(X1="SPL")!(X1="MT")!(X1="CHAN")  ;Quit w/ OK for HFS, Spool, MT, TCP/IP
 G:X1="RES" RESOK^%ZIS6
 N $ET S $ET="D OPNERR Q"
 O X::$S($D(%ZISTO):%ZISTO,1:0) E  S Y=999 Q  ;G NOPN
 S Y=0 I '$D(%ZISCHK)!($G(%ZIS)["T") C X Q
 S:X]"" IO(1,X)="" Q
 Q
 ;
OPNERR S $EC="",Y=-1 Q
 ;
GETENV ;Get environment  (UCI^VOL^NODE^BOX:VOLUME)
 N %,%1 S %=$$VERSION,%1=$ZU(86),%1=$S(%<3.1:$P(%1,"*",3),1:$P(%1,"*",2))
 D UCI S Y=$P(Y,",")_"^"_^%ZOSF("VOL")_"^"_$ZU(110)_"^"_^%ZOSF("VOL")_":"_%1
 Q
VERSION(X) ;return Cache version, X=1 - return full name
 Q $S($G(X):$P($ZV,")")_")",1:$P($P($ZV,") ",2),"("))
 ;
OS() ;Return the OS NT, VMS, Unix
 Q $S($ZV["VMS":"VMS",$ZV["UNIX":"UNIX",$ZV["Linux":"UNIX",$ZV["Windows":"NT",$ZV["NT":"NT",1:"UNK")
 ;
SETNM(X) ;Set name, Fall into SETENV
SETENV ;Set environment
 N Q,$ET,$ES S $ET="S $EC="""" Q"
 I $$OS="VMS" S Q=$ZF("SETPRN",$E(X,1,15))
 Q
 ;
SID() ;System ID Ver 1
 N %1,%2,%3,%4,%5,T S T="~"
 S %1=$ZU(5) ;namespace
 S %2=$ZU(12,"") ;directory
 I '$L(%2),$$VERSION'<5.2 S %2=$$defdir^%SYS.GLO(%1) ;remote directory
 S %3=$G(^XTV(8989.3,1,"SID")),%4=$P(%3,"^",4),%5=$P(%3,"^",5)
 I $L(%4),$L(%5),%2[%4 S %2=$P(%2,%4)_%5_$P(%2,%4,2,9)
 S %3=%1_T_%2 ;namespace~directory
 Q "1~"_%3
 ;
PRI() ;Check if a mixed OS enviroment.
 ;Default return 1 unless we are on the secondary OS.
 ;Only Cache on a VMS(1)/Linux or NT(2) mix is supported now.
 N % S %=1
 I $P(^XTV(8989.3,1,0),"^",5),$$OS'="VMS" S %=2
 Q %
 ;
HFSREW(IO,IOPAR) ;Rewind Host File.
 S $ZT="HFSRWERR"
 C IO O @(""""_IO_""""_$S(IOPAR]"":":"_IOPAR_":1",1:":1")) I '$T Q 0
 Q 1
HFSRWERR ;Error encountered
 Q 0
LOGRSRC(OPT,TYPE,STATUS) ;record resource usage in ^XTMP("KMPR"
 Q:'$G(^%ZTSCH("LOGRSRC"))  ; quit if RUM not turned on.
 ; call to RUM routine.
 D RU^%ZOSVKR($G(OPT),$G(TYPE),$G(STATUS))
 Q
SETTRM(X) ;Turn on specified terminators.
 U $I:(:"+T":X)
 Q 1
 ;
T0 ; start RT clock, obsolete
 ;S XRT0=$H
 Q
T1 ; store RT datum, obsolete
 ;S ^%ZRTL(3,XRTL,+$H,XRTN,$P($H,",",2))=XRT0 K XRT0
 Q
RETURN(%COMMAND,JUSTSTATUS) ; [Public] execute a shell command - *10002* OSE/SMH
 ; - return the last line; or just the status of the command.
 ; %COMMAND is the string value of the Linux/Windows command
 ;
 ; OSE/SMH: Cache implementation notes:
 ;
 ; - I don't see a way for Cache to suppress output of $ZF or
 ; alternately to return the status of "QR" open. That's why
 ; we have two different implentations for status vs no status.
 ;
 ; "QR" open note: The default timeout for close is 30 seconds. If the
 ; process is long-lived, we will not close. I don't know if that's
 ; the best way to do things right now.
 ;
 I $G(JUSTSTATUS) Q $ZF(-1,%COMMAND)
 ;
 N OLDIO S OLDIO=$IO
 O %COMMAND:"QR":2
 E  Q -1
 N % S %=$System.Process.SetZEOF(1) ; Prevent Cache from throwing an error at EOF
 U %COMMAND
 N OUT R OUT:2
 U OLDIO C %COMMAND
 Q OUT
 ;
 ; *10005* Plan VI Calls for VistA Internationalization
BL(X) ; Byte Length of X in UTF-8 encoding
 Q $L($ZCONVERT(string,"O","UTF8"))
 ;
BE(X,S,E) ; Byte Extract of X in UTF-8 encoding
 Q $E($ZCONVERT(string,"O","UTF8"),S,E)
 ;
ENV(X) ; Get Environment Variable from Operating System
 Q $SYSTEM.Util.GetEnviron(X)
 ; /*10005*
