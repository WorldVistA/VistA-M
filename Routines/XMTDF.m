XMTDF ;ISC-SF/GMB-Filter message: multiple conditions ;04/15/2003  12:45
 ;;8.0;MailMan;**18**;Jun 28, 2002
 ; XMF("SUBJ")  Subject contains this string
 ; XMF("FROM")  Message is from this person
 ; XMF("TO")    Message is to this person
FILTER(XMDUZ,XMZ,XMZSUBJ,XMZFROM,XMK,XMKN,XMACT) ; figures out which basket to save to
 ; the message should be put in.
 ; Defaults: the "IN" basket.
 ; If basket doesn't exist, it creates the basket.
 ; Returns:
 ; XMK  basket number
 ; XMKN basket name
 ; Optionally, if specified by user:
 ; XMACT("VDAYS") set vaporize date to this many days from today.
 ; XMACT("NONEW") don't make this message new.
 ; XMACT("FWD")   forward this message
 N XMORDER,XMIEN,XMFREC
 K XMK,XMKN
 S (XMORDER,XMIEN)=0
 F  S XMORDER=$O(^XMB(3.7,XMDUZ,15,"AF",XMORDER)) Q:'XMORDER  D  Q:$D(XMKN)
 . F  S XMIEN=$O(^XMB(3.7,XMDUZ,15,"AF",XMORDER,XMIEN)) Q:'XMIEN  D  Q:$D(XMKN)
 . . N XMF
 . . S XMFREC=$G(^XMB(3.7,XMDUZ,15,XMIEN,0))
 . . S:$P(XMFREC,U,5)]"" XMF("SUBJ")=$P(XMFREC,U,5)
 . . S:$P(XMFREC,U,6)]"" XMF("FROM")=$P(XMFREC,U,6)
 . . S:$P(XMFREC,U,7)]"" XMF("TO")=$P(XMFREC,U,7)
 . . S:$$GOODMSG(XMZ,XMZSUBJ,XMZFROM,.XMF) XMKN=$P(XMFREC,U,3)
 I '$D(XMKN) D  Q
 . S XMK=1,XMKN=$$EZBLD^DIALOG(37005)   ; Default to "IN" basket
 . D:'$D(^XMB(3.7,XMDUZ,2,XMK,0)) MAKEBSKT^XMXBSKT(XMDUZ,XMK,XMKN)
 S XMK=$O(^XMB(3.7,XMDUZ,2,"B",XMKN,0))
 I $P(XMFREC,U,8) S XMACT("VDAYS")=$P(XMFREC,U,8)
 I $P(XMFREC,U,9)="N" S XMACT("NONEW")=1
 I $D(^XMB(3.7,XMDUZ,15,XMIEN,1,"B")),$$OKFWD(XMZ) S XMACT("FWD")=XMIEN
 Q:XMK
 I XMKN=$$EZBLD^DIALOG(37004) S XMK=.5 D MAKEBSKT^XMXBSKT(XMDUZ,XMK,XMKN) Q  ; "WASTE"
 D MAKEBSKT^XMXBSKT(XMDUZ,.XMK,XMKN)
 Q
GOODMSG(XMZ,XMZSUBJ,XMZFROM,XMF) ;
 ; This function is a copy of $$GOODMSG^XMJMFB, but with fewer
 ; conditions to match on.
 N XMNOGOOD
 I $D(XMF("SUBJ")),$$UP^XLFSTR(XMZSUBJ)'[XMF("SUBJ") Q 0
 I $D(XMF("FROM")) D  Q:XMNOGOOD 0
 . I XMF("FROM")=+XMF("FROM"),XMF("FROM")=XMZFROM S XMNOGOOD=0 Q
 . S XMNOGOOD=1
 . Q:XMF("FROM")'["@"
 . S XMZFROM=$$UP^XLFSTR(XMZFROM)
 . Q:$P(XMZFROM,"@")'[$P(XMF("FROM"),"@")
 . Q:$P(XMZFROM,"@",2)'[$P(XMF("FROM"),"@",2)
 . S XMNOGOOD=0
 I $D(XMF("TO")) D  Q:XMNOGOOD 0
 . I $D(^XMB(3.9,XMZ,6,"B",XMF("TO"))) S XMNOGOOD=0 Q
 . I $L(XMF("TO"))>30,$D(^XMB(3.9,XMZ,6,"B",$E(XMF("TO"),1,30))),XMF("TO")=$P($G(^XMB(3.9,XMZ,6,+$O(^XMB(3.9,XMZ,6,"B",$E(XMF("TO"),1,30),0)),0)),U,1) S XMNOGOOD=0 Q
 . S XMNOGOOD=1
 . Q:XMF("TO")'["@"
 . N XMTOX,XMTO
 . S XMTO=""
 . F  S XMTO=$O(^XMB(3.9,XMZ,6,"B",XMTO)) Q:XMTO=""  D  Q:'XMNOGOOD
 . . Q:XMTO'["@"
 . . S XMTOX=$$UP^XLFSTR(XMTO)
 . . Q:$P(XMTOX,"@")'[$P(XMF("TO"),"@")
 . . Q:$P(XMTOX,"@",2)'[$P(XMF("TO"),"@",2)
 . . S XMNOGOOD=0
 Q 1
BASKET(X) ; Input Transform for file 3.7, subfile 3.715, field 2 BASKET
 N DIC,Y,DA
 S DA(1)=$G(XMDUZ,DUZ)
 S DIC="^XMB(3.7,"_DA(1)_",2,"
 S DIC("P")=3.701
 S DIC(0)="EQL"
 D ^DIC
 I $P(Y,U)=1 K X Q  ; May not filter to the IN basket
 I Y>0 S X=$P(Y,U,2) Q
 K X
 Q
BSKTHELP ; Executable Help for file 3.7, subfile 3.715, field 2 BASKET
 N DIC,Y
 Q:"??"'[X
 S DIC("S")="I X'="""_$$EZBLD^DIALOG(37005)_"""" ; IN
 S DIC="^XMB(3.7,"_$G(XMDUZ,DUZ)_",2,"
 S DIC(0)="EQL"
 D ^DIC
 Q
FROM(X) ; Input Transform for file 3.7, subfile 3.715, field 5 FROM
 S X=$$UP^XLFSTR(X)
 I X["@" K:$L(X)<2!($L(X)>45) X Q
 N DIC,Y
 S DIC="^VA(200,",DIC(0)="MNE"
 D ^DIC
 I Y=-1 K X Q
 S X=+Y
 Q
TO(X) ; Input Transform for file 3.7, subfile 3.715, field 6 ADDRESSED TO
 I X["@" D  Q
 . S X=$$UP^XLFSTR(X)
 . K:$L(X)<2!($L(X)>55) X
 I $E(X,1,2)="G."!($E(X,1,2)="g.") D  Q
 . ; See GETPERS^XMJMF2 for another way to do the lookup.  The difference
 . ; is that the other way does not let unauthorized senders pick groups
 . ; which have authorized senders.
 . S X=$E(X,3,99)
 . N DIC,Y
 . ; Screen:  Group is public OR user is organizer
 . ;          OR group is unrestricted and user is member
 . S DIC("S")="N XMR S XMR=^(0) I $S($P(XMR,U,2)=""PU"":1,$P($G(^XMB(3.8,+Y,3),.5),U)=$G(XMDUZ,DUZ):1,+$P(XMR,U,6):0,$D(^XMB(3.8,+Y,1,""B"",$G(XMDUZ,DUZ))):1,1:0)"
 . S DIC="^XMB(3.8,"
 . S DIC(0)="MEZ"
 . D ^DIC
 . I Y=-1 K X Q
 . S X="G."_$P(Y,U,2)_$S($P(Y(0),U,6):$$EZBLD^DIALOG(39135),1:"") ; " [Private Mail Group]"
 S X=$$UP^XLFSTR(X)
 N DIC,Y
 S DIC="^VA(200,",DIC(0)="MNE"
 D ^DIC
 I Y=-1 K X Q
 S X=$P(Y,U,2)
 Q
FWDTO(XMADDR,XMIA) ; Input Transform for file 3.7, subfile 3.715,
 ; subfile 3.7159, field .01 FORWARD TO
 N DO ; to keep FileMan from exploding (that's D-oh)
 N XMERROR,XMRESTR,XMINSTR,XMFULL,XMFWDADD
 S XMINSTR("ADDR FLAGS")="X" ; do not create ^TMP(, just check.
 D ADDRESS^XMXADDR(DUZ,XMADDR,.XMFULL,.XMERROR)
 I $D(XMERROR) K XMADDR Q
 S XMADDR=XMFULL
 Q
DELFWDTO(XMUSER,XMFILTER,XMIEN,XMFWD,XMERROR) ; Delete a user's invalid FORWARD TO address.
 N XMPARM,XMINSTR,XMFDA
 S XMFDA(3.7159,XMIEN_","_XMFILTER_","_XMUSER_",",.01)="@"
 D FILE^DIE("","XMFDA")
 S XMINSTR("FROM")=.5
 S XMPARM(1)=XMFWD,XMPARM(3)=XMERROR
 S XMPARM(2)=$P(^XMB(3.7,XMUSER,15,XMFILTER,0),U,1) ; filter name
 D TASKBULL^XMXBULL(.5,"XM FILTER FWD ADDRESS DELETE",.XMPARM,"",XMUSER,.XMINSTR)
 Q
OKFWD(XMZ) ; Is it OK to automatically forward this message?
 N XMZREC
 S XMZREC=$G(^XMB(3.9,XMZ,0))
 Q:$$CLOSED^XMXSEC(XMZREC) 0
 Q:$$CONFID^XMXSEC(XMZREC) 0
 Q 1
