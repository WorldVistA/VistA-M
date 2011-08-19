XMVGROUP ;ISC-SF/GMB-Group creation/enrollment ;04/15/2003  12:50
 ;;8.0;MailMan;**18**;Jun 28, 2002
 ; Replaces JOIN, ENT^XMA7G & ^XMA7G1 (ISC-WASH/RJ/THM/CAP/JA)
 ; Entry points used by MailMan options (not covered by DBIA):
 ; EDITMG    XMEDITMG        - Mail Group Edit
 ; ENROLL    XMENROLL        - Enroll in / Disenroll from a group
 ; LCOORD    XMMGR-MAIL-GRP-COORDINATOR
 ; RCOORD    XMMGR-MAIL-GRP-COORD-W/REMOTES
 ; PERSONAL  XMEDITPERSGROUP - Edit user's personal group.
 ;
 ; DBIAs:
 ;   1544 - Use $$ISA^USRLM (Authorization/Subscription)
ENROLL ; Enroll in / Disenroll from a group
 N DIC,Y,XMABORT,XMIEN,XMSELF,XMIA
 S XMABORT=0
 S:'$D(XMDUZ) XMDUZ=DUZ
 S XMSELF=+$P($G(^XMB(1,1,2)),U,2) ; Is self-disenrollment allowed in a non-self enrolling mail group?
 F  D  Q:XMABORT
 . S DIC="^XMB(3.8,",DIC(0)="AEQMZ"
 . S DIC("S")="I $S($P(^(0),U,2)=""PU"":1,$D(^XMB(3.8,+Y,1,""B"",XMDUZ)):1,1:0)"
 . S DIC("W")="W:$D(^XMB(3.8,+Y,1,""B"",XMDUZ)) ?35,"""_$$EZBLD^DIALOG(38020)_""" I $P(^XMB(3.8,+Y,0),U,3)'=""y"" W ?43,"""_$$EZBLD^DIALOG(38021)_"""" ; Member / ...Self Enrollment Not Allowed.
 . W !
 . D ^DIC I Y<0 S XMABORT=1 Q
 . S XMIEN=+Y
 . I $D(^XMB(3.8,XMIEN,1,"B",XMDUZ)) D  Q
 . . I $P(^XMB(3.8,XMIEN,0),U,3)'="y",'XMSELF W !,$$EZBLD^DIALOG(38022.1) Q  ;Self enrollment is not allowed for this mail group.
 . . D DROP(XMIEN,XMDUZ)
 . I $P(^XMB(3.8,XMIEN,0),U,3)'="y" W !,$$EZBLD^DIALOG(38022) Q  ;Self enrollment is not allowed for this mail group.
 . D JOIN(XMIEN,XMDUZ)
 Q
JOIN(XMIEN,XMDUZ) ; Enroll in a group
 N XMFDA
 S XMFDA(3.81,"+1,"_XMIEN_",",.01)=XMDUZ
 D UPDATE^DIE("","XMFDA")
 W !,$$EZBLD^DIALOG(38023) ;You are now a member.
 N DIR,X,Y
 S DIR(0)="Y"
 ; Do you want past messages to this group to be forwarded to you?
 D BLD^DIALOG(38023.1,"","","DIR(""A"")")
 S DIR("B")=$$EZBLD^DIALOG(39053) ; no
 D BLD^DIALOG(38232,"","","DIR(""?"")")
 ;Answer YES to forward past mail group messages.
 ;You will be asked for a time frame to search,
 ;and then MailMan will create a task to find and forward
 ;existing mail group messages.
 D ^DIR Q:$D(DIRUT)!'Y
 N XMINSTR,XMTSK,XMABORT
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV D INITAPI^XMVVITAE
 S XMABORT=0,XMINSTR("FLAGS")="F"
 D FWDBSKT(XMDUZ,.XMINSTR,.XMABORT) Q:XMABORT
 D FWDDATES^XMVGRP(XMDUZ,.XMINSTR,.XMABORT) Q:XMABORT
 D FAFMSGS^XMXGRP1(XMDUZ,$P($G(^XMB(3.8,XMIEN,0)),U,1),XMDUZ,.XMINSTR,.XMTSK)
 D FWDTSK(XMTSK)
 Q
FWDBSKT(XMDUZ,XMINSTR,XMABORT) ; Select basket to forward to
 N XMDIC,XMK
 S XMDIC("B")=$$EZBLD^DIALOG(37005) ;IN
 D SELBSKT^XMJBU(XMDUZ,39022,"L",.XMDIC,.XMK) I XMK=U S XMABORT=1 Q
 S XMINSTR("SELF BSKT")=XMK
 Q
FWDTSK(XMTSK) ;
 W !
 ;Task #|1| will find and forward past messages.
 N XMTEXT
 D BLD^DIALOG(38023.9,XMTSK,"","XMTEXT","F")
 D MSG^DIALOG("WM","",IOM,"","XMTEXT")
 Q
DROP(XMIEN,XMDUZ) ; Disenroll from a group
 N DIR,X,Y
 S DIR(0)="Y"
 I $P(^XMB(3.8,XMIEN,0),U,3)'="y" D
 . ;You're a member. Self enrollment is not allowed for this mail group.
 . ;If you drop out, you will not be able to re-join. (To re-join later,
 . ;you will have to ask the group coordinator to re-enroll you.)
 . ;You are a member.  Do you want to drop out
 . D BLD^DIALOG(38024.1,"","","DIR(""A"")")
 E  D  ;You are a member.  Do you want to drop out
 . S DIR("A")=$$EZBLD^DIALOG(38024)
 S DIR("B")=$$EZBLD^DIALOG(39053) ;No
 ;Enter YES to remove yourself from the group; NO to remain a member.
 D BLD^DIALOG(38025,"","","DIR(""?"")")
 D ^DIR Q:$D(DIRUT)!'Y
 K DIR,X,Y
 N DA,DIK
 S DA(1)=XMIEN,DA=$O(^XMB(3.8,XMIEN,1,"B",XMDUZ,0)),DIK="^XMB(3.8,"_XMIEN_",1,"
 D ^DIK
 W !,$$EZBLD^DIALOG(38026) ;You are no longer a member.
 Q
PERSONAL ; Enter/Edit Personal Group
 ; See entry EDIT for info on XMIA & XMTRKNEW
 N DIC,DLAYGO,X,Y,XMABORT,XMIA,XMTRKNEW
 S XMABORT=0,(XMIA,XMTRKNEW)=1
 S DIC="^XMB(3.8,",DIC(0)="AEQMZL",DLAYGO=3.8
 ; Group is private, and user is organizer
 S DIC("S")="I $P(^(0),U,2)=""PR"",$P($G(^XMB(3.8,+Y,3)),U)=$G(XMDUZ,DUZ)"
 F  D  Q:XMABORT
 . W !
 . D ^DIC I Y<0 S XMABORT=1 Q
 . N XMDR,XMNEW
 . S XMNEW=$P(Y,U,3)
 . S:XMNEW XMDR="4////PR;5////"_$G(XMDUZ,DUZ)_";10////1;"
 . S XMDR=$G(XMDR)_".01T;2;3" ; name, members, description
 . S XMDR=XMDR_";10;12" ; restrictions, remote members
 . D EDIT(+Y,XMDR,XMNEW)
 Q
EDIT(XMG,DR,XMNEW) ; Edit mail group
 ; XMIA is used for interaction on the REMOTE MEMBER input transform
 ; to facilitate lookup.  XMTRKNEW is used by the AC xref on the
 ; .01 field of the LOCAL MEMBER multiple.  If local members are added
 ; to the group, XMNEWMBR is set by the AC xref.
 N DIE,DIDEL,Y,DIC,DA,XMNEWMBR
 S (DIDEL,DIE)=3.8,DA=XMG
 S:$P(^XMB(1,1,0),U,19) DR=DR_";14;15" ; fax recipients, fax groups
 D ^DIE
 I 'XMNEW,$D(XMNEWMBR) D FWD(XMG,.XMNEWMBR)
 Q
FWD(XMG,XMTO) ; Forward past mail group messages to new local members
 N XMI
 S XMI=""
 F  S XMI=$O(XMTO(XMI)) Q:'XMI  K:'$D(^XMB(3.8,XMG,1,"B",XMI)) XMTO(XMI)
 Q:'$D(XMTO)
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV D INITAPI^XMVVITAE
 D NOTIFY^XMXGRP1(XMG,.XMTO)
 N XMINSTR,XMTSK,XMABORT
 S XMABORT=0
 D ENFWD^XMVGRP(XMDUZ,.XMINSTR,.XMABORT) Q:XMABORT
 D FAFMSGS^XMXGRP1(XMDUZ,$P(^XMB(3.8,XMG,0),U,1),.XMTO,.XMINSTR,.XMTSK)
 D FWDTSK(XMTSK)
 Q
LAYGO(X) ; Prevent someone from adding a (private) group with the same name as a public one.
 ; This function is invoked by the LAYGO field of ^XMB(3.8,.01)
 ; Returns 1 if group X may be created; 0 if not.
 N IEN,LAYGO
 S IEN="",LAYGO=1
 F  S IEN=$O(^XMB(3.8,"B",X,IEN)) Q:IEN=""  D  Q:'LAYGO
 . Q:$P(^XMB(3.8,IEN,0),U,2)="PR"
 . S LAYGO=0 ;Can't add it because public group '|1|' already exists.
 . D EN^DDIOL($$EZBLD^DIALOG(38027,X),"","!,$C(7)")
 Q LAYGO
REMOTE(XMADDR,XMIA) ; Serves as input transform for 'remote member'
 ; Allow remote addressees or local devices or local servers
 N XMERROR,XMRESTR,XMINSTR,XMFULL,XMPREFIX,DIX,DO,XMFWDADD
 S XMINSTR("ADDR FLAGS")="X" ; do not create ^TMP(, just check.
 I XMADDR[":" D  Q:'$D(XMADDR)
 . D RTYPE^XMXADDR($P(XMADDR,":")) I $D(XMERROR) K XMADDR Q
 . D PREFIX^XMXADDR(.XMADDR,.XMPREFIX) I $D(XMERROR) K XMADDR Q
 I XMADDR'["@",".D.d.H.h.S.s."'[("."_$E(XMADDR,1,2)),'$D(XMPREFIX) K XMADDR Q
 D ADDRESS^XMXADDR(DUZ,XMADDR,.XMFULL,.XMERROR)
 I $D(XMERROR) K XMADDR Q
 I XMFULL'["@" D
 . I ".D.H.S."[("."_$E(XMFULL,1,2)) S XMFULL=XMFULL_"@"_^XMB("NETNAME") Q
 . ;I $G(XMPREFIX)'="" S XMFULL=XMFULL_"@"_^XMB("NETNAME") Q
 I XMFULL'["@" D  Q
 . K XMADDR
 . D EN^DDIOL($$EZBLD^DIALOG(38028)) ;It can't be a local address, except for Device or Server.
 . I $E(XMFULL,1,2)="G." D EN^DDIOL($$EZBLD^DIALOG(38029)) ;Put the group in the MEMBER GROUP multiple.
 . E  D EN^DDIOL($$EZBLD^DIALOG(38030)) ;Put the person in the MEMBER multiple.
 . I $G(XMPREFIX)'="" D EN^DDIOL($$EZBLD^DIALOG(38031,XMPREFIX)) ;Put '|1|' in the TYPE field.
 I $G(XMPREFIX)'="" S XMFULL=XMPREFIX_":"_XMFULL
 S XMADDR=XMFULL
 Q
EDITMG ; Mail Group Edit
 ; See entry EDIT for info on XMIA & XMTRKNEW
 N DIC,XMABORT,DLAYGO,X,Y,XMIA,XMTRKNEW,XMREC
 S XMABORT=0,(XMIA,XMTRKNEW)=1,DLAYGO=3.8
 S DIC(0)="AEQLM",DIC="^XMB(3.8,"
 S DIC("S")=$$GRPSCR(0)
 F  D  Q:XMABORT
 . W !
 . D ^DIC I Y<0 S XMABORT=1 Q
 . N XMDR
 . S XMDR=".01T;2;3" ; name, members, description
 . ; type - if type is public, ask about self enrollment,
 . ;        else ask about restrictions.
 . S XMDR=XMDR_";4;I X=""PU"" S Y=7;10;S Y=5;7"
 . S XMDR=XMDR_";5:6.9" ; organizer, coordinator, authorized senders
 . S XMDR=XMDR_";10.1:13.9" ; member groups, remote members, distr list
 . D EDIT(+Y,XMDR,$P(Y,U,3))
 Q
GRPSCR(XMCOORD) ; Who may edit a mail group?
 N XMSCR,XMOK
 S XMOK=0
 I $T(ISA^USRLM)'="" S XMOK=$$ISA^USRLM(DUZ,"CLINICAL COORDINATOR")
 I $D(^XUSEC("XMMGR",DUZ))!$D(^XUSEC("XM GROUP EDIT MASTER",DUZ))!XMOK D
 . ; Screen whether group is public or (private and) unrestricted
 . S XMSCR="N XMREC S XMREC=^(0) I $P(XMREC,U,2)=""PU""!'$P(XMREC,U,6)!"
 E  S XMSCR="I " ; Or, at the very minimum,
 ; Screen whether user is organizer or coordinator.
 Q XMSCR_"($P($G(^XMB(3.8,+Y,3)),U,1)=$G(XMDUZ,DUZ))"_$S($G(XMCOORD):"!$D(^XMB(3.8,""AC"",$G(XMDUZ,DUZ),+Y))",1:"")
 ;
LCOORD ; Mail Group Coordinator edit w/o remote members
 D COORD(0)
 Q
RCOORD ; Mail Group Coordinator edit w/remote members
 D COORD(1)
 Q
COORD(XMREMOTE) ;
 ; See entry EDIT for info on XMIA & XMTRKNEW
 N DIC,XMABORT,DLAYGO,X,Y,XMIA,XMTRKNEW
 S XMABORT=0,(XMIA,XMTRKNEW)=1
 S DIC(0)="AEQM",DIC="^XMB(3.8,"
 S DIC("S")=$$GRPSCR(1)
 F  D  Q:XMABORT
 . W !
 . D ^DIC I Y<0 S XMABORT=1 Q
 . ; edit local members, member groups, & perhaps, remote members
 . D EDIT(+Y,"2;11"_$S(XMREMOTE:";12",1:""),0)
 Q
