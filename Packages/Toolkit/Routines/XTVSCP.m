XTVSCP ;Albany FO/GTS - VistA Package Sizing Manager; 12-JUL-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
EN(XPID) ; -- main entry point for XTVS PKG EXT CRT PARAM
 ;INPUT: XPID - $JOB value of ^XTMP("XTSIZE") array
 ;
 D EN^VALM("XTVS PKG EXT CRT PARAM")
 Q
 ;
HDR ; -- header code
 NEW XSYSTEM,XDATE,DIRHEAD,SPCPAD
 ;
 SET XDATE=$P($P(^XTMP("XTSIZE",XPID,0),"^",3),"-")
 SET XSYSTEM=$P(^XTMP("XTSIZE",XPID,0),"^",4)
 SET XDATE=$$FMTE^XLFDT(XDATE,"1P")
 SET:XDATE']"" XDATE="undefined"
 SET:XSYSTEM']"" XSYSTEM="undefined"
 ;
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Package Parameters"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^XTVSLM()_"     Build: "_$$BLDNUM^XTVSLM()
 SET DIRHEAD="System: "_XSYSTEM_"    Extract PID:"_XPID_"     Date: "_XDATE
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 Q
 ;
INIT ; -- init variables and list array
 NEW PARMROOT
 SET VALMCNT=0
 SET PARMROOT="^TMP(""XTSIZE"","_$J_")" ;Result Param File array
 FOR  SET PARMROOT=$QUERY(@PARMROOT) QUIT:PARMROOT=""  Q:$QSUBSCRIPT(PARMROOT,2)="IDX"  Q:$QSUBSCRIPT(PARMROOT,1)'="XTSIZE"  DO
 . DO SPLITADD^XTVSLAPI(.VALMCNT,@PARMROOT,1)
 DO MSG
 Q
 ;
HELP ; -- help code
 IF $D(X),X'["??" DO
 . SET X="?"
 . DO DISP^XQORM1 W !
 IF $D(X),X["??",X'["???" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . WRITE !,"Package Parameters & Parameter Corrections action help..."
 . WRITE !,"List specific actions:",!
 . DO DISP^XQORM1 W !!
 . SET XTQVAR=Y
 . IF XTQVAR DO
 .. SET XTQVAR=0
 .. FOR TXTCT=1:1 SET XTX=$P($T(CPTXT2+TXTCT^XTVSHELP),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 ... IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 ... W !,$S(XTX["$PAUSE":"",1:XTX)
 . W !
 IF $D(X),X["???" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . WRITE !,"Details about displayed data...",!
 . SET XTQVAR=Y
 . IF XTQVAR DO
 .. SET XTQVAR=0
 .. FOR TXTCT=1:1 SET XTX=$P($T(CPTXT3+TXTCT^XTVSHELP),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 ... IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 ... W !,$S(XTX["$PAUSE":"",1:XTX)
 . W !
 D MSG
 S VALMBCK="R"
 K XTX,Y,TXTCT,XTQVAR
 QUIT
 ;
EXIT ; -- exit code
 Q
 ;
MSG(TEXT) ; -- set default message
 IF $G(TEXT)]"" SET VALMSG=TEXT
 IF $G(TEXT)']"" SET VALMSG="Enter ?? : more actions & Help, ??? : Process Help"
 QUIT
 ;
KILL ; -- Cleanup local and global arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("XTVS PKG MAN NEW PARAM",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
 ;Action PROTOCOL entry points
REDISPRM ; -- Redisplay Paramters file
 ; -- Protocol: XTVS PKG EXT REDISP PARAM ACTION
 ;
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Package Parameters"
 SET VALMBG=1
 DO KILL
 DO INIT
 SET VALMBCK="R"
 QUIT
 ;
REDISCRT ; -- Redisplay Parameter file corrections list
 ; -- Protocol: XTVS PKG EXT DISP CORRECTIONS ACTION
 ;
 SET VALMHDR(1)="     VistA Package Size Analysis Manager - Package Parameter Corrections"
 SET VALMBG=1
 DO KILL
 SET VALMCNT=0
 SET PARMROOT="^TMP(""XTVS-FILERPT"","_$J_")"
 FOR  SET PARMROOT=$QUERY(@PARMROOT) QUIT:PARMROOT=""  Q:$QSUBSCRIPT(PARMROOT,1)'="XTVS-FILERPT"  DO
 . IF @PARMROOT["file number notes" DO ADD^XTVSLAPI(.VALMCNT," ")
 . DO ADD^XTVSLAPI(.VALMCNT,@PARMROOT)
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
WRPARMFL ; Write Parameter File to VistA Package Size Default Directory
 ; -- Protocol: XTVS PKG EXT PARAM WRT ACTION
 ;
 NEW POPERR,PKGROOT,SUB3,SUB4,EXTDIR,FILENME,NOWDT,INITIAL
 SET POPERR=0
 SET NOWDT=$$FMTE^XLFDT($$NOW^XLFDT,"2M")
 SET NOWDT=$TR(NOWDT,"/","-")
 SET NOWDT=$TR(NOWDT,"@","_")
 SET NOWDT=$TR(NOWDT,":","")
 SET INITIAL=$P($G(^VA(200,DUZ,0)),"^",2)
 IF INITIAL']"" SET INITIAL="<unk>"
 ;
 D FULL^VALM1
 ;
 SET EXTDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET FILENME="XTMPSIZE"_"_"_INITIAL_NOWDT_".DAT"
 DO JUSTPAWS^XTVSLAPI("Parameter file: "_FILENME_", will be created.")
 DO OPEN^%ZISH("XTMP",EXTDIR,FILENME,"A")
 SET:POP POPERR=POP
 QUIT:POPERR
 U IO
 SET PKGROOT="^TMP(""XTSIZE"","_$J_")"
 SET INSCTRT="^TMP(""XTSIZE"","_$J_")"
 FOR  SET PKGROOT=$QUERY(@PKGROOT) QUIT:PKGROOT']""  Q:$QSUBSCRIPT(PKGROOT,1)'="XTSIZE"  Q:$QSUBSCRIPT(PKGROOT,2)'=$J  DO
 . SET SUB3=$QSUBSCRIPT(PKGROOT,3)
 . SET SUB4=$QSUBSCRIPT(PKGROOT,4)
 . IF $G(SUB4)'="",$G(SUB3)'="",$G(@INSCTRT@(SUB4,SUB3))'="" W !,@INSCTRT@(SUB4,SUB3)_"^*"
 . WRITE !,@PKGROOT
 D CLOSE^%ZISH("XTMP")
 DO MSG
 SET VALMBCK="R"
 QUIT
  ;
SNDNPFLE ;Send New Paramater file & report
 ; -- Protocol: XTVS PKG MGR NEW PARAM MAIL ACTION
 ;
 NEW XTINSTMM,XTINSTVA,XTTASKMM,XTTASKVA,XTTOMM,XTTOVA,XMERR,XMZ,XTLPCNT,XTTYPE,XTSVSUBJ,XQSND
 ;
 ;XTSVSUBJ - Subject of message generated 
 ;XQSND    - User's DUZ, Group Name, or S.server name
 SET XQSND=DUZ
 SET XTSVSUBJ="VistA Package Parameter File"
 ;
 DO FULL^VALM1
 WRITE !!," The message can take some time to be sent.",!
 ;
 S XTINSTMM("ADDR FLAGS")="R"  ;Do not Restrict addressing
 S XTTYPE="S"
 K XMERR
 D TOWHOM^XMXAPIU(DUZ,,XTTYPE,.XTINSTMM)
 ;
 ;Check Network addresses and mail attachmt
 S XTINSTVA("ADDR FLAGS")="R"  ;Do not Restrict addressing
 S XTINSTVA("FROM")="VISTA_PACKAGE_MANAGER_RPT"
 S XTSVSUBJ=$E(XTSVSUBJ,1,65)
 S XTLPCNT=""
 F  S XTLPCNT=$O(^TMP("XMY",$J,XTLPCNT)) Q:XTLPCNT=""  S XTTOVA(XTLPCNT)=""
 ;
 I +$G(XMERR)'>0 DO
 .WRITE !!,"NOTE: Attachments sent to VA MailMan addresses will be unreadable."
 .WRITE !,"  Send the parameters in the message if sending to a VA Mailman address.",!
 .N XTFORMAT
 .SET XTFORMAT=$$MSGORATC^XTVSLAPI("the VistA Pkg Parameter File")
 .; Report in message
 .IF XTFORMAT="M" DO
 .. S XTSVSUBJ=XTSVSUBJ_" & Error Rpt"
 .. D ALLMSG("^TMP(""XTSIZE"","_$J_")","^TMP(""XTVS-FILERPT"","_$J_")","^TMP($J,""XTNETMSG"")")
 .. D SENDMSG^XMXAPI(XQSND,XTSVSUBJ,"^TMP($J,""XTNETMSG"")",.XTTOVA,.XTINSTVA,.XTTASKVA)
 .. D JUSTPAWS^XTVSLAPI("MSG#: "_XTTASKVA_" created!")
 .; Report in attachment
 .IF XTFORMAT="A" DO
 ..W !,"                                    [Creating attachments..."
 ..D OUTLKARY("^TMP(""XTSIZE"","_$J_")","^TMP($J,""XTNETMSG"")",XTSVSUBJ,1)
 ..D SENDMSG^XMXAPI(XQSND,XTSVSUBJ,"^TMP($J,""XTNETMSG"")",.XTTOVA,.XTINSTVA,.XTTASKVA)
 ..D JUSTPAWS^XTVSLAPI("MSG#: "_XTTASKVA_" created!")
 ;
 K ^TMP("XMY",$J),^TMP("XMY0",$J),^TMP($J,"XTNETMSG")
 ;
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
ALLMSG(XTPMARY,ERROOT,XTOTMSG) ;Create msg array with no attachment
 ;INPUT:
 ;  XTPMARY  - Array containing Package Parameter File text
 ;  ERROOT   - Array containing Error Report
 ;  XTOTMSG  - Array to use for E-mail Text
 ;
 ;OUTPUT:
 ;  XTOTMSG  - Array of message text to send via E-Mail
 ;
 NEW XTERRND,XTCHAR,OTLKNDE
 SET:+$G(XTRT)=0 XTRT=0
 SET:+$G(XTRT) XTCHAR=0
 SET XTSTR=""
 KILL @XTOTMSG
 SET @XTOTMSG@(1)=" "
 SET OTLKNDE=1
 ;
 IF ($O(@ERROOT@(0))'="") DO
 . SET @XTOTMSG@(2)="Report of Package File Number Corrections made when creating parameter file."
 . SET @XTOTMSG@(3)=" "
 . SET @XTOTMSG@(4)="NOTE: Undefined File Number Ranges and *High/*Low File Numbers are reported."
 . SET @XTOTMSG@(5)="File Number multiple entries not included in File Number Ranges multiple are"
 . SET @XTOTMSG@(6)="added to the Package file parameter ranges and indicated in this report."
 . SET @XTOTMSG@(7)="*High/*Low File Numbers are NOT added to File Number Parameter range.  If only"
 . SET @XTOTMSG@(8)="*High/*Low numbers are defined for a Package's files then that is reported."
 . SET @XTOTMSG@(9)=" "
 . SET OTLKNDE=9
 . SET XTERRND=ERROOT
 . FOR  SET XTERRND=$QUERY(@XTERRND) QUIT:XTERRND=""  Q:$QSUBSCRIPT(XTERRND,1)'="XTVS-FILERPT"  Q:$QSUBSCRIPT(XTERRND,2)'=$J  DO
 .. SET OTLKNDE=OTLKNDE+1
 .. IF @XTERRND["file number notes" SET @XTOTMSG@(OTLKNDE)=" " SET OTLKNDE=OTLKNDE+1
 .. SET @XTOTMSG@(OTLKNDE)=@XTERRND
 ;
 IF ($O(@ERROOT@(0))="") SET @XTOTMSG@(2)="No File corrections made in the parameter file!"
 SET OTLKNDE=OTLKNDE+1
 ;
 SET @XTOTMSG@(OTLKNDE)=""
 SET OTLKNDE=OTLKNDE+1
 SET @XTOTMSG@(OTLKNDE)=""
 SET OTLKNDE=OTLKNDE+1
 SET @XTOTMSG@(OTLKNDE)="----------------------------------------------------------------------"
 SET OTLKNDE=OTLKNDE+1
 SET @XTOTMSG@(OTLKNDE)=""
 SET OTLKNDE=OTLKNDE+1
 SET @XTOTMSG@(OTLKNDE)="VistA Package Parameters:"
 SET OTLKNDE=OTLKNDE+1
 SET @XTOTMSG@(OTLKNDE)="-------------------------"
 SET OTLKNDE=OTLKNDE+1
 SET @XTOTMSG@(OTLKNDE)=""
 SET OTLKNDE=OTLKNDE+1
 ;
 ; No parameter file
 IF ($O(@XTPMARY@(0))="") DO
 . SET @XTOTMSG@(OTLKNDE)=""
 . SET OTLKNDE=OTLKNDE+1
 . SET @XTOTMSG@(OTLKNDE)="No Parameter List to report!"
 . SET OTLKNDE=OTLKNDE+1
 ;
 ; Parameter file exists - write parameter file to message
 IF ($O(@XTPMARY@(0))'="") DO
 .FOR  SET XTPMARY=$QUERY(@XTPMARY) QUIT:(XTPMARY="")  Q:($QSUBSCRIPT(XTPMARY,1)'="XTSIZE")  Q:($QSUBSCRIPT(XTPMARY,2)'=$J)  DO
 .. DO:XTPMARY#100=0 HANGCHAR^XTVSLAPI(.XTCHAR) ; Display progress character
 .. SET @XTOTMSG@(OTLKNDE)=@XTPMARY SET OTLKNDE=OTLKNDE+1
 ;
 QUIT
 ;
OUTLKARY(XTPMARY,XTOTLK,XTSVSUBJ,XTRT) ;Create attachmts array
 ;INPUT:
 ;  XTPMARY  - Array containing Package Parameter File text
 ;  XTOTLK   - Array containing message text for network addresses
 ;  XTSVSUBJ - Message subject
 ;  XTRT     - Real Time processing from UI
 ;
 N XTFILNAM,XTDTTM,XTCRLF,XTSTR,XTNODE,XTOUTNOD,XTNODATA,XTCHAR,NOWDT,INITIAL,OTLKNDE,ERROOT
 S:+$G(XTRT)=0 XTRT=0
 S:+$G(XTRT) XTCHAR=0
 S XTSTR=""
 S XTNODATA=0
 S XTCRLF=$C(13,10)
 S XTDTTM=$$NOW^XLFDT
 K @XTOTLK
 S @XTOTLK@(1)="Attachment Generated......: "_$$FMTE^XLFDT(XTDTTM)_XTCRLF
 S @XTOTLK@(2)=" "
 S @XTOTLK@(3)="Extract Requested......: "_XTSVSUBJ_XTCRLF
 S @XTOTLK@(4)=" "
 ;
 SET NOWDT=$$FMTE^XLFDT(XTDTTM,"2M")
 SET NOWDT=$TR(NOWDT,"/","-")
 SET NOWDT=$TR(NOWDT,"@","_")
 SET NOWDT=$TR(NOWDT,":","")
 SET INITIAL=$P($G(^VA(200,DUZ,0)),"^",2)
 IF INITIAL']"" SET INITIAL="<unk>"
 SET XTFILNAM="XTMPSIZE"_"_"_INITIAL_NOWDT_".DAT"
 ;
 S @XTOTLK@(5)="Attached Package Parameter file.....: "_XTFILNAM_XTCRLF
 S:($O(@XTPMARY@(0))="") XTNODATA=1
 S @XTOTLK@(6)=" "
 S:(XTNODATA=0) @XTOTLK@(7)=" "
 S:(XTNODATA=1) @XTOTLK@(7)="No Parameter List to file and attach!"
 SET OTLKNDE=7
 ;
 SET ERROOT="^TMP(""XTVS-FILERPT"","_$J_")"
 IF ($O(@ERROOT@(0))'="") DO
 . SET @XTOTLK@(9)="Report of Package File Number Corrections made when creating "_XTFILNAM_"."
 . SET @XTOTLK@(10)=" "
 . SET @XTOTLK@(11)="NOTE: Undefined File Number Ranges and *High/*Low File Numbers are reported."
 . SET @XTOTLK@(12)="File Number multiple entries not included in File Number Ranges multiple are"
 . SET @XTOTLK@(13)="added to the Package file parameter ranges and indicated in this report."
 . SET @XTOTLK@(14)="*High/*Low File Numbers are NOT added to File Number Parameter range.  If only"
 . SET @XTOTLK@(15)="*High/*Low numbers are defined for a Package's files then that is reported."
 . SET @XTOTLK@(16)=" "
 . SET OTLKNDE=16
 SET:($O(@ERROOT@(0))="") @XTOTLK@(8)="No File corrections made in "_XTFILNAM_"!"
 FOR  SET ERROOT=$QUERY(@ERROOT) QUIT:ERROOT=""  Q:$QSUBSCRIPT(ERROOT,1)'="XTVS-FILERPT"  Q:$QSUBSCRIPT(ERROOT,2)'=$J  DO
 . SET OTLKNDE=OTLKNDE+1
 . IF @ERROOT["file number notes" SET @XTOTLK@(OTLKNDE)=" " SET OTLKNDE=OTLKNDE+1
 . SET @XTOTLK@(OTLKNDE)=@ERROOT
 ;
 ;Begin file output
 SET OTLKNDE=OTLKNDE+1
 S @XTOTLK@(OTLKNDE)=$$UUBEGFN^XTVSLAPI(XTFILNAM)
 S XTNODE=XTPMARY
 S XTOUTNOD=OTLKNDE
 ;;
 FOR  SET XTNODE=$QUERY(@XTNODE) QUIT:(XTNODE="")  Q:($QSUBSCRIPT(XTNODE,1)'="XTSIZE")  Q:($QSUBSCRIPT(XTNODE,2)'=$J)  DO
 . I +$G(XTRT) D:XTNODE#100=0 HANGCHAR^XTVSLAPI(.XTCHAR) ; Display progress character
 . S XTSTR=XTSTR_@XTNODE_XTCRLF
 . D ENCODE^XTVSLAPI(.XTSTR,.XTOUTNOD,XTOTLK)
 ;
 F  Q:$L(XTSTR<45)  D ENCODE^XTVSLAPI(.XTSTR,.XTOUTNOD,XTOTLK)
 S:(XTSTR'="") @XTOTLK@(XTOUTNOD+1)=$$UUEN^XTVSLAPI(XTSTR)
 S @XTOTLK@(XTOUTNOD+2)=" "
 S @XTOTLK@(XTOUTNOD+3)="end"
 ;
 QUIT
