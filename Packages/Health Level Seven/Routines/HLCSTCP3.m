HLCSTCP3 ;SFIRMFO/RSD - BI-DIRECTIONAL TCP ;2018-09-06  10:24 AM
 ;;1.6;HEALTH LEVEL SEVEN;**76,77,133,122,153,157,OSEHRA**;OCT 13, 1995;Build 8
 ;
 ; Changes **OSEHRA** by Sam Habiel (c) 2018
 ;
OPENA ;
 ; called from $$OPEN^HLCSTCP2 and this sub-routine OPENA
 ;
 ; **P153 START CJM
 ; Reset the TCP Address incase DNS changed it without a successful connection
 K HLDOM
 S HLTCPADD=$P(^HLCS(870,HLDP,400),U)
 ;
RETRY ;
 ; **P153 END CJM
 ;
 I $G(HLMSG),$D(^HLMA(HLMSG,"P")) S HLPORTA=+$P(^("P"),U,6)
 S POP=1
 ;
 ; patch HL*1.6*122 start
 ; variable HLDRETR=re-transmit attemps (#870,200.02)
 ; variable HLTCPLNK("TIMEOUT")=timeout for 3rd parameter of CALL^%ZISTCP()
 ; defined in HLCSTCP routine
 ;
 I '$G(HLDRETR("COUNT")) S HLDRETR("COUNT")=1
 I '$G(HLTCPLNK("TIMEOUT")) S HLTCPLNK("TIMEOUT")=5
 S HLDRETR("COUNT-2")=HLDRETR("COUNT")+HLDRETR
 ; patch 133
 ; I $G(HLDIRECT("OPEN TIMEOUT")) D
 ; .S HLI=1
 ; .D CALL^%ZISTCP(HLTCPADD,HLTCPORT,HLDIRECT("OPEN TIMEOUT"))
 ; E  D
 ; .F HLI=1:1:HLDRETR D CALL^%ZISTCP(HLTCPADD,HLTCPORT) Q:'POP
 I $G(HLDIRECT("OPEN TIMEOUT")) D
 . D MON^HLCSTCP("Open")
 . D CALL^%ZISTCP(HLTCPADD,HLTCPORT,HLDIRECT("OPEN TIMEOUT"))
 . ; give site one more chance to override the application setup
 . I $G(POP),(HLTCPLNK("TIMEOUT")>HLDIRECT("OPEN TIMEOUT")) D
 .. D CALL^%ZISTCP(HLTCPADD,HLTCPORT,HLTCPLNK("TIMEOUT"))
 E  D
 . N COUNT
 . ; try to connect HLDRETR times
 . F HLDRETR("COUNT")=HLDRETR("COUNT"):1:HLDRETR("COUNT-2") D  Q:('POP)!($$STOP^HLCSTCP)
 .. D MON^HLCSTCP("Open")
 .. ; D CALL^%ZISTCP(HLTCPADD,HLTCPORT)
 .. D CALL^%ZISTCP(HLTCPADD,HLTCPORT,HLTCPLNK("TIMEOUT"))
 .. ;open error
 .. I POP D
 ... D CC^HLCSTCP2("Openfail")
 ... H $S(HLDRETR("COUNT")=1:0,HLDRETR("COUNT")<10:1,1:8)
 ... I '$D(^XTMP("HL7-Openfail",$J)) D
 .... S ^XTMP("HL7-Openfail",0)=$$FMADD^XLFDT($$NOW^XLFDT,3)_"^"_$$NOW^XLFDT
 .... S ^XTMP("HL7-Openfail",$J,"COUNT","FIRST")=HLDRETR("COUNT")_"^"_$$NOW^XLFDT
 ... S COUNT=$P($G(^XTMP("HL7-Openfail",$J,"COUNT","LAST")),"^")+1
 ... S ^XTMP("HL7-Openfail",$J,"COUNT","LAST")=COUNT_"^"_$$NOW^XLFDT
 ;
 ;set # of opens back in msg
 ; I $G(HLMSG),$D(^HLMA(HLMSG,"P")) S $P(^("P"),U,6)=HLPORTA+HLI
 I $G(HLMSG),$D(^HLMA(HLMSG,"P")) S $P(^("P"),U,6)=HLDRETR("COUNT")
 ; patch HL*1.6*122 end
 ;
 ;device open
 I 'POP S HLPORT=IO D  Q $S($G(HLERROR)]"":0,1:1)
 . N $ETRAP,$ESTACK S $ETRAP="D ERROR^HLCSTCP2" ;HL*1.6*77
 . ;if address came from DNS, set back into LL
 . I $D(HLIP) S $P(^HLCS(870,HLDP,400),U)=HLTCPADD
 . ; write and read to check if still open
 . ; patch HL*1.6*157: HLOS is from calling $$OS^%ZOSV
 . ; Q:HLOS'["OpenM"  X "U IO:(::""-M"")" ; must be Cache/NT + use packet mode
 . ; Q:(HLOS'["VMS")&(HLOS'["UNIX")  X "U IO:(::""-M"")" ; must be Cache + packet mode  ; **OSEHRA** -> This line crashes on GTM/YDB
 . ; **OSEHRA** - begin replacement code
 . Q:(HLOS'["VMS")&(HLOS'["UNIX")
 . I ^%ZOSF("OS")["OpenM" U IO:(::"-M")
 . E  I ^%ZOSF("OS")["GT.M"  U IO:(nowrap:nodelimiter)
 . E  U IO
 . Q:$P(^HLCS(870,HLDP,400),U,7)'="Y"  ; must want to SAY HELO
 . U IO W "HELO "_$$KSP^XUPARAM("WHERE"),! R X:1
 ;openfail-try DNS lookup
 ;
 ; patch HL*1.6*122 start
 ;I '$D(HLDOM) S HLDOM=+$P(^HLCS(870,HLDP,0),U,7),HLDOM=$P($G(^DIC(4.2,HLDOM,0)),U) D:HLDOM]"" DNS
 I '$D(HLDOM) D
 . S HLDOM=+$P(^HLCS(870,HLDP,0),U,7),HLDOM=$P($G(^DIC(4.2,HLDOM,0)),U)
 . S HLDOM("DNS")=$P($G(^HLCS(870,+$G(HLDP),0)),"^",8)
 . D:HLDOM]""!($L(HLDOM("DNS"),".")>2) DNS
 ;
 Q:$$STOP^HLCSTCP 0
 ;HLIP=ip add. from DNS call, get first one and try open again
 ;
 ; **P153 START CJM
 ;I $D(HLIP) S HLTCPADD=$P(HLIP,","),HLIP=$P(HLIP,",",2,99) G:HLTCPADD OPENA
 I $D(HLIP) S HLTCPADD=$P(HLIP,","),HLIP=$P(HLIP,",",2,99) G:HLTCPADD RETRY
 ; **P153 END CJM
 ;
 ; open error
 ;cleanup and close
 ; patch 133
 I $G(HLDIRECT("OPEN TIMEOUT")) D
 . D MON^HLCSTCP("Openfail")
 . I $D(HLPORT) D CLOSE^%ZISTCP K HLPORT
 E  D
 . D CC^HLCSTCP2("Openfail")
 Q 0
 ; patch HL*1.6*122 end
 ;
 ;
 ;following code was removed, site's complained of to many alerts
 ;couldn't open, send 1 alert
 ;I '$G(HLPORTA) D
 ;. ;send alert
 ;. N XQA,XQAMSG,XQAOPT,XQAROU,XQAID,Z
 ;. ;get mailgroup from file 869.3
 ;. S Z=$P($$PARAM^HLCS2,U,8),HLPORTA="" Q:Z=""
 ;. S XQA("G."_Z)="",XQAMSG=$$HTE^XLFDT($H,2)_" Logical Link "_$P(^HLCS(870,HLDP,0),U)_" exceeded Open Retries."
 ;. D SETUP^XQALERT
 ;open error
 ;D CC("Openfail") H 3
 ;Q 0
 ;
 ;
DNS ;VA domains must have "med" inserted.
 ;All domains must use port 5000 and are prepended with "HL7"
 ;non-VA DNS lookups will succeed if site uses port 5000 and 
 ;configure their local DNS with "HL7.yourdomain.com" and entries
 ;are created in the logical link file and domain file.
 D MON^HLCSTCP("DNS Lkup")
 I HLDOM["DOMAIN.EXT"&(HLDOM'[".MED.") S HLDOM=$P(HLDOM,".DOMAIN.EXT")_".DOMAIN.EXT"
 I HLTCPORT=5000 S HLDOM="HL7."_HLDOM
 I HLTCPORT=5500 S HLDOM="MPI."_HLDOM
 ;
 ; patch HL*1.6*122 start
 I $L($G(HLDOM("DNS")),".")>2 D
 . S HLDOM=HLDOM("DNS")
 ; patch HL*1.6*122 end
 ;
 S HLIP=$$ADDRESS^XLFNSLK(HLDOM)
 K:HLIP="" HLIP
 Q
 ;
