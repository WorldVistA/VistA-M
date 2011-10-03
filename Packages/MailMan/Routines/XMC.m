XMC ;ISC-SF/GMB-Network Programmer Options Menu ;12/16/2002  09:35
 ;;8.0;MailMan;**12**;Jun 28, 2002
 ; Was (WASH ISC)/THM
ENTER ;
 I '$G(DUZ) W $C(7),!!,$$EZBLD^DIALOG(38105) Q  ; You do not have a DUZ.
 N XMDUZ,XMV,XMABORT,XM,XMDISPI,XMDUN
 D INIT^XMVVITAE
 I '$D(DT) D DT^DICRW
 I $D(IO)[0 S IOP="HOME" D ^%ZIS
 U IO(0) W !,^XMB("NETNAME")
 D:$O(^DOPT("XMC","B",""))'?1"ACT".E INIT
 F  D  Q:XMABORT
 . N DIC,X,Y
 . U IO(0)
 . W !
 . S DIC="^DOPT(""XMC"",",DIC(0)="AEQZ"
 . D ^DIC K DIC I Y<0 S XMABORT=1 Q
 . S X=$P(Y(0),U,2,99)
 . K DIC,Y
 . S XM="D"
 . D @X
 . I $L(IO) U IO X ^%ZOSF("EON")
 . D ^%ZISC
 . X ^%ZOSF("EON")
 . U IO(0)
 . S XMABORT=0
 D KL
 Q
KL ;
 X ^%ZOSF("EON")
 D KL1
 Q
KL1 ;
 ; XMOS   - Operating System of the computer at this site
 D KILL
 K %DT,%H,ER,I,X,Y,Y1,Y3,Z
 K XMCNT
 K XMD,XMDIAL
 K XME,XMEC,XMER,XMESC
 K XMFS
 K XMLAN,XMLIN,XMLL,XMLT,XMLX
 K XMOS
 K XMP,XMPOLL
 K XMR
 K XMS0AJ,XMSUB,XMSUM
 K XMTLER
 K XMZ
 Q
KILL ; Kill variables used across routines
 ; XM      - Debug: Write all xactions to screen, too? ""=no; "D"=yes
 ; XMB("SCR IEN") - Script IEN
 ; XMB("SCR REC") - Script record
 ; XMC("AUDIT") - Are we auditing? 0=no; n=yes, where n is 1 to 99
 ; XMC("BATCH") - Batch mode (to tape or global)? 0=no; 1=yes
 ; XMC("DIR") - Current direction of transmission? S=sending; R=receiving
 ; XMC("HELO RECV") - Name of site we are receiving message from
 ; XMC("HELO SEND") - Name of site we are sending message to
 ; XMC("C","R") - # chars rcvd this session
 ; XMC("C","S") - # chars sent this session
 ; XMC("L") - # lines xmited (rcvd & sent) this session
 ; XMC("R") - # msgs rcvd this session
 ; XMC("S") - # msgs sent this session
 ; XMC("MAILMAN") - MailMan version # of remote site, when communicating
 ;                  with another MailMan site, version > 4
 ; XMC("SHOW TRAN") - ["S"= Write the 'send' line to the screen
 ;                    ["R"= Write the 'receive' line to the screen
 ; XMC("START") - timestamp at start of xmit session
 ; XMC("TALKMODE") - Are we in talk mode? 0=no; 1=yes
 ; XMC("TURN") - Have we turned already? 0=no; 1=yes
 ; XMCHAN  - Before GET^XML: Name of Comm Protocol (file 3.4) channel
 ;           After  GET^XML: IEN of Comm Protocol (file 3.4) channel
 ; XMCLOSE - Xecute this variable to close the channel (file 3.4,field 4)
 ; XMHOST  - IP address
 ; XMINST  - IEN of Domain (file 4.2) being communicated with
 ; XMLINE  - Tracks line number when dumping msgs to/reading from tape
 ; XMPROT  - Name of Communications Protocol (file 3.4) channel
 ; XMOPEN  - Xecute this variable to open the channel (file 3.4,field 3)
 ; XMREC   - Xecute this variable to receive a line (file 3.4,field 2)
 ; XMRG    - The line received
 ; XMRPORT - Port # used
 ; XMSEN   - Xecute this variable to send a line (file 3.4,field 1)
 ; XMSG    - The line to send
 ; XMSITE  - Name of Domain (file 4.2) being communicated with
 ; XMTASK  - Tracks IEN in 4.281 when dumping msgs to/reading from tape
 ; XMTRAN  - A line to display on the screen by TRAN^XMC1
 K XMB
 K XMC,XMCHAN
 K XMINST,XMSITE
 K XMSEN,XMREC,XMOPEN,XMCLOSE
 ; Kill variables in DIC(3.4 and DIC(4.6
 ; (Not used: XMBT,XMLCHAR)
 K X,ER,TCPCHAN
 K XM
 K XMBT
 K XMDECNET
 K XMER
 K XMHANG,XMHOST
 K XMLCHAR,XMLCT,XMLER,XMLINE,XMLST,XMLTCP
 K XMNO220
 K XMPROT
 K XMRG,XMRPORT
 K XMSG,XMSIO,XMSTIME
 K XMTASK,XMTRAN
 Q
INIT ;INITIALIZE COMMAND TABLE
 N I,X,DIK
 K ^DOPT("XMC")
 S ^DOPT("XMC",0)=$$EZBLD^DIALOG(42201)_"^1N^" ; MailMan Network Programmer Option
 F I=1:1 S X=$P($E($T(Z+I),4,99),";") Q:X=""  S ^DOPT("XMC",I,0)=$$EZBLD^DIALOG($P(X,U,1))_U_$P(X,U,2,99)
 S DIK="^DOPT(""XMC"","
 D IXALL^DIK
 Q
Z ;;
 ;;42201.01^^XM;MAILMAN
 ;;42201.02^PLAY^XMCX;PLAY A SCRIPT
 ;;42201.03^Q1^XMCX;SCHEDULE TASK FOR ONE DOMAIN WITH QUEUED MESSAGES
 ;;42201.04^QALL^XMCX;SCHEDULE TASKS FOR ALL DOMAINS WITH QUEUED MESSAGES
 ;;42201.05^SHOWQ^XMCQ;SHOW A QUEUE
 ;;42201.06^LIST^XMCXT;LIST TRANSCRIPT
 ;;42201.07^STATUS^XMCQ;TRANSMIT QUEUE STATUS REPORT
 ;;42201.08^ACTIVE^XMCQA;ACTIVELY TRANSMITTING QUEUES REPORT
 ;;42201.09^ALL^XMCQA;QUEUES WITH MESSAGES TO GO OUT REPORT
 ;;42201.1^ENTER^XMCQH;HISTORICAL QUEUE STATISTICS REPORT
 ;;42201.11^GLBOUT^XMCB;SEND MESSAGES TO ANOTHER UCI VIA %ZISL GLOBAL
 ;;42201.12^GLBIN^XMCB;RECEIVE MESSAGES FROM ANOTHER UCI VIA %ZISL GLOBAL
 ;;42201.13^TAPEOUT^XMCB;SEQUENTIAL MEDIA QUEUE TRANSMISSION
 ;;42201.14^TAPEIN^XMCB;SEQUENTIAL MEDIA MESSAGE RECEPTION
 ;;42201.15^VAL^XMCE;VALIDATION NUMBER EDIT
 ;;42201.16^OUT^XMCE;TOGGLE A SCRIPT OUT OF SERVICE
 ;;42201.17^EDIT42^XMCE;EDIT A SCRIPT
 ;;42201.18^EDIT46^XMCE;SUBROUTINE EDITOR
 ;;
 ;;**OBSOLETE**
 ;;BLOB SEND^BLOB^XMA2B
 ;;DIAL PHONE^DI^XMC1
 ;;HANG UP PHONE^H^XMC1
 ;;IMMEDIATE SCRIPT MODE^IMM^XMC11
 ;;RESUME SCRIPT PROCESSING^RES^XMC1
 ;;
