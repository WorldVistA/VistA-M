XTVSLAPI ;Albany FO/GTS - VistA Package Sizing Manager; 27-JUN-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ; APIs
 ;
EMAILEXT ; Extract & Email ^XTMP(""XTSIZE"","_$JOB_")
 ; -- Option: XTVS PKG MGR EXT PACKAGE MSG
 ;
 NEW EXTRSLT
 SET EXTRSLT=$$PKGEXT^XTVSLNA1()
 IF 'EXTRSLT,$D(^XTMP("XTSIZE",$JOB)) DO
 . NEW XTINSTMM,XTTOMM,XMERR,XMZ,XTTYPE
 . ;
 . WRITE !!," The message can take some time to be sent.",!
 . KILL XMERR
 . SET XTINSTMM("ADDR FLAGS")="R"  ;Do not Restrict addressing
 . SET XTTYPE="S"
 . DO TOWHOM^XMXAPIU(DUZ,,XTTYPE,.XTINSTMM)
 . IF +$G(XMERR)'>0 DO
 .. NEW XMY,XMTEXT,XMDUZ,XMSUB,XTLPCNT,XDATE
 .. SET XTLPCNT=""
 .. FOR  SET XTLPCNT=$O(^TMP("XMY",$J,XTLPCNT)) QUIT:XTLPCNT=""  SET XMY(XTLPCNT)=""
 .. SET XMDUZ=DUZ
 .. SET XDATE=$P($P(^XTMP("XTSIZE",$JOB,0),"^",3),"-") ; Date from 3rd pce [date of extract]
 .. SET XDATE=$$FMTE^XLFDT(XDATE,"1P")
 .. SET XMSUB="PACKAGE FILE EXTRACT ("_$P(^XTMP("XTSIZE",$JOB,0),"^",4)_" ; "_XDATE_" ; $JOB#: "_$JOB_")"
 .. SET XMTEXT="^XTMP(""XTSIZE"","_$JOB_","
 .. DO ENT^XMPG
 .. IF +XMZ>0 DO JUSTPAWS^XTVSLAPI("^XTMP(""XTSIZE"","_$JOB_") Emailed via PackMan.  [MSG #:"_XMZ_"]")
 .. IF +XMZ'>0 DO JUSTPAWS^XTVSLAPI("Error: ^XTMP(""XTSIZE"","_$JOB_") not sent in Packman. ["_XMMG_"]")
 . IF $P(EXTRSLT,"^",2)'>0 KILL ^TMP("XMY",$J),^XTMP("XTSIZE",$JOB)
 ;
 IF EXTRSLT DO JUSTPAWS^XTVSLAPI("^XTMP(""XTSIZE"","_$JOB_") global exists.  Use Extract Manager to access it.")
 QUIT
 ;
ADD(VALMCNT,MSG,LRBOLD,STRTBLD,ENDBLD) ; -- add line to build display
 ;Input
 ; VALMCNT - Current array node number
 ; MSG     - Message to add to ListMan Display
 ; LRBOLD  - Turns Bold text on - off
 ; STRTBLD - Column position to begin Bold Text
 ; ENDBLD  - Number of columns to apply Bold Text
 ;
 SET VALMCNT=VALMCNT+1
 DO SET^VALM10(VALMCNT,MSG)
 IF $GET(LRBOLD) DO
 . SET:'$G(STRTBLD) STRTBLD=1
 . SET:'$G(ENDBLD) ENDBLD=79
 . DO CNTRL^VALM10(VALMCNT,STRTBLD,ENDBLD,IOUON,IOUOFF)
 QUIT
 ;
SPLITADD(VALMCNT,MSG,ADDSPACE) ; -- add line to build display
 ;Input
 ; VALMCNT - Current array node number
 ; MSG     - Message to add to ListMan Display
 ; ADDSPACE - Add space indicator (1 - add space, 0 - no space
 ;
 NEW SEGMENTS,TOTNODES,PCE,MSGPCE,START,END
 SET:(+$G(ADDSPACE)'=1) ADDSPACE=0
 SET SEGMENTS=$L(MSG)/80
 SET TOTNODES=+$P(SEGMENTS,".")
 IF ADDSPACE,(+$P(SEGMENTS,".",2)>0) SET TOTNODES=TOTNODES+1
 FOR PCE=0:1:TOTNODES  DO
 . SET START=1+(PCE*80)
 . SET END=80+(PCE*80)
 . SET MSGPCE=$E(MSG,START,END)
 . SET VALMCNT=VALMCNT+1
 . DO SET^VALM10(VALMCNT,MSGPCE)
 QUIT
 ;
RTRNADD(EMGRTARY,LNENUM,MSG) ; Add a line to EMGRTARY array
 ;INPUT
 ;  EMGRTARY - Extract Management array [Passed by value for Indirect use]
 ;  LNENUM   - Last Node number in the EMGRTARY array
 ;  MSG      - Message to store in next line on EMGRTARY array
 ;
 SET LNENUM=LNENUM+1
 SET @EMGRTARY@(LNENUM,0)=MSG
 QUIT
 ;
EDITPCHK() ; -- does DUZ have XTVS EDITOR key
 NEW XTVSSEC
 DO OWNSKEY^XUSRB(.XTVSSEC,"XTVS EDITOR")
 QUIT +$G(XTVSSEC(0))
 ;
YNCHK(APROMPT,DEFANS) ; Yes/No Prompt
 ;INPUT
 ;  APROMPT  - Prompt to display before Y/N question [DIR("A")]
 ;  DEFANS   - Default Y/N answer [DIR("B")] (optional - defaults to NO)
 ;OUTPUT
 ;  XTSVRSLT - value of Y when DIR Y/N prompt answer = Yes/No
 ;             -1 when Timeout, ^ or ^^ out.
 ;
 NEW DIR,DIRUT,DTOUT,DUOUT,X,Y,XTSVRSLT
 SET DIR("A")=APROMPT
 SET DIR(0)="Y^A"
 SET DIR("B")=$G(DEFANS)
 IF '$D(DEFANS) SET DIR("B")="NO"
 DO ^DIR
 SET XTSVRSLT=Y_"^"_Y
 IF $D(DTOUT)!$D(DUOUT)!$D(DIROUT) SET XTSVRSLT="0"_"^-1"
 QUIT XTSVRSLT
 ;
SELXTMP(BEGIN,END,XTOFFSET) ;Select XTMPSIZE.DAT file
 ;
 NEW BEGRNG,ENDRNG
 SET:'$D(XTOFFSET) XTOFFSET=0
 SET BEGRNG=BEGIN-XTOFFSET
 SET ENDRNG=END-XTOFFSET
 D FULL^VALM1
 SET DIR("A",1)=""
 SET DIR("A")="Select the XTMPSIZE*.DAT Package Parameter file item number"
 SET DIR(0)="N^"_BEGRNG_":"_ENDRNG
 DO ^DIR
 IF ($D(DTOUT))!($D(DUOUT)) QUIT -1
 QUIT Y+XTOFFSET
 ;
WRTTXTFL(FILENME,STORPATH) ; Output Package Manager Report to Text file
 NEW POPERR,LMTMPNDE
 SET (D1,POPERR)=""
 ;
 ;If write delimited report to a file
 IF FILENME]"" DO  QUIT:POPERR
 . DO OPEN^%ZISH("DELIMFL1",STORPATH,FILENME,"A")
 . SET:POP POPERR=POP
 . QUIT:POPERR
 . U IO
 . SET LMTMPNDE=0
 . FOR  SET LMTMPNDE=$O(^TMP("XTVS PKG MGR RPT",$J,LMTMPNDE)) Q:+LMTMPNDE=0  DO
 .. W !,^TMP("XTVS PKG MGR RPT",$J,LMTMPNDE,0)
 . D CLOSE^%ZISH("DELIMFL1")
 QUIT
 ;
SNDEXT(XTSVSUBJ,XQSND,XTEXTARY) ;Send VistA Size report
 ; -- Protocol: XTVS PKG MGR RPT MAIL ACTION
 ;
 ;INPUT:
 ;  XTSVSUBJ - Subject of message generated 
 ;  XQSND    - User's DUZ, Group Name, or S.server name
 ;  XTEXTARY - Array containing msg text
 ;
 N XTINSTMM,XTINSTVA,XTTASKMM,XTTASKVA,XTTOMM,XTTOVA,XMERR,XMZ,XTLPCNT,XTTYPE
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
 .N XTFORMAT
 .WRITE !!,"NOTE: Attachments sent to VA MailMan addresses will be unreadable."
 .WRITE !,"  Send the the report in a message if sending to a VA Mailman address."
 .SET XTFORMAT=$$MSGORATC^XTVSLAPI("the VistA Size Report")
 .IF XTFORMAT'="M",XTFORMAT'="A" DO JUSTPAWS("  Message not sent!")
 .; Report in message
 .IF XTFORMAT="M" DO
 .. D SENDMSG^XMXAPI(XQSND,XTSVSUBJ,XTEXTARY,.XTTOVA,.XTINSTVA,.XTTASKVA)
 .. D JUSTPAWS("MSG#: "_XTTASKVA_" created!")
 .; Report in attachment
 .IF XTFORMAT="A" DO
 .. W !,"                                    [Creating attachments..."
 .. D OUTLKARY(XTEXTARY,"^TMP($J,""XTNETMSG"")",XTSVSUBJ,1)
 .. D SENDMSG^XMXAPI(XQSND,XTSVSUBJ,"^TMP($J,""XTNETMSG"")",.XTTOVA,.XTINSTVA,.XTTASKVA)
 .. D JUSTPAWS("MSG#: "_XTTASKVA_" created!")
 ;
 K ^TMP("XMY",$J),^TMP("XMY0",$J),^TMP($J,"XTNETMSG")
 DO MSG^XTVSLR
 SET VALMBCK="R"
 Q
 ;
MSGORATC(XTQTXT) ; Query message or text attachment
 ; INPUT:
 ;  XTQTXT - Report name text to include in user prompt
 ;
 ; OUTPUT:
 ;  RESULT - 
 ;        M : Message    - Send report in a message
 ;        A : Attachment - Send report as a text file attachment to the message
 ;       -1 : Fail/Error condition
 ;
 NEW RESULT
 SET DIR("A")="Send "_XTQTXT_" as a message or a text file attachment: "
 SET DIR("B")="A"
 SET DIR(0)="SAB^M:Message;A:Attachment"
 SET DIR("?")="Enter 'M' to send the report in a message or 'A' to send in a file attached to a message."
 D ^DIR
 SET RESULT=$SELECT($D(DIRUT):-1,1:Y)
 QUIT RESULT
 ;
OUTLKARY(XTPMARY,XTOTLK,XTSVSUBJ,XTRT) ;Create attachmts array
 ;INPUT:
 ;  XTPMARY  - Array containing raw message text
 ;  XTOTLK   - Array containing message text for network addresses
 ;  XTSVSUBJ - Message subject
 ;  XTRT     - Real Time processing from UI
 ;
 N XTFILNAM,XTDTTM,XTCRLF,XTSTR,XTNODE,XTOUTNOD,XTNODATA,XTCHAR
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
 S XTFILNAM="VistAPkgSize_"_$P(XTDTTM,".",1)_"_"_$P(XTDTTM,".",2)_".txt"
 S @XTOTLK@(5)="Attached VistA Size Report file.....: "_XTFILNAM_XTCRLF
 S:($O(@XTPMARY@(0))="") XTNODATA=1
 S @XTOTLK@(6)=" "
 S:(XTNODATA=0) @XTOTLK@(7)=" "
 S:(XTNODATA=1) @XTOTLK@(7)="No report!!"
 ;
 ;Begin file output
 S @XTOTLK@(8)=$$UUBEGFN(XTFILNAM)
 S XTNODE=0
 S XTOUTNOD=8
 F  S XTNODE=$O(@XTPMARY@(XTNODE)) Q:(XTNODE="")  Q:($P($G(@XTPMARY@(XTNODE)),"^",1)="CURRENT")  DO
 . I +$G(XTRT) D:XTNODE#100=0 HANGCHAR(.XTCHAR) ; Display progress character
 . S XTSTR=XTSTR_@XTPMARY@(XTNODE,0)_XTCRLF
 . D ENCODE(.XTSTR,.XTOUTNOD,XTOTLK)
 ;
 F  Q:$L(XTSTR<45)  D ENCODE(.XTSTR,.XTOUTNOD,XTOTLK)
 S:(XTSTR'="") @XTOTLK@(XTOUTNOD+1)=$$UUEN(XTSTR)
 S @XTOTLK@(XTOUTNOD+2)=" "
 S @XTOTLK@(XTOUTNOD+3)="end"
 ;
 SET VALMBCK="R"
 QUIT
 ;
UUBEGFN(XTFILENM) ; Construct uuencode "begin" coding
 ; Call with XTFILENM = name of uuencoded file attachmt
 ; 
 ; Returns XTX = string with "begin..."_file name
 ;
 N XTX
 S XTX="begin 644 "_XTFILENM
 Q XTX
 ;
ENCODE(XTSTR,XTDTANOD,XTOTLK) ;Encode a string, keep remainder for next line
 ;INPUT:
 ;  XTSTR     - String to send in msg; call by reference, Remainder returned in XTSTR
 ;  XTDTANOD  - Number of next Node to store msg line in array
 ;  XTOTLK    - Array containing msg text for network addresses
 ;
 N XTQUIT,XTLEN,XTX
 S XTQUIT=0,XTLEN=$L(XTSTR)
 F  D  Q:XTQUIT
 . I $L(XTSTR)<45 S XTQUIT=1 Q
 . S XTX=$E(XTSTR,1,45)
 . S XTDTANOD=XTDTANOD+1,@XTOTLK@(XTDTANOD)=$$UUEN(XTX)
 . S XTSTR=$E(XTSTR,46,XTLEN)
 Q
 ;
UUEN(STR) ; Uuencode string passed in.
 ;Input
 ; STR - String to Encode
 ;
 ;Output
 ; TMP - Encoded string
 ;
 N J,K,LEN,XTI,XTX,S,TMP,X,Y
 S TMP="",LEN=$L(STR)
 F XTI=1:3:LEN D
 . S XTX=$E(STR,XTI,XTI+2)
 . I $L(XTX)<3 S XTX=XTX_$E("   ",1,3-$L(XTX))
 . S S=$A(XTX,1)*256+$A(XTX,2)*256+$A(XTX,3),Y=""
 . F K=0:1:23 S Y=(S\(2**K)#2)_Y
 . F K=1:6:24 D
 . . S J=$$DEC^XLFUTL($E(Y,K,K+5),2)
 . . S TMP=TMP_$C(J+32)
 S TMP=$C(LEN+32)_TMP
 Q TMP
 ;
HANGCHAR(XTCHAR) ; Display Hang Characters
 ;Input
 ;  XTCHAR - Last "Hang Character" displayed
 NEW XTBS,XTD,XTS
 SET:'$D(XTCHAR) XTCHAR=0
 SET XTD="-"
 SET XTS="\"
 SET XTBS="/"
 NEW XTRESET,XTY
 SET XTY=$Y
 DO IOXY^XGF(IOSL-1,62) ;IA #3173
 SET XTRESET=0
 SET:XTCHAR=0 XTCHAR=XTBS
 IF 'XTRESET,XTCHAR=XTD SET XTCHAR=XTS SET XTRESET=1
 IF 'XTRESET,XTCHAR=XTS SET XTCHAR=XTBS SET XTRESET=1
 IF 'XTRESET,XTCHAR=XTBS SET XTCHAR=XTD SET XTRESET=1
 WRITE XTCHAR
 IF 1 ;Needed for ^DIC screen calls
 Q
 ;
JUSTPAWS(MSG) ; Press Return to Continue
 NEW DIR,X,Y,DTOUT,DIRUT,DUOUT
 IF $G(MSG)="" SET MSG=""
 IF MSG]"" DO
 . SET DIR("A",1)=" "
 . SET DIR("A",2)="   "_MSG
 . SET DIR("A",3)=" "
 SET DIR("A")="Press Return to continue"
 SET DIR(0)="E"
 SET DIR("?")="Press the Enter/Return Key to continue"
 DO ^DIR
 QUIT
 ;
FEXT(XTMPARY) ;Return Package File Multiple entries
 ; INPUT:  XTMPARY  - Package Extract Array [^XTMP("XTSIZE")]
 ; OUTPUT: FILELIST - Pipe (|) delimited list of File Multiple entries
 ;
 NEW FILELIST,FLNMNODE
 SET FILELIST=""
 SET FLNMNODE=0
 FOR  SET FLNMNODE=$O(@XTMPARY@(FLNMNODE))  QUIT:FLNMNODE=""  DO
 . SET FILELIST=FILELIST_FLNMNODE_"|"
 QUIT FILELIST
 ;
LISTOUT(SELARY) ; List the packages for selection
 NEW ITEMNMBR,DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y
 SET Y=0
 SET ITEMNMBR=""
 FOR  SET ITEMNMBR=$O(SELARY(ITEMNMBR)) QUIT:+ITEMNMBR=0  QUIT:$D(DIRUT)  WRITE !,"   ",ITEMNMBR,": ",SELARY(ITEMNMBR) DO:'(ITEMNMBR#20) PAUSE^VALM1
 QUIT
 ;
UNLCKPFL(FILENAME) ; UnLOCK a Parameter file
 NEW UNLKFNME,LOCKRSLT,DEFDIR
 SET LOCKRSLT=0
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET UNLKFNME=$P(FILENAME,".")_".LCK"
 ;
 ;Check PID owning LOCK
 KILL FLSLIST,LOCKLIST
 SET FLSLIST(UNLKFNME)=""
 SET LOCKRSLT=$$LIST^%ZISH(DEFDIR,"FLSLIST","LOCKLIST")
 KILL FLSLIST,LOCKLIST
 ;
 IF +LOCKRSLT=0 SET LOCKRSLT="-1^UNLOCK Failure: Parameter file "_FILENAME_" was not LOCKED."
 IF '$D(OPTUNLCK),(+LOCKRSLT=1) SET LOCKRSLT=$$CHKPID(DEFDIR,FILENAME) ;Do not check from XTVS PKG MGR PARAM UNLOCK ACTION
 ;
 IF $P(LOCKRSLT,"^")=1 DO
 . NEW DELLKFL
 . SET DELLKFL(UNLKFNME)=""
 . SET LOCKRSLT=$$DEL^%ZISH(DEFDIR,$NA(DELLKFL))
 . KILL DELLKFL(UNLKFNME) ;Delete Parameter Lock file
 . IF LOCKRSLT=1 SET LOCKRSLT="1^Parameter file "_FILENAME_" LOCK released."
 . IF LOCKRSLT=0 SET LOCKRSLT="0^UNLOCK failed: Parameter file "_FILENAME_"!"
 . ;
 QUIT LOCKRSLT
 ;
CHKPID(DEFDIR,FILENAME) ; Check PID in .LCK against $JOB
 NEW DOLRJ,CKDOLRJ,UNLKFNME
 SET UNLKFNME=$P(FILENAME,".")_".LCK"
 SET DOLRJ=""
 DO OPEN^%ZISH("CKHNDL",DEFDIR,UNLKFNME,"R")
 SET CKDOLRJ=$S('POP:1,1:0) ;Pop = 0, file opened
 IF 'CKDOLRJ SET CKDOLRJ="-1^LOCK Check Failure: Parameter file has been UNLOCKED by another process!"
 IF $P(CKDOLRJ,"^")=1 DO
 . USE IO
 . READ DOLRJ:5
 . DO CLOSE^%ZISH("CKHNDL")
 . IF $JOB=DOLRJ SET CKDOLRJ=1
 . IF $JOB'=DOLRJ SET CKDOLRJ="0^Parameter file "_FILENAME_" LOCKED by another user."
 QUIT CKDOLRJ
 ;
REQLOCK(FILENAME) ; Check LOCK on a Parameter file. If unlocked, set LOCK
 ;RETURN: Code^msg
 ;  Code  0 - Obtained LOCK
 ;        1 - LOCK failed
 NEW FILENME,LOCKRSLT,DOLRJ,EXTDIR
 KILL FLSLIST,LOCKLIST
 SET EXTDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET FILENME=$P(FILENAME,".")_".LCK"
 SET FLSLIST(FILENME)=""
 ;
 ;Check for existing Lock
 SET LOCKRSLT=$$LIST^%ZISH(EXTDIR,"FLSLIST","LOCKLIST")
 KILL FLSLIST,LOCKLIST
 IF LOCKRSLT=1 DO
 . DO OPEN^%ZISH("CKHNDL",EXTDIR,FILENME,"R")
 . USE IO
 . FOR  S DOLRJ="" READ DOLRJ:5 Q:$$STATUS^%ZISH  DO
 .. SET LOCKRSLT=LOCKRSLT_"^Parameter file "_FILENAME_" LOCKED by $JOB PID "_$S(DOLRJ]"":DOLRJ,1:"{unknown}")
 . DO CLOSE^%ZISH("CKHNDL")
 ;
 ;File not locked, LOCK it
 IF LOCKRSLT=0 DO
 . NEW LOCKERR
 . SET LOCKERR=0
 . DO OPEN^%ZISH("LKHNDL",EXTDIR,FILENME,"W")
 . SET LOCKERR=$S(POP>0:1,1:0)
 . IF 'LOCKERR DO
 .. USE IO
 .. WRITE $JOB
 .. SET LOCKRSLT=LOCKRSLT_"^"_FILENAME_" LOCK obtained."
 . DO CLOSE^%ZISH("LKHNDL")
 . IF LOCKERR SET LOCKRSLT="1^LOCK request for parameter file "_FILENAME_" FAILED."
 QUIT LOCKRSLT
 ;
 ;
NOTCE(NTCTEXT,XTVSADDR,PKGNAME) ; Send Package extract notice msg to requester
 ; Input:
 ;   NTCTEXT  - Notice Text to share with reader
 ;   XTVSADDR - Recipients E-Mail address
 ;   PKGNAME  - Name of package that had data cleanup during extract
 ;   
 NEW XMERR,XMY,XMTEXT,XMDUZ,XMSUB,ERRTEXT
 KILL ^TMP("XTVS-REMOTE-ERROR",$JOB)
 IF PKGNAME]"" DO
 . SET ^TMP("XTVS-REMOTE-ERROR",$JOB,1)="Notice for Package Extract on "_^%ZOSF("PROD")_"."
 . SET ^TMP("XTVS-REMOTE-ERROR",$JOB,2)="Data was cleaned up on "_PKGNAME_" extract."
 . SET ^TMP("XTVS-REMOTE-ERROR",$JOB,3)=NTCTEXT
 SET XMDUZ="VISTA PACKAGE SIZE ANALYSIS MANAGER"
 SET XMY(XTVSADDR)=""
 SET XMTEXT="^TMP(""XTVS-REMOTE-ERROR"","_$JOB_","
 SET XMSUB="PACKAGE EXTRACT ("_^%ZOSF("PROD")_") ; data cleanup!"
 DO ^XMD
 IF +XMZ'>0 DO
 . SET ERRTEXT="'Extract cleanup notice message' FAILED to return to "_XTVSADDR_"."
 . DO APPERROR^%ZTER("WRERR^XTVSSVR : Package extract error")
 KILL ^TMP("XTVS-REMOTE-ERROR",$JOB)
 QUIT
 ;
RMTPKGMG(MSGTEXT,XTVSADDR,PKGNAME) ; Send Package extract notice msg to requester
 ; Input:
 ;   MSGTEXT  - Text to share with reader
 ;   XTVSADDR - Recipients E-Mail address
 ;   PKGNAME  - Name of package that had data cleanup during extract
 ;   
 NEW XMERR,XMY,XMTEXT,XMDUZ,XMSUB,ERRTEXT
 KILL ^TMP("XTVS-REMOTE-ERROR",$JOB)
 IF PKGNAME]"" DO
 . SET ^TMP("XTVS-REMOTE-ERROR",$JOB,1)="Package Size Report warning for "_^%ZOSF("PROD")_"."
 . SET ^TMP("XTVS-REMOTE-ERROR",$JOB,2)=MSGTEXT
 SET XMDUZ=DUZ
 SET XMY(XTVSADDR)=""
 SET XMTEXT="^TMP(""XTVS-REMOTE-ERROR"","_$JOB_","
 SET XMSUB="PACKAGE REPORT NOTICE ("_^%ZOSF("PROD")_") ; Report process warning."
 DO ^XMD
 IF +XMZ'>0 DO
 . SET ERRTEXT="'Package Report Notcie' FAILED to return to "_XTVSADDR_"."
 . DO APPERROR^%ZTER("WRERR^XTVSSVR : Package extract error")
 KILL ^TMP("XTVS-REMOTE-ERROR",$JOB)
 QUIT
