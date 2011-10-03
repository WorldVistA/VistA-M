XMXADDR2 ;ISC-SF/GMB-XMXADDR (cont.) ;04/17/2002  13:42
 ;;8.0;MailMan;;Jun 28, 2002
BRODCAST(XMDUZ,XMADDR,XMSTRIKE,XMPREFIX,XMLATER,XMFULL) ;
 I $D(XMRESTR("NET RECEIVE")) D SETERR^XMXADDR4(0,"",39035) Q  ;Broadcast messages are not accepted from remote sites.
 I DUZ'=.5,'$D(^XUSEC("XMSTAR",DUZ)),'$D(^XUSEC("XMSTAR LIMITED",DUZ)) D  Q
 . ;Only the Postmaster or XMSTAR key holders may broadcast messages.
 . D SETERR^XMXADDR4($G(XMIA),"!",39036)
 I $D(XMRESTR("NOBCAST")) D SETERR^XMXADDR4($G(XMIA),"P",39036.5) Q  ; Messages with replies may not be broadcast.
 N XMCAST
 I DUZ=.5!$D(^XUSEC("XMSTAR",DUZ)) D  Q:$D(XMERROR)
 . I '$G(XMIA) S XMCAST=$S(XMADDR="*":"F",1:"L") Q
 . I XMADDR'="*" S XMCAST="L" Q
 . D TYPECAST(.XMCAST)
 E  S XMCAST="L"
 I XMCAST="F" D FULLCAST(XMSTRIKE,XMPREFIX,XMLATER,.XMFULL) Q
 ; Doing a limited broadcast...
 N XMLTD
 I XMADDR'="*" D
 . D CHECKIT(XMADDR,.XMLTD)
 E  D
 . D TYPELTD(.XMLTD) Q:$D(XMERROR)
 . D PARMLTD(.XMLTD) Q:$D(XMERROR)
 Q:$D(XMERROR)
 ;S XMFULL="* (Limited Broadcast)"
 S XMFULL="*;"_XMLTD("TYPE")_";"_XMLTD("PARM")
 I $G(XMINSTR("ADDR FLAGS"))["X" Q
 I XMSTRIKE Q:$D(^TMP("XMY0",$J,XMFULL,"L"))  W:$G(XMIA) $$EZBLD^DIALOG(39037) ;Deleting limited broadcast recipients
 I $G(XMIA),'XMSTRIKE,XMLATER="?" D QLATER^XMXADDR(XMFULL,.XMLATER)  Q:$D(XMERROR)
 I XMLATER,'$G(XMIA) Q
 I 'XMSTRIKE,$G(XMIA) W !,$$EZBLD^DIALOG(39038),! ;Limited broadcast recipients:
 N XMSCREEN
 ; User must have access code, verify code, primary menu, and mailbox
 S XMSCREEN="I $L($P(^(0),U,3)),$L($P($G(^(.1)),U,2)),$L($P($G(^(201)),U,1)),$D(^XMB(3.7,+Y,2))"
 D FIND^DIC(200,"","@","QX",XMLTD("PARM IEN"),"",XMLTD("XREF"),XMSCREEN)
 I '$D(^TMP("DILIST",$J)) D  Q
 . D SETERR^XMXADDR4($G(XMIA),"",39039) ;No matches.  No recipients.
 D SHOWLTD(XMDUZ,XMSTRIKE,XMPREFIX,XMLATER,$G(XMIA))
 Q
TYPECAST(XMCAST) ;
 N DIR,XMALL
 S XMALL=$$EZBLD^DIALOG(39040) ;Broadcast to all local users
 S DIR(0)="S^"_XMALL_";"_$$EZBLD^DIALOG(39041) ;Limited broadcast to local users
 D BLD^DIALOG(39042,"","","DIR(""A"")") ;Broadcast type
 S DIR("B")=$P(XMALL,":",2,9)
 ;Enter B to broadcast to all local users.
 ;Enter L to broadcast to a subset of local users.  Limited broadcasts
 ;are to local users who have something in common, such as belonging
 ;to the same DIVISION, or holding the same PRIMARY MENU.
 ;The LIMITED BROADCASTs from which you may choose are defined by
 ;your IRM in the MAILMAN SITE PARAMETERS file.
 D BLD^DIALOG(39043,"","","DIR(""?"")")
 D ^DIR I $D(DIRUT) D SETERR^XMXADDR4(0,"",37002) Q  ;up-arrow or time out.
 S XMCAST=$S(Y=$P(XMALL,":",1):"F",1:"L")
 Q
FULLCAST(XMSTRIKE,XMPREFIX,XMLATER,XMFULL) ;
 S XMFULL=$$EZBLD^DIALOG(39006) ;* (Broadcast to all local users)
 W:$G(XMIA) $E(XMFULL,2,99)
 D SETEXP^XMXADDR(XMFULL,"",XMSTRIKE,XMPREFIX,XMLATER)
 Q
TYPELTD(XMLTD) ;
 N DIC,DA,X,Y,DIR,XMDEF
 S DA(1)=1
 S DIC="^XMB(1,1,5,"
 S XMDEF=$P(^XMB(1,1,0),U,20) I XMDEF S XMDEF=$P($G(^XMB(1,1,5,XMDEF,0)),U,1) I XMDEF'="" S DIC("B")=XMDEF
 S DIC(0)="AEQZ"
 D ^DIC I Y=-1!$D(DTOUT)!$D(DUOUT) D SETERR^XMXADDR4(0,"",37002) Q  ;up-arrow or time out.
 S XMLTD("TYPE IEN")=+Y
 S XMLTD("TYPE")=$P(Y(0),U,1)
 S XMLTD("FILE")=$P(Y(0),U,2)
 S XMLTD("XREF")=$P(Y(0),U,3)
 D CHKFILE(.XMLTD) Q:$D(XMERROR)
 D CHKXREF(.XMLTD) Q:$D(XMERROR)
 Q
CHKFILE(XMLTD) ;
 I XMLTD("FILE")="" D  Q
 . ;Limited Broadcast entry |1|, field |2| is null.
 . D SETERR^XMXADDR4($G(XMIA),"!",39044,XMLTD("TYPE IEN"),1)
 I '$$VFILE^DILFD(XMLTD("FILE")) D  Q
 . ;Limited Broadcast entry |1|, field |2|: '|3|' does not exist.
 . D SETERR^XMXADDR4($G(XMIA),"!",39045,XMLTD("TYPE IEN"),1,XMLTD("FILE"))
 Q
CHKXREF(XMLTD) ;
 I XMLTD("XREF")="" D  Q
 . ;Limited Broadcast entry |1|, field |2| is null.
 . D SETERR^XMXADDR4($G(XMIA),"!",39044,XMLTD("TYPE IEN"),2)
 I '$D(^VA(200,XMLTD("XREF"))) D  Q
 . ;Limited Broadcast entry |1|, field |2|: '|3|' does not exist.
 . D SETERR^XMXADDR4($G(XMIA),"!",39045,XMLTD("TYPE IEN"),2,XMLTD("XREF"))
 Q
PARMLTD(XMLTD) ;
 N DIC,DIR,X,Y
 S DIC=$$ROOT^DILFD(XMLTD("FILE"))
 S DIC(0)="AEQZ"
 S DIC("S")="I $D(^VA(200,"""_XMLTD("XREF")_""",+Y))"
 S DIC("A")=$$EZBLD^DIALOG(39046,XMLTD("TYPE")) ;Select Limited Broadcast |1|:
 D ^DIC I Y=-1!$D(DTOUT)!$D(DUOUT) D SETERR^XMXADDR4(0,"",37002) Q  ;up-arrow or time out.
 S XMLTD("PARM IEN")=+Y
 S XMLTD("PARM")=Y(0,0)
 Q
CHECKIT(XMADDR,XMLTD) ;
 S XMLTD("TYPE")=$P(XMADDR,";",2) I XMLTD("TYPE")="" D SETERR^XMXADDR4($G(XMIA),"!",39047) Q  ;Limited Broadcast selection is null.
 S XMLTD("PARM")=$P(XMADDR,";",3) I XMLTD("PARM")="" D SETERR^XMXADDR4($G(XMIA),"!",39047.5) Q  ;Limited Broadcast selection value is null.
 S XMLTD("TYPE IEN")=$$FIND1^DIC(4.32,",1,","OQ",XMLTD("TYPE"))
 I 'XMLTD("TYPE IEN") D SETERR^XMXADDR4($G(XMIA),"!",$S(XMLTD("TYPE IEN")=0:39048,1:39049),XMLTD("TYPE")) Q  ;Limited Broadcast selection not found: |1| / Limited Broadcast selection ambiguous: |1|
 N XMREC
 S XMREC=$G(^XMB(1,1,5,XMLTD("TYPE IEN"),0))
 S XMLTD("TYPE")=$P(XMREC,U,1)
 S XMLTD("FILE")=$P(XMREC,U,2)
 S XMLTD("XREF")=$P(XMREC,U,3)
 D CHKFILE(.XMLTD) Q:$D(XMERROR)
 D CHKXREF(.XMLTD) Q:$D(XMERROR)
 S XMLTD("PARM IEN")=$$FIND1^DIC(XMLTD("FILE"),"","OQ",XMLTD("PARM"))
 I XMLTD("PARM IEN") S XMLTD("PARM")=$$GET1^DIQ(XMLTD("FILE"),XMLTD("PARM IEN")_",",.01) Q
 N XMPARM S XMPARM(1)=XMLTD("PARM"),XMPARM(2)=XMLTD("FILE")
 D SETERR^XMXADDR4($G(XMIA),"!",$S(XMLTD("PARM IEN")=0:39050,1:39051),.XMPARM) ;Limited Broadcast value '|1|' not found / Limited Broadcast value '|1|' ambiguous
 Q
SHOWLTD(XMDUZ,XMSTRIKE,XMPREFIX,XMLATER,XMIA) ;
 N XMI,XMGM,XMCNT
 S (XMI,XMCNT)=0
 F  S XMI=$O(^TMP("DILIST",$J,2,XMI)) Q:'XMI  S XMGM=^(XMI) D
 . N XMERROR,XMFWDADD
 . I 'XMLATER D INDIV^XMXADDR(XMDUZ,XMGM,XMSTRIKE,XMPREFIX,XMLATER)
 . Q:'XMIA
 . I XMCNT,XMCNT#16=0 D  Q:'XMIA
 . . N DIR,Y ;Do you want to see more Limited Broadcast recipients
 . . S DIR("A")=$$EZBLD^DIALOG(39052)
 . . S DIR(0)="Y",DIR("B")=$$EZBLD^DIALOG(39053) ;No
 . . D ^DIR
 . . S XMIA=+Y  ; The '+' takes care of $D(DIRUT)
 . S XMCNT=XMCNT+1
 . W:XMCNT#4-1=0 !
 . W ?XMCNT-1#4*20,$E($S(XMPREFIX="":"",1:XMPREFIX_":")_$$NAME^XMXUTIL(XMGM),1,19)
 K ^TMP("DILIST",$J)
 Q
INXFORM(X) ; Input transform for file 4.3, field 51 LIMITED BROADCAST DEFAULT
 N DIC,DA,Y,DIR,XMERROR,XMLTD,XMIA
 I '$D(ZTQUEUED) S XMIA=1
 S DA(1)=1
 S DIC="^XMB(1,1,5,"
 S DIC(0)="EQZ"
 D ^DIC I Y=-1!$D(DTOUT)!$D(DUOUT) K X Q
 S XMLTD("TYPE IEN")=+Y
 S XMLTD("TYPE")=$P(Y(0),U,1)
 S XMLTD("FILE")=$P(Y(0),U,2)
 S XMLTD("XREF")=$P(Y(0),U,3)
 D CHKFILE(.XMLTD) I $D(XMERROR) K X Q
 D CHKXREF(.XMLTD) I $D(XMERROR) K X Q
 S X=XMLTD("TYPE IEN")
 Q
EXHELP ; Executable help for file 4.3, field 51 LIMITED BROADCAST DEFAULT
 N I
 D EN^DDIOL($$EZBLD^DIALOG(38056)) ; Choose from:
 S I=0
 F  S I=$O(^XMB(1,1,5,I)) Q:'I  D EN^DDIOL($P(^(I,0),U,1))
 Q
