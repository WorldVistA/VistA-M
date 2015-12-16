XUESSO3 ;ISD/HGW Enhanced Single Sign-On Utilities ;03/30/15  11:52
 ;;8.0;KERNEL;**655**;Jul 10, 1995;Build 16
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
IAMFU(Y,NAME,SSN,DOB,ADUPN,SECID,AUTHCODE) ;RPC. XUS IAM FIND USER
 ;Identity and Access Management Find User RPC for SSOi provisioning
 ; The XUSHOWSSN key is required to do lookups using PII (SSN or DoB).
 ; Input:  One or more of Name, SSN, DoB, AD UPN, and/or SecID must be provided.
 ;           AUTHCODE    = Security Phrase for IAM Provisioning Application
 ; Return: Array of values, where
 ;           Fail    Y(0)="-1^Error Message"
 ;           Success Y(0)=total number of entries found, from "0" to "n".
 ;                   Y(1) through Y(n)="DUZ^Name^SSN^Dob^AD UPN^SecID"
 ;
 ; ZEXCEPT: %DT
 N X,XARRY,XCOUNT,XI,XJ,XNAME,XRESULT,XSHOWSSN,XTEMP,XUENTRY
 I DUZ'>1 S Y(0)="-1^Unauthorized access" Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 S Y=XUENTRY Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U,1)'="IAM PROVISIONING" S Y="-1^Unauthorized access" Q
 S XSHOWSSN=$$KCHK^XUSRB("XUSHOWSSN")
 S XCOUNT=0
 ; 1. Search by NAME
 I $G(NAME)'="" D
 . S XNAME=NAME
 . S NAME=$$FORMAT^XLFNAME7(.XNAME,3,35,,0,,,2) ; NAME converted to standard format
 . D LIST^DIC(200,"","@;.01","","","",NAME,"","","","XTEMP")
 . S XJ=+$G(XTEMP("DILIST",0))
 . I XJ>0 S XI=1 F  D  Q:+XI'>0
 . . S XI=$O(XTEMP("DILIST",XI)) Q:+XI'>0
 . . S XJ=0 F  D  Q:+XJ'>0
 . . . S XJ=$O(XTEMP("DILIST",XI,XJ)) Q:+XJ'>0
 . . . S XRESULT=$G(XTEMP("DILIST",XI,XJ))
 . . . I XRESULT>0 D ADDTOLST(.Y,.XCOUNT,XSHOWSSN,XRESULT)
 ; 2. Search by SSN
 I ($G(SSN)'="")&($G(XSHOWSSN)=1) D
 . S XARRY(9)=SSN
 . S XRESULT=$$FINDUSER^XUESSO2(.XARRY)
 . I +XRESULT>0 D ADDTOLST(.Y,.XCOUNT,XSHOWSSN,XRESULT)
 . K XARRY(9)
 ; 3. Search by DOB
 I ($G(DOB)'="")&($G(XSHOWSSN)=1) D
 . S X=DOB,%DT="PX" D ^%DT S X=Y,XRESULT=0
 . F  D  Q:XRESULT=""
 . . S XRESULT=$O(^VA(200,XRESULT)) Q:XRESULT=""
 . . I $P($G(^VA(200,XRESULT,1)),U,3)=X D ADDTOLST(.Y,.XCOUNT,XSHOWSSN,XRESULT)
 ; 4. Search by ADUPN
 I $G(ADUPN)'="" D
 . S X=$$LOW^XLFSTR(ADUPN),XRESULT=0
 . F  D  Q:XRESULT=""
 . . S XRESULT=$O(^VA(200,"ADUPN",X,XRESULT))
 . . I XRESULT>0 D ADDTOLST(.Y,.XCOUNT,XSHOWSSN,XRESULT)
 ; 5. Search by SECID
 I $G(SECID)'="" D
 . S XARRY(7)=SECID
 . S XRESULT=$$FINDUSER^XUESSO2(.XARRY)
 . I +XRESULT>0 D ADDTOLST(.Y,.XCOUNT,XSHOWSSN,XRESULT)
 . K XARRY(7)
 ; 6. Return results
 S Y(0)=XCOUNT
 Q
 ;
IAMDU(Y,DISPDUZ,AUTHCODE) ;RPC. XUS IAM DISPLAY USER
 ;Identity and Access Management Display User RPC for SSOi provisioning
 ; Input:  DISPDUZ         = DUZ (IEN) of user to be displayed
 ;         AUTHCODE        = Security Phrase for IAM Provisioning Application
 ; Return: Array of values, where
 ;           Fail    Y(0)  ="-1^Error Message"
 ;           Success Y(0)  = 1
 ;                   Y(1)  = NAME
 ;                   Y(2)  = INITIAL
 ;                   Y(3)  = TITLE
 ;                   Y(4)  = NICK NAME
 ;                   Y(5)  = SSN (<Hidden> if caller does not have XUSHOWSSN key)
 ;                   Y(6)  = DOB (<Hidden> if caller does not have XUSHOWSSN key)
 ;                   Y(7)  = DEGREE
 ;                   Y(8)  = MAIL CODE
 ;                   Y(9)  = DISUSER
 ;                   Y(10) = TERMINATION DATE
 ;                   Y(11) = TERMINATION REASON
 ;                   Y(12) = PRIMARY MENU OPTION
 ;                   Y(13,0) = SECONDARY MENU OPTION (number of entries)
 ;                   Y(13,1) to Y(13,n) = SECONDARY MENU OPTION entries
 ;                   Y(14) = FILE MANAGER ACCESS CODE
 ;                   Y(15,0) = DIVISION (number of entries)
 ;                   Y(15,1) to Y(15,n) = DIVISION entries
 ;                   Y(16) = SERVICE/SECTION
 ;                   Y(17) = SUBJECT ALTERNATIVE NAME (PIV CARD)
 ;                   Y(18) = SECID
 ;                   Y(19) = SUBJECT ORGANIZATION
 ;                   Y(20) = SUBJECT ORGANIZATION ID
 ;                   Y(21) = UNIQUE USER ID
 ;                   Y(22) = NETWORK USERNAME
 ;                   Y(23) = AD UPN
 ;
 N XI,XJ,XSHOWSSN,XTMP,XTMP1,XTMP205,XTMP5,XTMP501,XUENTRY
 I DUZ'>1 S Y(0)="-1^Unauthorized access" Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 S Y=XUENTRY Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U,1)'="IAM PROVISIONING" S Y="-1^Unauthorized access" Q
 I $G(DISPDUZ)'>0 S Y(0)="-1^User not selected" Q
 I $G(^VA(200,DISPDUZ,0))="" S Y(0)="-1^User not found" Q
 S XSHOWSSN=$$KCHK^XUSRB("XUSHOWSSN")
 S XTMP=$G(^VA(200,DISPDUZ,0))
 S XTMP1=$G(^VA(200,DISPDUZ,1))
 S XTMP5=$G(^VA(200,DISPDUZ,5))
 S XTMP205=$G(^VA(200,DISPDUZ,205))
 S XTMP501=$G(^VA(200,DISPDUZ,501))
 S Y(0)=1
 S Y(1)=$P($G(XTMP),U,1)
 S Y(2)=$P($G(XTMP),U,2)
 S Y(3)=$P($G(XTMP),U,9)
 I $G(Y(3))>0 S Y(3)=$P($G(^DIC(3.1,Y(3),0)),U,1)
 S Y(4)=$P($G(^VA(200,DISPDUZ,.1)),U,4)
 S Y(5)="<Hidden>" I $G(XSHOWSSN)=1 S Y(5)=$P($G(XTMP1),U,9)
 S Y(6)="<Hidden>" I $G(XSHOWSSN)=1 S Y(6)=$$FMTE^XLFDT($P($G(XTMP1),U,3),"D")
 S Y(7)=$P($G(^VA(200,DISPDUZ,3.1)),U,6)
 S Y(8)=$P($G(XTMP5),U,2)
 S Y(9)=$P($G(XTMP),U,7)
 S Y(10)=$P($G(XTMP),U,11)
 S Y(11)=$P($G(XTMP),U,13)
 S Y(12)=$P($G(^VA(200,DISPDUZ,201)),U,1)
 I $G(Y(12))>0 S Y(12)=$P($G(^DIC(19,Y(12),0)),U,1)
 S Y(13,0)=$P($G(^VA(200,DISPDUZ,203,0)),U,4) ;number of entries
 I Y(13,0)>0 S (XI,XJ)=0 F  D  Q:XI=""
 . S XJ=XJ+1,XI=$O(^VA(200,DISPDUZ,203,XI))
 . I XI'="" S Y(13,XJ)=$P($G(^VA(200,DISPDUZ,203,XI,0)),U,1)
 . I $G(Y(13,XJ))>0 S Y(13,XJ)=$P($G(^DIC(19,Y(13,XJ),0)),U,1)
 S Y(14)=$P($G(XTMP),U,4)
 S Y(15,0)=$P($G(^VA(200,DISPDUZ,2,0)),U,4) ;number of entries
 I Y(15,0)>0 S (XI,XJ)=0 F  D  Q:XI=""
 . S XJ=XJ+1,XI=$O(^VA(200,DISPDUZ,2,XI))
 . I XI'="" S Y(15,XJ)=$P($G(^VA(200,DISPDUZ,2,XI,0)),U,1)
 . I $G(Y(15,XJ))>0 S Y(15,XJ)=$P($G(^DIC(4,Y(15,XJ),0)),U,1)
 S Y(16)=$P($G(XTMP5),U,1)
 I $G(Y(16))>0 S Y(16)=$P($G(^DIC(49,Y(16),0)),U,1)
 S Y(17)=$P($G(XTMP501),U,2)
 S Y(18)=$TR($P($G(XTMP205),U,1),"%","^")
 S Y(19)=$P($G(XTMP205),U,2)
 S Y(20)=$P($G(XTMP205),U,3)
 S Y(21)=$P($G(XTMP205),U,4)
 S Y(22)=$P($G(XTMP501),U,1)
 S Y(23)=$P($G(XTMP205),U,5)
 Q
 ;
IAMAU(Y,NAME,SECID,EMAIL,ADUPN,SSN,DOB,STATION,AUTHCODE) ;RPC. XUS IAM ADD USER
 ;Identity and Access Management Add User RPC for SSOi provisioning
 ; The XUSPF200 security key is required to add a user without an SSN (file #200 special privileges).
 ; Input:  NAME      = SubjectID to be used in SAML Token
 ;         SECID     = UniqueUserID to be used in SSOi or SSOe SAML Token
 ;         EMAIL     = User's e-mail address
 ;         ADUPN     = Active Directory User Principle Name
 ;         SSN       = User's Social Security Number or Taxpayer Identification Number
 ;         DOB       = User's Date of Birth
 ;         STATION   = NEW PERSON file (#200) DIVISION
 ;         AUTHCODE  = Security Phrase for IAM Provisioning Application
 ; Return: Fail    Y = "-1^Error Message"
 ;         Success Y = "DUZ^DIVISION"
 ;
 ; ZEXCEPT: %DT
 N DIC,DUZZERO,ERRMSG,FDR,IEN,NEWDUZ,X,XARRAY,XDIV,XUENTRY,Y
 I DUZ'>1 S Y="-1^Unauthorized access" Q
 I '+$$ACTIVE^XUSER(DUZ) S Y="-1^Unauthorized access" Q
 I ('$$SSNCHECK^XUESSO1($G(SSN)))&('$$KCHK^XUSRB("XUSPF200")) S Y="-1^Unauthorized access" Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 S Y=XUENTRY Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U,1)'="IAM PROVISIONING" S Y="-1^Unauthorized access" Q
 I $G(NAME)="" S Y="-1^Missing SubjectID" Q
 I $G(SECID)="" S Y="-1^Missing SecID" Q
 S XARRAY(1)="Department of Veterans Affairs"
 S XARRAY(2)="urn:oid:2.16.840.1.113883.4.349"
 S XARRAY(3)=SECID
 S XARRAY(4)=NAME
 S XARRAY(7)=SECID
 S XARRAY(9)=$G(SSN)
 S Y=$$FINDUSER^XUESSO2(.XARRAY) ;See if user already exists
 I +Y<0 I $P(Y,U,2)'="User not found" Q
 I +Y>0 S Y="-1^User already exists" Q
 S Y=$$ADDUSER^XUESSO2(.XARRAY) ;Add the user
 I +Y<0 Q
 S NEWDUZ=Y
 ;Use FM calls to edit the user with the remaining information
 K ^TMP("DIERR",$J)
 S DIC(0)="",ERRMSG=""
 S IEN=NEWDUZ_","
 I $G(EMAIL)'="" S FDR(200,IEN,.151)=$$LOW^XLFSTR(EMAIL)
 I $G(ADUPN)'="" S FDR(200,IEN,205.5)=$$LOW^XLFSTR(ADUPN)
 I $G(DOB)'="" S X=DOB S %DT="EX" D ^%DT S DOB=Y S FDR(200,IEN,5)=DOB
 I $G(STATION)'="" D
 . S XDIV="" S XDIV=$O(^DIC(4,"B",$G(STATION),XDIV))
 . I XDIV'="" D
 . . S FDR(200.02,"+3,"_IEN,.01)=XDIV
 . . S FDR(200.02,"+3,"_IEN,.02)=1
 ; Apply all the changes
 S DUZZERO=DUZ(0),DUZ(0)="@" ;Make sure we can update the entry
 I $D(FDR) K IEN D UPDATE^DIE("E","FDR","IEN") ;File all the data
 S DUZ(0)=DUZZERO ;Restore original FM access
 I $D(^TMP("DIERR",$J)) S Y="-1^FileMan error for DUZ="_NEWDUZ Q  ;FileMan Error
 I +ERRMSG<0 S Y=ERRMSG_" for DUZ="_NEWDUZ Q  ;Couldn't update user
 I +NEWDUZ<1 S Y="-1^Update failed for DUZ="_NEWDUZ Q
 S Y=NEWDUZ_U_STATION
 Q
 ;
IAMEU(Y,INARRY,AUTHCODE) ;RPC. XUS IAM EDIT USER
 ;Identity and Access Management Edit User RPC for SSOi provisioning
 ; The XUSPF200 security key is required to edit a user without an SSN (file #200 special privileges).
 ; The XUSHOWSSN security key is required allow lookup, display, and edit of PII (SSN and DoB).
 ; Input:  INARRY    = Array: The IAM RSD is unclear what that data is or how it will be formatted.
 ;         AUTHCODE  = Security Phrase for IAM Provisioning Application
 ; Return: Fail    Y = "-1^Error Message"
 ;         Success Y = The IAM RSD is unclear what is expected of a successful edit.
 ;
 N XUENTRY
 I DUZ'>1 S Y="-1^Unauthorized access" Q
 I '+$$ACTIVE^XUSER(DUZ) S Y="-1^Unauthorized access" Q
 I '$$KCHK^XUSRB("XUSHOWSSN") S Y="-1^Unauthorized access" Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 S Y=XUENTRY Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U,1)'="IAM PROVISIONING" S Y="-1^Unauthorized access" Q
 ;***** Set up call to find an existing user
 ;S Y=$$FINDUSER^XUESSO2(.XARRAY) ;Example call to identify user
 ;***** Or (preferred), look up user by DUZ (require application to do a FIND, select, and DISPLAY before EDIT)
 ;***** If SSN is not passed, look up SSN of current user and check for security key. Also check format of SSN.
 ;I ('$$SSNCHECK^XUESSO1($G(SSN)))&('$$KCHK^XUSRB("XUSPF200")) S Y="-1^Unauthorized access" Q
 ;***** Make sure fields are formatted correctly for Update into NPF
 ;***** Use FM calls to edit the user with the remaining information
 ;***** Must include a means to change name and to delete (empty) fields with erroneous info
 S Y="-1^Not implemented yet"
 Q
 ;
IAMBU(Y,SECID,AUTHCODE) ;RPC. XUS IAM BIND USER
 ;Identity and Access Management Edit User RPC for SSOi binding
 ; Input:  SECID     = unique Security ID [SecID, assigned by Identity and Access Management]
 ;         AUTHCODE  = Security Phrase for IAM Binding Application
 ; Return: Fail    Y = "-1^Error Message"
 ;         Success Y = DUZ
 ;
 N XARRY,XRESULT,XUENTRY
 I DUZ'>1 S Y="-1^Unauthorized access" Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 S Y=XUENTRY Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U,1)'="IAM BINDING" S Y="-1^Unauthorized access" Q
 S XARRY(1)="Department of Veterans Affairs" ;Subject Organization
 S XARRY(2)="urn:oid:2.16.840.1.113883.4.349" ;Subject Organization ID
 S XARRY(3)=$G(SECID) ;Unique User ID
 S XARRY(7)=$G(SECID) ;SecID
 I $G(SECID)'="" S XRESULT=$$FINDUSER^XUESSO2(.XARRY)
 I XRESULT'=DUZ S Y="-1^Another user has the same SecID" Q
 S Y=XRESULT
 Q
 ;
ESSO(RET,DOC) ; RPC. XUS ESSO VALIDATE
 ;This API/RPC uses the VA Identity and Access Management (IAM) SAML token definition version 1.2 attributes
 ; from a STS SAML token for user sign-on.
 ; Input:     DOC    = Closed reference to global root containing XML document (loaded STS SAML Token).
 ;                     See $$EN^MXMLDOM instructions in the VistA Kernel Developers Guide for required
 ;                     format of the DOC global.
 ; Return:    RET(0) = DUZ if sign-on was OK, zero if not OK.
 ;            RET(1) = (0=OK, 1,2...=Can't sign on for some reason).
 ;            RET(2) = Verify Code needs changing.
 ;            RET(3) = Message.
 ;            RET(4) = 0
 ;            RET(5) = count of the number of lines of text, zero if none.
 ;            RET(5+n) = message text.
 ;
 N VCCH,XARRY,XDIV,XDIVA,XOPT,XUDEV,XUF,XUHOME,XUM,XUMSG,XUVOL,X,Y
 S U="^",RET(0)=0,RET(5)=0,XUF=$G(XUF,0),XUM=0,XUMSG=0,XUDEV=0
 ; Begin user sign-on
 S DUZ=0,DUZ(0)="",VCCH=0 D NOW^XUSRB
 S XOPT=$$STATE^XWBSEC("XUS XOPT")
 S XUVOL=^%ZOSF("VOL"),XUMSG=$$INHIBIT^XUSRB() I XUMSG S XUM=1 G VAX^XUSRB ;Logon inhibited
 ;3 Strikes
 I $$LKCHECK^XUSTZIP($G(IO("IP"))) S XUMSG=7 G VAX^XUSRB ;IP locked
 S DUZ=$$EN^XUSAML(DOC) ;Process SAML token
 I DUZ'>0,$$FAIL^XUS3 D  G VAX^XUSRB
 . S XUM=1,XUMSG=7,X=$$RA^XUSTZ H 5 ;3 Strikes
 S XUMSG=$$UVALID^XUS() G:XUMSG VAX^XUSRB ;Check if user is locked out, terminated, or disusered
 S VCCH=$$VCVALID^XUSRB() ;Check if VC needs changing
 I DUZ>0 S XUMSG=$$POST^XUSRB(1)
 I XUMSG>0 S DUZ=0,VCCH=0 ;If can't sign-on, don't tell need to change VC
 I 'XUMSG,VCCH S XUMSG=12 D SET^XWBSEC("XUS DUZ",DUZ) ;Need to change VC
 S RET(0)=DUZ
 G VAX^XUSRB ;Fork to normal sign-on
 Q
 ;
ADDTOLST(XR,XCOUNT,XSHOWSSN,XRESULT) ;Subroutine. To be used exclusively by IAMFU^XUESSO3.
 N XFLAG,XI,XODOB,XONME,XOSEC,XOSSN,XOUPN
 S XFLAG=0
 F XI=1:1:XCOUNT D
 . I XRESULT=$P($G(XR(XI)),U,1) S XFLAG=1 ;Already in list, do not add again
 I XFLAG=0 D
 . S XCOUNT=XCOUNT+1
 . S XONME=$$NAME^XUSER(XRESULT,"F") ;Name
 . S XOSSN="<Hidden>" I $G(XSHOWSSN)=1 S XOSSN=$P($G(^VA(200,XRESULT,1)),U,9) ;SSN
 . S XODOB="<Hidden>" I $G(XSHOWSSN)=1 S XODOB=$$FMTE^XLFDT($P($G(^VA(200,XRESULT,1)),U,3),"D") ;DoB
 . S XOUPN=$P($G(^VA(200,XRESULT,205)),U,5) ;AD UPN
 . S XOSEC=$TR($P($G(^VA(200,XRESULT,205)),U,1),"%","^") ;SecID
 . S XR(XCOUNT)=XRESULT_"^"_XONME_"^"_XOSSN_"^"_XODOB_"^"_XOUPN_"^"_XOSEC
 Q
 ;
VACAA(INARRAY,AUTHCODE) ; Veterans Access, Choice, and Accountability Act of 2014 (VACAA)
 ; One-time use for XU*8*655, remove with next patch.
 ; VACAA will access this function from a KIDS post-install routine.
 ; Input:  INARRAY(1)  = NAME
 ;         INARRAY(2)  = DEGREE
 ;         INARRAY(3)  = SEX
 ;         INARRAY(4)  = STREET ADDRESS 1
 ;         INARRAY(5)  = STREET ADDRESS 2
 ;         INARRAY(6)  = STREET ADDRESS 3
 ;         INARRAY(7)  = CITY
 ;         INARRAY(8)  = STATE
 ;         INARRAY(9)  = ZIP
 ;         INARRAY(10) = NPI
 ;         INARRAY(11) = (Optional) TAX ID
 ;         INARRAY(12) = DEA #
 ;         INARRAY(13) = TW or HN
 ;         AUTHCODE    = String authorization phrase
 ; Return: Fail        = "-1^Error Message"
 ;         Success     = IEN of NEW PERSON file (#200) entry (Note: this routine will NOT set DUZ to the identified IEN)
 ;
 ; ZEXCEPT: DA,DD,DIC,DIE,DINUM,DLAYGO,DO,DR
 N FADA,FDR,IEN,X,XATTRIB,XDUZ,XIP,XSEC,XSTATE,XTAXID,Y
 I $$SHAHASH^XUSHSH(256,AUTHCODE)'="69AB5CA7FF413ACA7422D52E466B0C1220BE64C25AFB354E2915A572E251E560" Q "-1^Unauthorized access"
 I $G(INARRAY(1))="" Q "-1^Missing Name"
 I $G(INARRAY(4))="" Q "-1^Missing Street Addr"
 I $G(INARRAY(7))="" Q "-1^Missing City"
 I $G(INARRAY(8))="" Q "-1^Missing State"
 I $G(INARRAY(9))="" Q "-1^Missing Zip Code"
 I $G(INARRAY(10))="" Q "-1^Missing NPI"
 I '$$CHKDGT^XUSNPI($G(INARRAY(10))) Q "-1^Invalid NPI"
 S XATTRIB(8)=$G(INARRAY(10)) ; NPI
 S XDUZ=$$FINDUSER^XUESSO2(.XATTRIB) ; First find user based on NPI alone
 ;Set minimum 4 attributes
 I $G(INARRAY(13))="TW" S XATTRIB(1)="TriWest Healthcare Alliance" S XATTRIB(2)="http://www.triwest.com" ; Subject Organization and OID
 I $G(INARRAY(13))="HN" S XATTRIB(1)="Health Net, Inc." S XATTRIB(2)="http://www.healthnet.com" ; Subject Organization and OID
 S XATTRIB(3)=XATTRIB(8) ; Unique User ID = NPI per NHIN standard
 S XATTRIB(4)=INARRAY(1) ; Subject ID = NAME
 I (+XDUZ>0)&('+$$ACTIVE^XUSER(XDUZ)) S XDUZ=$$FINDUSER^XUESSO2(.XATTRIB) ; If not active user, lookup on NPI again, update M4A
 I +XDUZ<1 S XDUZ=$$ADDUSER^XUESSO2(.XATTRIB) ;Add the new user with M4A
 I +XDUZ<1 Q XDUZ  ;Quit with error code from ^XUESSO2
 S IEN=XDUZ_","
 I ($G(INARRAY(2))'="")&($P($G(^VA(200,XDUZ,3.1)),U,6)="") S FDR(200,IEN,10.6)=$E($G(INARRAY(2)),1,10)  ; DEGREE
 I (($G(INARRAY(3))="M")!($G(INARRAY(3))="F"))&($P($G(^VA(200,XDUZ,1)),U,2)="") S FDR(200,IEN,4)=$E($G(INARRAY(3)),1,1)  ; SEX
 I ($L($G(INARRAY(4)))>2)&($P($G(^VA(200,XDUZ,.11)),U,1)="") S FDR(200,IEN,.111)=$E($G(INARRAY(4)),1,50)  ; STREET ADDRESS 1
 I ($L($G(INARRAY(5)))>2)&($P($G(^VA(200,XDUZ,.11)),U,2)="") S FDR(200,IEN,.112)=$E($G(INARRAY(5)),1,50)  ; STREET ADDRESS 2
 I ($L($G(INARRAY(6)))>2)&($P($G(^VA(200,XDUZ,.11)),U,3)="") S FDR(200,IEN,.113)=$E($G(INARRAY(6)),1,50)  ; STREET ADDRESS 3
 I ($L($G(INARRAY(7)))>2)&($P($G(^VA(200,XDUZ,.11)),U,4)="") S FDR(200,IEN,.114)=$E($G(INARRAY(7)),1,30)  ; CITY
 I ($G(INARRAY(8))'="")&($P($G(^VA(200,XDUZ,.11)),U,5)="") D
 . I $L($G(INARRAY(8)))>2 S XSTATE="" S XSTATE=$O(^DIC(5,"B",$G(INARRAY(8)),XSTATE))
 . I $L($G(INARRAY(8)))=2 D
 . . S XIP=""
 . . D POSTAL^XIPUTIL($G(INARRAY(9)),.XIP)
 . . S XSTATE=$G(XIP("STATE POINTER"))
 . I XSTATE'="" S FDR(200,IEN,.115)=XSTATE ; STATE (pointer to ^DIC(5))
 I ($G(INARRAY(9))'="")&($P($G(^VA(200,XDUZ,.11)),U,6)="") S FDR(200,IEN,.116)=$G(INARRAY(9))  ; ZIP CODE
 D APPLY(.FDR,IEN) K FDR S IEN=XDUZ_","
 S XTAXID=$TR($G(INARRAY(11)),"-","")
 I XTAXID'="" D
 . S XTAXID=$E(XTAXID,1,2)_"-"_$E(XTAXID,3,9)
 . S XTAXID=$TR(XTAXID," ","0")
 I (XTAXID'="")&($P($G(^VA(200,XDUZ,"TPB")),U,2)="") S FDR(200,IEN,53.92)=XTAXID  ; TAX ID
 D APPLY(.FDR,IEN) K FDR S IEN=XDUZ_","
 I $P($G(^VA(200,XDUZ,"TPB")),U,1)="" S FDR(200,IEN,53.91)=1 ; NON-VA PRESCRIBER: (1=YES)
 I $P($G(^VA(200,XDUZ,"PS")),U,6)="" S FDR(200,IEN,53.6)=4 ; PROVIDER TYPE: (4=FEE BASIS)
 D APPLY(.FDR,IEN) K FDR S IEN=XDUZ_","
 I '+$$ACTIVE^XUSER(XDUZ)'="" D  ;Could not get UPDATE^DIE to work consistently for these fields
 . I $G(INARRAY(12))'="" D
 . . S FDR(200,IEN,53.1)=1 ; AUTHORIZED TO WRITE MED ORDERS: (1=YES)
 . . D APPLY(.FDR,IEN)
 . . S DIE="^VA(200,",DA=XDUZ,DR="53.2////"_INARRAY(12) ; DEA # (stuff, due to duplicate DEA#s and user name changes)
 . . L +^VA(200,XDUZ):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) D ^DIE L -^VA(200,XDUZ)
 . I $D(^VA(200,XDUZ,"PS")) D
 . . I '$P(^VA(200,XDUZ,"PS"),"^",4)!($P(^VA(200,XDUZ,"PS"),"^",4)>DT) D  ;Give user "XUORES" key if not an active user
 . . . S DA=XDUZ
 . . . K DIC S DIC="^DIC(19.1,",DIC(0)="MZ",X="XUORES" D ^DIC
 . . . K DIC S FADA=XDUZ
 . . . I +Y>0 S X=+Y D
 . . . . S:'$D(^VA(200,FADA,51,0)) ^VA(200,FADA,51,0)="^"_$P(^DD(200,51,0),"^",2)_"^^"
 . . . . S DIC="^VA(200,"_FADA_",51,",DIC(0)="LM",DIC("DR")="1////"_$S($G(DUZ):DUZ,1:"")_";2///"_DT,DLAYGO=200.051,DINUM=X,DA(1)=FADA
 . . . . L +^VA(200,FADA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) K DD,DO D FILE^DICN L -^VA(200,FADA) K DIC,DR,X,Y
 . . I $P($G(^VA(200,XDUZ,"PS")),"^",5)="" D  ; PROVIDER CLASS (pointer to ^DIC(7))
 . . . S X=0
 . . . S X=$O(^DIC(7,"B","PHYSICIAN",X))
 . . . I X>0 D
 . . . . S DIE="^VA(200,",DA=XDUZ,DR="53.5////"_X
 . . . . L +^VA(200,XDUZ):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) D ^DIE L -^VA(200,XDUZ)
 Q XDUZ
APPLY(FDR,IEN) ; Apply the changes, used by "VACAA", remove with next patch
 ;ZEXCEPT: DIC
 K ^TMP("DIERR",$J)
 S DIC(0)=""
 I $D(FDR) K IEN D UPDATE^DIE("E","FDR","IEN") ;File all the data
 Q
