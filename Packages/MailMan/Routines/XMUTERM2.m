XMUTERM2 ;ISC-SF/GMB-Delete Mailbox (cont.) ;04/17/2002  12:09
 ;;8.0;MailMan;;Jun 28, 2002
 ;
 ; The following are called from CHOOSE^XMUTERM
 ;
MMCHOOSE(XMGRACE,XMCUTOFF) ;
 N XMI,XMABORT,XMTERM
 S (XMI,XMABORT)=0
 F  S XMI=$O(^XMB(3.7,XMI)) Q:XMI'>0  D  Q:XMABORT
 . D CHECK1^XMUTERM1(XMI,XMGRACE,XMCUTOFF,.XMTERM) I XMTERM D DELETE(XMI,.XMABORT) Q
 . D CHECK2^XMUTERM1(XMI,XMCUTOFF,.XMTERM) I XMTERM D DELETE(XMI,.XMABORT)
 Q
ICHOOSE(XMGRACE,XMCUTOFF) ;
 F  D  Q:XMABORT
 . N DIC,Y
 . S DIC="^XMB(3.7,"
 . S DIC(0)="AEQM"
 . S DIC("S")="N XMTERM,XMFORGET D CHECK1^XMUTERM1(Y,XMGRACE,XMCUTOFF,.XMTERM),CHECK2^XMUTERM1(Y,XMCUTOFF,.XMFORGET) I XMTERM!XMFORGET"
 . W ! D ^DIC I Y=-1 S XMABORT=1 Q
 . D DELETE(+Y)
 Q
DELETE(XMI,XMABORT) ;
 N XMREC1,XMREC2,XMDELETE
 S XMREC1=$G(^VA(200,XMI,0))
 I XMREC1'="" D  Q:'XMDELETE
 . N DIR,Y
 . W !!,$$NAME^XMXUTIL(XMI)
 . W !,$$EZBLD^DIALOG(36336),$$EZBLD^DIALOG($S($P(XMREC1,U,3)="":36334,1:36335)) ; Access Code: NONE / <Hidden>
 . W ?25,$$EZBLD^DIALOG(36337),$$EZBLD^DIALOG($S($P($G(^VA(200,XMI,.1)),U,2)="":36334,1:36335)) ; Verify Code: NONE / <hidden>
 . W ?50,$$EZBLD^DIALOG(36338),$S($P($G(^VA(200,XMI,201)),U,1)="":$$EZBLD^DIALOG(36334),1:$P($G(^DIC(19,$P(^(201),U),0)),U)) ; Primary Menu: NONE / ...
 . W !,$$EZBLD^DIALOG(36339),$S($P($G(^VA(200,XMI,1)),U,7)="":$$EZBLD^DIALOG(36334),1:$$FMTE^XLFDT($P(^(1),U,7),"2D")) ; Date Entered: NONE / date
 . W ?25,$$EZBLD^DIALOG(36340),$S($P($G(^VA(200,XMI,1.1)),U,1)="":$$EZBLD^DIALOG(36334),1:$$FMTE^XLFDT($P(^(1.1),U,1),"2D")) ; Last Logon: NONE / date
 . W ?50,"DISUSER: ",$$EZBLD^DIALOG($S($P(XMREC1,U,7):39054,1:39053)) ; YES / NO
 . W !,$$EZBLD^DIALOG(36341),$S($P(XMREC1,U,11)="":$$EZBLD^DIALOG(36334),1:$$FMTE^XLFDT($P(XMREC1,U,11),"2D")) ; Term Date: NONE / date
 . W:$P(XMREC1,U,11) ?25,$$EZBLD^DIALOG(36342),$$EZBLD^DIALOG($S($P(XMREC1,U,5)="y":39054,1:39053)) ; Delete Mail: YES / NO
 . S XMREC2=^XMB(3.7,XMI,0)
 . W ?50,$$EZBLD^DIALOG(36343),$P(XMREC2,U,6) ; New Messages:
 . W !,$$EZBLD^DIALOG(38012),$S($P($G(^XMB(3.7,XMI,"L")),U)="":$$EZBLD^DIALOG(38002),1:$P(^("L"),U)) ; last used mailman: Never / date
 . W !,$$EZBLD^DIALOG(38004) ; Forwarding Address:
 . I $P(XMREC2,U,2)="" D
 . . W $$EZBLD^DIALOG(36334) ; NONE
 . E  D
 . . W $P(XMREC2,U,2),$$EZBLD^DIALOG($S($P(XMREC2,U,8):38005,1:38006)) ; fwding addr, local deliver on/off
 . W !
 . S DIR(0)="Y"
 . S DIR("B")=$$EZBLD^DIALOG(39053) ; NO
 . S DIR("A")=$$EZBLD^DIALOG(36344) ; Delete this user's mailbox
 . D ^DIR I $D(DIRUT) S XMDELETE=0,XMABORT=1 Q
 . I 'Y S XMDELETE=0 Q
 . S XMDELETE=1
 N XMPARM
 S XMPARM(1)=XMI,XMPARM(2)=$S(XMREC1="":$$EZBLD^DIALOG(36346),1:$P(XMREC1,U)) ; * not in NEW PERSON file *
 W !,$$EZBLD^DIALOG(36345,.XMPARM) ; Deleting mailbox for user |1| |2|
 D TERMINAT^XMUTERM1(XMI)
 Q
 ;
 ; The following are called from TERMINAT^XMUTERM1
 ;
GROUP(XMDUZ) ; Remove user from mail groups
 N XMI,XMJ,DIK,DA
 ; Remove user as member from all mail groups
 S XMI=0
 F  S XMI=$O(^XMB(3.8,"AB",XMDUZ,XMI)) Q:XMI'>0  D
 . S DA(1)=XMI,DIK="^XMB(3.8,XMI,1,",XMJ=0
 . F  S XMJ=$O(^XMB(3.8,"AB",XMDUZ,XMI,XMJ)) Q:XMJ'>0  S DA=XMJ D ^DIK
 K ^XMB(3.8,"AB",XMDUZ)
 ; Remove user as coordinator from all mail groups
 S XMI=0
 F  S XMI=$O(^XMB(3.8,"AC",XMDUZ,XMI)) Q:XMI'>0  D
 . S XMFDA(3.8,XMI_",",5.1)=.5 ; (change coord to postmaster)
 . D FILE^DIE("","XMFDA")
 K ^XMB(3.8,"AC",XMDUZ)
 ; Remove user's personal mail groups, and
 ; remove user as organizer or authorized sender from all mail groups.
 S XMI=0
 F  S XMI=$O(^XMB(3.8,XMI)) Q:XMI'>0  D
 . I +$G(^XMB(3.8,XMI,3))=XMDUZ D  ; user is organizer
 . . I $P(^XMB(3.8,XMI,0),U,6)=1 S DA=XMI,DIK="^XMB(3.8," D ^DIK Q  ; delete personal group
 . . S XMFDA(3.8,XMI_",",5)=.5 ; (change organizer to postmaster)
 . . D FILE^DIE("","XMFDA")
 . ; Remove user as authorized sender from all mail groups
 . Q:'$D(^XMB(3.8,XMI,4,"B",XMDUZ))
 . S DA=$O(^XMB(3.8,XMI,4,"B",XMDUZ,0))
 . I '$D(^XMB(3.8,XMI,4,DA,0)) K ^XMB(3.8,XMI,4,"B",XMDUZ) Q
 . S DA(1)=XMI,DIK="^XMB(3.8,XMI,4," D ^DIK
 Q
SURROGAT(XMDUZ) ; Remove as mail surrogate
 N XMI,DA,DIK
 S XMI=0,DIK="^XMB(3.7,XMI,9,"
 F  S XMI=$O(^XMB(3.7,"AB",XMDUZ,XMI)) Q:XMI'>0  D
 . S DA=$O(^XMB(3.7,"AB",XMDUZ,XMI,0))
 . I '$D(^XMB(3.7,XMI,9,DA,0)) K ^XMB(3.7,"AB",XMDUZ,XMI) Q
 . S DA(1)=XMI D ^DIK
 K ^XMB(3.7,"AB",XMDUZ)
 Q
MAILBOX(XMDUZ) ; Remove user's mailbox
 Q:'$D(^XMB(3.7,XMDUZ))
 N DIK,DA
 S DIK="^XMB(3.7,",DA=XMDUZ D ^DIK
 K:$D(^XMB(3.7,XMDUZ)) ^XMB(3.7,XMDUZ) ; just in case!
 K:$D(^XMB(3.7,"B",XMDUZ)) ^XMB(3.7,"B",XMDUZ)
 Q
LATERNEW(XMDUZ) ; Remove the scheduling of any messages slated to become new for this user
 N DIK,DA
 S DIK="^XMB(3.73,"
 S DA=""
 F  S DA=$O(^XMB(3.73,"C",XMDUZ,DA)) Q:'DA  D ^DIK
 Q
LATERSND(XMDUZ) ; Remove the scheduling of any messages slated to be sent by this user.
 N XMZ,DIK,DA
 S XMZ=0
 F  S XMZ=$O(^XMB(3.9,"AW",XMDUZ,XMZ)) Q:'XMZ  D
 . S DA(1)=XMZ
 . S DIK="^XMB(3.9,"_DA(1)_",7,"
 . S DA=0
 . F  S DA=$O(^XMB(3.9,"AW",XMDUZ,XMZ,DA)) Q:'DA  D ^DIK
 Q
