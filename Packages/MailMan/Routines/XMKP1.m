XMKP1 ;ISC-SF/GMB-Address and Post msg (cont.) ;04/17/2002  10:54
 ;;8.0;MailMan;;Jun 28, 2002
RCPTFWD(XMSF,XMTO,XMFDA,XMIENS,XMNOW,XMFWDBY) ; Someone special fwded to this particular recipient
 N XMBY,XMFREC
 S XMFREC=^TMP("XMY",$J,XMTO,"F")
 S XMBY=$P(XMFREC,U)
 I +XMBY=XMBY D
 . ; Recipient has fwding address; note that recipient fwded.
 . S XMFDA(3.91,XMIENS,8)=$$NAME^XMXUTIL(XMBY)_" "_XMNOW   ; fwd by name date time
 . S XMFDA(3.91,XMIENS,8.01)=XMBY ; fwd by duz
 . S XMFDA(3.91,XMIENS,8.02)="A"  ; Auto-Forward
 . Q:XMSF="S"
 . I $P(XMFREC,U,2)'="" D  Q  ; original forwarder is from remote site
 . . S XMFDA(3.91,XMIENS,8.03)=$P(XMFREC,U,2)
 . . S XMFDA(3.91,XMIENS,8.04)="@"
 . S XMFDA(3.91,XMIENS,8.03)=XMFWDBY
 . S XMFDA(3.91,XMIENS,8.04)=$S($G(XMINSTR("FWD BY XMDUZ"))="F":"F",1:"@") ; Filter-Forward or otherwise
 E  D
 . ; Forwarded from remote site.
 . S XMFDA(3.91,XMIENS,8)=XMBY_" "_XMNOW   ; fwd by name date time
 . S XMFDA(3.91,XMIENS,8.01)="@" ; fwd by duz
 Q
