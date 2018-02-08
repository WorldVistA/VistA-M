A1VSLAPI ;Albany FO/GTS - VistA Package Sizing Manager; 27-JUN-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
 ; APIs
 ;
EMAILEXT ; Extract & E-Mail ^XTMP(""A1SIZE"","_$JOB_")
 ; -- Option: A1VS EXT-EMAIL PKG DATA
 ;
 NEW EXTRSLT
 SET EXTRSLT=$$PKGEXT^A1VSLNA1()
 IF 'EXTRSLT,$D(^XTMP("A1SIZE",$JOB)) DO
 . NEW A1INSTMM,A1TOMM,XMERR,XMZ,A1TYPE
 . ;
 . KILL XMERR
 . SET A1INSTMM("ADDR FLAGS")="R"  ;Do not Restrict addressing
 . SET A1TYPE="S"
 . DO TOWHOM^XMXAPIU(DUZ,,A1TYPE,.A1INSTMM)
 . IF +$G(XMERR)'>0 DO
 .. NEW XMY,XMTEXT,XMDUZ,XMSUB,A1LPCNT,XDATE
 .. SET A1LPCNT=""
 .. FOR  SET A1LPCNT=$O(^TMP("XMY",$J,A1LPCNT)) QUIT:A1LPCNT=""  SET XMY(A1LPCNT)=""
 .. SET XMDUZ=DUZ
 .. SET XDATE=$P(^XTMP("A1SIZE",$JOB,0),"^")
 .. SET XDATE=$$FMTE^XLFDT(XDATE,"1P")
 .. SET XMSUB="PACKAGE FILE EXTRACT ("_$P(^XTMP("A1SIZE",$JOB,0),"^",2)_" ; "_XDATE_" ; $JOB#: "_$JOB_")"
 .. SET XMTEXT="^XTMP(""A1SIZE"","_$JOB_","
 .. DO ENT^XMPG
 .. IF +XMZ>0 DO JUSTPAWS^A1VSLAPI("^XTMP(""A1SIZE"","_$JOB_") E-Mailed via PackMan.  [MSG #:"_XMZ_"]")
 .. IF +XMZ'>0  DO JUSTPAWS^A1VSLAPI("Error: ^XTMP(""A1SIZE"","_$JOB_") not sent in Packman. ["_XMMG_"]")
 . IF $P(EXTRSLT,"^",2)'>0 KILL ^TMP("XMY",$J),^XTMP("A1SIZE",$JOB)
 ;
 IF EXTRSLT DO JUSTPAWS^A1VSLAPI("^XTMP(""A1SIZE"","_$JOB_") global exists.  Use Extract Manager to access it.")
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
EDITPCHK() ; -- does DUZ have A1VS EDITOR key
 NEW A1VSSEC
 DO OWNSKEY^XUSRB(.A1VSSEC,"A1VS EDITOR")
 QUIT +$G(A1VSSEC(0))
 ;
YNCHK(APROMPT) ; Yes/No Prompt
 ;INPUT
 ;  APROMPT - Prompt to display before Y/N question
 ;OUTPUT
 ;  value of Y returned from DIR Y/N prompt
 ;
 NEW DIR,DIRUT,DTOUT,DUOUT,X,Y
 SET DIR("A")=APROMPT
 SET DIR(0)="Y^A"
 SET DIR("B")="NO"
 DO ^DIR
 Q Y
 ;
SELXTMP(BEGIN,END,A1OFFSET) ;Select XTMPSIZE.DAT file
 ;
 SET:'$D(A1OFFSET) A1OFFSET=0
 D FULL^VALM1
 SET DIR("A",1)=""
 SET DIR("A")="Select the XTMPSIZE*.DAT Package Parameter file item number"
 SET DIR(0)="N:"_BEGIN_":"_END
 DO ^DIR
 IF ($D(DTOUT))!($D(DUOUT)) QUIT -1
 QUIT Y+A1OFFSET
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
 . FOR  SET LMTMPNDE=$O(^TMP("A1VS PKG MGR RPT",$J,LMTMPNDE))  Q:+LMTMPNDE=0  DO
 .. W !,^TMP("A1VS PKG MGR RPT",$J,LMTMPNDE,0)
 . D CLOSE^%ZISH("DELIMFL1")
 QUIT
 ;
SNDEXT(A1SVSUBJ,XQSND,A1EXTARY) ;Send VistA Size report
 ; -- Protocol: A1VS PKG MGR RPT MAIL ACTION
 ;
 ;INPUT:
 ;  A1SVSUBJ - Subject of message generated 
 ;  XQSND    - User's DUZ, Group Name, or S.server name
 ;  A1EXTARY - Array containing msg text
 ;  
 N A1INSTMM,A1INSTVA,A1TASKMM,A1TASKVA,A1TOMM,A1TOVA,XMERR,XMZ,A1LPCNT,A1TYPE
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
 .D OUTLKARY(A1EXTARY,"^TMP($J,""A1NETMSG"")",A1SVSUBJ,1)
 .D SENDMSG^XMXAPI(XQSND,A1SVSUBJ,"^TMP($J,""A1NETMSG"")",.A1TOVA,.A1INSTVA,.A1TASKVA)
 ;
 K ^TMP("XMY",$J),^TMP("XMY0",$J),^TMP($J,"A1NETMSG")
 SET VALMBCK="R"
 Q
 ;
OUTLKARY(A1PMARY,A1OTLK,A1SVSUBJ,A1RT) ;Create attachmts array
 ;INPUT:
 ;  A1PMARY  - Array containing raw message text
 ;  A1OTLK   - Array containing message text for network addresses
 ;  A1SVSUBJ - Message subject
 ;  A1RT     - Real Time processing from UI
 ;
 N A1FILNAM,A1DTTM,A1CRLF,A1STR,A1NODE,A1OUTNOD,A1NODATA,A1CHAR
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
 S A1FILNAM="VistAPkgSize_"_$P(A1DTTM,".",1)_"_"_$P(A1DTTM,".",2)_".txt"
 S @A1OTLK@(5)="Attached VistA Size Report file.....: "_A1FILNAM_A1CRLF
 S:($O(@A1PMARY@(0))="") A1NODATA=1
 S @A1OTLK@(6)=" "
 S:(A1NODATA=0) @A1OTLK@(7)=" "
 S:(A1NODATA=1) @A1OTLK@(7)="No report!!"
 ;
 ;Begin file output
 S @A1OTLK@(8)=$$UUBEGFN(A1FILNAM)
 S A1NODE=0
 S A1OUTNOD=8
 F  S A1NODE=$O(@A1PMARY@(A1NODE)) Q:(A1NODE="")  Q:($P($G(@A1PMARY@(A1NODE)),"^",1)="CURRENT")  DO
 . I +$G(A1RT) D:A1NODE#100=0 HANGCHAR(.A1CHAR) ; Display progress character
 . S A1STR=A1STR_@A1PMARY@(A1NODE,0)_A1CRLF
 . D ENCODE(.A1STR,.A1OUTNOD,A1OTLK)
 ;
 F  Q:$L(A1STR<45)  D ENCODE(.A1STR,.A1OUTNOD,A1OTLK)
 S:(A1STR'="") @A1OTLK@(A1OUTNOD+1)=$$UUEN(A1STR)
 S @A1OTLK@(A1OUTNOD+2)=" "
 S @A1OTLK@(A1OUTNOD+3)="end"
 ;
 SET VALMBCK="R"
 QUIT
 ;
UUBEGFN(A1FILENM) ; Construct uuencode "begin" coding
 ; Call with A1FILENM = name of uuencoded file attachmt
 ; 
 ; Returns A1X = string with "begin..."_file name
 ;
 N A1X
 S A1X="begin 644 "_A1FILENM
 Q A1X
 ;
ENCODE(A1STR,A1DTANOD,A1OTLK) ;Encode a string, keep remainder for next line
 ;INPUT:
 ;  A1STR     - String to send in msg; call by reference, Remainder returned in A1STR
 ;  A1DTANOD  - Number of next Node to store msg line in array
 ;  A1OTLK    - Array containing msg text for network addresses
 ;
 N A1QUIT,A1LEN,A1X
 S A1QUIT=0,A1LEN=$L(A1STR)
 F  D  Q:A1QUIT
 . I $L(A1STR)<45 S A1QUIT=1 Q
 . S A1X=$E(A1STR,1,45)
 . S A1DTANOD=A1DTANOD+1,@A1OTLK@(A1DTANOD)=$$UUEN(A1X)
 . S A1STR=$E(A1STR,46,A1LEN)
 Q
 ;
UUEN(STR) ; Uuencode string passed in.
 ;Input
 ; STR - String to Encode
 ;
 ;Output
 ; TMP - Encoded string
 ;
 N J,K,LEN,A1I,A1X,S,TMP,X,Y
 S TMP="",LEN=$L(STR)
 F A1I=1:3:LEN D
 . S A1X=$E(STR,A1I,A1I+2)
 . I $L(A1X)<3 S A1X=A1X_$E("   ",1,3-$L(A1X))
 . S S=$A(A1X,1)*256+$A(A1X,2)*256+$A(A1X,3),Y=""
 . F K=0:1:23 S Y=(S\(2**K)#2)_Y
 . F K=1:6:24 D
 . . S J=$$DEC^XLFUTL($E(Y,K,K+5),2)
 . . S TMP=TMP_$C(J+32)
 S TMP=$C(LEN+32)_TMP
 Q TMP
 ;
 ;
HANGCHAR(A1CHAR) ; Display Hang Characters
 ;Input
 ;  A1CHAR - Last "Hang Character" displayed
 NEW A1BS,A1D,A1S
 SET:'$D(A1CHAR) A1CHAR=0
 SET A1D="-"
 SET A1S="\"
 SET A1BS="/"
 NEW A1RESET,A1Y
 SET A1Y=$Y
 DO IOXY^XGF(IOSL-1,62) ;IA #3173  ;;TO DO: GTS - instead of IOSL, use current line #
 SET A1RESET=0
 SET:A1CHAR=0 A1CHAR=A1BS
 IF 'A1RESET,A1CHAR=A1D SET A1CHAR=A1S SET A1RESET=1
 IF 'A1RESET,A1CHAR=A1S SET A1CHAR=A1BS SET A1RESET=1
 IF 'A1RESET,A1CHAR=A1BS SET A1CHAR=A1D SET A1RESET=1
 WRITE A1CHAR
 IF 1 ;Needed for ^DIC screen calls
 Q
 ;
EXTPKG(LISTTMP) ;loop through PACKAGE file & extract data
 ;
 K ^XTMP("A1SIZE",$J) S ^XTMP("A1SIZE",$J,0)=DT
 S VPIEN=0 F  S VPIEN=$O(^DIC(9.4,VPIEN)) Q:'VPIEN  S VPNAME=$P(^DIC(9.4,VPIEN,0),"^") D SETXTMP
 K VPNAME,VPN,VPLOW,VPHIGH,VPOTHER,VPNAT,VPRNGE
 Q
 ;
SETXTMP ; set ^XTMP global with PACKAGE data
 ;
 ; Piece 1 = Namespace
 ; Piece 2 = Lower File Number Range
 ; Piece 3 = Highest File Number Range
 ; Piece 4 = Other Namepaces separated by "|"
 ;
 NEW VPPARPKG,PARNTNME
 SET VPNAT=$G(^DIC(9.4,VPIEN,7)),VPNAT=$P(VPNAT,"^",3),VPPARPKG=$P($GET(^DIC(9.4,VPIEN,15002)),"^",2),PARNTNME=""
 QUIT:VPNAT'="I"
 S VPN=$P(^DIC(9.4,VPIEN,0),"^",2)
 S (VPEXCPT,VPOTHER,VPRNGE)=""
 S VP11=$G(^DIC(9.4,VPIEN,11)),VPLOW=$P(VP11,"^"),VPHIGH=$P(VP11,"^",2)
 S VPIEN2=0 F  S VPIEN2=$O(^DIC(9.4,VPIEN,14,VPIEN2)) Q:'VPIEN2  S VPOTHER=VPOTHER_^DIC(9.4,VPIEN,14,VPIEN2,0)_"|"
 S VPIEN2=0 F  S VPIEN2=$O(^DIC(9.4,VPIEN,"EX",VPIEN2)) Q:'VPIEN2  S VPEXCPT=VPEXCPT_^DIC(9.4,VPIEN,"EX",VPIEN2,0)_"|"
 ;
 ;Get Ranges from multiple field 15001.1
 IF +$$FLDNUM^DILFD(9.4,"LOW-HIGH RANGE")=15001.1,$D(^DIC(9.4,VPIEN,15001)) DO
 .S VPRNGE=""
 .S VPIEN2=0
 .F  S VPIEN2=$O(^DIC(9.4,VPIEN,15001.1,VPIEN2)) Q:'VPIEN2  DO
 ..S VPLNUM=$P($G(^DIC(9.4,VPIEN,15001.1,VPIEN2,0)),"^")
 ..S VPHNUM=$P($G(^DIC(9.4,VPIEN,15001.1,VPIEN2,0)),"^",2)
 ..S VPRNGE=VPRNGE_VPLNUM_"-"_VPHNUM_"|"
 ;
 ;Get file numbers from multiple field 15001
 IF +$$FLDNUM^DILFD(9.4,"FILE NUMBER")=15001,$D(^DIC(9.4,VPIEN,15001)) DO
 .S VPIEN2=0
 .FOR  S VPIEN2=$O(^DIC(9.4,VPIEN,15001,VPIEN2)) Q:'VPIEN2  DO
 ..S (VPFNUM,VPLNUM,VPHNUM)=""
 ..S VPFNUM=^DIC(9.4,VPIEN,15001,VPIEN2,0)
 ..S:+VPFNUM>0 ^XTMP("A1SIZE",$J,VPNAME,VPFNUM)=""
 ;
 ;Get PARENT PACKAGE field (#15003)
 IF VPPARPKG]"" DO
 .SET PARNTNME=$P($G(^DIC(9.4,VPPARPKG,0)),"^")
 ;
 SET ^XTMP("A1SIZE",$J,VPNAME)=VPN_"^"_VPLOW_"^"_VPHIGH_"^"_VPOTHER_"^"_VPEXCPT_"^"_VPRNGE_"^"_PARNTNME
 QUIT
 ;
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
 DO ^DIR
 QUIT
 ;
FEXT(XTMPARY) ;Return Package File Multiple entries
 ; INPUT:  XTMPARY  - Package Extract Array [^XTMP("A1SER")]
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
