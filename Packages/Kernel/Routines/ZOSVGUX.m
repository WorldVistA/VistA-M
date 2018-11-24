%ZOSV ;VEN/SMH,KRM/CJE,FIS/KSB - View commands & special functions. ;Nov 23, 2018@15:02
 ;;8.0;KERNEL;**275,425,499,10001,10002,10004,10005**;Jul 10, 1995;Build 25
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Original Routine authored by Department of Veterans Affairs
 ; Almost the entire routine was rewritten by Sam Habiel, Christopher Edwards, KS Bhaskar
 ;
ACTJ() ; # active jobs
 ; Next call active as of 6.3
 I $T(+0^%PEEKBYNAME)]"" Q $$^%PEEKBYNAME("node_local.ref_cnt",$$DEFREG)
 I ($G(^XUTL("XUSYS","CNT"))<1)!($G(^XUTL("XUSYS","CNT","SEC"))>($$SEC^XLFDT($H)+3600)) D
 . I $$UP^XLFSTR($ZV)["LINUX" D
 .. N I,IO,LINE
 .. S IO=$IO
 .. O "FTOK":(SHELL="/bin/sh":COMMAND="$gtm_dist/mupip ftok "_$$DEFFILE:READONLY)::"PIPE" U "FTOK"
 .. F I=1:1:3 R LINE
 .. O "IPCS":(SHELL="/bin/sh":COMMAND="ipcs -mi "_$TR($P($P(LINE,"::",3),"[",1)," ",""):READONLY)::"PIPE" U "IPCS"
 .. F I=1:1 R LINE Q:$ZEO  I 1<$L(LINE,"nattch=") S ^XUTL("XUSYS","CNT")=+$P(LINE,"nattch=",2) Q
 .. U IO C "FTOK" C "IPCS"
 . ;
 . I $$UP^XLFSTR($ZV)["DARWIN" D  ; OSEHRA/SMH - Should work on Linux too!
 .. ; We previously used lsof against the default file, but that was TOOOOO SLOOOOW.
 .. ; See https://apple.stackexchange.com/questions/81140/why-is-lsof-on-os-x-so-ridiculously-slow
 .. ; Now we just do lsof against processes called mumps, and grep for the ones that have the default region open. xargs is used for trimming.
 .. N %CMD S %CMD="pgrep mumps | xargs -n 1 -I{} lsof -p{} | grep "_$$DEFFILE_" | wc -l | xargs"
 .. S ^XUTL("XUSYS","CNT")=$$RETURN^%ZOSV(%CMD)
 . ;
 . I $$UP^XLFSTR($ZV)["CYGWIN" D
 .. S ^XUTL("XUSYS","CNT")=+$$RETURN^%ZOSV("ps -as | grep mumps | grep -v grep | wc -l")
 . ;
 . S ^XUTL("XUSYS","CNT","SEC")=$$SEC^XLFDT($H)
 Q ^XUTL("XUSYS","CNT")
 ;
AVJ() ; # available jobs, Limit is in the OS.
 N V,J
 S V=^%ZOSF("VOL"),J=$O(^XTV(8989.3,1,4,"B",V,0)),J=$P($G(^XTV(8989.3,1,4,J,0),"^^1000"),"^",3)
 Q J-$$ACTJ ;Use signon Max
 ;
DEFFILE() ; Default Region File Name ; *10004*
 Q $V("GVFILE",$$DEFREG)
 ;
DEFREG() ; Default Region Name; *10004*
 Q $VIEW("REGION","^DD")
 ;
RTNDIR() ; primary routine source directory
 N DIRS
 D PARSEZRO(.DIRS,$ZRO)
 N I F I=1:1 Q:'$D(DIRS(I))  I DIRS(I)[".so" K DIRS(I)
 I '$D(DIRS) S $EC=",U255,"
 QUIT $$ZRO1ST(.DIRS)
 ;
PARSEZRO(DIRS,ZRO) ; Parse $zroutines properly into an array
 ; Eat spaces
 F  Q:($E(ZRO)'=" ")  S ZRO=$E(ZRO,2,1024) ; 1023 is the GT.M maximum
 ;
 N PIECE
 N I
 F I=1:1:$L(ZRO," ") S PIECE(I)=$P(ZRO," ",I)
 N CNT S CNT=1
 F I=0:0 S I=$O(PIECE(I)) Q:'I  D
 . S DIRS(CNT)=$G(DIRS(CNT))_PIECE(I)
 . I DIRS(CNT)["("&(DIRS(CNT)[")") S CNT=CNT+1 QUIT
 . I DIRS(CNT)'["("&(DIRS(CNT)'[")") S CNT=CNT+1 QUIT
 . S DIRS(CNT)=DIRS(CNT)_" " ; prep for next piece
 QUIT
 ;
ZRO1ST(DIRS) ; $$ Get first usable routine directory
 N OUT S OUT="" ; $$ Return; default empty
 N I F I=0:0 S I=$O(DIRS(I)) Q:'I  D  Q:OUT]""  ; 1st directory
 . N %1 S %1=DIRS(I)
 . N SO S SO=$E(%1,$L(%1)-2,$L(%1))
 . S SO=$$UP^XLFSTR(SO)
 . I SO=".SO" QUIT
 . ;
 . ; Parse with (...)
 . I %1["(" DO
 . . S OUT=$P(%1,"(",2)
 . . I OUT[" " S OUT=$P(OUT," ")
 . . E  S OUT=$P(OUT,")")
 . ; no parens
 . E  S OUT=%1
 ;
 ; Add trailing slash
 I OUT]"",$E(OUT,$L(OUT))'="/" S OUT=OUT_"/"
 QUIT OUT
 ;
TEMP() ; Return path to temp directory
 ;N %TEMP S %TEMP=$P($$RTNDIR," "),%TEMP=$P(%TEMP,"/",1,$L(%TEMP,"/")-2)_"/t/"
 Q $G(^%ZOSF("TMP"),$P($G(^XTV(8989.3,1,"DEV"),"/tmp/"),U))
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
 N XMB,XMTEXT,XMY S XMB="XUPROGMODE",XMB(1)=DUZ,XMB(2)=$I D ^XMB:$L($T(+0^XMB)) D BYE^XUSCLEAN K ZTPAC,X,XMB
 D UCI S XUCI=Y D PRGM^ZUA
 I $D(%ut) QUIT
 F  BREAK
 HALT
 ;
PROGMODE() ; In Application mode
 Q 1 ; This was used to control UCI switching, has no meaning in GT.M
 ;
UCI ;
 S Y=^%ZOSF("PROD") Q
 ;
UCICHECK(X) ;
 Q X
 ;
JOBPAR ; <=====
 N CMD,COMM,IO
 S IO=$IO,COMM="/proc/"_X_"/comm"
 O COMM:(READONLY:EXCEPTION="S Y="""" Q") U COMM R CMD U IO C COMM
 S Y=$S("mumps"=$G(CMD):^%ZOSF("PROD"),1:"")
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
 ; NB: Updated in patch *10004* to deal with multiple commas (as in global references)
 N %ZE
 I $ZS="" Q ""
 S %ZE=$P($ZS,",",2)_","_$TR($P($ZS,",",4,999),",","'")_","_$P($ZS,",")_",-"_$P($ZS,",",3)
 Q %ZE
 ;
DOLRO ;SAVE ENTIRE SYMBOL TABLE IN LOCATION SPECIFIED BY X
 ; Old Algorithm
 S Y="%" F  M @(X_"Y)="_Y) S Y=$O(@Y) Q:Y=""
 QUIT
 ;
 ; New Algorithm; faster by 2-6ms
 ;N %11111,Y
 ;ZSHOW "V":%11111
 ;N %00000 F %00000=0:0 S %00000=$O(%11111("V",%00000)) Q:'%00000  S Y=$P(%11111("V",%00000),"=") I Y'["(" M @(X_"Y)="_Y)
 ;QUIT
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
 N %HOST,%V S %V=^%ZOSF("PROD"),%HOST=$P($SYSTEM,",",2) ; Uses env variable gtm_sysid
 S Y=$TR(%V,",","^")_"^"_%HOST_"^"_$P(%V,",",2)_":"_%HOST
 Q
 ;
VERSION(X) ;return OS version, X=1 - return OS
 Q $S($G(X):$P($ZV," ",3,99),1:$P($P($ZV," V",2)," "))
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
 N V S V=$$VERSION(0)
 I +V'<6.2 S %ZH0=$ZH QUIT
 S %ZH0=$S(""'=$T(ZHOROLOG^%POSIX):$$ZHOROLOG^%POSIX,1:$H)
 Q
 ;
T1 ; store RT datum w/ZHDIF
 N V S V=$$VERSION(0)
 I +V'<6.2 S %ZH1=$ZH QUIT
 S %ZH1=$S(""'=$T(ZHOROLOG^%POSIX):$$ZHOROLOG^%POSIX,1:$H)
 Q
 ;
ZHDIF ;Display dif of two $ZH's
 N SC0 S SC0=$P(%ZH0,",",2)
 N SC1 S SC1=$P(%ZH1,",",2)
 N DC0 S DC0=$P(%ZH0,",")*86400
 N DC1 S DC1=$P(%ZH1,",")*86400
 N MCS0 S MCS0=$P(%ZH0,",",3)/1000000
 N MCS1 S MCS1=$P(%ZH1,",",3)/1000000
 ;
 N T0 S T0=SC0+DC0+MCS0
 N T1 S T1=SC1+DC1+MCS1
 ;
 S %ZH2=T1-T0
 QUIT
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
 F  S %I=$O(%Y("D",%I)) Q:'%I  I %Y("D",%I)'["CLOSED" S Y=Y_%X_$P(%Y("D",%I)," "),%X=","
 Q
 ;
RETURN(%COMMAND,JUSTSTATUS) ; [Public] execute a shell command 
 ; - return the last line; or just the status of the command.
 ; %COMMAND is the string value of the Linux command
 N IO,LINE,TMP
 S IO=$IO
 O "COMMAND":(SHELL="/bin/sh":COMMAND=%COMMAND:READONLY)::"PIPE" U "COMMAND"
 F  R TMP:1 Q:$ZEO  S LINE=TMP
 U IO C "COMMAND"
 I $G(JUSTSTATUS) Q $ZCLOSE
 Q $G(LINE)
 ;
 ; *10005* Plan VI Calls for VistA Internationalization
BL(X) ; Byte Length of X in UTF-8 encoding
 Q $ZL(X)
 ;
BE(X,S,E) ; Byte Extract of X in UTF-8 encoding
 Q $ZE(X,S,E)
 ; /*10005*
