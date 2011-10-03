XMXADDR3 ;ISC-SF/GMB-XMXADDR (cont.) ;04/15/2003  13:16
 ;;8.0;MailMan;**18**;Jun 28, 2002
SERVER(XMADDR,XMSTRIKE,XMPREFIX,XMLATER,XMFULL) ;
 N XMG
 S XMADDR=$P(XMADDR,".",2,99)
 I $G(XMIA) D
 . N DIC,X
 . S X=XMADDR
 . S DIC="^DIC(19,"
 . S DIC(0)="FEZ"_$S($D(XMGCIRCL):"O",1:"")
 . D ^DIC
 . I Y<0 D SETERR^XMXADDR4(1,"!",39060) Q  ;Invalid server name
 . S XMG=+Y
 E  D
 . S XMG=$$FIND1^DIC(19,"","O",XMADDR) I 'XMG D SETERR^XMXADDR4(0,"",$S($D(DIERR):39061,1:39062)) ; Server ambiguous / Server not found.
 Q:$D(XMERROR)
 S XMFULL="S."_$P(^DIC(19,XMG,0),U,1)
 D SETEXP^XMXADDR(XMFULL,XMG,XMSTRIKE,XMPREFIX,XMLATER)
 Q
DEVICE(XMADDR,XMSTRIKE,XMPREFIX,XMLATER,XMFULL) ;
 N XMG
 S XMADDR1=$$UP^XLFSTR($E(XMADDR,1))
 S XMADDR=$P(XMADDR,".",2,99)
 I $G(XMIA) D
 . N DIC,X
 . S X=XMADDR
 . S DIC="^%ZIS(1,"   ; file 3.5
 . S DIC(0)="EF"_$S($D(XMGCIRCL):"O",1:"")
 . D ^DIC
 . I Y<0 D SETERR^XMXADDR4(1,"!",39063) Q  ;Invalid device name
 . S XMG=+Y
 . S XMADDR=$P(Y,U,2)
 E  D
 . S XMG=$$FIND1^DIC(3.5,"","O",XMADDR) I 'XMG D SETERR^XMXADDR4(0,"",$S($D(DIERR):39064,1:39065)) Q  ; Device ambiguous. / Device not found.
 . S XMADDR=$P(^%ZIS(1,XMG,0),U,1)
 Q:$D(XMERROR)
 I XMADDR["P-MESSAGE" D  Q  ;You may not use P-MESSAGE in an address.
 . D SETERR^XMXADDR4($G(XMIA),"!",39066)
 S XMFULL=XMADDR1_"."_XMADDR
 D SETEXP^XMXADDR(XMFULL,XMG,XMSTRIKE,XMPREFIX,XMLATER)
 Q
REMOTE(XMDUZ,XMADDR,XMSTRIKE,XMPREFIX,XMLATER,XMFULL) ;
 ; XMVIA    IEN of domain in ^DIC(4.2 via which the msg will be sent
 ; XMVIAN   Name of domain via which the msg will be sent
 ; XMDOMAIN Domain of the addressee
 ; XMNAME   Name of the addressee
 N XMVIA,XMVIAN,XMDOMAIN,XMNAME
 S:XMADDR["<"!(XMADDR[" ") XMADDR=$$REMADDR(XMADDR)
 S XMNAME=$P(XMADDR,"@",1)
 I XMNAME="" D  Q
 . D SETERR^XMXADDR4($G(XMIA),"!",39010) ;Null addressee
 S XMDOMAIN=$P(XMADDR,"@",2,99)
 I XMDOMAIN="" D  Q
 . ; You must specify a reachable uunet host / Null domain
 . D SETERR^XMXADDR4($G(XMIA),"!",$S(XMNAME["!":39067,1:39068))
 ; find out the full domain name, and
 ; whether the domain is valid, and if so, via which entry in DIC(4.2
 D DNS^XMXADDRD(XMDUZ,.XMDOMAIN,.XMVIA,.XMVIAN) Q:$D(XMERROR)
 I XMDOMAIN=^XMB("NETNAME") D  ; the full domain name = the local domain
 . N XMQUOTED
 . I XMNAME?1""""1.E1"""" S XMNAME=$E(XMNAME,2,$L(XMNAME)-1),XMQUOTED=1
 . I $E(XMNAME,1)=" "!($E(XMNAME,$L(XMNAME))=" ") S XMNAME=$$STRIP^XMXUTIL1(XMNAME)
 . D LOCAL^XMXADDR(XMDUZ,XMNAME,XMSTRIKE,XMPREFIX,.XMLATER,.XMFULL)
 . Q:'$D(XMERROR)
 . Q:$G(XMQUOTED)
 . N XMSAVE
 . S XMSAVE=XMNAME
 . I ".G.g.D.d.H.h.S.s."[("."_$E(XMNAME,1,2)) S XMNAME=$E(XMNAME,1,2)_$TR($E(XMNAME,3,99),"._+",", .")
 . E  S XMNAME=$TR(XMNAME,"._+",", .")
 . I XMSAVE'=XMNAME D  Q:'$D(XMERROR)
 . . K XMERROR
 . . I $G(XMIA) D EN^DDIOL($$EZBLD^DIALOG(39069,XMNAME)) ;Checking: |1|
 . . D LOCAL^XMXADDR(XMDUZ,XMNAME,XMSTRIKE,XMPREFIX,.XMLATER,.XMFULL)
 . Q:'$G(XMRESTR("NET RECEIVE"))
 . Q:"^39062^39065^39132^"'[(U_XMERROR_U)
 . ; Server, Device, or Group not found.  Try lower case.
 . ; (We do not need to try local user again.)
 . S XMSAVE=XMNAME,XMNAME=$$LOW^XLFSTR(XMNAME) Q:XMSAVE=XMNAME
 . K XMERROR
 . D LOCAL^XMXADDR(XMDUZ,XMNAME,XMSTRIKE,XMPREFIX,.XMLATER,.XMFULL)
 E  D
 . I $D(XMRESTR("NONET")) D  Q
 . . ;Messages longer than |1| lines may not be sent across the network.
 . . D SETERR^XMXADDR4($G(XMIA),"!",39001,XMRESTR("NONET"))
 . I $D(XMFWDADD),+$G(^XMB(1,1,3)) D  Q:$D(XMERROR)
 . . ; This is an auto-forward address, and we are limiting it.
 . . Q:$$FWDOK(3.1,XMDOMAIN)  ; Approved auto-forward site?
 . . I '$D(^XUSEC("XM AUTO-FORWARD WAIVER",+XMFWDADD)) D  Q
 . . . ;You can't have your mail forwarded to a non-VA site.  Waivers can
 . . . ;be requested through your site Information Security Officer (ISO)
 . . . D SETERR^XMXADDR4($G(XMIA),"P",38130.1)
 . . Q:$$FWDOK(3.2,XMDOMAIN)  ; Waiver auto-forward site?
 . . ;You have been granted a waiver to have your mail forwarded to a
 . . ;non-VA site, but this site is not one of the sites for which a
 . . ;waiver has been granted.  Please contact your site Information
 . . ;Security Officer (ISO) for further information.
 . . D SETERR^XMXADDR4($G(XMIA),"P",38130.2)
 . ; I XMDOMAIN?.E1".VA.GOV" D
 . ;. ; Check the address before the @ to find any obvious errors
 . ; Now transform spaces, commas, and periods in XMNAME
 . S XMFULL=XMNAME_"@"_XMDOMAIN
 . I XMSTRIKE D REMINUS(.XMFULL,XMNAME,XMDOMAIN) Q:$D(XMERROR)
 . I XMLATER="?" D QLATER^XMXADDR(XMFULL,.XMLATER) Q:$D(XMERROR)
 . D SETEXP^XMXADDR(XMFULL,XMVIA,XMSTRIKE,XMPREFIX,XMLATER)
 Q
FWDOK(XMNODE,XMDOMAIN) ; Is the auto-forward domain OK?
 N I,XMOK
 S I="",XMOK=0
 F  S I=$O(^XMB(1,1,XMNODE,"B",I)) Q:I=""!(I=$E(XMDOMAIN,$L(XMDOMAIN)-$L(I)+1,99))
 Q I'=""
REMINUS(XMFULL,XMNAME,XMDOMAIN) ;
 Q:$D(^TMP("XMY",$J,XMFULL))
 I $O(^TMP("XMY",$J,":"))="" Q:'$G(XMIA)  D  Q
 . D SETERR^XMXADDR4($G(XMIA),"!",39015.1) ;Not a current recipient.
 N XMTRY,XMTO
 S XMTRY=$$LOW^XLFSTR(XMNAME)_"@"_XMDOMAIN
 I $D(^TMP("XMY",$J,XMTRY)) S XMFULL=XMTRY Q
 S XMTRY=$$UP^XLFSTR(XMNAME)_"@"_XMDOMAIN
 I $D(^TMP("XMY",$J,XMTRY)) S XMFULL=XMTRY Q
 S XMTO=":"
 F  S XMTO=$O(^TMP("XMY",$J,XMTO)) Q:XMTO=""  Q:$$UP^XLFSTR(XMTO)=XMTRY
 I XMTO="" Q:'$G(XMIA)  D SETERR^XMXADDR4($G(XMIA),"!",39015.1) Q  ;Not a current recipient.
 S XMFULL=XMTO
 Q
REMADDR(XMADDR) ;
 I XMADDR["<" Q $TR($P($P(XMADDR,">",1),"<",2,99),"<")  ; handles <addr> and <<addr>>
 Q:XMADDR'[" " XMADDR
 I $E(XMADDR,1)=" "!($E(XMADDR,$L(XMADDR))=" ") S XMADDR=$$STRIP^XMXUTIL1(XMADDR)
 I XMADDR'["""",XMADDR'["(" Q XMADDR
 I XMADDR["""@" D  Q XMADDR
 . ; "first last"@domain
 . N I,J,XMDOM
 . S I=$F(XMADDR,"""@")
 . S XMDOM=$E(XMADDR,I,999)
 . S XMDOM=$P(XMDOM," ",1)
 . S J=$F(XMADDR,"""")
 . S XMADDR=$E(XMADDR,J-1,I-J)_"@"_XMDOM
 ; last.first@domain (first last)
 N I
 F I=1:1:$L(XMADDR," ") Q:$P(XMADDR," ",I)["@"
 S XMADDR=$P(XMADDR," ",1,I)
 Q XMADDR
