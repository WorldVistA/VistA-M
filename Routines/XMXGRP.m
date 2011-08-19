XMXGRP ;ISC-SF/GMB-Group creation/enrollment ;03/31/2003  13:38
 ;;8.0;MailMan;**16**;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ADDMBRS - Add new members / Edit existing members
 ; DELMBRS - Delete existing members
 ; DROP    - A user chooses to drop
 ; JOIN    - A user chooses to join
 ;
 ; DBIAs:
 ;   1544 - Use $$ISA^USRLM (Authorization/Subscription)
ADDMBRS(XMDUZ,XMGROUP,XMMBR,XMINSTR,XMTSK) ; Add users to groups, if they aren't
 ; already members.  This API handles adding local users, devices,
 ; server options, mail groups, and remote users to mail groups.
 ; It does not handle adding distribution lists or fax recipients
 ; or fax groups.
 ; 
 ; Optionally, forward existing messages which are addressed to the
 ; groups to the users, and/or add the users to the messages, so that
 ; they will receive responses.  (LOCAL USERS ONLY!)
 ; XMDUZ   - The user who is doing this.  Must be authorized to edit
 ;           the mail groups.
 ; XMGROUP - The name or IEN (or list of same) of the groups.
 ; XMMBR   - The user (or list of users) to add to the groups.
 ; XMINSTR - Special instructions
 ;     ("FLAGS") - Flags, may contain any combination of the following:
 ;                 "A" - Add users to messages, but don't forward.
 ;                       (Messages will be delivered the next time
 ;                       someone replies, and users will be able to
 ;                       Query/Search for them at any time.)
 ;                 "F" - Forward messages to users, if the users aren't
 ;                       already on the messages.
 ;                 Closed messages will be ignored.  Users will not be
 ;                 added to them.
 ; Note: If FLAGS contains only an "A", then FDATE and TDATE apply.
 ;       If FLAGS contains only an "F", then FDATE and TDATE apply.
 ;       If FLAGS contains "A" and "F", then messages from FDATE thru
 ;       TDATE will be "F"orwarded, and all other messages will have
 ;       the users "A"dded to them, without forwarding.
 ; Note: Currently, FLAGS may not contain "A".  We don't yet have a way
 ; to mark users (recipients) who have been added to a message, but will
 ; not receive them until someone replies on the message, or until the
 ; user searches for them and reads them.  This is a problem, because
 ; if someone does a QD on them, they have no idea why these recipients
 ; haven't read the message.  Perhaps we could mark them 'Parked until
 ; next reply.'  That would require a new field, and other routines would
 ; have to be aware of and handle this new field.  Until that happens,
 ; we are stripping any "A" from XMINSTR("FLAGS").
 ;     ("FDATE") - Add users to messages originating on or after this
 ;                 date.  Must be FM format.  Default is from the
 ;                 beginning of time.  Used in conjunction with FLAGS.
 ;     ("TDATE") - Add users to messages originating on or before this
 ;                 date.  Must be FM format.  Default is to the present.
 ;                 Used in conjunction with FLAGS.
 ; XMTSK           Output task number
 N XMGRP,XMTO,XMCUT
 D CHKGRPS(XMDUZ,.XMGROUP,.XMGRP) Q:'$D(XMGRP)
 D CHKMBRS(XMDUZ,.XMMBR) Q:'$D(^TMP("XMY0",$J))
 D ADD2GRPS(.XMGRP,.XMTO,.XMINSTR)
 Q:'$D(XMTO)  ; Quit if no local users added to groups.
 Q:'$D(XMINSTR("FLAGS"))
 I $G(XMINSTR("FDATE"),$O(^XMB(3.9,"C",2500000)))>$G(XMINSTR("TDATE"),DT) Q  ; Quit if 'from' date is greater than 'to' date.
 S XMCUT=$P(^XMB(3.7,XMDUZ,0),U,7)
 I XMCUT>$G(XMINSTR("FDATE")) D
 . S XMINSTR("FDATE")=XMCUT
 . D ERRSET^XMXUTIL(37100,$$FMTE^XLFDT(XMCUT,5))
 . ; You may not access any message prior to |1| unless someone forwards
 . ; it to you.
 D FAFMSGS^XMXGRP1(XMDUZ,.XMGRP,.XMTO,.XMINSTR,.XMTSK)
 Q
CHKGRPS(XMDUZ,XMGROUP,XMGRP) ;
 I $G(XMGROUP)]"",$O(XMGROUP(""))="" D  Q
 . D CHKGRP(XMDUZ,XMGROUP,.XMGRP)
 N XMI
 S XMI=""
 F  S XMI=$O(XMGROUP(XMI)) Q:XMI=""  D
 . D CHKGRP(XMDUZ,XMI,.XMGRP)
 Q
CHKGRP(XMDUZ,XMGROUP,XMGRP) ;
 N XMGNAME,XMGIEN,XMABORT
 S XMABORT=0
 D GRPOK(XMGROUP,.XMGNAME,.XMGIEN,.XMABORT) Q:XMABORT
 D AUTHOK(XMDUZ,.XMGIEN,.XMABORT) Q:XMABORT
 S XMGRP(XMGNAME)=XMGIEN
 Q
GRPOK(XMGROUP,XMGNAME,XMGIEN,XMABORT) ;
 ; make sure group name is good, translate to group ien.
 S XMGIEN=$$IEN^XMXAPIG(XMGROUP) I 'XMGIEN S XMABORT=1 Q
 S XMGNAME=$$NAME^XMXAPIG(XMGIEN)
 Q
AUTHOK(XMDUZ,XMGIEN,XMABORT) ;
 ; make sure user is authorized to add members to group.
 N XMOK
 S XMOK=0
 I $T(ISA^USRLM)'="" S XMOK=$$ISA^USRLM(DUZ,"CLINICAL COORDINATOR") ; CAC?
 I $D(^XUSEC("XMMGR",DUZ))!$D(^XUSEC("XM GROUP EDIT MASTER",DUZ))!XMOK I $S($P(^XMB(3.8,XMGIEN,0),U,2)="PU":1,'$P(^(0),U,6):1,1:0) Q  ; If holds proper key, then group must be public or (private and) unrestricted.
 I $D(^XMB(3.8,"AC",XMDUZ,XMGIEN)) Q  ; User is coordinator
 I $P($G(^XMB(3.8,XMGIEN,3)),U,1)=XMDUZ Q  ; User is organizer
 S XMABORT=1
 N XMP
 S XMP("PARAM","ID")="XMGROUP"
 S XMP("PARAM","VALUE")=$$NAME^XMXAPIG(XMGIEN)
 ; You are not authorized to edit this mail group
 D ERRSET^XMXUTIL(38200,.XMP)
 Q
CHKMBRS(XMDUZ,XMMBR) ; Check the users to add.
 N XMINSTR
 D INIT^XMXADDR
 S XMINSTR("ADDR FLAGS")="XY" ; Create only the ^TMP("XMY0") global.
 D CHKADDR^XMXADDR(XMDUZ,.XMMBR,.XMINSTR)
 Q:$D(^TMP("XMY0",$J))
 D CLEANUP^XMXADDR
 Q
ADD2GRPS(XMGRP,XMTO,XMINSTR) ; See if members already in the groups.
 ; If not, add them
 ; >> Question: May a broadcast or limited broadcast be added to a group?
 N XMGN,XMGI,XMM,XMTRKNEW
 S (XMGN,XMM)=""
 F  S XMGN=$O(XMGRP(XMGN)) Q:XMGN=""  S XMGI=XMGRP(XMGN) D
 . N XMNEWMBR
 . F  S XMM=$O(^TMP("XMY0",$J,XMM)) Q:XMM=""  D
 . . D AM(XMGI,XMM,^TMP("XMY0",$J,XMM),$G(^(XMM,1),"@"),.XMTO,.XMINSTR)
 ; If we added a member group, shouldn't we also forward the msgs to
 ; local members of the group, too?
 D CLEANUP^XMXADDR
 Q
AM(XMG,XMM,XMMIEN,XMTYPE,XMTO,XMINSTR) ; Add/edit a member (not delete)
 N XMFDA,XMIEN,XMMULT,XMABORT
 S XMABORT=0
 D AMINIT(XMG,.XMM,XMMIEN,.XMMULT,.XMABORT) Q:$G(XMABORT)
 S XMFDA(XMMULT,"?+1,"_XMG_",",.01)=XMM
 S XMFDA(XMMULT,"?+1,"_XMG_",",1)=XMTYPE
 I "AF"[$G(XMINSTR("FLAGS"),U),XMMULT=3.81 S XMTO($S(XMTYPE?1U:XMTYPE_":",1:"")_XMM)=""
 D UPDATE^DIE("","XMFDA","XMIEN")
 ;I XMIEN(1,0)="+" S XMCNT=$G(XMCNT)+1
 ; Need to create array showing which were added and which were edited.
 ; Counts for each.
 Q
AMINIT(XMG,XMM,XMMIEN,XMMULT,XMABORT) ;
 I XMM["@" S XMMULT=3.812 Q  ; Remote member
 I ".D.H.S."[("."_$E(XMM,1,2)) D  Q
 . S XMMULT=3.812 ; Remote member
 . S XMM=XMM_"@"_^XMB("NETNAME")
 I $E(XMM,1,2)="G." D  Q
 . I XMMIEN=XMG D  Q
 . . S XMABORT=1
 . . ; Group cannot be a member of itself.
 . S XMM=XMMIEN
 . S XMMULT=3.811 ; Group member
 S XMM=XMMIEN
 S XMMULT=3.81 ; Local member
 Q
JOIN(XMDUZ,XMGROUP,XMINSTR,XMTSK) ; User chooses to join a group.
 ; XMGROUP - The name (or IEN) of the group. (Just one group!)
 ; XMINSTR - Special instructions.  See ADDMBR, above
 ;           Also, if XMINSTR("FLAGS")["F", may specify:
 ;     ("SELF BSKT") - direct forwarded messages to a specific basket.
 N XMABORT,XMGNAME,XMGIEN,XMTYPE,XMSELF,XMMBR
 S XMABORT=0
 D GRPOK(XMGROUP,.XMGNAME,.XMGIEN,.XMABORT) Q:XMABORT
 D GRPINFO(XMDUZ,XMGIEN,.XMTYPE,.XMSELF,.XMMBR,.XMABORT) Q:XMABORT
 I 'XMMBR D  Q:XMABORT
 . I 'XMSELF D  Q
 . . S XMABORT=1
 . . N XMP
 . . S XMP("PARAM","ID")="XMGROUP"
 . . S XMP("PARAM","VALUE")=XMGNAME
 . . D ERRSET^XMXUTIL(38022,.XMP) ; Self enrollment not allowed.
 . N XMFDA ; Add user to group.
 . S XMFDA(3.81,"?+1,"_XMGIEN_",",.01)=XMDUZ
 . D UPDATE^DIE("","XMFDA")
 Q:'$D(XMINSTR("FLAGS"))
 D FAFMSGS^XMXGRP1(XMDUZ,XMGNAME,XMDUZ,.XMINSTR,.XMTSK)
 Q
DROP(XMDUZ,XMGROUP) ; User chooses to drop from a group.
 ; XMGROUP - The name (or IEN) of the group.
 N XMABORT,XMGNAME,XMGIEN,XMTYPE,XMSELF,XMMBR
 S XMABORT=0
 D GRPOK(XMGROUP,.XMGNAME,.XMGIEN,.XMABORT) Q:XMABORT
 D GRPINFO(XMDUZ,XMGIEN,.XMTYPE,.XMSELF,.XMMBR,.XMABORT) Q:XMABORT
 I XMMBR D
 . I 'XMSELF,'$P($G(^XMB(1,1,2)),U,2) D  Q
 . . S XMABORT=1
 . . N XMP
 . . S XMP("PARAM","ID")="XMGROUP"
 . . S XMP("PARAM","VALUE")=XMGNAME
 . . D ERRSET^XMXUTIL(38022.1,.XMP) ; Self dis-enrollment not allowed.
 . N DIR,X,Y,DA,DIK ; Drop user from group.
 . S DA(1)=XMGIEN,DA=XMMBR,DIK="^XMB(3.8,"_XMGIEN_",1,"
 . D ^DIK
 Q
GRPINFO(XMDUZ,XMGIEN,XMTYPE,XMSELF,XMMBR,XMABORT) ;
 N XMREC
 S XMMBR=+$O(^XMB(3.8,XMGIEN,1,"B",XMDUZ,0)) ; Is user a member?
 S XMREC=^XMB(3.8,XMGIEN,0)
 S XMSELF=($P(XMREC,U,3)="y") ; Self enrollment allowed?
 S XMTYPE=$P(XMREC,U,2) ; Public or Private?
 I XMTYPE="PU"
 E  I XMTYPE="PR" D
 . Q:XMMBR
 . S XMABORT=1
 . N XMP
 . S XMP("PARAM","ID")="XMGROUP"
 . S XMP("PARAM","VALUE")=$P(XMREC,U,1)
 . D ERRSET^XMXUTIL(38201) ; Group is private.
 ;E  D
 ;. S XMABORT=1
 ;. D ERRSET^XMXUTIL() ; Group must be designated as PUBLIC or PRIVATE.
 Q
ADD2GRPZ(XMGRP,XMMBR,XMTO) ; See if members already in the groups.
 ; If not, add them
 N XMGN,XMGI,XMM,XMTRKNEW
 S (XMGN,XMM)="",XMTRKNEW=1
 F  S XMGN=$O(XMGRP(XMGN)) Q:XMGN=""  S XMGI=XMGRP(XMGN) D
 . N XMNEWMBR
 . F  S XMM=$O(XMMBR(XMM)) Q:XMM=""  D
 . . D AMZ(XMGI,XMMBR(XMM),$G(XMMBR(XMM,1),"@"),.XMTO)
 . I $G(XMNEWMBR) D NOTIFY^XMXGRP1(XMGI,.XMNEWMBR)
 Q
AMZ(XMG,XMM,XMTYPE,XMTO) ; Add/edit a member (not delete)
 N XMFDA,XMIEN
 S XMFDA(3.81,"?+1,"_XMG_",",.01)=XMM
 S XMFDA(3.81,"?+1,"_XMG_",",1)=XMTYPE
 S XMTO($S(XMTYPE?1U:XMTYPE_":",1:"")_XMM)=""
 D UPDATE^DIE("","XMFDA","XMIEN")
 ;I XMIEN(1,0)="+" S XMCNT=$G(XMCNT)+1
 ; Need to create array showing which were added and which were edited.
 ; Counts for each.
 Q
