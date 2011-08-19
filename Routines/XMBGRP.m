XMBGRP ;ISC-SF/GMB-Mail Group APIs ;04/17/2002  07:44
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/JL,CAP
 ;
 ; Entry points (DBIA 1146):
 ; $$DM  Delete local members from a mail group.
 ; $$MG  Create a mail group or add members to an existing mail group.
MG(XMGROUP,XMTYPE,XMORG,XMSELF,XMY,XMDESC,XMQUIET) ; Create group or add members to existing group
 ;Example:
 ;S X=$$MG^XMBGRP(XMGROUP,XMTYPE,XMORG,XMSELF,.XMY,.XMDESC,XMQUIET)
 ;
 ;XMGROUP  =group name if creating a new group;
 ;         =group name or pointer to ^XMB(3.8,
 ;         if adding members to an existing group.
 ;XMTYPE   type of group - used only for creation
 ;         0=public (default)
 ;         1=private
 ;XMORG    group organizer - used only for creation
 ;         pointer to ^VA(200, (default=DUZ)
 ;XMSELF   allow self enrollment - used only for creation
 ;         0=no
 ;         1=yes (default)
 ;XMY      local group members (Array - Pass by reference)
 ;         XMY(member DUZ)=""
 ;XMDESC   description (Array - Pass by reference)
 ;         - used only for creation
 ;         Must be appropriate for FM word processing field.
 ;XMQUIET  silent flag
 ;         0=interactive
 ;         1=silent (default)
 N XMABORT,XMGIEN,XMGNAME
 S XMABORT=0
 D MGINIT(XMGROUP,.XMGIEN,.XMGNAME,.XMTYPE,.XMORG,.XMSELF,.XMY,.XMDESC,.XMQUIET,.XMABORT)
 I XMABORT K XMY Q 0
 I '$D(XMGIEN) D
 . D CREATE(XMGNAME,.XMGIEN,XMTYPE,XMORG,XMSELF,.XMDESC,XMQUIET,.XMABORT)  Q:XMABORT
 . Q:'$O(XMY(""))
 . D ADD(XMGIEN,.XMY,.XMABORT) Q:XMABORT
 . D NOTIFY("Members have been added to the "_XMGNAME_" Mail Group.",XMQUIET)
 E  D
 . D ADD(XMGIEN,.XMY,.XMABORT)
 K XMY
 Q $S(XMABORT:0,1:XMGIEN)
MGINIT(XMGROUP,XMGIEN,XMGNAME,XMTYPE,XMORG,XMSELF,XMY,XMDESC,XMQUIET,XMABORT) ;
 D CHKGROUP(XMGROUP,.XMGIEN,.XMGNAME,.XMABORT) Q:XMABORT
 I $D(XMGIEN),'$O(XMY("")) D  Q
 . D NOTIFY("E907 No members specified to add to Mail Group "_XMGNAME,XMQUIET)
 . S XMABORT=1
 D CHKVAL(.XMTYPE,"XMTYPE",2,0,.XMABORT) Q:XMABORT
 S:$G(XMORG)="" XMORG=DUZ
 S:XMORG<1 XMORG=.5
 I '$D(^VA(200,XMORG,0)) D  Q
 . D NOTIFY("E904 "_XMORG_" is not a user to use as an organizer of a mail group.",XMQUIET)
 . S XMABORT=1
 D CHKVAL(.XMSELF,"XMSELF",4,1,.XMABORT) Q:XMABORT
 D CHKVAL(.XMQUIET,"XMQUIET",7,1,.XMABORT) Q:XMABORT
 S:$D(ZTQUEUED) XMQUIET=1
 Q
CHKGROUP(XMGROUP,XMGIEN,XMGNAME,XMABORT) ;
 I +XMGROUP=XMGROUP D  Q
 . S XMGIEN=XMGROUP
 . S XMGNAME=$P($G(^XMB(3.8,XMGIEN,0)),U,1)
 . I XMGNAME="" D
 . . D NOTIFY("E910 Mail Group "_XMGROUP_" could not be found !",XMQUIET)
 . . S XMABORT=1
 S XMGNAME=XMGROUP
 I $L(XMGNAME)<3 D  Q
 . D NOTIFY("E901 "_XMGNAME_" is not valid -- it is shorter than 3 characters",XMQUIET)
 . S XMABORT=1
 I $L(XMGNAME)>30 D  Q
 . D NOTIFY("E902 "_XMGNAME_" is not valid -- it is longer than 30 characters",XMQUIET)
 . S XMABORT=1
 I $D(^XMB(3.8,"B",XMGNAME)) S XMGIEN=$O(^(XMGNAME,0))
 Q
CHKVAL(XMVAL,XMVNAME,XMPOSN,XMDEFALT,XMABORT) ;
 S:$G(XMVAL)="" XMVAL=XMDEFALT
 I XMVAL=0!(XMVAL=1) Q
 D NOTIFY("E903 Parameter "_XMPOSN_"="_XMVAL_" (not valid, must be 0 or 1).",XMQUIET)
 S XMABORT=1
 Q
CREATE(XMGNAME,XMGIEN,XMTYPE,XMORG,XMSELF,XMDESC,XMQUIET,XMABORT) ;
 N DIC,Y,DA,DO,DD,X
 S X=XMGNAME
 S DIC="^XMB(3.8,",DIC(0)="FZMN"_$S(XMQUIET:"",1:"E")
 S DIC("DR")="4///"_$S(XMTYPE=0:"PU",1:"PR")_";5///"_XMORG_";10///0;7///"_$S(XMSELF:"y",1:"n")
 D FILE^DICN
 I Y<0 D  Q
 . D NOTIFY("Mail Group ("_XMGNAME_") creation failed!",XMQUIET)
 . S XMABORT=1
 S XMGIEN=+Y
 ;Add descriptive text
 I $O(XMDESC(""))'="" D
 . D WP^DIE(3.8,XMGIEN_",",3,"","XMDESC")
 . K XMDESC
 D NOTIFY("Mail Group "_XMGROUP_" created.",XMQUIET)
 Q
ADD(XMGIEN,XMY,XMABORT) ; Add local members
 L +^XMB(3.8,XMGIEN):9 E  D  Q
 . D NOTIFY("E906 "_XMGROUP_" File could not be locked - Did not add members.",XMQUIET)
 . S XMABORT=1
 N XMUSER,XMFDA,XMADDCNT
 S XMUSER="",XMADDCNT=0
 F  S XMUSER=$O(XMY(XMUSER)) Q:XMUSER=""  D
 . I '$D(^VA(200,XMUSER,0))!'$D(^XMB(3.7,XMUSER,0)) D  Q
 . . D NOTIFY("E908 Invalid member ("_XMUSER_") - NOT pointer to ^VA(200",XMQUIET)
 . Q:$D(^XMB(3.8,XMGIEN,1,"B",XMUSER))  ; already a member
 . S XMFDA(3.81,"+1,"_XMGIEN_",",.01)=XMUSER
 . D UPDATE^DIE("","XMFDA")
 . S XMADDCNT=XMADDCNT+1
 L -^XMB(3.8,XMGIEN)
 K XMY
 S:'XMADDCNT XMABORT=1  ; No members added
 Q
DM(XMGROUP,XMY,XMQUIET) ; Delete members
 ;XMGROUP  Mail Group Name or entry number
 ;XMY      Array of members to remove
 ;         XMY(local member DUZ)=""
 ;XMQUIET  Silent Flag
 N XMGIEN,XMUSER,DIK,DA,XMABORT
 S XMABORT=0
 D DMINIT(XMGROUP,.XMGIEN,.XMY,.XMQUIET,.XMABORT)
 I XMABORT K XMY Q 0
 L +^XMB(3.8,XMGIEN):9 E  D  Q 0
 . D NOTIFY("E906 "_XMGROUP_" File could not be locked - Did not delete members.",XMQUIET)
 . S XMABORT=1
 S DA(1)=XMGIEN,DIK="^XMB(3.8,"_XMGIEN_",1,"
 S XMUSER=""
 F  S XMUSER=$O(XMY(XMUSER)) Q:XMUSER=""  D
 . S DA=$O(^XMB(3.8,XMGIEN,1,"B",XMUSER,0)) Q:'DA
 . D ^DIK
 K XMY
 L -^XMB(3.8,XMGIEN)
 Q 1
DMINIT(XMGROUP,XMGIEN,XMY,XMQUIET,XMABORT) ;
 N XMGNAME
 D CHKGROUP(XMGROUP,.XMGIEN,.XMGNAME,.XMABORT) Q:XMABORT
 I '$D(XMGIEN) D  Q
 . D NOTIFY("E910 Mail Group "_XMGROUP_" could not be found !",XMQUIET)
 . S XMABORT=1
 D CHKVAL(.XMQUIET,"XMQUIET",3,1,.XMABORT) Q:XMABORT
 S:$D(ZTQUEUED) XMQUIET=1
 I '$O(XMY("")) D  Q
 . D NOTIFY("E909 Member delete attempted with no members specified.",XMQUIET)
 . S XMABORT=1
 Q
NOTIFY(XMMSG,XMQUIET) ; Notification
 N I,XMTEXT
 S XMTEXT(1)="There was a call to the Mail Group Applications Programmer"
 S XMTEXT(2)="Interface (API) that required notification to the user:"
 S XMTEXT(3)=""
 S XMTEXT(4)=XMMSG
 I XMQUIET D SENDMSG(.XMTEXT) Q
 F I=1:1:4 W !,XMTEXT(I)
 W !,$C(7)
 Q
SENDMSG(XMTEXT) ;
 N XMY,XMDUZ,XMSUB
 S XMY(.5)="",XMY(DUZ)="",XMTEXT="XMTEXT("
 S XMDUZ=.5,XMSUB="MAIL GROUP API"
 D ^XMD
 Q
