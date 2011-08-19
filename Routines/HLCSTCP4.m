HLCSTCP4 ;SFIRMFO/RSD - BI-DIRECTIONAL TCP ;04/16/08  14:20
 ;;1.6;HEALTH LEVEL SEVEN;**109,122,140**;Oct 13,1995;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ; RDERR & ERROR moved from HLCSTCP2 on 12/2/2003 - LJA
 ;
RDERR ; Error during read process, decrement counter
 D LLCNT^HLCSTCP(HLDP,4,1)
ERROR ; Error trap
 ; OPEN ERROR-retry.
 ; WRITE ERROR (SERVER DISCONNECT)-close channel, retry
 ;
 ;**109**
 ;I $G(HLMSG) L -^HLMA(HLMSG)
 ;
 ; patch HL*1.6*122 start
 N STOP
 S STOP=0
 I $G(HLDP) S STOP=$$STOP^HLCSTCP
 ; patch HL*1.6*140
 S $ETRAP="D HALT^ZU" ;RWF
 S HLTCP("$ZA\8192#2")=""
 I (^%ZOSF("OS")["OpenM") D
 . S HLTCP("$ZA")=$ZA
 . ; For TCP devices $ZA\8192#2: the device is currently in the
 . ; Connected state talking to a remote host.
 . S HLTCP("$ZA\8192#2")=$ZA\8192#2
 ;
 S HLTCPERR("ERR-$ZE")=$$EC^%ZOSV
 ; I $$EC^%ZOSV["OPENERR"!($$EC^%ZOSV["NOTOPEN")!($$EC^%ZOSV["DEVNOTOPN") D CC^HLCSTCP2("Op-err") S:$G(HLPRIO)="I" HLERROR="15^Open Related Error" D UNWIND^%ZTER Q
 I $$EC^%ZOSV["OPENERR"!($$EC^%ZOSV["NOTOPEN")!($$EC^%ZOSV["DEVNOTOPN") D  G:STOP H2^XUSCLEAN Q
 . D CC^HLCSTCP2("Op-err")
 . S:$G(HLPRIO)="I" HLERROR="15^Open Related Error"
 . I STOP D  Q
 .. D CC^HLCSTCP2("Shutdown: (with 'Op-err')")
 . I 'STOP D UNWIND^%ZTER
 ; patch HL*1.6*140 start
 ; I $$EC^%ZOSV["WRITE" D  G:STOP!(HLTCP("$ZA\8192#2")=0) H2^XUSCLEAN Q
 I $$EC^%ZOSV["WRITE" D  G:STOP!(HLTCP("$ZA\8192#2")) H2^XUSCLEAN Q
 . ; S:$G(HLPRIO)="I" HLERROR="108^Write Error"
 . I $G(HLPRIO)="I" D  Q
 .. S HLERROR="108^Write Error"
 .. D CC^HLCSTCP2("Wr-err")
 .. D UNWIND^%ZTER
 . ;
 . I STOP D  Q
 .. D ^%ZTER,CC^HLCSTCP2("Shutdown: (with 'Wr-err')")
 . E  D  Q
 .. I HLTCP("$ZA\8192#2") D ^%ZTER,CC^HLCSTCP2("Wr-err") Q
 .. E  D  Q
 ... D CC^HLCSTCP2("Halt (Wr): (Disconnected with 'Wr-err')")
 ... D UNWIND^%ZTER
 ;
 ; I $$EC^%ZOSV["READ" D CC^HLCSTCP2("Rd-err") S:$G(HLPRIO)="I" HLERROR="108^Read Error" D UNWIND^%ZTER Q
 ; I $$EC^%ZOSV["READ" D  G:STOP!(HLTCP("$ZA\8192#2")=0) H2^XUSCLEAN Q
 I $$EC^%ZOSV["READ" D  G:STOP!(HLTCP("$ZA\8192#2")) H2^XUSCLEAN Q
 . ; S:$G(HLPRIO)="I" HLERROR="108^Read Error"
 . I $G(HLPRIO)="I" D  Q
 .. S HLERROR="108^Read Error"
 .. D CC^HLCSTCP2("Rd-err")
 .. D UNWIND^%ZTER
 . ;
 . I STOP D  Q
 .. D ^%ZTER,CC^HLCSTCP2("Shutdown: (with 'Rd-err')")
 . E  D  Q
 .. I HLTCP("$ZA\8192#2") D ^%ZTER,CC^HLCSTCP2("Rd-err") Q
 .. E  D  Q
 ... D CC^HLCSTCP2("Halt (Rd): (Disconnected with 'Rd-err')")
 ... D UNWIND^%ZTER
 ;
 ; S HLCSOUT=1 D ^%ZTER,CC^HLCSTCP2("Error"),SDFLD^HLCSTCP
 ; S:$G(HLPRIO)="I" HLERROR="9^Error"
 D ^%ZTER
 I $G(HLPRIO)="I" D  Q
 . S HLERROR="9^Error"
 . D CC^HLCSTCP2("Error")
 . D UNWIND^%ZTER
 ;
 I STOP D  Q
 . D CC^HLCSTCP2("Shutdown: (with 'Error')")
 . D H2^XUSCLEAN
 ;
 D CC^HLCSTCP2("Error")
 ; patch HL*1.6*122 end
 D H2^XUSCLEAN
 ; patch HL*1.6*140 end
 Q
 ;
PROXY ; set DUZ for application proxy user
 ;
 ; removed the execution: patch 122 TEST v2
 Q
 ;
 ;; S HLDUZ=+$$APFIND^XUSAP("HLSEVEN,APPLICATION PROXY")
 ;; S DUZ=HLDUZ
 ;; D DUZ^XUP(DUZ)
 ;; Q
 ;
HLDUZ ; compare DUZ and set DUZ to application proxy user
 ;
 ; removed the execution: patch 122 TEST v2
 Q
 ;
 ;; I '$G(HLDUZ) D PROXY
 ;
HLDUZ2 ; compare DUZ and HLDUZ
 I $G(DUZ)'=HLDUZ D
 . S DUZ=HLDUZ
 . D DUZ^XUP(DUZ)
 Q
 ;
CLEANVAR ; clean variables for server, called from HLCSTCP1
 ;
 ; clean variables except Kernel related variables
 ; protect variables defined in HLCSTCP
 N HLDP
 N HLCSOUT,HLDBACK,HLDBSIZE,HLDREAD,HLDRETR,HLRETRA,HLDWAIT,HLOS
 N HLTCPADD,HLTCPCS,HLTCPLNK,HLTCPORT,HLTCPRET,HLCSFAIL,HLZRULE
 ;
 ; protect variables defined in LISTEN^HLCSTCP
 ; N HLLSTN,HLCSOUT,HLDBACK,HLDBSIZE,HLDREAD,HLDRETR,HLRETRA,HLDWAIT
 ; N HLOS,HLTCPADD,HLTCPCS,HLTCPLNK,HLTCPORT,HLTCPRET,HLCSFAIL
 N HLLSTN
 ;
 ; protect variables defined in CACHEVMS^HLCSTCP and EN^HLCSTCP
 N %
 ; protect variables defined in this routine HLCSTCP1
 N $ETRAP,$ESTACK
 N HLMIEN,HLASTMSG
 N HLTMBUF
 N HLDUZ,DUZ
 ; Kernel variables for single listener
 N ZISOS,ZRULE
 ;
 D KILL^XUSCLEAN
 Q
MIEN ; sets HLIND1=ien in 773^ien in 772 for message
 N HLMID,X
 I HLIND1 D
 . S:'$G(^HLMA(+HLIND1,0)) HLIND1=0
 . S:'$G(^HL(772,+$P(HLIND1,U,2),0)) HLIND1=0
 ;msg. id is 10th of MSH & 11th for BSH or FSH
 S X=10+($E(HLMSG(1,0),1,3)'="MSH"),HLMID=$$PMSH(.HLMSG,X)
 ;if HLIND1 is set, kill old message, use HLIND1 for new
 ;message, it means we never got end block for 1st msg.
 I HLIND1 D  Q
 . ;get pointer to 772, kill header
 . ;
 . ; patch HL*1.6*122: MPI-client/server
 . F  L +^HLMA(+HLIND1):10 Q:$T  H 1
 . K ^HLMA(+HLIND1,"MSH")
 . L -^HLMA(+HLIND1)
 . ;
 . I $D(^HL(772,+$P(HLIND1,U,2),"IN")) K ^("IN")
 . S X=$$MAID^HLTF(+HLIND1,HLMID)
 . D SAVE^HLCSTCP1(.HLMSG,"^HLMA("_+HLIND1_",""MSH"")")
 . S:$P(HLIND1,U,3) $P(HLIND1,U,3)=""
 D TCP^HLTF(.HLMID,.X,.HLDT)
 S HLBUFF("IEN773")=X
 I 'X D  Q
 . ;error - record and reset array
 . ;killing HLLSTN will allow MON^HLCSTCP to work with multi-server
 . D CLEAN^HLCSTCP1 K HLLSTN
 . ;error 100=LLP could not en-queue the message, reset array
 . D MONITOR^HLCSDR2(100,19,HLDP),MON^HLCSTCP("ERROR") H 30
 ;HLIND1=ien in 773^ien in 772
 S HLIND1=X_U_+$G(^HLMA(X,0))
 S HLBUFF("HLIND1")=HLIND1
 ;save MSH into 773
 D SAVE^HLCSTCP1(.HLMSG,"^HLMA("_+HLIND1_",""MSH"")")
 Q
 ;
PMSH(MSH,P) ;get piece P from MSH array (passed by ref.)
 N FS,I,L,L1,L2,X,Y
 S FS=$E(MSH(1,0),4),(L2,Y)=0,X=""
 F I=1:1 S L1=$L($G(MSH(I,0)),FS),L=L1+Y-1 D  Q:$L(X)!'$D(MSH(I,0))
 . S:L1=1 L=L+1
 . S:P'>L X=$P($G(MSH(I-1,0)),FS,P-L2)_$P($G(MSH(I,0)),FS,(P-Y))
 . S L2=Y,Y=L
 Q X
 ;
ERROR1 ;
 ; moved from ERROR^HLCSTCP1
 ; Error trap for disconnect error and return back to the read loop.
 ; patch HL*1.6*122 start
 ; patch HL*1.6*140
 ; S $ETRAP="D HALT^ZU" ;RWF
 S $ETRAP="H 1 D HALT^ZU" ;RWF
 I (^%ZOSF("OS")["OpenM") D
 . S HLTCP("$ZA")=$ZA
 . ; For TCP devices $ZA\8192#2: the device is currently in the
 . ; Connected state talking to a remote host.
 . S HLTCP("$ZA\8192#2")=$ZA\8192#2
 . I HLTCP("$ZA\8192#2")=0 D
 .. ; decrement counter of multi-listener
 .. I $D(^HLCS(870,"E","M",+$G(HLDP))) D EXITM^HLCSTCP
 .. ; process terminated
 .. D H2^XUSCLEAN
 ; patch HL*1.6*140
 ;S $ETRAP="D UNWIND^%ZTER" ;RWF
 ; I $$EC^%ZOSV["READ"!($$EC^%ZOSV["NOTOPEN")!($$EC^%ZOSV["DEVNOTOPN") D UNWIND^%ZTER Q
 I ($$EC^%ZOSV["NOTOPEN")!($$EC^%ZOSV["DEVNOTOPN") D  Q
 . ; if it is not a multi-listener
 . I '$D(^HLCS(870,"E","M",+$G(HLDP))) D CC^HLCSTCP1("Open-err")
 . D UNWIND^%ZTER
 I $$EC^%ZOSV["READ" D  Q
 . ; if it is not a multi-listener
 . I '$D(^HLCS(870,"E","M",+$G(HLDP))) D CC^HLCSTCP1("Rd-err")
 . D UNWIND^%ZTER
 ;
 ; I $$EC^%ZOSV["WRITE" D CC("Wr-err") D UNWIND^%ZTER Q
 I $$EC^%ZOSV["WRITE" D  Q
 . ; if it is not a multi-listener
 . I '$D(^HLCS(870,"E","M",+$G(HLDP))) D CC^HLCSTCP1("Wr-err")
 . D UNWIND^%ZTER
 ;
 ; for GT.M
 I $ECODE["UREAD" D  Q
 . ; if it is not a multi-listener
 . I '$D(^HLCS(870,"E","M",+$G(HLDP))) D CC^HLCSTCP1("Rd-err")
 . D UNWIND^%ZTER
 ;
 ; S HLCSOUT=1 D ^%ZTER,CC("Error")
 S HLCSOUT=1
 D ^%ZTER
 ; if it is not a multi-listener
 I '$D(^HLCS(870,"E","M",+$G(HLDP))) D CC^HLCSTCP1("Error")
 ; patch HL*1.6*122 end
 ;
 D UNWIND^%ZTER
 Q
 ;
CLRMCNTR ;
 ; clear the counter to set as "0 server" for multi-listener
 ; HL*1.6*122 start
 Q:'$G(HLDP)
 Q:'$D(^HLCS(870,"E","M",HLDP))
 S $P(^HLCS(870,HLDP,0),"^",4)="MS"
 S $P(^HLCS(870,HLDP,0),U,5)="0 server"
 Q
 ;
CREATUSR ;
 ; patch HL*1.6*122 TEST v2: DUZ code removed
 ; create application proxy users for listeners and incoming filer
 ;; N HLTEMP
 ;; S HLTEMP=$$CREATE^XUSAP("HLSEVEN,APPLICATION PROXY","#")
 Q
