XMJMD ;ISC-SF/GMB-Later Messages ;12/04/2002  13:46
 ;;8.0;MailMan;**10**;Jun 28, 2002
 ; Replaces ^XMB1 (ISC-WASH/THM/CAP)
 ; Entry points are:
 ; EDIT     Change/Delete Later'd messages for a particular user
 ; REPORT   Report on Later'd messages for a particular user
 ; LATER    Add/Edit Later'd Dates for a particular user/message
 ; LTRADD   Add Later'd delivery date for a particular user/message
 ; DELUSER  Delete all Later'd messages for a particular user
 ; DELMSG   Delete all Later'd dates for a particular message
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; EDIT     XMLATER-EDIT
 ; REPORT   XMLATER-REPORT
REPORT ; Report on later'd messages
 N ZTSAVE,ZTDESC,ZTRTN,I
 D CHECK^XMVVITAE
 S ZTDESC=$$EZBLD^DIALOG(34639) ; MailMan: Report on Later'd Messages
 S ZTRTN="RPTLATER^XMJMD"
 F I="XMDUZ","XMV(""NAME"")" S ZTSAVE(I)=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 Q
RPTLATER ;
 ; XMDUZ,XMV("NAME") are provided
 N XMZ,XMABORT,XMWHEN,XMIEN,XMREC,XMZREC,XMPAGE,XMLEN,XMK,XMKN
 S XMLEN("DATE")=$L($$FMTE^XLFDT($E($$NOW^XLFDT,1,12),"5Z"))
 S XMLEN("XMZ")=$L($O(^XMB(3.9,":"),-1))
 S:XMLEN("XMZ")<7 XMLEN("XMZ")=7
 S XMLEN("BSKT")=10
 S XMLEN("SUBJ")=79-XMLEN("DATE")-XMLEN("XMZ")-XMLEN("BSKT")-6
 S (XMPAGE,XMABORT)=0
 W:$E(IOST,1,2)="C-" @IOF
 D RPTHDR(.XMLEN,.XMPAGE)
 S XMIEN=""
 F  S XMIEN=$O(^XMB(3.73,"C",XMDUZ,XMIEN)) Q:XMIEN=""  D  Q:XMABORT
 . S XMREC=$G(^XMB(3.73,XMIEN,0)) I XMREC="" K ^XMB(3.73,"C",XMDUZ,XMIEN) Q
 . S XMZ=+$P(XMREC,U,3)
 . S XMZREC=$G(^XMB(3.9,XMZ,0)) I XMZREC="" D DELDATE(XMIEN) Q
 . S XMWHEN=$P(XMREC,U,1)
 . S XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,""))
 . S XMKN=$S('XMK:$$EZBLD^DIALOG(34014),1:$P($G(^XMB(3.7,XMDUZ,2,XMK,0)),U)) ; * N/A *
 . I $Y+3>IOSL D  Q:XMABORT
 . . I $E(IOST,1,2)="C-" D PAGE^XMXUTIL(.XMABORT) Q:XMABORT
 . . W @IOF D RPTHDR(.XMLEN,.XMPAGE)
 . W !,$$LJ^XLFSTR($$FMTE^XLFDT($E(XMWHEN,1,12),"5Z"),XMLEN("DATE")),"  ",$$LJ^XLFSTR($E(XMKN,1,XMLEN("BSKT")),XMLEN("BSKT")),"  ",$J(XMZ,XMLEN("XMZ")),"  ",$E($$SUBJ^XMXUTIL2(XMZREC),1,XMLEN("SUBJ"))
 W:$O(^XMB(3.73,"C",XMDUZ,""))="" !,$$EZBLD^DIALOG(34630) ; No Later'd Messages
 I $E(IOST,1,2)="C-",'XMABORT D WAIT^XMXUTIL
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
RPTHDR(XMLEN,XMPAGE) ;
 S XMPAGE=XMPAGE+1
 W $$EZBLD^DIALOG(34631,XMV("NAME")),?70,$$EZBLD^DIALOG(34542,XMPAGE) ; Later'd Messages Report for: / Page
 W !,$$LJ^XLFSTR($$EZBLD^DIALOG(34632),XMLEN("DATE")),"  ",$$LJ^XLFSTR($$EZBLD^DIALOG(34011),XMLEN("BSKT")),"  ",$$RJ^XLFSTR($$EZBLD^DIALOG(34633),XMLEN("XMZ")),"  ",$$EZBLD^DIALOG(34002) ; Date / Basket / Msg ID / Subject
 W !,$$REPEAT^XLFSTR("-",79)
 Q
DELUSER(XMDUZ) ; Delete all Later'd messages for a particular user
 N XMIEN
 S XMIEN=""
 F  S XMIEN=$O(^XMB(3.73,"C",XMDUZ,XMIEN)) Q:XMIEN=""  D DELDATE(XMIEN)
 Q
DELDATE(XMIEN) ; Delete a particular Later'd message date
 N DIK
 S DIK="^XMB(3.73,",DA=XMIEN
 D ^DIK
 Q
DELMSG(XMZ) ; Delete all Later'd dates for a particular message
 N XMDUZ,XMIEN
 S (XMDUZ,XMIEN)=""
 F  S XMDUZ=$O(^XMB(3.73,"AC",XMZ,XMDUZ)) Q:XMDUZ=""  D
 . F  S XMIEN=$O(^XMB(3.73,"AC",XMZ,XMDUZ,XMIEN)) Q:XMIEN=""  D DELDATE(XMIEN)
 Q
LATER(XMDUZ,XMZ) ; For a particular message,
 ; let user edit any existing latered times or add a new one.
 N XMABORT,XMWHEN
 S XMABORT=0
 I $D(^XMB(3.73,"AC",XMZ,XMDUZ)) D
 . W @IOF
 . D LATER^XMJMQ1(XMDUZ,XMZ,"","","","",.XMABORT)
 . S XMABORT=0
 . N DIR,XMIEN,XMADD,XMCHG,XMDEL
 . S XMIEN=$O(^XMB(3.73,"AC",XMZ,XMDUZ,0))
 . I $O(^XMB(3.73,"AC",XMZ,XMDUZ,XMIEN)) S XMIEN=0
 . S XMADD=$$EZBLD^DIALOG(34634) ; A:Add another date on which this message should appear new
 . S XMCHG=$$EZBLD^DIALOG($S(XMIEN:34635,1:34635.1)) ; C:Change this / a date
 . S XMDEL=$$EZBLD^DIALOG($S(XMIEN:34636,1:34636.1)) ; D:Delete this / a date
 . S DIR(0)="SO^"_XMADD_";"_XMCHG_";"_XMDEL
 . D ^DIR I $D(DIRUT) S XMABORT=1 Q
 . I Y=$P(XMADD,":",1) D  Q
 . . D LTRDATE(.XMWHEN,.XMABORT) Q:XMABORT
 . . D LTRADD(XMDUZ,XMZ,XMWHEN)
 . I 'XMIEN D WHICH(XMDUZ,XMZ,.XMIEN,.XMABORT) Q:XMABORT
 . I Y=$P(XMCHG,":",1) D CHGDATE(XMIEN) Q
 . D DELDATE(XMIEN) ; Delete this date
 . W $$EZBLD^DIALOG(34637) ; " ... deleted."
 E  D
 . D LTRDATE(.XMWHEN,.XMABORT) Q:XMABORT
 . D LTRADD(XMDUZ,XMZ,XMWHEN)
 Q
EDIT ; Change/delete later'd messages
 I '$D(^XMB(3.73,"C",XMDUZ)) W !!,$C(7),$$EZBLD^DIALOG(34638) Q  ; You have no Later'd messages.
 D LTREDIT($G(XMDUZ,DUZ))
 Q
LTREDIT(XMDUZ,XMZ) ;
 N X,Y,XMIEN,XMDEL,DIR,DIE,DR,DA,DIRUT,XMABORT
 S XMABORT=0
 D WHICH(XMDUZ,.XMZ,.XMIEN,.XMABORT) Q:XMABORT
 ; The user has chosen a record to edit (and change the later'd date)
 S XMDEL=$$EZBLD^DIALOG(34636) ; D:Delete this date
 S DIR(0)="S^"_$$EZBLD^DIALOG(34635)_";"_XMDEL ; C:Change this date
 D ^DIR Q:$D(DIRUT)
 I Y=$P(XMDEL,":",1) D  Q
 . D DELDATE(XMIEN) ; Delete this date
 . W $$EZBLD^DIALOG(34637) ; " ... deleted."
 K DIR,X,Y,DIRUT
 D CHGDATE(XMIEN) ; Change this date
 Q
WHICH(XMDUZ,XMZ,XMIEN,XMABORT) ;
 N DIC,D,X,Y
 W !
 S DIC="^XMB(3.73,"
 S DIC(0)="NEU"
 S D="C"
 I $D(XMZ) S DIC("S")="I $D(^XMB(3.73,""AC"","_XMZ_","_$G(XMDUZ,DUZ)_",Y))"
 E  S DIC("S")="I $D(^XMB(3.73,""C"","_$G(XMDUZ,DUZ)_",Y))"
 S X=$G(XMDUZ,DUZ)
 D IX^DIC I Y=-1 S XMABORT=1 Q
 S XMIEN=+Y
 Q
CHGDATE(DA) ; Change a date
 N DIE,DR,DIDEL
 S DIDEL=3.73
 S DIE=3.73
 S DR=.01
 D ^DIE
 Q
LTRDATE(Y,XMABORT) ;
 N DIR
 S DIR(0)="3.73,.01"
 S DIR("B")="T+1"
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 Q
LTRADD(XMDUZ,XMZ,XMWHEN) ;
 N XMFDA
 Q:$D(^XMB(3.73,"AB",XMWHEN,XMDUZ,XMZ))  ; Already scheduled?
 S XMFDA(3.73,"+1,",.01)=XMWHEN
 ;S XMFDA(3.73,"+1,",1)=XMDUZ  Not needed, because done by trigger
 S XMFDA(3.73,"+1,",2)=XMZ
 D UPDATE^DIE("","XMFDA")
 Q
