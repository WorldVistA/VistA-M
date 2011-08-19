XMXADDRG ;ISC-SF/GMB-Expand group ;04/15/2003  13:05
 ;;8.0;MailMan;**18**;Jun 28, 2002
 ; Replaces ^XMA21G (ISC-WASH/CAP)
EXPAND(XMDUZ,XMADDR,XMSTRIKE,XMPREFIX,XMLATER,XMFULL,XMG) ;
 ; XMG      IEN of group in ^XMB(3.8)
 ; XMGN     Name of group
 ; XMGPRIV  Restrictions on use of group
 ; XMGMREC  Group member's ^XMB(3.7,x,0 record
 ; XMGCIRCL Array used to guard against circular references
 N XMGREC,XMGN,XMGPRIV,XMSCREEN,XMGCIRCL,XMIASAVE,XMGMBRS
 I $D(XMRESTR("NOFPG")) D  Q  ;Must be sender or hold XM GROUP PRIORITY
 . ;key to forward priority mail to groups.
 . D SETERR^XMXADDR4($G(XMIA),"!",39130)
 S XMADDR=$E(XMADDR,3,999)
 ; Screen:  Group is public OR user is organizer
 ;          OR group is unrestricted and user is member
 S XMSCREEN="N XMR S XMR=^(0) I $S($P(XMR,U,2)=""PU"":1,$P($G(^XMB(3.8,+Y,3),.5),U)=XMDUZ:1,+$P(XMR,U,6):0,$D(^XMB(3.8,+Y,1,""B"",XMDUZ)):1,1:0)"
 I $G(XMIA) D  Q:$D(XMERROR)
 . N DIC,X
 . S X=XMADDR
 . S DIC("S")=XMSCREEN
 . S DIC="^XMB(3.8,"
 . S DIC(0)="MEZ"
 . D ^DIC
 . I Y<0 D SETERR^XMXADDR4(XMADDR'="?","",39002) Q  ;Not found.
 . S XMG=+Y
 . S XMGN=$P(Y,U,2)
 . S XMGREC=Y(0)
 E  D  Q:$D(XMERROR)
 . S XMG=$$FIND1^DIC(3.8,"","MO",XMADDR,"",XMSCREEN) I 'XMG D SETERR^XMXADDR4(0,"",$S($D(DIERR):39131,1:39132)) Q  ; Mail group ambiguous. / Mail group not found.
 . S XMGREC=^XMB(3.8,XMG,0)
 . S XMGN=$P(XMGREC,U)
 I $D(^XMB(3.8,XMG,4,"B")),'$D(^("B",XMDUZ))!$D(XMRESTR("NET RECEIVE")) D  Q
 . ; If the group has authorized senders, then the sender must be local.
 . ; Incoming network mail may not address such a group.
 . D SETERR^XMXADDR4(0,"",39133) ;Sender not authorized to group.
 . Q:'$G(XMIA)
 . N XMABORT,XMTEXT
 . S XMABORT=0
 . W @IOF
 . ;You may not send mail directly to this group.
 . ;You must send it to an authorized sender for the group.
 . D BLD^DIALOG(39134,"","","XMTEXT","F")
 . D MSG^DIALOG("WE","","","","XMTEXT")
 . D AUTHSEND^XMHIG(XMG,XMABORT)
 S XMGPRIV=$P(XMGREC,U,6)
 S XMFULL="G."_XMGN_$S($G(XMINSTR("ADDR FLAGS"))["Y":"",XMGPRIV:$$EZBLD^DIALOG(39135),1:"") ;[Private Mail Group]
 I $G(XMINSTR("ADDR FLAGS"))["X" Q
 I XMSTRIKE Q:$D(^TMP("XMY0",$J,XMFULL,"L"))  W:$G(XMIA) $$EZBLD^DIALOG(39136) ;Deleting Members ...
 I $G(XMIA),'XMSTRIKE D  Q:$D(XMERROR)
 . I XMLATER="",$G(XMBIGGRP),$$BIG(XMG) D LATERIT(XMFULL,.XMLATER)
 . I XMLATER="?" D QLATER^XMXADDR(XMFULL,.XMLATER)
 I XMLATER,'$G(XMIA) Q
 I $D(XMIA) S XMIASAVE=XMIA
 I $D(^TMP("XM",$J,"GRPERR")) K ^TMP("XM",$J,"GRPERR")
 D EXPGROUP(XMDUZ,XMG,XMGREC,XMSTRIKE,XMPREFIX,XMLATER,.XMGCIRCL)
 I '$G(XMGMBRS),'XMLATER D
 . D SETERR^XMXADDR4($G(XMIA),"",39137) ;Mail group has no members
 I $D(^TMP("XM",$J,"GRPERR")) D
 . D GRPERR^XMXADDR4(XMDUZ,XMG,XMGN)
 . K ^TMP("XM",$J,"GRPERR")
 K XMIA
 I $D(XMIASAVE) S XMIA=XMIASAVE
 Q
BIG(XMIEN) ; Function returns 1 if big group, 0 if not
 Q:$D(^XMB(3.8,XMIEN,5,"B")) 1  ; has member groups
 Q:$D(^XMB(3.8,XMIEN,7,"B")) 1  ; has distribution list
 ;Q:$D(^XMB(3.8,XMIEN,9,"B")) 1  ; has fax groups
 N XMCNT,XMNODE
 S XMCNT=0
 F XMNODE=1,6,8 D  ; local, remote, & fax members
 . Q:'$D(^XMB(3.8,XMIEN,XMNODE,0))
 . S XMCNT=XMCNT+$P($G(^XMB(3.8,XMIEN,XMNODE,0)),U,4)
 Q XMCNT'<XMBIGGRP
LATERIT(XMFULL,XMLATER) ;
 N DIR,X,Y,DIRUT
 ;This group seems to be fairly big.  If you don't need to 'minus'
 ;anyone from it, then you can save some time by queuing it for 'Later'
 ;delivery.  Would you like to queue this group for later delivery
 D BLD^DIALOG(39138,"","","DIR(""A"")")
 S DIR(0)="Y"
 S DIR("B")=$$EZBLD^DIALOG(39053) ;No
 ;Answer NO if
 ; - You need to delete any group members from the message.
 ;Answer YES if
 ; - You don't need to delete any group members from the message
 ; - and you'd like to save a bit of time.
 D BLD^DIALOG(39139,"","","DIR(""?"")")
 D ^DIR I $D(DIRUT) D  Q
 . D SETERR^XMXADDR4(0,"",37002) ;up-arrow or time out.
 . D EN^DDIOL(XMFULL_$$EZBLD^DIALOG(39015)) ;removed from recipient list.
 Q:'Y
 S XMLATER="?"
 Q
EXPGROUP(XMDUZ,XMG,XMGREC,XMSTRIKE,XMPREFIX,XMLATER,XMGCIRCL) ;
 ;Q:'$$AUTHGRP(XMDUZ,XMG,XMGREC)
 S XMGCIRCL(XMG)=""
 S $P(^XMB(3.8,XMG,0),U,4,5)=$P(XMGREC,U,4)+1_U_DT ; # references to group^date last ref'd
 I $G(XMIA) D
 . W !
 . D DISPCNT(XMG,1,39141) ;Local
 . D DISPCNT(XMG,5,39142) ;Member Group(s)
 . D DISPCNT(XMG,6,39143) ;Remote
 . D DISPCNT(XMG,7,39144) ;Distribution List(s)
 . D DISPCNT(XMG,8,39145) ;Fax Recipient(s)
 . D DISPCNT(XMG,9,39146) ;Fax Group(s)
 . I $X>1 W ":",!
 D INDIV(XMDUZ,XMG,XMSTRIKE,XMPREFIX,XMLATER) I XMLATER,'$G(XMIA) K XMGCIRCL(XMG) Q
 D GROUP(XMDUZ,XMG,XMSTRIKE,XMPREFIX,XMLATER,.XMGCIRCL) I XMLATER,'$G(XMIA) K XMGCIRCL(XMG) Q
 D REMOTE(XMDUZ,XMG,XMSTRIKE,XMPREFIX,XMLATER) I XMLATER,'$G(XMIA) K XMGCIRCL(XMG) Q
 D DISTR^XMXADDR4(XMDUZ,XMG,XMSTRIKE,XMPREFIX,XMLATER) I XMLATER,'$G(XMIA) K XMGCIRCL(XMG) Q
 I $P(^XMB(1,1,0),U,19) D FAXGROUP^XMXADDR4(XMDUZ,XMG,XMSTRIKE,XMPREFIX,XMLATER) I XMLATER,'$G(XMIA) K XMGCIRCL(XMG) Q
 I $P(^XMB(1,1,0),U,19) D FAXINDIV^XMXADDR4(XMDUZ,XMG,XMSTRIKE,XMPREFIX,XMLATER) I XMLATER,'$G(XMIA) K XMGCIRCL(XMG) Q
 K XMGCIRCL(XMG)
 Q
DISPCNT(XMIEN,XMNODE,XMDESCR) ;
 N XMCNT
 S XMDESCR=$$EZBLD^DIALOG(XMDESCR)
 S XMCNT=$P($G(^XMB(3.8,XMIEN,XMNODE,0)),U,4) Q:'XMCNT
 I $X+3+$L(XMCNT)+$L(XMDESCR)>IOM W ",",!
 E  W:$X>4 ", "
 W XMCNT," ",XMDESCR
 Q
AUTHGRP(XMDUZ,XMG,XMGREC) ;
 ; Screen:  Group is public OR user is owner
 ;          OR group is unrestricted and user is member
 N XMOWNER
 I $P(XMGREC,U,2)="PU" Q 1  ; Group is public
 S XMOWNER=$P(^XMB(3.8,XMG,3),U,1) S:XMOWNER="" XMOWNER=.5
 I XMDUZ=XMOWNER Q 1  ; User is owner of group
 I +$P(XMGREC,U,6)=0,$D(^XMB(3.8,XMG,1,"B",XMDUZ)) Q 1  ; Group is unrestricted and user is a member
 D SETERR^XMXADDR4($G(XMIA),"!",39147,$P(XMGREC,U,1))
 Q 0  ;You may not access group '|1|'.
INDIV(XMDUZ,XMG,XMSTRIKE,XMPREFIX,XMLATER) ;
 ; XMGM     Group member
 N XMI,XMGM,XMCNT,XMREC,XMTYPE
 S XMI=0,XMCNT=0
 F  S XMI=$O(^XMB(3.8,XMG,1,XMI)) Q:'XMI  S XMREC=^(XMI,0) D  I XMLATER,'$G(XMIA) Q
 . S XMGM=$P(XMREC,U,1),XMTYPE=$P(XMREC,U,2)
 . ; If SHARED,MAIL or no mailbox, then delete from group.
 . I XMGM=.6!'$D(^XMB(3.7,XMGM))!'$D(^VA(200,XMGM,0)) D DELETE2^XMXADDR4(XMG,1,XMI) Q
 . N XMFULL,XMERROR,XMFWDADD
 . D PERSON^XMXADDR1(XMDUZ,XMGM,"","","","",.XMFULL)
 . I $D(XMERROR) D  Q
 . . ; Commenting out because I'm not sure it should be reported.
 . . ;S XMFULL=$P($G(^VA(200,XMGM,0)),U,1)
 . . ;I XMFULL="" S XMFULL="USER #"_XMGM
 . . ;S ^TMP("XM",$J,"GRPERR",XMG,"L",XMFULL)=XMERROR
 . S XMGMBRS=1
 . I 'XMLATER D INDIV^XMXADDR(XMDUZ,XMGM,XMSTRIKE,$S(XMPREFIX'="":XMPREFIX,1:XMTYPE),XMLATER)
 . Q:'$G(XMIA)
 . I XMCNT,XMCNT#16=0 D  Q:'$G(XMIA)
 . . N DIR,Y
 . . S DIR("A")=$$EZBLD^DIALOG(39148) ;Do you want to see more members
 . . S DIR(0)="Y",DIR("B")=$$EZBLD^DIALOG(39053) ;No
 . . D ^DIR
 . . S XMIA=+Y  ; The '+' takes care of $D(DIRUT)
 . S XMCNT=XMCNT+1
 . W:XMCNT#4-1=0 !
 . W ?XMCNT-1#4*20,$E($S(XMPREFIX'="":XMPREFIX_":",XMTYPE="":"",1:XMTYPE_":")_XMFULL,1,19)
 Q
GROUP(XMDUZ,XMG,XMSTRIKE,XMPREFIX,XMLATER,XMGCIRCL) ;
 N XMIEN,XMI,XMREC,XMTYPE
 S XMI=0
 F  S XMI=$O(^XMB(3.8,XMG,5,XMI)) Q:'XMI  S XMREC=^(XMI,0) D  I XMLATER,'$G(XMIA) Q
 . S XMIEN=$P(XMREC,U,1),XMTYPE=$P(XMREC,U,2)
 . I '$D(^XMB(3.8,XMIEN,0)) D DELETE2^XMXADDR4(XMG,5,XMI) Q
 . S XMREC=^XMB(3.8,XMIEN,0)
 . W:$G(XMIA) !,$S(XMPREFIX'="":"",XMTYPE="":"",1:XMTYPE_":"),"G.",$P(XMREC,U,1),":"
 . I $D(XMGCIRCL(XMIEN)) D  Q
 . . ; Circular (infinite loop) reference!  Don't go there!
 . . S ^TMP("XM",$J,"GRPERR",XMG,"C",$P(XMREC,U,1))="" Q
 . . Q:'$G(XMIASAVE)
 . . N XMTEXT
 . . ;Mail group contains circular reference to G.|1|.
 . . ;Circular reference ignored.
 . . ;This circular reference should be investigated and eliminated.
 . . D BLD^DIALOG(39140,$P(XMGREC,U,1),"","XMTEXT","F")
 . . D MSG^DIALOG("WE","","","","XMTEXT")
 . D EXPGROUP(XMDUZ,XMIEN,XMREC,XMSTRIKE,$S(XMPREFIX'="":XMPREFIX,1:XMTYPE),XMLATER,.XMGCIRCL)
 . W:$G(XMIA) !,$$EZBLD^DIALOG(39149,$P(XMREC,U,1)) ;Finished with group |1|.
 Q
REMOTE(XMDUZ,XMG,XMSTRIKE,XMPREFIX,XMLATER) ;
 N XMGM,XMI
 S XMI=0
 F  S XMI=$O(^XMB(3.8,XMG,6,XMI)) Q:XMI'>0  D  I XMLATER,'$G(XMIA) Q
 . S XMGM=$P(^XMB(3.8,XMG,6,XMI,0),U)
 . Q:XMGM=""  ; Really should delete it from the remotes.
 . W:$G(XMIA) !,XMGM
 . Q:XMLATER
 . D DOREMOTE(XMDUZ,XMGM,XMSTRIKE,XMPREFIX,XMLATER)
 Q
DOREMOTE(XMDUZ,XMGM,XMSTRIKE,XMPREFIX,XMLATER) ;
 N XMERROR,XMFWDADD
 I XMGM[":" D  Q:$D(XMERROR)
 . I XMPREFIX="" D
 . . D PREFIX^XMXADDR(.XMGM,.XMPREFIX)
 . E  D
 . . D PREFIX^XMXADDR(.XMGM)
 . I $D(XMERROR) S ^TMP("XM",$J,"GRPERR",XMG,"R",XMGM)=$$GETERR^XMXADDR4
 D REMOTE^XMXADDR3(XMDUZ,XMGM,XMSTRIKE,XMPREFIX,XMLATER)
 I '$D(XMERROR) S XMGMBRS=1 Q
 ;37000 - up-arrow out.
 ;37001 - time out.
 ;37002 - up-arrow or time out.
 ;39015.1 - Not a current recipient.
 ;39133 - Sender not authorized to group.
 I "^37000^37001^37002^39015.1^39133^"[(U_XMERROR_U) S XMGMBRS=1 Q
 S ^TMP("XM",$J,"GRPERR",XMG,"R",XMGM)=$$GETERR^XMXADDR4
 Q
