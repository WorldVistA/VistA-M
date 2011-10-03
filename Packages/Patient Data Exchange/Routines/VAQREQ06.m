VAQREQ06 ;ALB/JFP - REQUEST PDX RECORD,TRANSMIT;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;**4,20,26,32**;NOV 17, 1993
EP ; -- Programmer entry point for sending PDX requests
 ; -- This code is used by both request and unsolicited request
 ;
 D:$D(XRTL) T0^%ZOSV ; -- Capacity start
 S VAQDOM="",(POP,DOMCNT)=0 W !!,"Working..."
 D PRELOAD
 F  S VAQDOM=$O(^TMP("VAQSEG",$J,VAQDOM))  Q:VAQDOM=""  D XMIT
 I POP K POP QUIT
 S VAQFLAG=1
 W !!,"Transactions filed "
TASK ; -- Load taskman variables and task off
 S ZTRTN="GENXMIT^VAQADM50"
 S ZTDESC=$S(VAQOPT="REQ":"PDX, REQUEST",VAQOPT="UNS":"PDX, UNSOLICITED",1:"PDX, GENERATE TRANSMISSION")
 S ZTDTH=$H,ZTIO=""
 S ZTSAVE("VAQTRN(")=""
 I ZTRTN'="" D ^%ZTLOAD
 I $D(ZTSK)  W "and queued "
 K ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 K ^TMP("CMNT",$J),FACDA,NOTI,PARMNODE,DOMDA,X,Y,DOMCNT,LOAD
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; -- Capacity stop
 QUIT
 ;
XMIT ; -- Makes an entry in the 'PDX TRANSACTION' file
 S Y=$$NEWTRAN^VAQFILE Q:Y<0
 S DOMCNT=DOMCNT+1 W:(DOMCNT#10)=0 "."
 S (VAQPR,DA)=+Y,VAQTRN=$P(Y,"^",2)
 S LOAD=$S(VAQOPT="REQ":"LDREQ",VAQOPT="UNS":"LDUNS",1:"LDREQ")
 D @LOAD
 D:$D(^TMP("VAQNOTI",$J)) MNOTI
 D:$D(^TMP("VAQSEG",$J)) MSEG
 I VAQOPT="UNS"&($D(^TMP("CMNT",$J))) D CMNT
 ; -- Load an array of newly entered transactions
 S VAQTRN(VAQPR)=""
 ; -- Updates workload file
 S X=$$WORKDONE^VAQADS01($S(VAQOPT="REQ":"RQST",VAQOPT="UNS":"SEND",1:""),VAQPR,$G(DUZ))
 Q
 ;
PRELOAD ; -- Loads the constant data for multiple domains
 S %DT="ST",X="NOW" D ^%DT S VAQRQDT=Y
 S VAQPID=""
 S VAQSENPT=""
 I VAQDFN>0 D
 .S DFN=+VAQDFN
 .D PID^VADPT6
 .S VAQPID=$P($G(VA("PID")),U,1)
 .K VA("PID"),VA("BID")
 .S VAQSENPT=$$GETSEN^VAQUTL97(DFN) ; --Sensitive patient
 .S:VAQSENPT<0 VAQSENPT=""
 ;
 S PARMNODE=$G(^VAT(394.81,1,0))
 S FACDA=$P(PARMNODE,U,1),DOMDA=$P(PARMNODE,U,2)
 S VAQRQSIT=$P($G(^DIC(4,FACDA,0)),U,1)
 S VAQRQADD=$P($G(^DIC(4.2,DOMDA,0)),U,1)
 ;
 S (VAQDZ,VAQDZN)=""
 I $G(DUZ)'="" D
 .S VAQDZN=$S($D(DUZ):$P(^VA(200,DUZ,0),U,1),1:"")
 .S VAQDZ=$S($D(DUZ):DUZ,1:"")
 QUIT
 ;
LDREQ ; -- Sets DR string and non-constant variables, LOAD FOR REQUEST
 S:'$D(VAQNOTI) VAQNOTI=0 ; -- UNS does not use notify logic
 S VAQAUSIT=$$GETINST^VAQUTL97(VAQDOM)
 S DR=".02///VAQ-RQST"
 S DR(1,394.61,.03)=".03////"_$S(+VAQDFN>0:+VAQDFN,1:"")
 S DR(1,394.61,.04)=".04///"_VAQSENPT
 S DR(1,394.61,.05)=".05///VAQ-RQST"
 S DR(1,394.61,10)="10///"_VAQNM
 S DR(1,394.61,11)="11///"_VAQISSN
 S DR(1,394.61,12)="12///"_VAQIDOB
 S DR(1,394.61,13)="13///"_VAQPID
 S DR(1,394.61,20)="20///"_VAQRQDT
 S DR(1,394.61,21)="21///"_VAQDZN
 S DR(1,394.61,30)="30///"_VAQRQSIT
 S DR(1,394.61,31)="31///"_VAQRQADD
 S DR(1,394.61,60)="60///"_VAQAUSIT
 S DR(1,394.61,61)="61///"_VAQDOM
 S DR(1,394.61,70)="70///"_VAQNOTI
 ;
 S DIE="^VAT(394.61,"
 D ^DIE K DIE,DR
 QUIT
 ;
LDUNS ; -- Sets DR string and non-constant variables, LOAD FOR UNSOLICITED
 S VAQAUSIT=$$GETINST^VAQUTL97(VAQDOM)
 S DR=".02///VAQ-TUNSL"
 S DR(1,394.61,.03)=".03////"_$S(+VAQDFN>0:+VAQDFN,1:"")
 S DR(1,394.61,.04)=".04///"_VAQSENPT
 S DR(1,394.61,.05)=".05///VAQ-UNSOL"
 S DR(1,394.61,10)="10///"_VAQNM
 S DR(1,394.61,11)="11///"_VAQISSN
 S DR(1,394.61,12)="12///"_VAQIDOB
 S DR(1,394.61,13)="13///"_VAQPID
 S DR(1,394.61,20)="20///"_VAQRQDT
 S DR(1,394.61,21)="21///"_VAQDZN
 S DR(1,394.61,50)="50///"_VAQRQDT
 S DR(1,394.61,51)="51///"_VAQDZN
 S DR(1,394.61,30)="60///"_VAQRQSIT
 S DR(1,394.61,31)="61///"_VAQRQADD
 S DR(1,394.61,60)="30///"_VAQAUSIT
 S DR(1,394.61,61)="31///"_VAQDOM
 ;
 S DIE="^VAT(394.61,"
 D ^DIE K DIE,DR
 QUIT
MNOTI ; -- Loads the notify muliple
 S DIE="^VAT(394.61,",DLAYGO=394.61,NOTI=""
 F  S NOTI=$O(^TMP("VAQNOTI",$J,NOTI))  Q:NOTI=""  D
 .S DR="71///"_NOTI
 .D ^DIE
 K DIE,DR,DLAYGO
 QUIT
 ;
MSEG ; -- Loads the data segment muliple
 S SEG=""
 F  S SEG=$O(^TMP("VAQSEG",$J,VAQDOM,SEG))  Q:(SEG="")  D
 .S SEGND=$G(^TMP("VAQSEG",$J,VAQDOM,SEG))
 .S VAQJUNK=$$FILESEG^VAQFILE2(394.61,VAQPR,80,$P(SEGND,"^",1),$P(SEGND,"^",3),$P(SEGND,"^",4))
 K VAQJUNK
 QUIT
 ;
CMNT ; -- Loads comment for unsolicited request (WORD PROCESSOR FIELD)
 S %X="^TMP(""CMNT"",$J,"
 S %Y="^VAT(394.61,"_DA_",""CMNT"","
 D %XY^%RCR
 K %X,%Y
 QUIT
 ;
END ; -- End of code
 ;QUIT
