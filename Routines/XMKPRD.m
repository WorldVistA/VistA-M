XMKPRD ;ISC-SF/GMB-DNS Interface ;07/11/2002  08:09
 ;;8.0;MailMan;;Jun 28, 2002
NEXTIPF(XMSITE,XMIPT,XMIPLIST) ; Function returns next IP address to try.
 ; IN:
 ; XMSITE   - .01 field of domain in file 4.2 (not a synonym)
 ; XMIPT    - List of IP addresses, separated by ",", already tried
 ; XMIPLIST - (optional) List of IP addresses, separated by ",", to try
 I '$D(XMIPLIST) D
 . D SHOW(42260) ;Call DNS for IP Address list ...
 . S XMIPLIST=$$IPADDR(XMSITE)
 . D SHOW($S(XMIPLIST="":42261,1:42262),XMIPLIST) ;Returned: Nothing!/|1|
 I XMIPLIST="" Q ""
 I $G(XMIPT)="" Q $P(XMIPLIST,",")
 N XMJ,XMIP
 F XMJ=1:1:$L(XMIPT,",") D  Q:XMIP=""!(","_XMIPT_","'[(","_XMIP_","))
 . S XMIP=$P(XMIPT,",",XMJ)
 . D NEXTIP(.XMIP,.XMIPLIST)
 Q XMIP
IPADDR(XMSITE) ;
 N XMIPARY,XMIP,XMIPSITE,XMI,XMIPREC,XMIPLIST
 D MAIL^XLFNSLK(.XMIPARY,XMSITE)
 S XMI=0
 F  S XMI=$O(XMIPARY(XMI)) Q:'XMI  D
 . S XMIPREC=XMIPARY(XMI)
 . S XMIP=$P(XMIPREC,U,2)
 . ;I XMIP'?1.N1"."1.N1"."1.N1".".E D  Q
 . I XMIP="" D  Q
 . . D SHOW(42260.1,XMIPREC) ;Ignore '|1|' - no IP address
 . S XMIPSITE=$$UP^XLFSTR($P(XMIPREC,U,1))
 . ; Accept whatever DNS returns, except for FORUM.  We accept FORUM if
 . ; we're trying to get to FORUM, but we don't want messages destined
 . ; for another site to be routed through FORUM.  If this is a non-VA
 . ; site, then it's OK to route through FORUM.
 . I ^XMB("NETNAME")[".VA.GOV",XMSITE'["FORUM.VA.GOV",XMIPSITE["FORUM.VA.GOV" D  Q
 . . D SHOW(42260.2,XMIPREC) ;Ignore '|1|' - that's a different site
 . ;I '$$SAMESITE(XMIPSITE,XMSITE) D  Q
 . ;. D SHOW(42260.2,XMIPREC) ;Ignore '|1|' - that's a different site
 . I ","_$G(XMIPLIST)_","[(","_XMIP_",") D  Q
 . . D SHOW(42260.3,XMIPREC) ;Ignore '|1|' - already have that IP address
 . D SHOW(42260.4,XMIPREC) ;Accept '|1|'
 . I $G(XMIPLIST)="" S XMIPLIST=XMIP Q
 . S XMIPLIST=XMIPLIST_","_XMIP
 Q $G(XMIPLIST)
SAMESITE(X,XMSITE) ;
 N DIC,Y,D
 I $E(X,$L(X))="." S X=$E(X,1,$L(X)-1)
 S DIC="^DIC(4.2,",DIC(0)="FMXZ",D="B^C"
 F  D MIX^DIC1 Q:Y>0!(X'[".")  S X=$P(X,".",2,99)
 I Y,Y(0,0)=XMSITE Q 1
 Q 0
SHOW(XMDIALOG,XM1) ;
 I $D(ZTQUEUED)!'$G(XMC("PLAY")) Q
 I +XMDIALOG=XMDIALOG W !,$$EZBLD^DIALOG(XMDIALOG,$G(XM1)) Q
 W !,XMDIALOG
 Q
NEXTIP(XMIP,XMIPLIST) ;
 N XMI
 F XMI=1:1:$L(XMIPLIST,",") Q:$P(XMIPLIST,",",XMI)=XMIP
 I XMIP'=$P(XMIPLIST,",",XMI) S XMIP=$P(XMIPLIST,","),XMIPLIST=$P(XMIPLIST,",",2,99) Q
 I XMI=1 S XMIPLIST=$P(XMIPLIST,",",2,99)
 E  I XMI=$L(XMIPLIST,",") S XMIPLIST=$P(XMIPLIST,",",1,XMI-1)
 E  S XMIPLIST=$P(XMIPLIST,",",1,XMI-1)_","_$P(XMIPLIST,",",XMI+1,99)
 S XMIP=$P(XMIPLIST,","),XMIPLIST=$P(XMIPLIST,",",2,99)
 Q
 ; *** The following is not used ***
CONNECT(XMSITE,XMIP,XMPORT) ; Function tries to connect to site.
 ; Returns the IP address if success; 0 if failure
 ; XMSITE - Site name to connect to
 ; XMIP   - Site IP address to try first (optional).  If none given,
 ;           or if attempt fails, DNS is called to retrieve address(es).
 ; XMPORT - Port number to use (optional, default=25)
 N XMIPLIST,XMOK
 I '$G(XMPORT) S XMPORT=25
 D SHOW("Connect to "_XMSITE_" on port "_XMPORT_$S($G(XMIP):", IP Address "_XMIP,1:""))
 I $G(XMIP)="" D NEXTIPR(XMSITE,.XMIP,.XMIPLIST) Q:XMIP="" 0
 S XMOK=0
 F  D TRYIP(XMIP,.XMOK) Q:XMOK  D NEXTIPR(XMSITE,.XMIP,.XMIPLIST) Q:XMIP=""
 Q:XMOK XMIP
 D SHOW("Connect failed.  Try again later.")
 Q 0
NEXTIPR(XMSITE,XMIP,XMIPLIST) ; Routine returns next IP address to try
 ; IN/OUT:
 ; XMIP     - in:  Last IP address tried
 ;            out: Next IP address to try
 ; XMIPLIST - in:  (optional) List of IP addresses, separated by ",",
 ;                 we haven't yet tried
 ;            out: Same, but with XMIP (out) removed
 I '$D(XMIPLIST) D
 . D SHOW(42260) ;Call DNS for IP Address list ...
 . S XMIPLIST=$$IPADDR(XMSITE)
 . D SHOW($S(XMIPLIST="":42261,1:42262),XMIPLIST) ;Returned: Nothing!/|1|
 I XMIPLIST="" S XMIP="" Q
 I $G(XMIP)="" S XMIP=$P(XMIPLIST,","),XMIPLIST=$P(XMIPLIST,",",2,99) Q
 D NEXTIP(.XMIP,.XMIPLIST)
 Q
TRYIP(XMIP,XMOK) ; Try the IP address, if it works, set XMOK=1
 D SHOW("Trying "_XMIP)
 D CALL^%ZISTCP(XMIP,XMPORT)
 S XMOK='POP
 I 'XMOK D SHOW("Attempt failed.")
 Q
