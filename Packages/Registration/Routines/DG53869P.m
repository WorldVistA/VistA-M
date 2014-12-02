DG53869P ;CHY/TJ - DG*5.3*869 MISSING - PRF POST ROUTINE ;
 ;;5.3;Registration;**869**;AUG 13,1993;Build 15
 ;
 ;  Post Installation Routine for patch DG*5.3*869
 ;
EN ;
 D MGSETUP       ; <--- Creates MailGroup (DGPF MISSING PT FLAG REVIEW) File # (3.8)
 D DGPFSET       ; <--- Creates Patient Record Flag (MISSING PATIENT) File # (26.15)
 Q
 ;
MGSETUP ;
 ;
 ;DBIA:      1146     $$MG^XMBGRP   Supported
 ;
 ;This mail group API contains the entry point $$MG^XMBGRP
 ;Creates a mail group or add local members to an existing mail group.
 ;
 ;If the mail group does not exist, it will be created.  Local
 ;members may be added.  There is no way to add other kinds of
 ;members.  XMTYPE, XMORG, XMSELF, and XMDESC are accepted.
 ;Usage: S X=$$MG^XMBGRP(XMGROUP,XMTYPE,XMORG,XMSELF,.XMY,.XMDESC,XMQUIET)
 ;This function returns the mail group IEN if successful; 0 if not.
 ;
 ;Parameters:
 ;XMGROUP  mail group IEN or name
 ;XMTYPE   mail group type (public or private)
 ;XMORG    organizer DUZ
 ;XMSELF   self enrollment allowed?
 ;.XMY     array of local members
 ;.XMDESC  array of text for the mail group description
 ;XMQUIET  silent flag
 ;
 N XMGROUP,XMTYPE,XMORG,XMSELF,XMQUIET K XMY,XMDESC S (XMY,XMDESC)="" ;new parameters
 S XMGROUP="DGPF MISSING PT FLAG REVIEW" ;mail group IEN or name
 S XMTYPE=0 ;mail group type (public or private)
 S XMORG=$G(XPDQUES("POS1 QUESTION"),DUZ) ;organizer (default=DUZ)
 S XMSELF=1 ;self enrollment allowed?
 S XMY="" ;array of local members
 S XMDESC="Members of this Mail Group will be notified via a MailMan message when a patient/resident has been assigned the NATIONAL, CATAGORY I -  MISSING  PATIENT RECORD FLAG" ;array of text for the mail group description
 S XMQUIET=0 ;silent flag
 ;
 N X S X=$$MG^XMBGRP(XMGROUP,XMTYPE,XMORG,XMSELF,.XMY,.XMDESC,XMQUIET)
 D:+X>0 BMES^XPDUTL("Mail Group "_XMGROUP_" created")
 Q
 ;
DGPFSET ;
 ;DG*5.3*869
 ;2.6.1. Create a new 'Missing Patient' national PRF entry in the PRF National Flag file #26.15.
 ;New National (Category I) PRF definition:
 ;   Name:   MISSING PATIENT
 ;   Status:  ACTIVE or INACTIVE*
 ;   Type:  CLINICAL
 ;   Review Frequency Days:  30
 ;   Notification Days:      7
 ;   Review Mail Group: DGPF MISSING PT FLAG REVIEW
 ;   TIU PN Title: PATIENT RECORD FLAG CATEGORY 1 - MISSING PATIENT
 ;   Description:
 ;       The purpose of this flag is to identify a missing
 ;       patient in the electronic medical record, including
 ;       a Text Integration Utility (TIU) progress note describing
 ;       the risk and circumstances.
 ;
 I $$PRODPRF()'["**ERROR**" D BMES^XPDUTL("National Category I , Patient Record Flag: MISSING PATIENT created")
 Q
 ;
PRODPRF() ;
 N DGPFERR,DGPFFDA,DGPFIEN,DGPFMSG,DGPFNM,DGPFSTAT,DGPFTYP,DGPFRFD,DGPFNOTD,DGPFRMG,DGPFTIU,DGPFDSC
 S DGPFNM="MISSING PATIENT" ;<--- NAT FLAG NAME (MISSING PATIENT)
 S DGPFSTAT=1 ;<---  ACTIVE STATUS (1)
 S DGPFTYP=$$FIND1^DIC(26.16,"","X","CLINICAL","B") ;<--- TYPE (CLINICAL)
 S DGPFRFD=30 ;<--- REVIEW FREQUENCY DAYS (30)
 S DGPFNOTD=7 ;<--- NOTIFICATION DAYS (7)
 S DGPFRMG=$$FIND1^DIC(3.8,"","X","DGPF MISSING PT FLAG REVIEW","B") ;<--- REVIEW MAIL GROUP (DGPF MISSING PT FLAG REVIEW)
 I +DGPFRMG'>0 S DGPFERR="   **ERROR** UNABLE TO DEFINE * "_"DGPF MISSING PT FLAG REVIEW"_" * MAIL GROUP" D BMES^XPDUTL(DGPFERR) Q DGPFERR
 S DGPFTIU=$$FIND1^DIC(8925.1,"","X","PATIENT RECORD FLAG CATEGORY I - MISSING PATIENT","B") ;<--- TIU PN TITLE (PATIENT RECORD FLAG CATEGORY 1 - MISSING PATIENT)
 I +DGPFTIU'>0 S DGPFERR="   **ERROR** UNABLE TO DEFINE * ""PATIENT RECORD FLAG CATEGORY 1 - MISSING PATIENT"" * TIU PN TITLE" D BMES^XPDUTL(DGPFERR) Q DGPFERR
 S DGPFDSC(1)="The purpose of this flag is to identify a missing patient in the "
 S DGPFDSC(2)="electronic medical record, including a Text Integration Utility (TIU) "
 S DGPFDSC(3)="progress note describing the risk and circumstances."
 S DGPFERR="   PRF National Flag Created: "_DGPFNM
 S DGPFFDA(26.15,"?+1,",.01)=DGPFNM ; NAME
 S DGPFFDA(26.15,"?+1,",.02)=DGPFSTAT ; STATUS
 S DGPFFDA(26.15,"?+1,",.03)=DGPFTYP ; TYPE
 S DGPFFDA(26.15,"?+1,",.04)=DGPFRFD ; REVIEW FREQUENCY DAYS
 S DGPFFDA(26.15,"?+1,",.05)=DGPFNOTD ; NOTIFICATION DAYS
 S DGPFFDA(26.15,"?+1,",.06)=DGPFRMG ; REVIEW MAIL GROUP
 S DGPFFDA(26.15,"?+1,",.07)=DGPFTIU ; TIU PN TITLE
 D UPDATE^DIE("","DGPFFDA","DGPFIEN","DGPFMSG")
 ;D WP^DIE(file,iens,field,flags,wp_root,msg_root)
 S:'$G(DGPFIEN) DGPFIEN=+DGPFIEN(1)
 D WP^DIE(26.15,DGPFIEN_",",1,"","DGPFDSC","DGPFMSG") ; DESCRIPTION
 I $D(DGPFMSG) D  Q DGPFERR
 . S DGPFERR="   **ERROR** "_$G(DGPFMSG("DIERR",1))_" Unable to create Patient Record Flag: "_DGPFNM
 ; Find the IEN of the NATIONAL PRF
 S DGPFIEN=$$FIND1^DIC(26.15,"","X",DGPFNM,"B")
 I 'DGPFIEN D  Q DGPFERR
 . S DGPFERR="   **ERROR** Unable to locate NAT PRF -  "_DGPFNM
 Q DGPFERR
 ;
