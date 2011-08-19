XMS3 ;ISC-SF/GMB-SMTP Send (RFC 822) ;04/15/2003  12:44
 ;;8.0;MailMan;**18**;Jun 28, 2002
 ; Entry points (DBIA 10073):
 ; REC   Get the next line of message text
 Q
HEADER(XMZ,XMZREC,XMFROM,XMNETNAM) ; RFC 822 - Header Records
 ; These records are what you see when you do a "QN" at the prompt:
 ; "Message Action: Ignore//"
 S XMSG="Subject: "_$S($P(XMZREC,U)=$$EZBLD^DIALOG(34012):"",1:$P(XMZREC,U)) X XMSEN Q:ER
 S XMSG="Date: "_$$INDT^XMXUTIL1($P(XMZREC,U,3)) X XMSEN Q:ER
 S XMSG="Message-ID: <"_$$NETID(XMZ)_">" X XMSEN Q:ER
 I $D(^XMB(3.9,XMZ,"IN")) D  Q:ER
 . N XMINRE
 . S XMINRE=^XMB(3.9,XMZ,"IN")
 . I $P(XMINRE,"@",1)?.E1".VA.GOV"!($P(XMINRE,"@",2)?.N) S XMINRE=$P(XMINRE,"@",2)_"@"_$P(XMINRE,"@")
 . S XMSG="In-reply-to: <"_XMINRE_">" X XMSEN
 I "^Y^y^"[(U_$P(XMZREC,U,5)_U) D  Q:ER
 . S XMSG="Return-Receipt-To: "_XMFROM X XMSEN
 I $D(^XMB(3.9,XMZ,"K")) D  Q:ER
 . S XMSG="Encrypted: "_$P(XMZREC,U,10)_U_^("K") X XMSEN
 I $P(XMZREC,U,4)'="" D  Q:ER
 . S XMSG="Sender: "_$$FROM^XMS1($P(XMZREC,U,4),XMNETNAM) X XMSEN
 S XMSG="From: "_XMFROM X XMSEN Q:ER
 I $P(XMZREC,U,6)'="" D  Q:ER
 . S XMSG="Expiry-Date: "_$$INDT^XMXUTIL1($P(XMZREC,U,6)) X XMSEN
 I $P(XMZREC,U,7)["P" D  Q:ER
 . S XMSG="Importance: high" X XMSEN Q:ER
 . S XMSG="X-Priority: 1" X XMSEN
 I "^Y^y^"[(U_$P(XMZREC,U,11)_U) D  Q:ER
 . S XMSG="Sensitivity: Private" X XMSEN
 I $D(^XMB(3.9,XMZ,.5)) D  Q:ER
 . N XMZBSKT
 . S XMZBSKT=$P($G(^XMB(3.9,XMZ,.5)),U,1)
 . Q:XMZBSKT=""
 . S XMSG="X-MM-Basket: "_XMZBSKT X XMSEN
 I $P(XMZREC,U,7)'="",$P(XMZREC,U,7)'="P" D  Q:ER
 . S XMSG="X-MM-Type: "_$P(XMZREC,U,7) X XMSEN
 I "^Y^y^"[(U_$P(XMZREC,U,9)_U) D  Q:ER
 . S XMSG="X-MM-Closed: YES" X XMSEN
 I "^Y^y^"[(U_$P(XMZREC,U,12)_U) D  Q:ER
 . S XMSG="X-MM-Info-Only: YES" X XMSEN
 D TOLIST(XMZ,XMNETNAM) Q:ER
 Q
NETID(XMZ) ;
 N XMCRE8
 S XMCRE8=$P($G(^XMB(3.9,XMZ,.6)),U,1)
 I 'XMCRE8 D
 . S XMCRE8=$P($G(^XMB(3.9,XMZ,0)),U,3)
 . I $P(XMCRE8,".")?7N S XMCRE8=$P(XMCRE8,".")
 . E  D
 . . S XMCRE8=$$CONVERT^XMXUTIL1(XMCRE8)
 . . I XMCRE8=-1 S XMCRE8=DT
 . S $P(^XMB(3.9,XMZ,.6),U,1)=XMCRE8
 . S ^XMB(3.9,"C",XMCRE8,XMZ)=""
 N XMREMID
 I $D(^XMB(3.9,XMZ,5)) D  Q:XMREMID'="" XMREMID
 . S XMREMID=^XMB(3.9,XMZ,5)
 . I $P(XMREMID,"@",1)?.E1".VA.GOV"!($P(XMREMID,"@",2)?.N) S XMREMID=$P(XMREMID,"@",2)_"@"_$P(XMREMID,"@")
 . Q:XMREMID'=""
 . D PARSE^XMR3(XMZ,.XMREMID)
 ;Q XMZ_"@"_^XMB("NETNAME")
 Q XMZ_"."_XMCRE8_"@"_^XMB("NETNAME")
TOLIST(XMZ,XMNETNAM) ;
 N XMTO,XMIEN
 S XMIEN=$O(^XMB(3.9,XMZ,6,0)),XMSG="To: "_$$TOFORMAT($P(^XMB(3.9,XMZ,6,XMIEN,0),U,1),$S($G(XMC("MAILMAN")):$P(^(0),U,2),1:""))
 F  S XMIEN=$O(^XMB(3.9,XMZ,6,XMIEN)) Q:'XMIEN!(XMIEN>50)  D  Q:ER
 . S XMTO=$$TOFORMAT($P(^XMB(3.9,XMZ,6,XMIEN,0),U,1),$S($G(XMC("MAILMAN")):$P(^(0),U,2),1:""))
 . S XMSG=XMSG_","
 . I $L(XMSG)+$L(XMTO)>80 D TOSEND(.XMSG) Q:ER
 . S XMSG=XMSG_" "_XMTO
 Q:ER
 D TOSEND(.XMSG) Q:ER
 I XMIEN>50 S XMSG="(Too many recipients to list...)" D TOSEND(.XMSG) Q:ER
 Q
TOFORMAT(XMTO,XMPREFIX) ;
 N XMDOM
 S XMDOM=$S(XMTO["@":$P(XMTO,"@",2,99),1:XMNETNAM)
 S XMTO=$$TO($P(XMTO,"@"))
 Q $S(XMPREFIX="":"",$E(XMTO,1)=$C(34):"",1:XMPREFIX_":")_XMTO_"@"_XMDOM
TO(XMTO) ;
 I $E(XMTO)'=$C(34),(XMTO[",")!(XMTO[" ") D
 . I XMTO["," S XMTO=$TR(XMTO,", .","._+")
 . I XMTO[" " S XMTO=$C(34)_XMTO_$C(34)
 Q XMTO
TOSEND(XMSG) ;
 I $L(XMSG)>80 D  Q
 . N XMSGHOLD,XMPIECES
 . S XMPIECES=$L(XMSG,"@")
 . S XMSGHOLD=$P(XMSG,"@",XMPIECES)
 . S XMSG=$P(XMSG,"@",1,XMPIECES-1)
 . X XMSEN
 . S XMSG="    @"_XMSGHOLD
 X XMSEN
 S XMSG="   "
 Q
TEXT(XMZ) ; Send body of text
 N XMS0AJ
 ;S XMBLOCK=1 ; *** What's this?  See ^XML4CRC* & ^XMLSWP*
 S XMS0AJ=0
 F  S XMS0AJ=$O(^XMB(3.9,XMZ,2,XMS0AJ)) Q:XMS0AJ'>0  D  Q:ER
 . S XMSG=^XMB(3.9,XMZ,2,XMS0AJ,0)
 . I $E(XMSG)="." S XMSG="."_XMSG
 . E  I $E(XMSG,1,4)="~*~^" S XMSG=" "_XMSG  ; *** What's this?
 . X XMSEN
 I ER S ER("MSG")="Error sending msg "_XMZ_", text line "_XMS0AJ Q
 ;D:$D(XMBLOCK) KILL^XML4CRC
 Q
RCPTERR(XMERRMSG,XMZ,XMZREC,XMNVFROM,XMRCPTO,XMRCPT,XMIEN) ; Non-delivery to recipient
 N XMFDA,XMIENS,XMTO,XMPARM,XMINSTR
 S XMIENS=XMIEN_","_XMZ_","
 S XMFDA(3.91,XMIENS,3)="@"                ; remote msg id
 S XMFDA(3.91,XMIENS,4)=XMCM("START","FM") ; xmit date/time
 S XMFDA(3.91,XMIENS,5)=$E($P(XMERRMSG," ",2,999),1,30)  ; status
 S XMFDA(3.91,XMIENS,6)="@"                ; path
 D FILE^DIE("","XMFDA")
 S XMTO=$$SENDER(XMZ,XMZREC,XMNVFROM,XMIEN,1,XMERRMSG) Q:"<>"[XMTO
 S XMINSTR("FROM")="POSTMASTER"
 S XMPARM(1)=$P(XMZREC,U,1) ; subject
 S XMPARM(2)=XMRCPTO
 S XMPARM(3)=XMERRMSG
 S XMPARM(4)=XMRCPT
 S XMPARM(5)=$S(XMTO["@":$G(^XMB(3.9,XMZ,5)),1:XMZ)
 D TASKBULL^XMXBULL(.5,"XM SEND ERR RECIPIENT",.XMPARM,"",XMTO,.XMINSTR)
 Q
MSGERR(XMSITE,XMINST,XMERRMSG,XMZ,XMZREC,XMNVFROM,XMRCPT) ;
 ; If a message is rejected at a site for any reason (the whole message,
 ; not just one recipient), then this message may be sent.
 N XMTO,XMPARM,XMIEN,XMNAME,XMCNT,XMINSTR
 D DOTRAN^XMC1(XMERRMSG)
 S XMPARM(3)=XMERRMSG
 S XMERRMSG=$E($P(XMERRMSG," ",2,999),1,30)
 K ^TMP("XM",$J,"REJECT")
 S XMIEN=""
 F  S XMIEN=$S($D(XMRCPT):$O(XMRCPT(XMIEN)),1:$O(^XMB(3.9,XMZ,1,"AQUEUE",XMINST,XMIEN))) Q:XMIEN=""  D
 . N XMFDA,XMIENS
 . S XMIENS=XMIEN_","_XMZ_","
 . S XMFDA(3.91,XMIENS,3)="@"      ; remote msg id
 . S XMFDA(3.91,XMIENS,4)=XMCM("START","FM") ; xmit date/time
 . S XMFDA(3.91,XMIENS,5)=XMERRMSG ; status
 . S XMFDA(3.91,XMIENS,6)="@"      ; path
 . S XMFDA(3.91,XMIENS,9)="@"      ; xmit time
 . D FILE^DIE("","XMFDA")
 . S XMNAME=$P($G(^XMB(3.9,XMZ,1,XMIEN,0)),U,1) Q:XMNAME=""
 . S XMTO=$$SENDER(XMZ,XMZREC,XMNVFROM,XMIEN) Q:"<>"[XMTO
 . S (XMCNT,^(XMTO))=$G(^TMP("XM",$J,"REJECT",XMTO))+1
 . S ^TMP("XM",$J,"REJECT",XMTO,XMCNT)=XMNAME
 S XMINSTR("FROM")="POSTMASTER"
 S XMPARM(1)=$P(XMZREC,U,1) ; subject
 S XMPARM(2)=XMSITE
 S XMTO=""
 F  S XMTO=$O(^TMP("XM",$J,"REJECT",XMTO)) Q:XMTO=""  D TASKBULL^XMXBULL(.5,"XM SEND ERR MSG",.XMPARM,"^TMP(""XM"",$J,""REJECT"",XMTO)",XMTO,.XMINSTR)
 K ^TMP("XM",$J,"REJECT")
 Q
SENDER(XMZ,XMZREC,XMNVFROM,XMIEN,XMDELFWD,XMERRMSG) ; Function returns 'to whom to send error message'
 N XMFWDREC,XMFWDR
 S XMFWDREC=$G(^XMB(3.9,XMZ,1,XMIEN,"F")) ; Try to find forwarder
 S XMFWDR=$P(XMFWDREC,U,2)
 I XMFWDR'="" D  Q XMFWDR  ; Forwarder is local
 . I $G(XMDELFWD) D DELFWD(XMZ,XMIEN,XMFWDR,XMERRMSG)
 I $E(XMFWDREC)="<" Q $E($P($P(XMFWDREC,U,1),">",1),2,999)  ; Forwarder is remote
 Q:$D(^XMB(3.9,XMZ,.7)) XMNVFROM  ; Sender is remote
 N XMFROM
 S XMFROM=$P(XMZREC,U,2)
 I +XMFROM=XMFROM Q XMFROM  ; Sender is local
 I XMFROM'["@" Q .5         ; Sender is fictitious, so notify postmaster
 Q XMNVFROM  ; Sender is remote
DELFWD(XMZ,XMIEN,XMFWDR,XMERRMSG) ; Delete user's forwarding address
 Q:+XMFWDR'=XMFWDR
 N XMFWD
 S XMFWD=$P(^XMB(3.7,XMFWDR,0),U,2) Q:XMFWD=""
 N XMINSTR,XMADDR,XMFULL,XMERROR,XMFDA,XMTXT,XMFWDADD
 S XMINSTR("ADDR FLAGS")="X" ; do not create ^TMP(, just check.
 S XMADDR=$P(^XMB(3.9,XMZ,1,XMIEN,0),U,1)
 D ADDRESS^XMXADDR(DUZ,XMFWD,.XMFULL,.XMERROR)
 I '$D(XMERROR),XMADDR'=$G(XMFULL) Q
 D DELFWD^XMVVITA(XMFWDR,XMFWD,XMERRMSG)
 Q
 ; The following has nothing to do with the above.
 ; These are used by the SERVER Communications Protocol in file 3.4.
REC ; Read the next line of text from the message.  When called for the
 ; first time, returns the first line.
 ; In:
 ; XMZ   - IEN of the message in file 3.9
 ; XMPOS - (optional) line number of the previous line read
 ;         Default is .999999
 ; Out:
 ; XMPOS - line number of XMRG
 ; XMRG  - =the next line of text, if OK; ="" if end of text reached
 ; XMER  - =0 if OK; =-1 if end of text reached
 S XMPOS=$S('$D(XMPOS):.999999,XMPOS<.999999:.999999,1:XMPOS)
 S XMPOS=$O(^XMB(3.9,XMZ,2,XMPOS))
 I +XMPOS'=XMPOS S XMER=-1,XMRG="" Q
 S XMRG=^XMB(3.9,XMZ,2,XMPOS,0),XMER=0
 Q
SEN ; Send a line to the return message
 S XMSLINE=XMSLINE+1,^XMB(3.9,XMZ,2,XMSLINE,0)=XMSG
 Q
OPEN ; Open the reverse message path
 Q
CLOSE ; Close the reverse message
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_XMSLINE_U_XMSLINE_U_DT
 Q
