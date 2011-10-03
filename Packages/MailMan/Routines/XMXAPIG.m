XMXAPIG ;ISC-SF/GMB-Mail Group APIs ;03/25/2003  14:48
 ;;8.0;MailMan;**16**;Jun 28, 2002
 ; All entry points covered by DBIA 3006
 ; Variables input:
 ; XMGROUP  Group's IEN or exact name
ADDMBRS(XMDUZ,XMGRP,XMMBR,XMINSTR,XMTSK) ; Add members to groups
 ; XMGRP    Same as XMGROUP, or array XMGRP(XMGROUP)=""
 ; XMMBR    Member or array of members to add.
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 K XMERR,^TMP("XMERR",$J)
 D XMDUZ^XMXPARM(.XMDUZ,.XMV)
 I $D(XMINSTR) D XMINSTR(.XMINSTR)
 Q:$D(XMERR)
 D ADDMBRS^XMXGRP(XMDUZ,.XMGRP,.XMMBR,.XMINSTR,.XMTSK)
 Q
JOIN(XMDUZ,XMGROUP,XMINSTR,XMTSK) ; User chooses to join a group.
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 K XMERR,^TMP("XMERR",$J)
 D XMDUZ^XMXPARM(.XMDUZ,.XMV)
 I $D(XMINSTR) D XMINSTR(.XMINSTR)
 D JOIN^XMXGRP(XMDUZ,XMGROUP,.XMINSTR,.XMTSK)
 Q
DROP(XMDUZ,XMGROUP) ; User chooses to drop from a group.
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 K XMERR,^TMP("XMERR",$J)
 D XMDUZ^XMXPARM(.XMDUZ,.XMV) Q:$D(XMERR)
 D DROP^XMXGRP(XMDUZ,XMGROUP)
 Q
XMINSTR(XMINSTR) ;
 S:$D(XMINSTR("SELF BSKT")) XMINSTR("SELF BSKT")=$$XMK^XMXPARM(XMDUZ,"XMINSTR(""SELF BSKT"")",XMINSTR("SELF BSKT"),1)
 I $D(XMINSTR("FLAGS")) D XMFLAG^XMXPARM("XMINSTR(""FLAGS"")",XMINSTR("FLAGS"),"AF")
 S:$D(XMINSTR("FDATE")) XMINSTR("FDATE")=$$XMDATE^XMXPARMB("XMINSTR(""FDATE"")",XMINSTR("FDATE"))
 S:$D(XMINSTR("TDATE")) XMINSTR("TDATE")=$$XMDATE^XMXPARMB("XMINSTR(""TDATE"")",XMINSTR("TDATE"))
 Q
GOTLOCAL(XMGROUP,XMDAYS,XMMBRS) ; Function: Any active local members?  (1=yes; 0=no)
 ; XMDAYS (optional) add'l requirement that the member must have used
 ;                   MailMan within the last XMDAYS days.
 ; XMMBRS (optional) add'l requirement that this many local members must
 ;                   be in the group.  (default is 1)
 N XMGIEN,XMSCREEN,XMLIST
 K XMERR,^TMP("XMERR",$J)
 S XMGIEN=$$IEN(XMGROUP) Q:$D(XMERR) 0
 ; User must have access code and mailbox
 S XMSCREEN="N XM S XM=+^(0) I $L($P($G(^VA(200,XM,0)),U,3)),$D(^XMB(3.7,XM,2))"
 I $G(XMDAYS) S XMSCREEN=XMSCREEN_",$P($G(^(""L"")),U,2)'<"_$$FMADD^XLFDT(DT,-XMDAYS)
 I '$G(XMMBRS) S XMMBRS=1
 D LIST^DIC(3.81,","_XMGIEN_",","@","I",XMMBRS,"","","",XMSCREEN,"","XMLIST")
 Q:+XMLIST("DILIST",0)=XMMBRS 1
 ; none found
 K:$D(DIERR) DIERR,^TMP("DIERR",$J)
 N XMPARM,XMDIALOG
 S XMPARM(1)=$$NAME(XMGIEN),XMDIALOG=39503 ;Mail group '|1|' has no active local members
 I $G(XMDAYS) S XMPARM(2)=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-XMDAYS),5),XMDIALOG=39504 ;Mail group '|1|' has no local members active since '|2|'
 I $G(XMMBRS) S XMPARM(3)=XMMBRS,XMDIALOG=XMDIALOG+.1
 ;39503.1-Mail group '|1|' does not have at least |3| active local members
 ;39504.1-Mail group '|1|' does not have at least |3| local members who have been active since '|2|'.
 D ERRSET^XMXUTIL(XMDIALOG,.XMPARM)
 Q 0
IEN(XMGROUP) ; INTERNAL USE ONLY function, given group's ien or exact name, returns ien
 I +XMGROUP=XMGROUP D  Q XMGROUP
 . I $D(^XMB(3.8,XMGROUP,0)) Q
 . D ERRSET^XMXUTIL(39502,XMGROUP) ;Mail group IEN '|1|' not found.
 . S XMGROUP=0
 N XMGIEN
 S XMGIEN=$O(^XMB(3.8,"B",XMGROUP,0)) Q:XMGIEN XMGIEN
 D ERRSET^XMXUTIL(39501,XMGROUP) ;Mail group '|1|' not found.
 Q 0
NAME(XMGIEN) ; INTERNAL USE ONLY function, given group's ien, returns name
 Q $P($G(^XMB(3.8,XMGIEN,0)),U,1)
MEMBER(XMDUZ,XMGROUP,XMCHKSUB) ; Is user a member of the group?
 ; XMCHKSUB - Check member groups, too? (0=no; 1=yes)
 N XMGIEN,XMCHECKD
 K XMERR,^TMP("XMERR",$J)
 S XMGIEN=$$IEN(XMGROUP) Q:$D(XMERR) 0
 I '$G(XMCHKSUB) Q $D(^XMB(3.8,XMGIEN,1,"B",XMDUZ))>0
 Q $$SUBMBR(XMDUZ,XMGIEN)
SUBMBR(XMDUZ,XMGIEN) ;
 I $D(^XMB(3.8,XMGIEN,1,"B",XMDUZ)) Q 1
 N XMI,XMMBR
 S XMCHECKD(XMGIEN)=""
 S XMI=0
 F  S XMI=$O(^XMB(3.8,XMGIEN,5,"B",XMI)) Q:'XMI  D  Q:$G(XMMBR)
 . Q:'$D(^XMB(3.8,XMI))
 . Q:$D(XMCHECKD(XMI))
 . S XMMBR=$$SUBMBR(XMDUZ,XMI)
 Q +$G(XMMBR)
