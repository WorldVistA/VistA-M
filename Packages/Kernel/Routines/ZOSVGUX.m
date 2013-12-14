%ZOSV ;SFISC/AC,PUG/TOAD,HOU/DHW - View commands & special functions. ;09/15/08  16:41
 ;;8.0;KERNEL;**275,425,499**;Jul 10, 1995;Build 14
 ;
ACTJ() ; # active jobs
 D:'($D(^XUTL("XUSYS","CNT"))#10)
 . N I,IO,LINE
 . S IO=$IO
 . O "FTOK":(SHELL="/bin/sh":COMMAND="$gtm_dist/mupip ftok "_$V("GVFILE","DEFAULT"):READONLY)::"PIPE" U "FTOK"
 . F I=1:1:3 R LINE
 . O "IPCS":(SHELL="/bin/sh":COMMAND="ipcs -mi "_$TR($P($P(LINE,"::",3),"[",1)," ",""):READONLY)::"PIPE" U "IPCS"
 . F I=1:1 R LINE Q:$ZEO  I 1<$L(LINE,"nattch=") S ^XUTL("XUSYS","CNT")=+$P(LINE,"nattch=",2) Q
 . U IO C "FTOK" C "IPCS"
 Q +$G(^XUTL("XUSYS","CNT"))
 ;
AVJ() ; # available jobs, Limit is in the OS.
 N V,J
 S V=^%ZOSF("VOL"),J=$O(^XTV(8989.3,1,4,"B",V,0)),J=$P($G(^XTV(8989.3,1,4,J,0),"^^1000"),"^",3)
 Q J-$$ACTJ ;Use signon Max
 ;
RTNDIR() ; primary routine source directory
 ; If $ZRO is a single directory, e.g., xxx, returns that directory, e.g., xxx/
 ; If $ZRO is of the form xxx yyy ... returns xxx/
 ; If $ZRO is of the form www(xxx) ... or www(xxx yyy) ... returns xxx/
 Q $P($S(($F($ZRO_" "," ")>$F($ZRO,"("))&$F($ZRO,"("):$P($P($ZRO,")"),"(",2),1:$ZRO)," ")_"/"
 ;
TEMP() ; Return path to temp directory
 ;N %TEMP S %TEMP=$P($$RTNDIR," "),%TEMP=$P(%TEMP,"/",1,$L(%TEMP,"/")-2)_"/t/"
 Q $G(^%ZOSF("TMP"),$G(^XTV(8989.3,1,"DEV"),"/tmp/"))
 ;
PASSALL ;
 U $I:(NOESCAPE:NOTERMINATOR:PASTHRU) Q
NOPASS ;
 U $I:(ESCAPE:TERMINATOR="":NOPASTHRU) Q
 ;
GETPEER() ;Get the IP address of a connection peer
 N PEER
 S PEER=$P($ZTRNLNM("SSH_CLIENT")," ") S:PEER="" PEER=$ZTRNLNM("REMOTEHOST")
 S PEER=$S($L(PEER):PEER,$L($G(IO("IP"))):IO("IP"),$L($G(IO("GTM-IP"))):IO("GTM-IP"),1:"")
 I $G(^XTV(8989.3,1,"PEER"))[PEER S PEER="" ;p499
 Q PEER
 ;
PRGMODE ;Drop into direct mode
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
 S Y=^%ZOSF("PROD") Q
 ;
UCICHECK(X) ;
 Q X
 ;
JOBPAR ; <=====
 N CMD,COMM,IO
 S IO=$IO
 S COMM="/proc/"_X_"/comm"
 O COMM:READONLY U COMM R CMD U IO C COMM
 S Y=$S("mumps"=CMD:^%ZOSF("PROD"),1:"")
 Q
 ;
SHARELIC(TYPE) ;Used by Cache implementations
 Q
 ;
PRIORITY ;
 K Y ; VA has this disabled in general.
 Q
 ;
PRIINQ() ;
 Q 5 ; for now, we're always middle of the road
 ;
BAUD S X="UNKNOWN"
 Q
 ;
LGR() ; Last global reference ($REFERENCE)
 Q $R
 ;
EC() ; Error Code: returning $ZS in format more like $ZE from DSM
 N %ZE
 I $ZS="" S %ZE=""
 S %ZE=$P($ZS,",",2)_","_$P($ZS,",",4)_","_$P($ZS,",")_",-"_$P($ZS,",",3)
 Q %ZE
 ;
DOLRO ;SAVE ENTIRE SYMBOL TABLE IN LOCATION SPECIFIED BY X
 ;S Y="%" F  S Y=$O(@Y) Q:Y=""  D
 ;. I $D(@Y)#2 S @(X_"Y)="_Y)
 ;. I $D(@Y)>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 S Y="%" F  M:$D(@Y) @(X_"Y="_Y) S Y=$O(@Y) Q:Y=""
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
 N %HOST,%V S %V=^%ZOSF("PROD"),%HOST=$$RETURN("hostname -s")
 S Y=$TR(%V,",","^")_"^"_%HOST_"^"_$P(%V,",",2)_":"_%HOST
 Q
 ;
VERSION(X) ;return OS version, X=1 - return OS
 Q $S($G(X):$P($ZV," V"),1:+$P($ZV," V",2))
 ;
OS() ;
 Q "UNIX"
 ;
SETNM(X) ;Set name, Trap dup's, Fall into SETENV
 N $ETRAP S $ETRAP="S $ECODE="""" Q"
SETENV ;Set environment X='PROCESS NAME^ '
 S ^XUTL("XUSYS",$J,0)=$H,^("NM")=X ; workaround
 Q
 ;
SID() ;System ID
 N J1,T S T="~"
 S J1(1)=$ZROUTINES,J1(1)=$P(J1(1)," ")
 S J1(2)=$ZGBLDIR
 Q "1~"_J1(1)_T_J1(2)
 ;
PRI() ;Check if a mixed OS enviroment.
 ;Default return 1 unless we are on the secondary OS.
 ;Only Cache on a VMS/Linux mix is supported now.
 Q 1
 ;
T0 ; start RT clock
 S %ZH0=$S(""'=$T(ZHOROLOG^%POSIX):$$ZHOROLOG^%POSIX,1:$H)
 Q
 ;
T1 ; store RT datum w/ZHDIF
 S %ZH1=$S(""'=$T(ZHOROLOG^%POSIX):$$ZHOROLOG^%POSIX,1:$H)
 Q
 ;
ZHDIF ;Display dif of two $ZH's
 W !," ET=",$J(($P(%ZH1,",")-$P(%ZH0,",")*86400)+($P(%ZH1,",",2)-$P(%ZH0,",",2)),6,2)
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
 U $I:(TERMINATOR=X)
 Q 1
 ;
DEVOK ;
 ;use lsof (list open files)
 ; given a device name in X
 ;INPUT:  X=Device $I, X1=IOT -- X1 needed for resources
 ;OUTPUT: Y=0 if available, Y=job # if owned
 ; Y=-1 if device does not exists.
 ; return Y=0 if not owned, Y=$J of owning job, Y=999 if dev cycling
 ;
 I $G(X1)="RES" G RESOK^%ZIS6
 S Y=0
 Q  ;Let ZIS deal with it.
 ;
DEVOPN ;List of Devices opened.  Linux only
 ;Returns variable Y. Y=Devices owned separated by a comma
 N %I,%X,%Y
 ZSHOW "D":%Y
 S %I=0,Y="",%X=""
 F  S %I=$O(%Y("D",%I)) Q:'%I  S Y=Y_%X_$P(%Y("D",%I)," "),%X=","
 Q
 ;
RETURN(%COMMAND) ; ** Private Entry Point: execute a shell command & return the last line **
 ; %COMMAND is the string value of the Linux command
 N IO,LINE,TMP
 S IO=$IO
 O "COMMAND":(SHELL="/bin/sh":COMMAND=%COMMAND:READONLY)::"PIPE" U "COMMAND"
 F  R TMP Q:$ZEO  S LINE=TMP
 U IO C "COMMAND"
 Q LINE
 ;
STRIPCR(%DIRECT) ; ** Private Entry Point: strip extraneous CR from end of lines of all
 ; routines in %DIRECTORY Linux directory
 ;
 ZSYSTEM "perl -pi -e 's/\r\n$/\n/' "_%DIRECT_"[A-K]*.m"
 ZSYSTEM "perl -pi -e 's/\r\n$/\n/' "_%DIRECT_"[L-S]*.m"
 ZSYSTEM "perl -pi -e 's/\r\n$/\n/' "_%DIRECT_"[T-z]*.m"
 ZSYSTEM "perl -pi -e 's/\r\n$/\n/' "_%DIRECT_"[_]*.m"
 Q
 ;
