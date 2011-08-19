XMXBULL ;ISC-SF/GMB-Send Bulletin ;04/23/2002  08:46
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XMB (ISC-WASH/THM/RWF/CAP)
 ; TASKBULL creates and delivers a bulletin in background.
 ; SENDBULL creates bulletin in foreground; delivers in background
 ; TASK     for use by TaskMan only
 ; The recipients of the message include any entries in the XMTO
 ; array that the caller has defined and the members of mail groups
 ; that are included in the definition of the entry in the Bulletin
 ; file (#3.6) at the time of delivery.  There must be valid
 ; recipients or the message will not be delivered.
 ; Inputs:
 ; XMDUZ    Sender DUZ
 ; XMBNAME  The name of a bulletin (an entry in File #3.6)
 ; XMPARM(parameter#)=The value to be stuffed into the bulletin for each
 ;       required parameter.  (eg. XMPARM(1)=data for parameter#1
 ; XMBODY   (optional) Additional text of the message
 ; XMTO     (optional) Array of recipients of a bulletin
 ; XMINSTR("FLAGS") (optional)
 ;                     ["P" - priority
 ; XMINSTR("FROM")  (optional) String saying from whom (default is sender)
 ; XMINSTR("LATER") (optional) date/time to send the bulletin (default is now)
 ; XMINSTR("VAPOR") (optional) date/time to vaporize the bulletin.
 ;                  If supplied, it takes precedence over the bulletin's
 ;                  RETENTION DAYS field.
 ; XMATTACH    (in)  Array of files to attach to message
 ;                   ("IMAGE",x) imaging (BLOB) files
 ; Output:
 ; XMZ      (from entry SENDBULL only) Message number if successful
 ; XMTASK   (from entry TASKBULL only) Task number (ZTSK) if successful
TASKBULL(XMDUZ,XMBNAME,XMPARM,XMBODY,XMTO,XMINSTR,XMTASK,XMATTACH) ; Tasks it
 N XMBIEN
 K XMERR,^TMP("XMERR",$J)
 I XMDUZ=.6 D ERRSET^XMXUTIL(39321) Q  ;SHARED,MAIL may not send a bulletin.
 S XMBIEN=$O(^XMB(3.6,"B",XMBNAME,""))
 D BULLETIN^XMKPO(XMDUZ,XMBNAME,XMBIEN,.XMPARM,.XMBODY,.XMTO,.XMINSTR,.XMTASK,.XMATTACH)
 Q
TASK ; TaskMan uses this entry point, and supplies variables:
 ; XMDUZ,XMBIEN,XMPARM,XMBODY,XMTO,XMINSTR,XMATTACH
 N XMZ
 K XMERR,^TMP("XMERR",$J)
 D SEND(XMDUZ,XMBIEN,.XMPARM,.XMBODY,.XMTO,.XMINSTR,.XMZ,.XMATTACH)
 S ZTREQ="@"
 Q
SENDBULL(XMDUZ,XMBNAME,XMPARM,XMBODY,XMTO,XMINSTR,XMZ,XMATTACH) ; Does it now
 N XMBIEN
 K XMERR,^TMP("XMERR",$J)
 I XMDUZ=.6 D ERRSET^XMXUTIL(39321) Q  ;SHARED,MAIL may not send a bulletin.
 S XMBIEN=$O(^XMB(3.6,"B",XMBNAME,""))
 D SEND(XMDUZ,XMBIEN,.XMPARM,.XMBODY,.XMTO,.XMINSTR,.XMZ,.XMATTACH)
 Q
SEND(XMDUZ,XMBIEN,XMPARM,XMBODY,XMTO,XMINSTR,XMZ,XMATTACH) ; Create and send the bulletin
 N XMREC,XMSUBJ,XMVDAYS
 S XMREC=^XMB(3.6,XMBIEN,0)
 S XMSUBJ=$$SUBJECT($P(XMREC,U,2),.XMPARM) Q:$D(XMERR)
 S XMVDAYS=$P(XMREC,U,3)
 I XMVDAYS,'$D(XMINSTR("VAPOR")) D
 . S XMINSTR("VAPOR")=$$FMADD^XLFDT(DT,XMVDAYS)
 E  K XMVDAYS
 D CRE8XMZ^XMXSEND(XMSUBJ,.XMZ) Q:$D(XMERR)
 D:$G(XMINSTR("ADDR FLAGS"))'["I" INIT^XMXADDR
 D BULLADDR(XMDUZ,XMBIEN,.XMINSTR)
 D CHKADDR^XMXADDR(XMDUZ,.XMTO,.XMINSTR)
 I '$$GOTADDR^XMXADDR D  Q
 . D CLEANUP^XMXADDR
 . D ERRSET^XMXUTIL(39320) ;No addressees.  Bulletin not sent.
 . D KILLMSG^XMXUTIL(XMZ)
 . S XMZ=-1
 I $P(XMREC,U,4),$G(XMINSTR("FLAGS"))'["P" S XMINSTR("FLAGS")=$G(XMINSTR("FLAGS"))_"P"
 D:$D(XMATTACH("IMAGE"))>9 ADDBLOB^XMXSEND(XMZ,.XMATTACH)
 D MOVEPART^XMXSEND(XMDUZ,XMZ,.XMINSTR)
 D MOVEBODY^XMXSEND(XMZ,"^XMB(3.6,"_XMBIEN_",1)") ; Bulletin text
 D DOPARMS(XMZ,.XMPARM)
 I $G(XMBODY)'="",$D(@XMBODY)>9,$O(@XMBODY@(0)) D MOVEBODY^XMXSEND(XMZ,XMBODY,"A") ; Append the text (no parm translation)
 I $E(XMREC,1,2)="XM" D CHKNONVF(XMZ,$P(XMREC,U))
 D SEND^XMKP(XMDUZ,XMZ)
 I $D(XMVDAYS) K XMINSTR("VAPOR")
 D CLEANUP^XMXADDR
 D CHECK^XMKPL
 Q
BULLADDR(XMDUZ,XMBIEN,XMINSTR) ;
 N XMGIEN,XMGROUP
 S XMGIEN=""
 F  S XMGIEN=$O(^XMB(3.6,XMBIEN,2,"B",XMGIEN)) Q:XMGIEN=""  D
 . S XMGROUP="G."_$P($G(^XMB(3.8,XMGIEN,0)),U,1)
 . D:XMGROUP]"G." CHKADDR^XMXADDR(XMDUZ,XMGROUP,.XMINSTR)
 Q
SUBJECT(XMSUBJ,XMPARM) ;
 D:XMSUBJ["|" FILL(.XMSUBJ,.XMPARM)
 I $L(XMSUBJ)<3 S XMSUBJ=XMSUBJ_"..."
 I $L(XMSUBJ)>65 S XMSUBJ=$E(XMSUBJ,1,65)
 Q $$XMSUBJ^XMXPARM("XMSUBJ",XMSUBJ)
DOPARMS(XMZ,XMPARM) ;
 N I,XMLINE
 S I=0
 F  S I=$O(^XMB(3.9,XMZ,2,I)) Q:I=""  D
 . Q:^XMB(3.9,XMZ,2,I,0)'["|"
 . S XMLINE=^XMB(3.9,XMZ,2,I,0)
 . D:XMLINE["|" FILL(.XMLINE,.XMPARM)
 . S ^XMB(3.9,XMZ,2,I,0)=XMLINE
 Q
FILL(XMLINE,XMPARM) ;
 ; This gets confused by "\027||1|, your Help Request from, |2|,":
 ;F  D  Q:XMLINE'["|"
 ;. S XMLINE=$P(XMLINE,"|",1)_$G(XMPARM(+$P(XMLINE,"|",2)))_$P(XMLINE,"|",3,999)
 ; This can handle it:
 Q:XMLINE'?.E1"|"1.N1"|".E
 N XML
 S XML=""
 F  D  Q:XMLINE'?.E1"|"1.N1"|".E
 . I $P(XMLINE,"|",2)?1N.N S XMLINE=$P(XMLINE,"|",1)_$G(XMPARM(+$P(XMLINE,"|",2)))_$P(XMLINE,"|",3,999) Q
 . S XML=XML_$P(XMLINE,"|",1)_"|",XMLINE=$P(XMLINE,"|",2,999)
 S XMLINE=XML_XMLINE
 Q
CHKNONVF(XMZ,XMBNAME) ; (CHecK NO eNVelope From)
 Q:$O(^TMP("XMY",$J,""),-1)'["@"
 I XMBNAME'="XM SEND ERR RECIPIENT",XMBNAME'="XM SEND ERR MSG" Q
 ; This is an error bulletin sent by MailMan to someone at a remote site
 ; indicating that their message could not be delivered for some reason.
 ; We want to make sure that the 'envelope from' is null, so we pre-set
 ; it here.  It's a little trick.
 S $P(^XMB(3.9,XMZ,.7),U,1)="<>"
 Q
