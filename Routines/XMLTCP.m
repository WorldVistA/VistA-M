XMLTCP ;(WASH ISC)/CAP-TCP/IP to MailMan ;07/23/2002  06:54
 ;;8.0;MailMan;;Jun 28, 2002
 ; modified to run with MSM NT and Protocol TCP/IP-MAILMAN (file 3.4)
SEND ;returns ER(0 OR 1), XMLER=number of "soft" errors
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D C^XMCTRAP"
 E  S X="C^XMCTRAP",@^%ZOSF("TRAP")
 I $G(XMINST) D XMTSTAT^XMTDR(XMINST,"S",XMSG,1)
 W XMSG,$C(13,10),!
 Q
REC ;Receive a line (must keep buffer / lines divided by LF)
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D C^XMCTRAP"
 E  S X="C^XMCTRAP",@^%ZOSF("TRAP")
 ;Return line if read last time
RE G R:XMLTCP[$C(10) S %=255-$L(XMLTCP) G R:%<1
 ;Insure can clean up if line dropped, etc.
 I $S(XMOS["VAX":1,+$G(XMOS("MSMVER"))<8:1,XMOS["OpenM-NT":1,1:0) R X#$S(%:%,1:1):$G(XMSTIME,160) G RE2
 ;Compliant with M standard
 R X:$G(XMSTIME,60)
 ;
RE2 I '$T,"."_$C(10)'=XMLTCP S XMRG="" D ERTRAN^XMC1("Receiver timed out") Q
 I X="" S ER=ER+.1 S:ER=1 XMRG="" Q:ER=1  H 1 G RE
 S XMLTCP=XMLTCP_X I XMLTCP'[$C(10) G RE
R S %=$F(XMLTCP,$C(10))
 ;
 ;Strip out LF (and CR, if present)
 I %,%<256 S XMRG=$E(XMLTCP,1,%-3+($A(XMLTCP,%-2)'=13)),XMLTCP=$E(XMLTCP,%,$L(XMLTCP)) G RQ
 ;
 ;Line too long or doesn't contain a Line Feed, return first 255 chars.
 S XMRG=$E(XMLTCP,1,255),XMLTCP=$E(XMLTCP,256,$L(XMLTCP))
 ;S:$E(XMLTCP)="." XMLTCP="."_XMLTCP
 ;
RQ I $L(XMRG),$C(13,10)[$E(XMRG) S XMRG=$E(XMRG,2,$L(XMRG)) G RQ
 I $G(XMINST) D XMTSTAT^XMTDR(XMINST,"R",XMRG)
 Q
SNDGTM ; Send for GT.M
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D C^XMCTRAP"
 E  S X="C^XMCTRAP",@^%ZOSF("TRAP")
 I $G(XMINST) D XMTSTAT^XMTDR(XMINST,"S",XMSG,1)
 W XMSG,$C(13,10),#
 Q
RECGTM ; Receive for GT.M
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D C^XMCTRAP"
 E  S X="C^XMCTRAP",@^%ZOSF("TRAP")
 R XMRG:$G(XMSTIME,60)
 I '$T S XMRG="" D ERTRAN^XMC1("Receiver timed out") Q
 S XMRG=$TR(XMRG,$C(10,12,13))
 I $G(XMINST) D XMTSTAT^XMTDR(XMINST,"R",XMRG)
 Q
