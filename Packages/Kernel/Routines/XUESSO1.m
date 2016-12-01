XUESSO1 ;SEA/LUKE Single Sign-on Utilities ;03/08/16  08:16
 ;;8.0;KERNEL;**165,183,196,245,254,269,337,395,466,523,655,659**;Jul 10, 1995;Build 22
 ;Per VA Directive 6402, this routine should not be modified.
 ;
GET(INDUZ) ;Gather identifying data from user's home site.
 ;Called by SETVISIT^XUSBSE1 (Get visitor info for TOKEN)
 ;Called by SNDQRY^DGROHLS (Retrieve user info) and SETUP^XWB2HL7 (Get visitor info)
 ;Called by (unknown) (VSA/VistA.js)
 ;To visit a remote site, user must have: Name, Access/Verify Codes, SSN (no pseudo), Station Name, Site Number
 ;The following data is optional: Phone, SecID, Network Username
 N %,NAME,SITE,SSN,PHONE,X,N,NETWORK
 I '$D(DUZ) Q "-1^Insufficient info to allow visiting:  No DUZ"
 I '$D(DUZ(2)) Q "-1^Insufficient info to allow visiting:  Missing DUZ(2)"
 S N=$G(^VA(200,DUZ,0))
 I '$L(N) Q "-1^Insufficient info to allow visiting:  Missing NPF Zero Node"
 S %=$P(N,U,3) I $L(%)<1 Q "-1^Insufficient info to allow visiting:  No Access Code"
 S %=$P($G(^VA(200,DUZ,.1)),U,2) I $L(%)<1 Q "-1^Insufficient info to allow visiting:  No Verify Code"
 S %=$P(N,U,11) I $L(%)>1,(DT>%) Q "-1^Insufficient info to allow visiting:  Terminated User"
 I $P($$ACTIVE^XUSER(DUZ),U,1)'=1 Q "-1^Insufficient info to allow visiting:  Not an active user"
 ;I $G(DUZ("LOA"))<2 Q "-1^Insufficient Level of Assurance to allow visiting:  User not authenticated"
 S NAME=$P(N,U)
 I '$L(NAME) Q "-1^Insufficient info to allow visiting:  No User Name"
 ;
 S SITE=$$NS^XUAF4(DUZ(2)) ;Site is name^station#
 I $P(SITE,U,2)="" Q "-1^Insufficient info to allow visiting:  Missing Station Number"
 ;
 S SSN=$P($G(^VA(200,DUZ,1)),U,9)
 I $$SPECIAL($P(SITE,"^",2)) S SSN=999999999 ;Manila RO doesn't need SSN
 I 'SSN Q "-1^Insufficient info to allow visiting:  Missing SSN"
 I $E(SSN,10)="P" Q "-1^Insufficient info to allow visiting:  User has a pseudo SSN"
 I '$$SSNCHECK(SSN) Q "-1^Insufficient info to allow visiting:  User does not have a valid SSN"
 ;
 S PHONE=$$PH
 S X=SSN_U_NAME_U_SITE_U_DUZ
 I $L(PHONE)>2&($L(PHONE<20)) S X=X_U_PHONE
 S $P(X,U,7)=$P($G(^VA(200,DUZ,205.1)),U) ;p655 SecID
 S $P(X,U,8)=$P($G(^VA(200,DUZ,501)),U) ;p655 Network Username
 ;X=ssn^name^station name^station number^DUZ^phone^SecID^network username
 Q X
 ;
PH() ; Try for a phone number or pager
 N %,X
 S %=""
 S X=$G(^VA(200,DUZ,.13))
 I '$L(X) Q ""
 S %=$P(X,U,5) I $L(%)>6 Q %  ;Commercial #
 S %=$P(X,U,2) I $L(%)>2 Q %  ;Office
 S %=$P(X,U,8) I $L(%)>6 Q %  ;Digital Pager
 S %=$P(X,U,7) I $L(%)>6 Q %  ;Pager
 S %=$P(X,U,3) I $L(%)>2 Q %  ;Phone #3
 S %=$P(X,U,4) I $L(%)>2 Q %  ;Phone #4
 S %=$P(X,U,1) I $L(%)>2 Q %  ;Home Phone
 Q "" ;Couldn't find one.
 ;
SPECIAL(SN) ;INTRINSIC. Special Manila RO site
 ; Returns 1 if SN is "358"
 Q 358=SN
 ;
PUT(DATIN) ;;Setup data from authenticating site GET() at receiving site
 ;Called by OLDCAPRI^XUSBSE1 (Old Capri) and SETUP^XUSBSE1 (BSE)
 ;Called by DIQ^DGROHLU (Sensitive Patient access) and REMOTE^XWB2HL7 (Visitor access via HL7)
 ;Called by (unknown) (VSA/VistA.js)
 ;Return: 0=fail, 1=OK
 N NAME,NETWORK,NEWDUZ,PHONE,RMTDUZ,SECID,SITE,SITENUM,SSN,TODAY,XSITEIEN,XT,XUMF
 I $G(DUZ("LOA"))="" S DUZ("LOA")=1
 ;I $G(DUZ("LOA"))<2 Q 0  ;do not allow access if Level Of Assurance is low
 I $G(DUZ("AUTHENTICATION"))="" S DUZ("AUTHENTICATION")="UNKNOWN"
 S U="^",TODAY=$$HTFM^XLFDT($H),DT=$P(TODAY,"."),NEWDUZ=0
 K ^TMP("DIERR",$J)
 ;
 S SSN=$P(DATIN,U,1),NAME=$P(DATIN,U,2),SITE=$P(DATIN,U,3)
 S SITENUM=$P(DATIN,U,4),RMTDUZ=$P(DATIN,U,5),PHONE=$P(DATIN,U,6)
 S SECID=$P(DATIN,U,7) ;p655
 S NETWORK=$P(DATIN,U,8) ;p655
 ;Format checks
 I NAME'?1U.E1","1U.E Q 0
 I SSN'?9N Q 0
 I '$L(SITE)!('$L(SITENUM)) Q 0
 S XUMF=1 D CHK^DIE(4,99,,SITENUM,.XT) I XT=U Q 0 ;p533
 D CHK^DIE(200.06,1,,SITE,.XT) I XT=U Q 0 ;p533
 I RMTDUZ'>0 Q 0 ;p337
 ;Check if visitor is from a valid active site
 S XSITEIEN=$$IEN^XUAF4(SITENUM) I XSITEIEN="" H 1 ;Q 0 ;Quit if authenticating VistA not in INSTITUTION file (#4)
 ;I '$$ACTIVE^XUAF4(XSITEIEN) Q 0 ;Quit if authenticating VistA is not an active VA site (spoofed)
 ;I $P($$NS^XUAF4(XSITEIEN),"^",1)'=SITE Q 0 ;Quit if authenticating VistA name and station number mismatch (spoofed)
 ;Get a LOCK. Block if can't get.
 L +^VA(200,"HL7"):10 Q:'$T 0
 S XT=$$TALL($G(DUZ,0)) L -^VA(200,"HL7")
 I XT Q $$SET(NEWDUZ) ;Return 1 if OK.
 Q 0
 ;
TALL(DUZ) ;INTRINSIC. Test for existing user or adds a new one
 ; ZEXCEPT: NAME,NEWDUZ,PHONE,RMTDUZ,SITE,SITENUM,SSN,XSSN,TODAY,SECID,NETWORK ;global variables within this routine
 ; ZEXCEPT: DIC ;turn off DIC(0) for ^XUA4A7 (work around)
 N FLAG,NEWREC,XUIAM
 S FLAG=0,DUZ(0)="@" ;Make sure we can add the entry
 S XUIAM=1 ;Do not trigger IAM updates
 ;See if match SECID. Only use for lookup. Do not load SECID's.
 I $L(SECID) D
 . S NEWDUZ=+$$SECMATCH^XUESSO2(SECID) Q:NEWDUZ<1  ;p655
 . I '$D(^VA(200,NEWDUZ,8910,"B",SITENUM)) D VISM
 . D ADDW,UPDT
 . S FLAG=1,DUZ(0)=$P($G(^VA(200,NEWDUZ,0)),U,4)
 . Q
 I FLAG Q 1 ;Quit here if we found a match on SECID
 ;See if the SSN is in the NPF cross reference
 I $D(^VA(200,"SSN",SSN)),$$SSNCHECK(SSN),'$$SPECIAL(SITENUM) D
 . N XUEIEN,XUEAUSER
 . S XUEIEN=0,NEWDUZ=0
 . F  S XUEIEN=$O(^VA(200,"SSN",SSN,XUEIEN)) Q:(XUEIEN="")!(NEWDUZ>0)  D
 . . N XUENAME S XUENAME=$P($G(^VA(200,XUEIEN,0)),U)
 . . S NEWDUZ=XUEIEN
 . . ;Update name if names don't match, user has visited before, and user is not an active local user
 . . I (XUENAME'=NAME)&(XUEIEN=$O(^VA(200,"AVISIT",SITENUM,RMTDUZ,0)))&(('$$ACTIVE^XUSER(XUEIEN))) D ADDN
 . Q:NEWDUZ'>0
 . I '$D(^VA(200,NEWDUZ,8910,"B",SITENUM)) D VISM
 . D ADDW,ADDI,UPDT
 . S FLAG=1,DUZ(0)=$P($G(^VA(200,NEWDUZ,0)),U,4)
 . Q
 I FLAG Q 1 ;Quit here if we found a match for SSN
 ;See if in the AVISIT cross reference (Manila only)
 I $$SPECIAL(SITENUM) D
 . S NEWDUZ=$O(^VA(200,"AVISIT",SITENUM,RMTDUZ,0))
 . Q:NEWDUZ'>0  ;User must have visited from Manila at least once to be found by this test
 . D ADDW,ADDI,UPDT S FLAG=1,DUZ(0)=$P($G(^VA(200,NEWDUZ,0)),U,4)
 . Q
 I FLAG Q 1 ;Quit here if we found a match for AVISIT
 ;Try for a NAME match in "B"
 N XUEIEN,XUESSN
 S NAME=$$UP^XLFSTR(NAME)
 I $D(^VA(200,"B",NAME)) D
 . S XUEIEN=0,NEWDUZ=0
 . F  S XUEIEN=$O(^VA(200,"B",NAME,XUEIEN)) Q:(XUEIEN="")!(NEWDUZ>0)  D
 . . S XUESSN=$P($G(^VA(200,XUEIEN,1)),U,9)
 . . I (XUESSN'=SSN)&($L(XUESSN)>8) Q  ;Do not use if name has a different SSN
 . . S NEWDUZ=XUEIEN
 . I NEWDUZ>0 D
 . . D ADDS
 . . I '$D(^VA(200,NEWDUZ,8910,"B",SITENUM)) D VISM
 . . D ADDW,ADDI,UPDT
 . . S FLAG=1,DUZ(0)=$P($G(^VA(200,NEWDUZ,0)),U,4)
 . Q
 I FLAG Q 1 ;Quit here if we found an exact match for NAME (w/o SSN)
 ;
 ;I DUZ("LOA")=1 Q 0  ;Do not add user if Level Of Assurance is low
 ;I $G(DUZ("REMAPP"))="^MDWS" Q 0  ;Do not add user if MDWS access
 I $G(DUZ("REMAPP"))="^MDWS" H $E(DT,1,3)-315  ;Discourage deprecated MDWS access
 ;
 ;We didn't find anybody under SecID,SSN,VISITED FROM, or NAME so we add a new user
 S DIC(0)="" ;Turn off ^XUA4A7 (work around)
 ;Put the name in the .01 field first.
 D ADDU ;ADDU will set NEWDUZ
 I NEWDUZ=0 Q 0  ;If NEWDUZ is still 0, the User add didn't work so exit.
 D ADDS,ADDA ;(p337) Add SSN and "VISITOR" Alias.
 D ADDW,ADDI ; Add NETWORK USERNAME and SSO attributes
 D VISM,UPDT ; Fill in the  VISITED FROM multiple
 I NEWDUZ=0 Q 0 ;Couldn't update user
 I $D(^TMP("DIERR",$J)) Q 0  ;FileMan Error
 ;
 S FLAG=$$BULL(NAME,NEWDUZ,SITE,SITENUM,RMTDUZ,PHONE,TODAY)
 S DUZ(0)=$P($G(^VA(200,NEWDUZ,0)),U,4)
 Q 1  ;Every thing OK
 ;
SET(NEWDUZ) ;INTRINSIC. Set the user up to go
 ; ZEXCEPT: RMTDUZ,SITENUM ;global variables within this routine
 ;Return: 0=fail, 1=OK
 Q:NEWDUZ'>0 0
 N XUSER,XOPT
 S DUZ=NEWDUZ,U="^",DUZ("VISITOR")=SITENUM_U_RMTDUZ ;p533
 D DUZ^XUS1A
 Q 1
 ;
ADDU ;SR. Add a new name to the New Person File
 ; ZEXCEPT: FDR,NAME,NEWDUZ,NEWREC ;global variables within this routine
 N DD,DO,DIC,DA,X,Y
 S NEWDUZ=0
 S DIC="^VA(200,",DIC(0)="F",X=NAME,NEWREC=1 ;p533
 D FILE^DICN
 S:Y>0 NEWDUZ=+Y
 Q
 ;
ADDS ;SR. Add a SSN to the New Person File
 ; ZEXCEPT: FDR,NEWDUZ,SSN,SITENUM ;global variables within this routine
 N IEN
 Q:$$SPECIAL(SITENUM)  ;don't add SSN if from Manila
 Q:$D(^VA(200,"SSN",SSN))  ;don't try to add a duplicate SSN
 Q:'$$SSNCHECK(SSN)  ;only add a valid SSN
 S IEN=NEWDUZ_","
 S FDR(200,IEN,9)=SSN
 ;Do update for all data in UPDT
 Q
 ;
ADDI ;SR. Add SSO attributes to the New Person File
 ; ZEXCEPT: FDR,NEWDUZ,SECID ;global variables within this routine
 N IEN
 Q:'$L(SECID)  ;need SECID for SSO
 S IEN=NEWDUZ_","
 I $P($G(^VA(200,NEWDUZ,205)),U,1)="" S FDR(200,IEN,205.1)=SECID ;SECID
 I $P($G(^VA(200,NEWDUZ,205)),U,2)="" S FDR(200,IEN,205.2)=$P($G(^XTV(8989.3,1,200)),U,2) ;Subject Organization
 I $P($G(^VA(200,NEWDUZ,205)),U,3)="" S FDR(200,IEN,205.3)=$P($G(^XTV(8989.3,1,200)),U,3) ;Subject Organization ID
 I $P($G(^VA(200,NEWDUZ,205)),U,4)="" S FDR(200,IEN,205.4)=SECID ;Unique User ID
 ;Do update for all data in UPDT
 Q
 ;
ADDN ;SR. Update the NAME in the New Person File
 ; ZEXCEPT: FDR,NEWDUZ,NAME,RMTDUZ,SITENUM ;global variables within this routine
 N IEN
 Q:NAME=$P($G(^VA(200,NEWDUZ,0)),U,1)  ; name is unchanged, do nothing
 I NEWDUZ'=$O(^VA(200,"AVISIT",SITENUM,RMTDUZ,0)) Q  ; user hasn't visited before, so this is not a valid name change
 S IEN=NEWDUZ_","
 S FDR(200,IEN,.01)=NAME
 ;Do update for all data in UPDT
 Q
 ;
ADDA ;SR. Add a new Alias to file 200.04
 ; ZEXCEPT: FDR,NEWDUZ ;global variables within this routine
 N IEN
 Q:$D(^VA(200,NEWDUZ,3,"B","VISITOR"))  ; Quit if user is already marked as visitor
 S IEN="+2,"_NEWDUZ_","
 S FDR(200.04,IEN,.01)="VISITOR"
 ;Do update for all data in UPDT
 Q
 ;
ADDW ;SR. Add NETWORK USERNAME to the New Person File
 ; ZEXCEPT: FDR,NEWDUZ,NETWORK ;global variables within this routine
 N IEN
 Q:$G(^VA(200,NEWDUZ,501))'=""  ; Quit if user already has a NETWORK USERNAME
 Q:$L($G(NETWORK))<12  ; Quit if NETWORK USERNAME is too short
 S IEN=NEWDUZ_","
 S FDR(200,IEN,501.1)=$G(NETWORK)
 ;Do update for all data in UPDT
 Q
 ;
VISM ;SR. Create a multiple for this site number in the VISITED FROM file
 ; ZEXCEPT: FDR,NEWDUZ,RMTDUZ,SITE,SITENUM,TODAY ;global variables within this routine
 N IEN
 S IEN="+3,"_NEWDUZ_","
 S FDR(200.06,IEN,.01)=SITENUM
 S FDR(200.06,IEN,1)=SITE
 S FDR(200.06,IEN,2)=RMTDUZ
 S FDR(200.06,IEN,3)=TODAY
 ;Do update for all data in UPDT
 Q
 ;
UPDT ;SR. Update all data fields
 ; Sets: NEWDUZ=0 if failed to complete update
 ; ZEXCEPT: FDR,NAME,NEWDUZ,SITE,SITENUM,PHONE,TODAY,DATIN,NEWREC ;global variables within this routine
 N IEN,FDQ
 I $D(FDR(200.06)) S IEN=$O(FDR(200.06,""))
 E  S IEN=$O(^VA(200,NEWDUZ,8910,"B",SITENUM,0))_","_NEWDUZ_","
 S FDR(200.06,IEN,4)=TODAY
 I $D(PHONE),($L(PHONE)>4) S FDR(200.06,IEN,5)=PHONE ;p466 Update the phone each time
 I $D(SITE) S FDR(200.06,IEN,1)=SITE ;p655 Update the site each time (name changes in INSTITUTION file)
 K IEN D UPDATE^DIE("E","FDR","IEN") ;File all the data
 I $D(^TMP("DIERR",$J)) D  Q
 . N DIK,DA,Y
 . I $D(NEWREC) S DIK="^VA(200,",DA=NEWDUZ D ^DIK ;Remove partial entry ;p533
 . S NEWDUZ=0 ;Tell failed
 Q
 ;
BULL(NAME,NEWDUZ,SITE,SITENUM,RMTDUZ,PHONE,TODAY) ;INTRINSIC. Send local bulletin if user added
 ; Returns: 0 if failed to send bulletin, 1 if success
 ; ZEXCEPT: XTMUNIT ;set for unit testing
 N XMB
 I ($G(NAME)="")!($G(NEWDUZ)="")!($G(SITE)="")!($G(SITENUM)="") Q 0
 I ($G(RMTDUZ)="")!($G(PHONE)="")!($G(TODAY)="") Q 0
 S XMB="XUVISIT"
 S XMB(1)=$$FMTE^XLFDT(TODAY)
 S XMB(2)=NAME,XMB(3)=NEWDUZ,XMB(4)=SITE
 S XMB(5)=SITENUM,XMB(6)=RMTDUZ,XMB(7)=PHONE
 I '$D(XTMUNIT) D ^XMB
 Q 1
 ;
SSNCHECK(SSN) ;INTRINSIC. Check for valid SSN
 ; Input: SSN in format "nnnnnnnnn" or "nnn-nn-nnnn"
 ; Returns: 0 if SSN is invalid, 1 if success
 ; Valid SSN range 001-01-0001 to 899-99-9999 with exceptions (rule as of 2011)
 ; Valid Individual Taxpayer Identification Number range 900-01-0001 to 999-99-9999 with exceptions (rule as of 1966)
 N X
 I $$PROD^XUPROD()=0 Q 1  ;allow use of invalid SSNs in development accounts
 S X=$TR(SSN,"-")
 I $L(X)'=9 Q 0
 I $E(X,1,3)'>0 Q 0   ;1st 3 digits cannot be 000
 I $E(X,4,5)'>0 Q 0   ;digits 4-5 cannot be 00
 I $E(X,6,9)'>0 Q 0   ;digits 6-9 cannot be 0000
 I $E(X,1,3)=666 Q 0  ;1st 3 digits cannot be 666
 I (X>987654319)&(X<987654330) Q 0  ;SSN range reserved for advertising
 I ($E(X,1,3)>899)&($E(X,4,5)=89) Q 0  ;digits 4-5 of ITIN cannot be 89
 I ($E(X,1,3)>899)&($E(X,4,5)=93) Q 0  ;digits 4-5 of ITIN cannot be 93
 Q 1
