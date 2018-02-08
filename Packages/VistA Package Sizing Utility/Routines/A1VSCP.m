A1VSCP ;Albany FO/GTS - VistA Package Sizing Manager; 12-JUL-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
 ;
EN(XPID) ; -- main entry point for A1VS PKG EXT CRT PARAM
 ;INPUT: XPID - $JOB value of ^XTMP("A1SIZE") array
 ;
 D EN^VALM("A1VS PKG EXT CRT PARAM")
 Q
 ;
HDR ; -- header code
 NEW XSYSTEM,XDATE,DIRHEAD,SPCPAD
 ;
 SET XDATE=$P(^XTMP("A1SIZE",XPID,0),"^")
 SET XSYSTEM=$P(^XTMP("A1SIZE",XPID,0),"^",2)
 SET XDATE=$$FMTE^XLFDT(XDATE,"1P")
 SET:XDATE']"" XDATE="undefined"
 SET:XSYSTEM']"" XSYSTEM="undefined"
 ;
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Package Parameters"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^A1VSLM()_"     Build: "_$$BLDNUM^A1VSLM()
 SET DIRHEAD="System: "_XSYSTEM_"    Extract PID:"_XPID_"     Date: "_XDATE
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 Q
 ;
INIT ; -- init variables and list array
 NEW PARMROOT
 SET VALMCNT=0
 SET PARMROOT="^TMP(""A1SIZE"","_$J_")" ;Result Param File array
 FOR  SET PARMROOT=$QUERY(@PARMROOT) QUIT:PARMROOT=""  Q:$QSUBSCRIPT(PARMROOT,2)="IDX"  Q:$QSUBSCRIPT(PARMROOT,1)'="A1SIZE"  DO
 . DO SPLITADD^A1VSLAPI(.VALMCNT,@PARMROOT,1)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
KILL ; -- Cleanup local and global arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("A1VS PKG MAN NEW PARAM",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
 ;Action PROTOCOL entry points
REDISPRM ; -- Redisplay Paramters file
 ; -- Protocol: A1VS PKG EXT REDISP PARAM ACTION
 ;
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Package Parameters"
 SET VALMBG=1
 DO KILL
 DO INIT
 SET VALMBCK="R"
 QUIT
 ;
REDISCRT ; -- Redisplay Parameter file corrections list
 ; -- Protocol: A1VS PKG EXT DISP CORRECTIONS ACTION
 ;
 SET VALMHDR(1)="     VistA Package Size Analysis Manager - Package Parameter Corrections"
 SET VALMBG=1
 DO KILL
 SET VALMCNT=0
 SET PARMROOT="^TMP(""A1VS-FILERPT"","_$J_")"
 FOR  SET PARMROOT=$QUERY(@PARMROOT) QUIT:PARMROOT=""  Q:$QSUBSCRIPT(PARMROOT,1)'="A1VS-FILERPT"  DO
 . IF @PARMROOT["file number notes" DO ADD^A1VSLAPI(.VALMCNT," ")
 . DO ADD^A1VSLAPI(.VALMCNT,@PARMROOT)
 SET VALMBCK="R"
 QUIT
 ;
WRPARMFL ; Write Parameter File to VistA Package Size Default Directory
 ; -- Protocol: A1VS PKG EXT PARAM WRT ACTION
 ;
 NEW POPERR,PKGROOT,SUB3,SUB4,EXTDIR,FILENME,NOWDT,INITIAL
 SET POPERR=0
 SET NOWDT=$$FMTE^XLFDT($$NOW^XLFDT,"2M")
 SET NOWDT=$TR(NOWDT,"/","-")
 SET NOWDT=$TR(NOWDT,"@","_")
 SET NOWDT=$TR(NOWDT,":","")
 SET INITIAL=$P($G(^VA(200,DUZ,0)),"^",2)
 IF INITIAL']"" SET INITIAL="<unk>"
 SET EXTDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 SET FILENME="XTMPSIZE"_"_"_INITIAL_NOWDT_".DAT"
 DO JUSTPAWS^A1VSLAPI("Parameter file: "_FILENME_", will be created.")
 DO OPEN^%ZISH("XTMP",EXTDIR,FILENME,"A")
 SET:POP POPERR=POP
 QUIT:POPERR
 U IO
 SET PKGROOT="^TMP(""A1SIZE"","_$J_")"
 SET INSCTRT="^TMP(""A1SIZE"","_$J_")"
 FOR  SET PKGROOT=$QUERY(@PKGROOT) QUIT:PKGROOT']""  Q:$QSUBSCRIPT(PKGROOT,1)'="A1SIZE"  DO
 . SET SUB3=$QSUBSCRIPT(PKGROOT,3)
 . SET SUB4=$QSUBSCRIPT(PKGROOT,4)
 . IF $G(SUB4)'="",$G(SUB3)'="",$G(@INSCTRT@(SUB4,SUB3))'="" W !,@INSCTRT@(SUB4,SUB3)_"^*"
 . WRITE !,@PKGROOT
 D CLOSE^%ZISH("XTMP")
 SET VALMBCK="R"
 QUIT
  ;
SNDNPFLE ;Send New Paremater file & report
 ; -- Protocol: A1VS PKG MGR NEW PARAM MAIL ACTION
 ;  
 NEW A1INSTMM,A1INSTVA,A1TASKMM,A1TASKVA,A1TOMM,A1TOVA,XMERR,XMZ,A1LPCNT,A1TYPE,A1SVSUBJ,XQSND
 ;
 ;A1SVSUBJ - Subject of message generated 
 ;XQSND    - User's DUZ, Group Name, or S.server name
 SET XQSND=DUZ
 SET A1SVSUBJ="VistA Package Parameter File"
 ;
 DO FULL^VALM1
 ;
 S A1INSTMM("ADDR FLAGS")="R"  ;Do not Restrict addressing
 S A1TYPE="S"
 K XMERR
 D TOWHOM^XMXAPIU(DUZ,,A1TYPE,.A1INSTMM)
 ;
 ;Check Network addresses and mail attachmt
 S A1INSTVA("ADDR FLAGS")="R"  ;Do not Restrict addressing
 S A1INSTVA("FROM")="VISTA_PACKAGE_MANAGER_RPT"
 S A1SVSUBJ=$E(A1SVSUBJ,1,65)
 S A1LPCNT=""
 F  S A1LPCNT=$O(^TMP("XMY",$J,A1LPCNT)) Q:A1LPCNT=""  S A1TOVA(A1LPCNT)=""
 ;
 I +$G(XMERR)'>0 DO
 .W !,"                                    [Creating attachments..."
 .D OUTLKARY("^TMP(""A1SIZE"","_$J_")","^TMP($J,""A1NETMSG"")",A1SVSUBJ,1)
 .D SENDMSG^XMXAPI(XQSND,A1SVSUBJ,"^TMP($J,""A1NETMSG"")",.A1TOVA,.A1INSTVA,.A1TASKVA)
 ;
 K ^TMP("XMY",$J),^TMP("XMY0",$J),^TMP($J,"A1NETMSG")
 ;
 SET VALMBCK="R"
 QUIT
 ;
OUTLKARY(A1PMARY,A1OTLK,A1SVSUBJ,A1RT) ;Create attachmts array
 ;INPUT:
 ;  A1PMARY  - Array containing Package Parameter File text
 ;  A1OTLK   - Array containing message text for network addresses
 ;  A1SVSUBJ - Message subject
 ;  A1RT     - Real Time processing from UI
 ;
 N A1FILNAM,A1DTTM,A1CRLF,A1STR,A1NODE,A1OUTNOD,A1NODATA,A1CHAR,NOWDT,INITIAL,OTLKNDE,ERROOT
 S:+$G(A1RT)=0 A1RT=0
 S:+$G(A1RT) A1CHAR=0
 S A1STR=""
 S A1NODATA=0
 S A1CRLF=$C(13,10)
 S A1DTTM=$$NOW^XLFDT
 K @A1OTLK
 S @A1OTLK@(1)="Attachment Generated......: "_$$FMTE^XLFDT(A1DTTM)_A1CRLF
 S @A1OTLK@(2)=" "
 S @A1OTLK@(3)="Extract Requested......: "_A1SVSUBJ_A1CRLF
 S @A1OTLK@(4)=" "
 ;
 SET NOWDT=$$FMTE^XLFDT(A1DTTM,"2M")
 SET NOWDT=$TR(NOWDT,"/","-")
 SET NOWDT=$TR(NOWDT,"@","_")
 SET NOWDT=$TR(NOWDT,":","")
 SET INITIAL=$P($G(^VA(200,DUZ,0)),"^",2)
 IF INITIAL']"" SET INITIAL="<unk>"
 SET A1FILNAM="XTMPSIZE"_"_"_INITIAL_NOWDT_".DAT"
 ;
 S @A1OTLK@(5)="Attached Package Parameter file.....: "_A1FILNAM_A1CRLF
 S:($O(@A1PMARY@(0))="") A1NODATA=1
 S @A1OTLK@(6)=" "
 S:(A1NODATA=0) @A1OTLK@(7)=" "
 S:(A1NODATA=1) @A1OTLK@(7)="No Parameter List to file and attach!"
 SET OTLKNDE=7
 ;
 SET ERROOT="^TMP(""A1VS-FILERPT"","_$J_")"
 IF ($O(@ERROOT@(0))'="") DO
 . SET @A1OTLK@(9)="Report of creating Package File Number Corrections made when creating "_A1FILNAM_"."
 . SET @A1OTLK@(10)=" "
 . SET @A1OTLK@(11)="NOTE: Undefined File Number Ranges and *High/*Low File Numbers are reported."
 . SET @A1OTLK@(12)="File Number multiple entries not included in File Number Ranges multiple are"
 . SET @A1OTLK@(13)="added to the Package file parameter ranges and indicated in this report."
 . SET @A1OTLK@(14)="*High/*Low File Numbers are NOT added to File Number Parameter range.  If only"
 . SET @A1OTLK@(15)="*High/*Low numbers are defined for a Package's files then that is reported."
 . SET @A1OTLK@(16)=" "
 . SET OTLKNDE=16
 SET:($O(@ERROOT@(0))="") @A1OTLK@(8)="No File corrections made in "_A1FILNAM_"!"
 FOR  SET ERROOT=$QUERY(@ERROOT) QUIT:ERROOT=""  Q:$QSUBSCRIPT(ERROOT,1)'="A1VS-FILERPT"  Q:$QSUBSCRIPT(ERROOT,2)'=$J  DO
 . SET OTLKNDE=OTLKNDE+1
 . IF @ERROOT["file number notes" SET @A1OTLK@(OTLKNDE)=" " SET OTLKNDE=OTLKNDE+1
 . SET @A1OTLK@(OTLKNDE)=@ERROOT
 ;
 ;Begin file output
 SET OTLKNDE=OTLKNDE+1
 S @A1OTLK@(OTLKNDE)=$$UUBEGFN^A1VSLAPI(A1FILNAM)
 S A1NODE=A1PMARY
 S A1OUTNOD=OTLKNDE
 ;;
 FOR  SET A1NODE=$QUERY(@A1NODE) QUIT:(A1NODE="")  Q:($QSUBSCRIPT(A1NODE,1)'="A1SIZE")  Q:($QSUBSCRIPT(A1NODE,2)'=$J)  DO
 . I +$G(A1RT) D:A1NODE#100=0 HANGCHAR^A1VSLAPI(.A1CHAR) ; Display progress character
 . S A1STR=A1STR_@A1NODE_A1CRLF
 . D ENCODE^A1VSLAPI(.A1STR,.A1OUTNOD,A1OTLK)
 ;
 F  Q:$L(A1STR<45)  D ENCODE^A1VSLAPI(.A1STR,.A1OUTNOD,A1OTLK)
 S:(A1STR'="") @A1OTLK@(A1OUTNOD+1)=$$UUEN^A1VSLAPI(A1STR)
 S @A1OTLK@(A1OUTNOD+2)=" "
 S @A1OTLK@(A1OUTNOD+3)="end"
 ;
 QUIT
