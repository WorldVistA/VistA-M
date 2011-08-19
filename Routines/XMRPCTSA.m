XMRPCTSA ;(KC-VAMC)/XXX-Steal TWIX's from PCTS Host [RCVR] ;04/08/98  10:39
 ;;8.0;MailMan;;Jun 28, 2002
 ; Create a Mailgroup called PCTS, all messages will be sent to its
 ; membership.  This can be called from a mailman script, it should
 ; look something like this:
 ; 
 ; O H=VHA.DMIA,P=SCP     <---- Domain name and protocol are meaningless
 ; C MINI
 ; L ogin:
 ; S pcts
 ; L CODE:
 ; X W "PCTS RUCHxxx",!    <---- This is your local routing indicator
 ; X S XMRPCTS0=XMCI+1
 ; X D ^XMRPCTS              <---- Call this routine
 ; X K XMRPCTS0
 ;-----------------
 ; Mailman Host: VHA.DMIA, Physical Link: MINIOUT
 ;-------------------------------------------------------------
XM N %,DIC,X,XMDF,XMTEXT,XXX,XMY,XMZ,Y
 S %=$$DSP("<==Locally Mailing AMS Message"),XMRPCTS("R")=XMRPCTS("R")+1
 N XM,XMCHAN,ZTSK,ZTQUEUED S ZTSK=1,ZTQUEUED=1,XMCHAN=1
 S XMDF=1,U="^",XMTEXT="^TMP($J,",XMDUZ=.5
 S XMY("G.PCTS")="",XMY(XMDUZ)="",XXX=XMSUB D ^XMD S XMLMN=XMZ
 ;--Make it look like a network message so we can track some info
 S ^XMB(3.9,XMZ,2,.001,0)="Received: from PCTS/AMS by "_^XMB("NETNAME")_" via DMI/MM translation with SSP."
 S ^XMB(3.9,XMZ,2,.002,0)="Subject: "_XXX
 S ^XMB(3.9,XMZ,2,.003,0)="Date: "_$$INDT^XMXUTIL1($$NOW^XLFDT())
 S ^XMB(3.9,XMZ,2,.004,0)="Message-ID:<"_$P(XMMN," ")_"@AMS>"
 S ^XMB(3.9,XMZ,2,.005,0)="From: The Austin AMS System"
 S ^XMB(3.9,XMZ,2,.006,0)="To: G.PCTS"
 S ^XMB(3.9,XMZ,2,.007,0)="X-Another service provided by DHCP"
 S ^XMB(3.9,XMZ,2,.008,0)=""
 Q
REPLY ;Let AMS know we have the message OK and what our local msg number is
 S %=$$DSP("<==MAK2, Message #"_XMLMN_" Removed from AMS Queue")
 U IO W "MAK2",!,XMMN,!,"#"_XMLMN,!,XMET,XMCR Q
 ;
INIT ;called from XMRPCTS & XMRPCTS0
 S %=$$DSP("==>Initializing<==")
 I '$G(XMCI) S XMCI=$S($G(XMRPCTS0):XMRPCTS0,1:999999) I XMCI>999 S ER=1,Y="Lost the counter to the script processor (XMCI)."
 S %=0,XMCR=$C(13),XMLF=$C(10),XMET=$C(4),XMSH=$C(1)
 D TERMON
 K ^TMP($J) ;Scratch Space
 S XMLPC=0 ;Longitudinal Parity Check for SSP
 S XMDH="0123456789ABCDEF" ; for LPC calculations
 Q
 ;
TERMON ;Need to change read terminators
 I ^%ZOSF("OS")["DSM" U IO:TERM=$C(3,4,13,27) Q
 I ^%ZOSF("OS")["MSM" U IO:(::::::::$C(3,4,13,27)) Q
 I ^%ZOSF("OS")["OpenM-NT" U $I:("":"+I-T":$C(3,4,13,27)) Q
 W XMRPCTS("ERROR"),"Terminators not defined for this operating system",!
 Q
 ;
DSP(XMTRAN) D TRAN^XMC1
 Q ""
 ;
ERR D ^%ZTER S %=$$DSP("ERROR captured in error trap !!!")
 G UNWIND^%ZTER
