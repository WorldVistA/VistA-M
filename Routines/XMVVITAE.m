XMVVITAE ;ISC-SF/GMB-Initialize User's MailMan Variables ;04/19/2002  13:26
 ;;8.0;MailMan;**36**;Jun 28, 2002
 ; Replaces ^XMGAPI1,FWD^XMA21,FWD,BANNER^XMA6,EDIT^XMA7 (ISC-WASH/CAP)
 ; Entry points (DBIA 2728):
 ; INIT     Set up variables for DUZ or XMDUZ.
 ; OTHER    Set up variables to become a surrogate of someone else.
 ; SELF     Return from being a surrogate to being oneself again.
 Q
INIT ; Set up one's variables (for yourself or as a surrogate).
 N XMAPI
INIT2 K XMV
 D SYSTEM(.XMV)
 S:'$D(XMDUZ) XMDUZ=DUZ
 D DUZ(DUZ,.XMV,.XMDUN,.XMDISPI,.XMNOSEND)
 D:XMDUZ'=DUZ SURROGAT(XMDUZ,.XMV,.XMDUN,.XMNOSEND,.XMPRIV)
 Q
INITAPI ; (For MailMan use only) Set up variables for an API call.
 N XMAPI
 S XMAPI=1 ; "last used MailMan" will not be recorded.
 G INIT2
CHECK ; Check to make sure one's variables exist.
 I '$D(XMV("NAME"))!'$D(XMV("RDR DEF")) D INIT
 Q
OTHER ; Become someone else.  INIT should have been called previously.
 I '$D(XMV) D INIT Q
 N XMAPI
 D SURROGAT(XMDUZ,.XMV,.XMDUN,.XMNOSEND,.XMPRIV)
 Q
SELF ; Return to oneself after having become someone else.
 ; INIT should have been called previously.
 S XMDUZ=DUZ
 I '$D(XMV) D INIT Q
 N XMAPI
 D USER(XMDUZ,.XMV,.XMNOSEND,.XMDUN)
 D LASTUSE(XMDUZ,.XMV)
 Q
SYSTEM(XMV) ;
 ; XMV("VERSION")
 I '$D(DT) D DT^DICRW
 S XMV("VERSION")="VA MailMan "_$P($T(XMVVITAE+1),";",3)
 ; Check to make sure that important variables are defined correctly.
 I +$G(^XMB("NUM")),$G(^XMB("NAME"))=$G(^XMB("NETNAME")),$G(^XMB("NETNAME"))=$P($G(^DIC(4.2,+$G(^XMB("NUM")),0)),U,1),$G(^XMB("NUM"))=$P($G(^XMB(1,1,0)),U,1) Q
 N XMPARM  ; The domain for this facility is not christened correctly.
 S XMPARM(1)=$G(^XMB("NUM"))
 S XMPARM(2)=$P($G(^XMB(1,1,0)),U,1)
 S XMPARM(3)=$P($G(^DIC(4.2,+$G(^XMB("NUM")),0)),U,1)
 S XMPARM(4)=$P($G(^DIC(4.2,+XMPARM(2),0)),U,1)
 S XMPARM(5)=$G(^XMB("NETNAME"))
 S XMPARM(6)=$G(^XMB("NAME"))
 F I=1:1:6 I XMPARM(I)="" S XMPARM(I)="?"
 ;The domain for this facility is not christened correctly.
 ;IRM must correct this for network mail to function properly.
 ;The following pointers should contain the same numbers,
 ;which should point to this facility's domain in ^DIC(4.2:
 ;^XMB("NUM")=|1|          ==> |3|
 ;$P(^XMB(1,1,0),U,1)=|2|  ==> |4|
 ;The following globals should contain the domain name of this facility:
 ;^XMB("NETNAME")=           |5|
 ;^XMB("NAME")=              |6|
 D BLD^DIALOG(38100,.XMPARM,"","XMV(""SYSERR"")")
 Q
DUZ(XMDUZ,XMV,XMDUN,XMDISPI,XMNOSEND) ;
 ; XMV("DUZ NAME")
 K XMV("ERROR")
 I $G(DUZ,0)=0 S XMV("ERROR",1)=$$EZBLD^DIALOG(38105) Q  ;You do not have a DUZ.
 D USER(XMDUZ,.XMV,.XMNOSEND,.XMDUN) Q:$D(XMV("ERROR"))
 S XMV("DUZ NAME")=XMV("NAME")
 D LASTUSE(XMDUZ,.XMV)
 D PREFER(XMDUZ,.XMV,.XMDISPI)
 Q
SURROGAT(XMDUZ,XMV,XMDUN,XMNOSEND,XMPRIV) ;
 ; XMV("PRIV")
 ; XMPRIV
 Q:XMDUZ=DUZ
 K XMV("ERROR"),XMV("WARNING")
 I XMDUZ=.6 D  Q
 . S XMV("PRIV")="R",XMPRIV="y^n"
 . S (XMDUN,XMV("NAME"))=$$NAME^XMXUTIL(.6)
 . D SETNET(XMDUZ,.XMV)
 . S XMV("NEW MSGS")=+$P(^XMB(3.7,XMDUZ,0),U,6)
 E  D  Q:$D(XMV("ERROR"))
 . N XMIEN
 . S XMIEN=+$O(^XMB(3.7,"AB",DUZ,XMDUZ,0))
 . ;Commented out because we shouldn't be here if not a valid surrogate
 . ;I 'XMIEN S XMV("ERROR",5)=$$EZBLD^DIALOG(38106,XMDUZ) Q  ;You are not a surrogate of DUZ |1|.
 . S XMPRIV=$G(^XMB(3.7,XMDUZ,9,XMIEN,0))
 . S XMV("PRIV")=$S($P(XMPRIV,U,2)="y":"R",1:"")_$S($P(XMPRIV,U,3)="y":"W",1:"")
 D USER(XMDUZ,.XMV,.XMNOSEND,.XMDUN) Q:$D(XMV("ERROR"))
 D LASTUSE(XMDUZ,.XMV)
 Q
USER(XMDUZ,XMV,XMNOSEND,XMDUN) ;
 ; XMV("WARNING")
 ; XMV("ERROR")
 ; XMV("NEW MSGS")
 ; XMV("NAME")
 ; XMV("NOSEND")
 ; XMNOSEND
 ; XMDUN
 N XMREC
 K XMV("ERROR"),XMV("WARNING")
 S XMREC=$G(^VA(200,XMDUZ,0))
 I XMREC="" S XMV("ERROR",2)=$$EZBLD^DIALOG(38107,XMDUZ) Q  ;There is no person with DUZ |1|.
 ;I $P(XMREC,U,3)="" S XMV("ERROR",3)=$$EZBLD^DIALOG(38108,XMDUZ) Q  ; There is no Access Code for DUZ XMDUZ
 I $P(XMREC,U,3)="",'$$USERTYPE^XUSAP(XMDUZ,"APPLICATION PROXY") S XMV("ERROR",3)=$$EZBLD^DIALOG(38108,XMDUZ) Q  ; There is no Access Code for DUZ XMDUZ
 ;I '$D(^XMB(3.7,XMDUZ,0)) S XMV("ERROR",4)=$$EZBLD^DIALOG(38109,XMDUZ) Q  ;There is no mailbox for DUZ |1|.
 I '$D(^XMB(3.7,XMDUZ,0)),'$$USERTYPE^XUSAP(XMDUZ,"APPLICATION PROXY") S XMV("ERROR",4)=$$EZBLD^DIALOG(38109,XMDUZ) Q  ;There is no mailbox for DUZ |1|.
 S XMV("NOSEND")=0
 S (XMDUN,XMV("NAME"))=$$NAME^XMXUTIL(XMDUZ)
 D SETNET(XMDUZ,.XMV)
 Q:$D(ZTQUEUED)!$G(XMAPI)
 I $D(^XTMP("XM","MAKENEW",XMDUZ)) D NEWAGAIN^XMJBN1(XMDUZ)
 I '$D(DUZ("SAV")),$D(XMMENU(0)) L +^XMB(3.7,"AD",DUZ):0 E  S (XMV("NOSEND"),XMNOSEND)=1,XMV("WARNING",4)=$$EZBLD^DIALOG(38110) ;Multiple Signon
 S:$D(^XMB(3.7,XMDUZ,"N")) XMV("WARNING",1)=$$EZBLD^DIALOG(38111) ;Priority Mail
 I '$D(DUZ("SAV")),'XMV("NOSEND"),$D(^XMB(3.7,"AD",XMDUZ)) D
 . I XMDUZ='DUZ,$G(XMV("PRIV"))'["W" Q
 . N XMZ
 . S XMREC=$G(^XMB(3.7,XMDUZ,"T"))
 . S XMZ=$P(XMREC,U,1) I XMZ="" K ^XMB(3.7,"AD",XMDUZ) Q
 . I '$D(^XMB(3.9,XMZ,0)) K ^XMB(3.7,XMDUZ,"T"),^XMB(3.7,"AD",XMDUZ) Q
 . S XMZ=$P(XMREC,U,3)
 . I XMZ,'$D(^XMB(3.9,XMZ,0)) K ^XMB(3.7,XMDUZ,"T"),^XMB(3.7,"AD",XMDUZ) Q
 . S XMV("WARNING",2)=$$EZBLD^DIALOG(38112) ;Message in Buffer
 S XMV("NEW MSGS")=+$P(^XMB(3.7,XMDUZ,0),U,6)
 I XMDUZ=.5 D
 . N I,XMK
 . S XMK=.99
 . F I=1:1 S XMK=$O(^XMB(3.7,.5,2,XMK)) Q:XMK>999!'XMK
 . S:I>900 XMV("WARNING",5)=$$EZBLD^DIALOG(38113,I) ;POSTMASTER has |1| baskets.
 D SETBAN(XMDUZ,.XMV)
 Q
SETNET(XMDUZ,XMV) ;
 ; XMV("NETNAME")
 S XMV("NETNAME")=$$NETNAME^XMXUTIL(XMDUZ)
 Q
SETBAN(XMDUZ,XMV) ;
 ; XMV("BANNER")
 N XMBANNER
 S XMBANNER=$G(^XMB(3.7,XMDUZ,"B"))
 I XMBANNER="" K XMV("BANNER")
 E  S XMV("BANNER")=XMBANNER
 Q
PREFER(XMDUZ,XMV,XMDISPI) ;
 ; XMV("SHOW INST")
 ; XMV("SHOW TITL")
 ; XMV("SHOW DUZ")
 ; XMV("ASK BSKT")
 ; XMV("MSG DEF")
 ; XMV("RDR DEF")
 ; XMV("RDR ASK")
 ; XMV("ORDER")
 ; XMV("PREVU")
 ; XMV("NEW OPT")
 ; XMV("NEW ORDER")
 ; XMDISPI
 N XMUREC,XMSREC
 S XMSREC=$G(^XMB(1,1,0)) ; Site's preferences
 ;S XMUREC=^XMB(3.7,DUZ,0) ; User's preferences
 S XMUREC=$G(^XMB(3.7,DUZ,0)) ; User's preferences
 S XMV("SHOW INST")=$S($P(XMSREC,U,5)["y":1,1:0)  ; Show Institution
 S XMV("SHOW TITL")=$S($P(XMUREC,U,10)=1:1,1:0)   ; Show Titles
 I XMV("SHOW TITL") S XMV("TITL SRC")=$S($P(XMSREC,U,11)'="":$P(XMSREC,U,11),1:"T") ; Title Source (Signature Block or Title)
 Q:$D(ZTQUEUED)
 S XMV("SHOW DUZ")=+$P(XMSREC,U,8)  ; Show DUZ when addressing messages
 S XMV("PREVU")=$S($P(XMUREC,U,4)="Y":1,1:0)
 S XMV("ASK BSKT")=$S($P(XMUREC,U,5)'["n":1,1:0)
 ; User's default message action (Delete, Ignore). If user doesn't have one, take site's.  If site doesn't have one, make it Ignore.
 S XMV("MSG DEF")=$S($P(XMUREC,U,9)'="":$P(XMUREC,U,9),$P(XMSREC,U,15)'="":$P(XMSREC,U,15),1:"I")
 S XMV("ORDER")=$S($P(XMUREC,U,13)="N":-1,1:1)
 S XMV("RDR DEF")=$S($P(XMUREC,U,16)'="":$P(XMUREC,U,16),1:"C")
 S XMV("RDR ASK")=$S($P(XMUREC,U,17)'="":$P(XMUREC,U,17),1:"Y")
 S XMV("NEW OPT")=$S($P(XMUREC,U,18)'="":$P(XMUREC,U,18),1:"R")
 S XMV("NEW ORDER")=$S($P(XMUREC,U,19)="N":-1,1:1)
 Q:$G(XMAPI)
 I $P(XMSREC,U,6)["y",'$D(^XMB(3.7,XMDUZ,1,1,0)) S XMV("WARNING",3)=$$EZBLD^DIALOG(38114) ;No Introduction
 S XMDISPI="X"  ; Show Help (Not used?)
 I XMV("SHOW INST") S XMDISPI=XMDISPI_"I"
 I XMV("SHOW TITL") S XMDISPI=XMDISPI_"T"
 I XMV("ASK BSKT") S XMDISPI=XMDISPI_"A"
 S XMDISPI=XMDISPI_U_XMV("MSG DEF")
 Q
LASTUSE(XMDUZ,XMV) ;
 ; XMV("LAST USE")
 I XMDUZ=.6!$D(ZTQUEUED)!$G(XMAPI) Q
 S XMV("LAST USE")=$P($G(^XMB(3.7,XMDUZ,"L"),$$EZBLD^DIALOG(38002)),U,1) ;Never
 Q:$D(DUZ("SAV"))
 S ^XMB(3.7,XMDUZ,"L")=$$MMDT^XMXUTIL1($$NOW^XLFDT)_$S(XMDUZ'=DUZ:$$EZBLD^DIALOG(38008,XMV("DUZ NAME")),1:"")_U_DT_U_DUZ ; (Surrogate: |1|)
 Q
