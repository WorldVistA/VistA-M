XMTDR ;ISC-SF/GMB-Transmit messages in a queue ;08/28/2003  09:22
 ;;8.0;MailMan;**22**;Jun 28, 2002
PLAY(XMINST,XMSITE,XMB) ; 
 N XMIO,XMTLER,XM,XMTURN
 S:'$D(ZTQUEUED) XM="D"
 S XMIO=$P(XMB("SCR REC"),U,5)
 D ENT^XMC1
 Q
TASK ; Task Manager comes here to send message to remote site
 ; (Tasked by QUEUE^XMKPR or REQUEUE^XMKPR)
 ; Was ZTSK^XMS0 (ISC-WASH/THM/CAP)
 ; Variables supplied by TaskMan:
 ; XMINST   Institution number
 ; XMPOLL   Are we polling?  0=no; 1=yes
 ;
 ; Variables used here:
 ; XMSITE   Institution name
 ; XMIO     same as ZTIO
 ; XMB("SCR IEN") Points to which script for XMINST in ^DIC(4.2 to use
 ; XMB("SCR REC") The script record
 ; XMB("TRIES")   # of tries
 I '$D(XMINST) S XMINST=XMB("XMSCR") K XMB ; Transition: v7.1 to v8.0
 S ZTREQ="@"
 Q:$$OBE(XMINST)
 I '$$NEXT^XMS(XMINST+1000),'$G(XMPOLL) D XMTFINIS(XMINST) Q
 N XMB,XMC,XMSITE,XM,XMIO
 S XM=$G(XM)
 S XMIO=ZTIO
 S XMSITE=$P(^DIC(4.2,XMINST,0),U,1)
 D XMTGET(XMINST,.XMB)
 D XMTAUDT(XMINST,.XMB)
 I XMB("TRIES")+1=$P(XMB("SCR REC"),U,3) D GET^XMCXT(1) ; Record transcript
 D ENT^XMC1
 I $G(ER),'$G(XMPOLL),'$G(XMC("NOREQUEUE")) D REQUEUE^XMKPR(XMINST,XMSITE,.XMB) Q
 D XMTFINIS(XMINST)
 I $G(XMC("S"))!$G(XMC("R")) D CHKSETIP(XMINST,XMSITE,.XMB)
 Q
CHKSETIP(XMINST,XMSITE,XMB) ;
 N XMOLDIP,XMIP,XMIENS,XMTXT,XMPARM
 S XMIP=$P(XMB("SCR REC"),U,6) Q:XMIP=""
 S XMIENS=XMINST_","
 ;I $P(^DIC(4.2,XMINST,0),U,12)'=XMIP D
 ;. S XMFDA(4.2,XMIENS,6.5)=XMIP ; successful IP address
 ;. D FILE^DIE("","XMFDA")
 Q:+XMB("SCR IEN")'=XMB("SCR IEN")!'XMB("SCR IEN")
 S XMOLDIP=$P(^DIC(4.2,XMINST,1,XMB("SCR IEN"),0),U,6)
 Q:XMOLDIP=XMIP
 I $$FIND1^DIC(4.2,"","MQX",XMC("HELO SEND"),"B^C")'=XMINST D  Q
 . Q:'$G(XMC("PLAY"))!$D(ZTQUEUED)
 . ;We will not change the IP address in the script because the site
 . ;self-identifed as |1|, which is not |2| or any of its synonyms.
 . N XMPARM,XMTEXT
 . S XMPARM(1)=XMC("HELO SEND"),XMPARM(2)=XMSITE
 . D BLD^DIALOG(42269,.XMPARM,"","XMTEXT","F")
 . D MSG^DIALOG("WM","","","","XMTEXT")
 S XMIENS=XMB("SCR IEN")_","_XMIENS
 S XMFDA(4.21,XMIENS,1.4)=XMIP ; successful IP address
 D FILE^DIE("","XMFDA")
 S XMPARM(1)=XMOLDIP,XMPARM(2)=XMIP,XMPARM(3)=$$MMDT^XMXUTIL1($$NOW^XLFDT)
 I $G(XMC("PLAY")),'$D(ZTQUEUED) W !,$$EZBLD^DIALOG(42267,.XMPARM) ;Changed IP address in script from '|1|' to '|2|'
 S XMTXT(1,0)=$$EZBLD^DIALOG(42268,.XMPARM) ;|3| - Changed IP address from '|1|' to '|2|' (MailMan)
 D WP^DIE(4.21,XMIENS,99,"A","XMTXT") ; Add line to script notes
 Q
OBE(XMINST) ; Overcome by Events?
 N XMTSK
 S XMTSK=+$$TSKEXIST^XMKPR(XMINST)
 I XMTSK,ZTSK'=XMTSK Q 1
 Q 0
XMTGET(XMINST,XMB) ;
 N XMTREC
 L +^XMBS(4.2999,XMINST,4):0 L -^XMBS(4.2999,XMINST,4) ; ensure latest
 S XMTREC=^XMBS(4.2999,XMINST,4)
 S XMB("SCR IEN")=$P(XMTREC,U,3)
 S XMB("TRIES")=$P(XMTREC,U,4)
 S XMB("ITERATIONS")=$P(XMTREC,U,6)
 S XMB("FIRST SCRIPT")=$P(XMTREC,U,7)
 S XMB("IP TRIED")=$P(XMTREC,U,8)
 S XMB("SCR REC")=^XMBS(4.2999,XMINST,5)
 Q
XMTAUDT(XMINST,XMB) ;
 N XMTREC,XMFDA,XMIENS,XMIEN,XMNOW
 L +^XMBS(4.2999,XMINST)
 S XMNOW=$$NOW^XLFDT
 S XMIENS=XMINST_","
 S XMFDA(4.2999,XMIENS,1)="@" ; current time
 S XMFDA(4.2999,XMIENS,2)="@" ; msg in transit
 S XMFDA(4.2999,XMIENS,3)="@" ; line last transmitted
 S XMFDA(4.2999,XMIENS,4)="@" ; errors this transmission
 S XMFDA(4.2999,XMIENS,5)="@" ; rate of transmission
 S XMFDA(4.2999,XMIENS,6)="@" ; device
 S XMTREC=^XMBS(4.2999,XMINST,4)
 I '$P(XMTREC,U,1)!$P(XMTREC,U,2) D
 . ; There's no start time or there is a finish time, so start audit anew
 . K ^XMBS(4.2999,XMINST,6)        ; kill off the audit multiple
 . S XMFDA(4.2999,XMIENS,41)=XMNOW ; start time
 . S XMFDA(4.2999,XMIENS,42)="@"   ; finish time
 S XMFDA(4.2999,XMIENS,45)=XMNOW   ; latest try time
 D FILE^DIE("","XMFDA")
 K XMFDA
 S XMFDA(4.29992,"+1,"_XMIENS,.01)=XMNOW ; audit try time
 S XMFDA(4.29992,"+1,"_XMIENS,1)=$E($P(XMB("SCR REC"),U),1,10) ; audit script name
 S XMFDA(4.29992,"+1,"_XMIENS,3)=$E($P(XMB("SCR REC"),U,6),1,20) ; audit IP address
 D UPDATE^DIE("","XMFDA","XMIEN")
 L -^XMBS(4.2999,XMINST)
 S XMB("AUDIT IENS")=XMIEN(1)_","_XMIENS
 Q
XMTFINIS(XMINST) ;
 N XMFDA,XMIENS
 L +^XMBS(4.2999,XMINST)
 K ^XMBS(4.2999,XMINST,3)  ; current xmit stats
 ;K ^XMBS(4.2999,XMINST,4) ; latest xmit info (don't delete)
 ;K ^XMBS(4.2999,XMINST,5) ; script
 ;K ^XMBS(4.2999,XMINST,6) ; xmit audit history (don't delete)
 S XMIENS=XMINST_","
 S XMFDA(4.2999,XMIENS,42)=$$NOW^XLFDT ; finish time
 D FILE^DIE("","XMFDA")
 L -^XMBS(4.2999,XMINST)
 Q
ERRTRAP ; (Called from ^XMCTRAP)
 I '$D(ZTSK)!$G(XMPOLL) D XMTFINIS(XMINST) Q
 D REQUEUE^XMKPR(XMINST,XMSITE,.XMB)
 Q
XMTSTAT(XMINST,XMWHICH,XMTXT,XMINCR) ; Statistics recording for message transmission
 ; We write to 4.2999 every 20 lines up to 100, and then every 100 lines
 ; after that.
 ; XMWHICH   S=Send; R=Receive
 ; XMTXT     XMSG or XMRG (What is sent or received)
 S XMC("C",XMWHICH)=$G(XMC("C",XMWHICH))+$L(XMTXT) ; chars xmit this session
 S XMC("L")=$G(XMC("L"))+$G(XMINCR,1) ; lines xmit this session
 Q:XMC("L")#$S(XMC("L")>100:100,1:20)
 S ^XMBS(4.2999,XMINST,3)=$H_U_$G(XMZ)_U_XMC("L")_U_$G(XMLER)_U_$J($G(XMC("C","R"))+$G(XMC("C","S"))/($$TSTAMP^XMXUTIL1-XMC("START")),0,0)_U_$E(IO,1,9)_" "_XMPROT_U_$G(ZTSK)_U_$G(XMC("DIR"))
 Q
XMTHIST(XMINST,XMWHICH,XMLINES) ; Update history statistics for sending/receiving msgs
 N XMMONTH,XMREC,XMOFF
 S XMMONTH=$E(DT,1,5)
 S XMREC=$G(^XMBS(4.2999,XMINST,100,XMMONTH,0))
 I XMREC="" D
 . S XMREC=XMMONTH_"00"
 . D STATMON(XMINST,XMMONTH)
 S XMC(XMWHICH)=$G(XMC(XMWHICH))+1
 S XMOFF=(XMWHICH="R") ; 0 if "S"; 1 if "R"
 S $P(XMREC,U,2+XMOFF)=$P(XMREC,U,2+XMOFF)+1 ; msgs sent/rcvd
 S $P(XMREC,U,4)=$P(XMREC,U,4)+$G(XMC("C","S"))-$G(XMC("C","S","CHK")) ; chars sent
 S $P(XMREC,U,5)=$P(XMREC,U,5)+$G(XMC("C","R"))-$G(XMC("C","R","CHK")) ; chars rcvd
 S $P(XMREC,U,6+XMOFF)=$P(XMREC,U,6+XMOFF)+XMLINES ; lines sent/rcvd
 S ^XMBS(4.2999,XMINST,100,XMMONTH,0)=XMREC
 S XMC("C","S","CHK")=$G(XMC("C","S")) ; chars sent checkpoint
 S XMC("C","R","CHK")=$G(XMC("C","R")) ; chars rcvd checkpoint
 Q
STATMON(XMINST,XMMONTH) ; Set up a record for a month for a domain
 D:'$D(^XMBS(4.2999,XMINST,0)) STAT(XMINST)
 N XMFDA,XMIEN
 S XMFDA(4.29991,"+1,"_XMINST_",",.01)=XMMONTH_"00"
 S XMIEN(1)=XMMONTH
 D UPDATE^DIE("","XMFDA","XMIEN")
 Q
STAT(XMINST) ; Set up record for domain in 4.2999 MESSAGE STATISTICS file
 Q:$D(^XMBS(4.2999,XMINST,0))
 N XMFDA,XMIEN
 S XMFDA(4.2999,"+1,",.01)=XMINST
 S XMIEN(1)=XMINST
 D UPDATE^DIE("","XMFDA","XMIEN") Q:'$D(DIERR)
 ; Just in case the call fails, we must do it ourselves
 S ^XMBS(4.2999,XMINST,0)=XMINST
 S ^XMBS(4.2999,"B",XMINST,XMINST)=""
 Q
