VAQADM2 ;ALB/JRP - MESSAGE ADMINISTRATION;22-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;**33**;NOV 17, 1993
START ;START RESPONSE TIME MONITORING (TIME TO PARSE A TRANSMISSION)
 I ($D(XRTL)) D T0^%ZOSV
 Q
 ;
STOP ;STOP RESPONSE TIME MONITORING
 I ($D(XRT0)) S XRTN=$T(+0) D T1^%ZOSV K XRTN,XRT0
 Q
 ;
SERVER ;PDX SERVER MAIN ENTRY POINT
 ;INPUT  : (As defined by MailMan)
 ;         XMFROM, XMREC, XMZ
 ;         Actually, XMFROM and XMZ are not defined by MailMan,
 ;         but by Kernel, in XQSRV* routines, and these variables only
 ;         exist because this routine is executed immediately.  If it
 ;         were queued, only the following would exist:
 ;         XQMSG - Msg IEN in file 3.9 (XMZ)
 ;         XQSND - Msg sender (XMFROM)
 ;OUTPUT : None
 ;NOTES  : Input is not checked (assume existence)
 ;
 ;CHECK FOR EXISTANCE OF TRANSMISSION
 Q:('$D(^XMB(3.9,XMZ)))
 ;DECLARE VARIABLES
 N VERSION,XMER,XMRG,XMPOS,TMP,PARSE,XMSER,XMXX,MESSAGE
 N TRANS,TYPE,STATUS,ERROR,XMIT,LOCSITE
 S PARSE="^TMP(""VAQ-PARSE"","_$J_",""PARSE"","_XMZ_")"
 S ERROR="^TMP(""VAQ-PARSE"","_$J_",""ERROR"","_XMZ_")"
 S XMIT="^TMP(""VAQ-PARSE"","_$J_",""XMIT"","_XMZ_")"
 K @PARSE,@ERROR,@XMIT
 ;GET LOCAL SITE FROM PARAMETER FILE
 S TMP=+$O(^VAT(394.81,0))
 S LOCSITE=+$G(^VAT(394.81,TMP,0))
 S TMP=$P($G(^DIC(4,LOCSITE,0)),"^",1)
 I (TMP="") S TMP=$P($$SITE^VASITE,"^",2) S:(TMP=-1) TMP="Local Facility"
 S LOCSITE=TMP
 I $$CLOSED(XQSND) D  Q
 .S @ERROR@("GENERAL",1)="Sending domain closed.  Message ignored and deleted."
 .D CLEANUP(1)
 ;READ FIRST LINE OF TRANSMISSION
 S XMPOS=0
 X XMREC
 I (XMER<0) D  Q
 .S @ERROR@("GENERAL",1)="Unable to read first line of message"
 .D CLEANUP(1)
 ;DETERMINE PDX VERSION NUMBER
 S TMP=+$P(XMRG,"^",11)
 S VERSION=$S((XMRG="$TRANSMIT"):1.5,((TMP=100)!(TMP=101)!($P(XMRG,"^",1)="ACK")):1,1:0)
 I ('VERSION) D  Q
 .S @ERROR@("GENERAL",1)="Unable to determine version of PDX used to generate transmission"
 .D CLEANUP(1)
 ;PARSE TRANSMISSION
 S XMPOS=0
 I (VERSION=1) D START D  K @PARSE@(1) D STOP
 .D PREPRS10^VAQPAR1(PARSE)
 .Q:(XMER<0)
 .D PARSE10^VAQPAR1(PARSE)
 I (VERSION=1.5) D START D PARSE^VAQPAR6(PARSE) D STOP
 I (XMER<0) D  Q
 .S @ERROR@("GENERAL",1)="Error occurred while parsing version "_VERSION_" transmission"
 .S @ERROR@("GENERAL",2)=$P(XMER,"^",2)
 .D CLEANUP(1) ; was (0) before patch 33
 ;ACT ON MESSAGE
 D ACTIONS^VAQADM21
 ;CLEAN UP & QUIT
 D CLEANUP(1) ; was (0) before patch 33
 Q
CLOSED(XMFROM) ; Is the domain from which this message was received closed?
 ; 1=yes, 0=no
 I XMFROM'["@" Q 0
 N VIEN
 S VIEN=$$FIND1^DIC(4.2,"","M",$P($P(XMFROM,"@",2),">",1),"B^C")
 Q:'VIEN 0
 I $P(^DIC(4.2,VIEN,0),U,2)["C" Q 1
 Q 0
 ;
CLEANUP(VDELMSG) ;CLEAN UP
 ; VDELMSG - Delete message if error? 1=yes; 0=no
 ;DELETE PARSING ARRAY
 K @PARSE,@XMIT
 ;SAVE TRANSMISSION & SEND ERROR MESSAGE
 I ($D(@ERROR)) D  Q:'VDELMSG
 .;SEND BULLETIN
 .D XMITERR^VAQBUL05
 .K @ERROR
 ;DELETE TRANSMISSION
 S XMSER="S.VAQ-PDX-SERVER",XMZ=XQMSG
 D REMSBMSG^XMA1C
 Q
