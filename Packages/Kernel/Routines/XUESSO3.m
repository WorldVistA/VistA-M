XUESSO3 ;ISD/HGW Enhanced Single Sign-On Utilities ;02/25/16  15:33
 ;;8.0;KERNEL;**655,659**;Jul 10, 1995;Build 22
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
IAMFU(R,NAME,SSN,DOB,ADUPN,SECID,AUTHCODE) ;RPC. XUS IAM FIND USER - IA #6288
 ; The XUSHOWSSN key is required to do lookups using PII (SSN or DoB).
 ; Input:  One or more of Name, SSN, DoB, AD UPN, and/or SecID must be provided.
 ;           AUTHCODE    = Security Phrase for IAM Provisioning Application
 ; Return:   Fail    R(0)="-1^Error Message"
 ;           Success R(0)=total number of entries found, from "0" to "n".
 ;                   R(1) through R(n)="DUZ^Name^NameComponents^SSN^Dob^AD UPN^SecID"
 ;
 ; ZEXCEPT: %DT
 N X,XARRY,XCOUNT,XI,XJ,XNAME,XRESULT,XSHOWSSN,XTEMP,XUENTRY,XUIAM,Y
 K R
 I DUZ'>1 S R(0)="-1^Unauthorized access" Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 S R(0)=XUENTRY Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U)'="IAM PROVISIONING" S R(0)="-1^Unauthorized access" Q
 S XUIAM=1 ;Do not trigger IAM updates
 S XSHOWSSN=$$KCHK^XUSRB("XUSHOWSSN")
 S XCOUNT=0
 ; 1. Search by NAME
 I $G(NAME)'="" D
 . D FIND^DIC(200,"","@","PC",NAME,"*","B")
 . S XI=0 F  S XI=$O(^TMP("DILIST",$J,XI)) Q:'XI  D
 . . S XRESULT=$G(^TMP("DILIST",$J,XI,0))
 . . D:XRESULT>0 ADDTOLST(.R,.XCOUNT,XSHOWSSN,XRESULT)
 . D CLEAN^DILF
 . K ^TMP("DILIST",$J)
 ; 2. Search by SSN
 I ($G(SSN)'="")&($G(XSHOWSSN)=1) D
 . S XARRY(9)=SSN
 . S XRESULT=$$FINDUSER^XUESSO2(.XARRY)
 . I +XRESULT>0 D ADDTOLST(.R,.XCOUNT,XSHOWSSN,XRESULT)
 . K XARRY(9)
 ; 3. Search by DOB
 I ($G(DOB)'="")&($G(XSHOWSSN)=1) D
 . S X=DOB,%DT="X" D ^%DT S X=Y,XRESULT=0
 . F  D  Q:XRESULT=""
 . . S XRESULT=$O(^VA(200,XRESULT)) Q:XRESULT=""
 . . I $P($G(^VA(200,XRESULT,1)),U,3)=X D ADDTOLST(.R,.XCOUNT,XSHOWSSN,XRESULT)
 ; 4. Search by ADUPN
 I $G(ADUPN)'="" D
 . S X=$$LOW^XLFSTR(ADUPN),XRESULT=0
 . S XRESULT=$$UPNMATCH^XUESSO2(ADUPN)
 . I XRESULT>0 D ADDTOLST(.R,.XCOUNT,XSHOWSSN,XRESULT)
 ; 5. Search by SECID
 I $G(SECID)'="" D
 . S XARRY(7)=SECID
 . S XRESULT=$$FINDUSER^XUESSO2(.XARRY)
 . I +XRESULT>0 D ADDTOLST(.R,.XCOUNT,XSHOWSSN,XRESULT)
 . K XARRY(7)
 ; 6. Return results
 S R(0)=XCOUNT
 Q
 ;
IAMDU(R,DISPDUZ,AUTHCODE) ;RPC. XUS IAM DISPLAY USER - IA #6289
 ; Input:  DISPDUZ        = DUZ (IEN) of user to be displayed
 ;         AUTHCODE       = Security Phrase for IAM Provisioning Application
 ; Return:   Fail    R(0) ="-1^Error Message"
 ;           Success R(0) = 1
 ;                   R("NAME") = NAME
 ;                   R("LASTNAME") = Family Name
 ;                   R("FIRSTNAME") = Given Name
 ;                   R("MIDDLENAME") = Middle Name
 ;                   R("SUFFIX") = Suffix(es)
 ;                   R("INITIAL") = INITIAL
 ;                   R("TITLE") = TITLE
 ;                   R("NICK_NAME") = NICK NAME
 ;                   R("SSN") = SSN (<Hidden> if caller does not have XUSHOWSSN key)
 ;                   R("DOB") = DOB (<Hidden> if caller does not have XUSHOWSSN key)
 ;                   R("DEGREE") = DEGREE
 ;                   R("MAIL_CODE") = MAIL CODE
 ;                   R("STATUS") = $$ACTIVE^XUSER(DISPDUZ)
 ;                   R("DISUSER") = DISUSER
 ;                   R("TERMINATION_DATE") = TERMINATION DATE
 ;                   R("TERMINATION_REASON") = TERMINATION REASON
 ;                   R("PRIMARY_MENU_OPTION") = PRIMARY MENU OPTION
 ;                   R("SECONDARY_MENU_OPTION",0) = SECONDARY MENU OPTION (number of entries)
 ;                   R("SECONDARY_MENU_OPTION",1) to R("SECONDARY_MENU_OPTION",n) = SECONDARY MENU OPTION entries
 ;                   R("FILE_MANAGER_ACCESS_CODE") = FILE MANAGER ACCESS CODE
 ;                   R("DIVISION",0) = DIVISION (number of entries)
 ;                   R("DIVISION",1) to R("DIVISION",n) = DIVISION entries
 ;                   R("SERVICE_SECTION") = SERVICE/SECTION
 ;                   R("SUBJECT_ALTERNATIVE_NAME") = SUBJECT ALTERNATIVE NAME (PIV CARD)
 ;                   R("SECID") = SECID
 ;                   R("ORGANIZATION_NAME") = SUBJECT ORGANIZATION
 ;                   R("ORGANIZATION_ID") = SUBJECT ORGANIZATION ID
 ;                   R("UNIQUE_USER_ID") = UNIQUE USER ID
 ;                   R("NETWORK_USER_NAME") = NETWORK USERNAME
 ;                   R("AD_UPN") = ADUPN
 ;                   R("EMAIL") = EMAIL ADDRESS
 ;                   R("GENDER") = SEX (M/F)
 ;
 N X,XI,XIEN,XJ,XN,XSHOWSSN,XT,XT1,XT205,XT5,XT501,XUENTRY,XUIAM,Y
 K R
 I DUZ'>1 S R(0)="-1^Unauthorized access" Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 S R(0)=XUENTRY Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U)'="IAM PROVISIONING" S R(0)="-1^Unauthorized access" Q
 I $G(DUZ("LOA"))<2 S R(0)="-1^Unauthorized access" Q
 I $G(DISPDUZ)'>0 S R(0)="-1^User not selected" Q
 I $G(^VA(200,DISPDUZ,0))="" S R(0)="-1^User not found" Q
 S XUIAM=1 ;Do not trigger IAM updates
 S XSHOWSSN=$$KCHK^XUSRB("XUSHOWSSN")
 S XT=$G(^VA(200,DISPDUZ,0))
 S XT1=$G(^VA(200,DISPDUZ,1))
 S XT5=$G(^VA(200,DISPDUZ,5))
 S XT205=$G(^VA(200,DISPDUZ,205))
 S XT501=$G(^VA(200,DISPDUZ,501))
 S R(0)=1
 S (XN,R("NAME"))=$P($G(XT),U)
 S XIEN=DISPDUZ_","
 S X=0 S X=$O(^VA(20,"BB",200,.01,XIEN,X)) ;Get NAME COMPONENTS
 S Y="" I +X>0 S Y=$G(^VA(20,X,1))
 S R("LASTNAME")=$P(Y,U)
 S R("FIRSTNAME")=$P(Y,U,2)
 S R("MIDDLENAME")=$P(Y,U,3)
 S R("SUFFIX")=$P(Y,U,4)
 S R("INITIAL")=$P($G(XT),U,2)
 S R("TITLE")="" S X=$P($G(XT),U,9)
 I $G(X)>0 S R("TITLE")=$P($G(^DIC(3.1,X,0)),U)
 S R("NICK_NAME")=$P($G(^VA(200,DISPDUZ,.1)),U,4)
 S R("SSN")="<Hidden>" I $G(XSHOWSSN)=1 S R("SSN")=$P($G(XT1),U,9)
 S R("DOB")="<Hidden>" I $G(XSHOWSSN)=1 S R("DOB")=$TR($$FMTE^XLFDT($P($G(XT1),U,3),"5DZ"),"/","")
 S R("DEGREE")=$P($G(^VA(200,DISPDUZ,3.1)),U,6)
 S R("MAIL_CODE")=$P($G(XT5),U,2)
 S R("STATUS")=$$ACTIVE^XUSER(DISPDUZ) ;Supported IA #2343
 S X=$P($G(R("STATUS")),U,3) I X'="" D
 . S X=$TR($$FMTE^XLFDT(X,"5DZ"),"/","")
 . S $P(R("STATUS"),U,3)=X
 S R("DISUSER")=$P($G(XT),U,7)
 S R("TERMINATION_DATE")=$TR($$FMTE^XLFDT($P($G(XT),U,11),"5DZ"),"/","")
 S R("TERMINATION_REASON")=$P($G(XT),U,13)
 S R("PRIMARY_MENU_OPTION")=$P($G(^VA(200,DISPDUZ,201)),U)
 I $G(R("PRIMARY_MENU_OPTION"))>0 S R("PRIMARY_MENU_OPTION")=$P($G(^DIC(19,R("PRIMARY_MENU_OPTION"),0)),U)
 S (XI,XJ)=0
 I $G(^VA(200,DISPDUZ,203,0))'="" F  D  Q:+XI'>0
 . S XI=$O(^VA(200,DISPDUZ,203,XI)) Q:+XI'>0
 . S XJ=XJ+1,R("SECONDARY_MENU_OPTION",XJ)=$P($G(^VA(200,DISPDUZ,203,XI,0)),U)
 . I $G(R("SECONDARY_MENU_OPTION",XJ))>0 S R("SECONDARY_MENU_OPTION",XJ)=$P($G(^DIC(19,R("SECONDARY_MENU_OPTION",XJ),0)),U)
 S R("SECONDARY_MENU_OPTION",0)=XJ ;number of entries
 S R("FILE_MANAGER_ACCESS_CODE")=$P($G(XT),U,4)
 S (XI,XJ)=0
 I $G(^VA(200,DISPDUZ,2,0))'="" F  D  Q:+XI'>0
 . S XI=$O(^VA(200,DISPDUZ,2,XI)) Q:+XI'>0
 . S XJ=XJ+1,R("DIVISION",XJ)=$P($G(^VA(200,DISPDUZ,2,XI,0)),U)
 . I $G(R("DIVISION",XJ))>0 S R("DIVISION",XJ)=$P($G(^DIC(4,R("DIVISION",XJ),99)),U)
 S R("DIVISION",0)=XJ ;number of entries
 S R("SERVICE_SECTION")=$P($G(XT5),U,1)
 I $G(R("SERVICE_SECTION"))>0 S R("SERVICE_SECTION")=$P($G(^DIC(49,R("SERVICE_SECTION"),0)),U)
 S R("SUBJECT_ALTERNATIVE_NAME")=$P($G(XT501),U,2)
 S R("SECID")=$TR($P($G(XT205),U),"%","^")
 S R("ORGANIZATION_NAME")=$P($G(XT205),U,2)
 S R("ORGANIZATION_ID")=$P($G(XT205),U,3)
 S R("UNIQUE_USER_ID")=$P($G(XT205),U,4)
 S R("NETWORK_USER_NAME")=$P($G(XT501),U)
 S R("AD_UPN")=$P($G(XT205),U,5)
 S R("EMAIL")=$P($G(^VA(200,DISPDUZ,.15)),U)
 S R("GENDER")=$P($G(XT1),U,2)
 Q
 ;
IAMAU(R,NAME,SECID,EMAIL,ADUPN,SSN,DOB,STATION,AUTHCODE) ;RPC. XUS IAM ADD USER - IA #6290
 ; The XUSPF200 security key is required to add a user without an SSN (file #200 special privileges).
 ; Input:  NAME      = SubjectID to be used in SAML Token
 ;         SECID     = UniqueUserID to be used in SSOi or SSOe SAML Token
 ;         EMAIL     = User's e-mail address
 ;         ADUPN     = Active Directory User Principle Name
 ;         SSN       = User's Social Security Number or Taxpayer Identification Number
 ;         DOB       = User's Date of Birth
 ;         STATION   = NEW PERSON file (#200) DIVISION
 ;         AUTHCODE  = (Required) Security Phrase for IAM Provisioning Application
 ; Return: Fail    R(0)               = "-1^Number of Errors"
 ;                 R(1) through R(n)  = "Error Message"
 ;         Success R(0)               = "DUZ^STATION"
 ;
 ; ZEXCEPT: %DT,DA,DIERR,DIK ;FileMan special variables
 N DIC,DUZZERO,ERRMSG,FDR,IEN,NEWDUZ,X,XARRAY,XDIV,XUENTRY,XUIAM,Y
 K R
 S R(0)=0
 I DUZ'>1 D EDITERR(.R,"Unauthorized access") Q
 I +$$ACTIVE^XUSER(DUZ)=0 D EDITERR(.R,"Unauthorized access") Q
 I $G(DUZ("LOA"))<2 D EDITERR(.R,"Unauthorized access") Q
 S XUIAM=1 ;Do not trigger IAM updates
 I ($G(SSN)'>1)&('$$KCHK^XUSRB("XUSPF200")) D EDITERR(.R,"Need XUSPF200 key if no SSN") Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 D EDITERR(.R,XUENTRY) Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U)'="IAM PROVISIONING" D EDITERR(.R,"Unauthorized access") Q
 I $G(NAME)="" D EDITERR(.R,"Missing SubjectID") Q
 I $G(SECID)="" D EDITERR(.R,"Missing SecID") Q
 S Y=$$SECMATCH^XUESSO2(SECID) I Y>0 D EDITERR(.R,"User with given SecID already exists") Q
 I $G(SSN)>1 S Y=+$O(^VA(200,"SSN",SSN,0))
 I Y>0 D EDITERR(.R,"User with given SSN already exists") Q
 I ($G(SSN)>1)&('$$SSNCHECK^XUESSO1($G(SSN))) D EDITERR(.R,"Invalid SSN") Q
 I $G(DOB)'="" D  Q:Y=-1
 . S X=DOB S %DT="X" D ^%DT I Y=-1 D EDITERR(.R,"Invalid DOB") Q
 . S DOB=$G(Y)
 I $G(STATION)'="" D  Q:Y=""
 . S Y="" S Y=$O(^DIC(4,"D",$G(STATION),Y))
 . I Y="" D EDITERR(.R,"-1^Invalid STATION") Q
 . S XDIV=$P($G(^DIC(4,Y,0)),U,1)
 S XARRAY(1)=$P($G(^XTV(8989.3,1,200)),U,2)
 S XARRAY(2)=$P($G(^XTV(8989.3,1,200)),U,3)
 S XARRAY(3)=SECID
 S XARRAY(4)=NAME
 S XARRAY(7)=SECID
 S XARRAY(9)=$G(SSN)
 S Y=$$ADDUSER^XUESSO2(.XARRAY) ;Add the user
 I +Y<0 D EDITERR(.R,Y) Q
 S NEWDUZ=Y
 ;Use FM calls to edit the user with the remaining information
 K ^TMP("DIERR",$J)
 S DIC(0)="",ERRMSG=""
 S IEN=NEWDUZ_","
 I $G(EMAIL)'="" S FDR(200,IEN,.151)=$$LOW^XLFSTR(EMAIL)
 I $G(ADUPN)'="" S FDR(200,IEN,205.5)=$$LOW^XLFSTR(ADUPN)
 I $G(DOB)'="" S FDR(200,IEN,5)=DOB
 I $G(XDIV)'="" S FDR(200.02,"+3,"_IEN,.01)=XDIV
 ; Apply all the changes: File valid values and reject invalid values.
 S DUZZERO=DUZ(0),DUZ(0)="@"
 I $D(FDR) K IEN D UPDATE^DIE("E","FDR","IEN") ;File all the data
 S DUZ(0)=DUZZERO ;Restore original FM access
 I $D(DIERR) D
 . S Y=0
 . F  D  Q:+Y'>0
 . . S Y=$O(^TMP("DIERR",$J,Y)) I +Y>0 W !,$G(^TMP("DIERR",$J,Y,"TEXT",1))
 . . I +Y>0 D EDITERR(.R,$G(^TMP("DIERR",$J,Y,"TEXT",1))) ;FileMan Error
 . K DA,DIK S DIK="^VA(200,",DA=NEWDUZ D ^DIK ;Rollback add if all fields could not be filed
 I +$G(R(0))'=-1 S R(0)=NEWDUZ_U_STATION
 Q
 ;
IAMEU(R,INARRY,AUTHCODE) ;RPC. XUS IAM EDIT USER - IA #6291
 ; The XUSHOWSSN security key is required to allow edit of PII (SSN and DoB).
 ; Input:  INARRY("SECID")            = SecID - Used to identify entry to be edited
 ;         INARRAY("LASTNAME")        = User NAME is "LASTNAME,FIRSTNAME MIDDLENAME SUFFIX"
 ;         INARRAY("FIRSTNAME")
 ;         INARRAY("MIDDLENAME")
 ;         INARRAY("SUFFIX")
 ;         INARRY("ORGANIZATION_NAME")= SUBJECT ORGANIZATION
 ;         INARRY("ORGANIZATION_ID")  = SUBJECT ORGANIZATION ID
 ;         INARRY("EMAIL")            = EMAIL ADDRESS
 ;         INARRY("AD_UPN")           = ADUPN
 ;         INARRY("SSN")              = SSN
 ;         INARRY("DOB")              = DOB (Date of Birth)
 ;         AUTHCODE                   = Security Phrase for IAM Provisioning Application
 ; Return: Fail    R(0)               = "-1^Number of Errors"
 ;                 R(1) through R(n)  = "Error Message"
 ;         Success R(0)               = DUZ of NEW PERSON file entry that was edited
 ;
 ; ZEXCEPT: %DT,DIERR ;FileMan special variables
 N DUZZERO,FDR,IEN,X,XARRAY,XDUZ,XSHOWSSN,XUENTRY,XUIAM,XUN,XUNAME,XUNEWN,XUOLDN,Y
 K R
 S R(0)=0
 S XUIAM=1 ;Do not trigger IAM updates
 I DUZ'>1 D EDITERR(.R,"Unauthorized access") Q
 I +$$ACTIVE^XUSER(DUZ)=0 D EDITERR(.R,"Unauthorized access") Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 D EDITERR(.R,$P(XUENTRY,U,2)) Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U)'="IAM PROVISIONING" D EDITERR(.R,"Unauthorized access") Q
 I $G(DUZ("LOA"))<2 D EDITERR(.R,"Unauthorized access") Q
 I $G(INARRY("SECID"))="" D EDITERR(.R,"User not identified by SecID") Q
 S XARRAY(7)=INARRY("SECID")
 S XDUZ=$$SECMATCH^XUESSO2(XARRAY(7)) I XDUZ'>0 D EDITERR(.R,"User not found") Q
 I $S($P(^VA(200,XDUZ,0),U,11):$P(^VA(200,XDUZ,0),U,11)<DT,1:0) D EDITERR(.R,"Not allowed to edit terminated user") Q
 S XSHOWSSN=$$KCHK^XUSRB("XUSHOWSSN")
 I ($G(INARRY("SSN")))&('XSHOWSSN) D EDITERR(.R,"XUSHOWSSN Security Key is required to edit SSN")
 I ($G(INARRY("DOB")))&('XSHOWSSN) D EDITERR(.R,"XUSHOWSSN Security Key is required to edit DOB")
 ;Use FM calls to edit the user with the remaining information
 K ^TMP("DIERR",$J)
 S IEN=XDUZ_","
 S XUN("FILE")=200,XUN("IENS")=IEN,XUN("FIELD")=.01
 S XUOLDN=$$NAMEFMT^XLFNAME(.XUN,"F","CS")
 K XUN S XUN=XUOLDN
 D NAMECOMP^XLFNAME(.XUN)
 I $D(INARRY("LASTNAME")) S XUN("FAMILY")=$G(INARRY("LASTNAME"))
 I $D(INARRY("FIRSTNAME")) S XUN("GIVEN")=$G(INARRY("FIRSTNAME"))
 I $D(INARRY("MIDDLENAME")) S XUN("MIDDLE")=$G(INARRY("MIDDLENAME"))
 I $D(INARRY("SUFFIX")) S XUN("SUFFIX")=$G(INARRY("SUFFIX"))
 S XUNEWN=$$NAMEFMT^XLFNAME(.XUN,"F","CS")
 I XUNEWN'=XUOLDN S FDR(200,IEN,.01)=XUNEWN ;set NAME if changed
 I $G(INARRY("ORGANIZATION_NAME"))'="" D
 . S X=$$TITLE^XLFSTR($E(INARRY("ORGANIZATION_NAME"),1,50))
 . I X'=$P($G(^VA(200,XDUZ,205)),U,2) S FDR(200,IEN,205.2)=X ;set SUBJECT ORGANIZATION if changed
 I $G(INARRY("ORGANIZATION_ID"))'="" D
 . S X=$$LOW^XLFSTR($E(INARRY("ORGANIZATION_ID"),1,50))
 . I X'=$P($G(^VA(200,XDUZ,205)),U,3) S FDR(200,IEN,205.3)=X ;set SUBJECT ORGANIZATION ID if changed
 I $G(INARRY("EMAIL"))'="" D
 . S X=$$LOW^XLFSTR(INARRY("EMAIL"))
 . I X'=$P($G(^VA(200,XDUZ,.15)),U) S FDR(200,IEN,.151)=X ;set EMAIL ADDRESS if changed
 I $G(INARRY("AD_UPN"))'="" D
 . S X=$$LOW^XLFSTR($E(INARRY("AD_UPN"),1,50))
 . I X'=$P($G(^VA(200,XDUZ,205)),U,5) S FDR(200,IEN,205.5)=X ;edit ADUPN if changed
 I ($G(INARRY("SSN"))'="")&(XSHOWSSN) D
 . S X=+$O(^VA(200,"SSN",INARRY("SSN"),0)) ;Search for existing user with this SSN
 . I +X>0 D  ;SSN found
 . . I +X'=XDUZ D  ;SSN assigned to another user
 . . . D EDITERR(.R,"This SSN is assigned to another user")
 . . ; else SSN is assigned to this user, so no need to change SSN
 . E  D  ;SSN not found
 . . I $$SSNCHECK^XUESSO1(INARRY("SSN")) D  ;validate SSN
 . . . S FDR(200,IEN,9)=INARRY("SSN") ;edit SSN if valid
 . . E  D  ;error if SSN not valid
 . . . D EDITERR(.R,"Not a valid SSN")
 I ($G(INARRY("DOB"))'="")&(XSHOWSSN) D
 . S X=INARRY("DOB") S %DT="X" D ^%DT
 . I Y>1 D
 . . I Y'=$P($G(^VA(200,XDUZ,1)),U,3) S FDR(200,IEN,5)=Y ;edit DOB if changed
 . E  D  ;error if DOB not valid
 . . D EDITERR(.R,"Not a valid DOB")
 ; Apply all the changes: File valid values and reject invalid values.
 S DUZZERO=DUZ(0),DUZ(0)="@"
 I $D(FDR) D FILE^DIE("E","FDR") ;File all the data
 S DUZ(0)=DUZZERO ;Restore original FM access
 I $D(DIERR) D
 . S Y=0
 . F  D  Q:+Y'>0
 . . S Y=$O(^TMP("DIERR",$J,Y))
 . . I +Y>0 D EDITERR(.R,$G(^TMP("DIERR",$J,Y,"TEXT",1))) ;FileMan Error
 E  I +$G(R(0))'=-1 D
 . S R(0)=XDUZ
 Q
 ;
IAMTU(R,SECID,TERMDATE,TERMRESN,AUTHCODE) ;RPC. XUS IAM TERMINATE USER - IA #6292
 ; Input:  SECID                     = SECID - Used to identify entry to be edited
 ;         TERMDATE                  = TERMINATION DATE
 ;         TERMRESN                  = Termination Reason
 ;         AUTHCODE                  = Security Phrase for IAM Provisioning Application
 ; Return: Fail    R(0)              = "-1^Number of Errors"
 ;                 R(1) through R(n) = "Error Message"
 ;         Success R(0)              = DUZ
 ;
 ; ZEXCEPT: %DT,DIERR ;FileMan special variables
 N DUZZERO,FDR,IEN,INARRY,X,XARRAY,XDUZ,XUENTRY,XUIAM,Y
 K R
 S R(0)=0
 S XUIAM=1 ;Do not trigger IAM updates
 I DUZ'>1 D EDITERR(.R,"Unauthorized access") Q
 I +$$ACTIVE^XUSER(DUZ)=0 D EDITERR(.R,"Unauthorized access") Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 D EDITERR(.R,$P(XUENTRY,U,2)) Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U)'="IAM PROVISIONING" D EDITERR(.R,"Unauthorized access") Q
 I $G(SECID)="" D EDITERR(.R,"User not identified by SecID") Q
 I $G(TERMDATE)="" D EDITERR(.R,"Missing Termination Date") Q
 I $G(TERMRESN)="" D EDITERR(.R,"Missing Termination Reason") Q
 S XARRAY(7)=SECID ;SecID
 S XDUZ=$$FINDUSER^XUESSO2(.XARRAY) ;Find user to be terminated
 I +XDUZ'>1 D EDITERR(.R,"User not found") Q
 ;Use FM calls to edit the user
 K ^TMP("DIERR",$J)
 S IEN=XDUZ_","
 S FDR(200,IEN,9.2)=TERMDATE ;set Termination Date
 S FDR(200,IEN,9.4)=$E(TERMRESN,1,45) ;set Termination Reason
 ; Apply the changes.
 S DUZZERO=DUZ(0),DUZ(0)="@"
 I $D(FDR) D FILE^DIE("E","FDR") ;File all the data
 S DUZ(0)=DUZZERO ;Restore original FM access
 I $D(DIERR) D
 . S Y=0
 . F  D  Q:+Y'>0
 . . S Y=$O(^TMP("DIERR",$J,Y))
 . . I +Y>0 D EDITERR(.R,$G(^TMP("DIERR",$J,Y,"TEXT",1))) ;FileMan Error
 E  I +$G(R(0))'=-1 D
 . S R(0)=XDUZ
 Q
 ;
IAMRU(R,SECID,AUTHCODE) ;RPC. XUS IAM REACTIVATE USER - IA #6293
 ; Input:  SECID                     = SECID - Used to identify entry to be edited
 ;         AUTHCODE                  = Security Phrase for IAM Provisioning Application
 ; Return: Fail    R(0)              = "-1^Number of Errors"
 ;                 R(1) through R(n) = "Error Message"
 ;         Success R(0)              = 1
 ;
 ; ZEXCEPT: DIERR ;FileMan special variables
 N DUZZERO,FDR,IEN,INARRY,X,XARRAY,XDUZ,XUENTRY,XUIAM,Y
 K R
 S R(0)=0
 S XUIAM=1 ;Do not trigger IAM updates
 I DUZ'>1 D EDITERR(.R,"Unauthorized access") Q
 I +$$ACTIVE^XUSER(DUZ)=0 D EDITERR(.R,"Unauthorized access") Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 D EDITERR(.R,$P(XUENTRY,U,2)) Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U)'="IAM PROVISIONING" D EDITERR(.R,"Unauthorized access") Q
 I $G(SECID)="" D EDITERR(.R,"User not identified by SecID") Q
 S XARRAY(7)=SECID ;SecID
 S XDUZ=$$FINDUSER^XUESSO2(.XARRAY) ;Find user to be reactivated
 I +XDUZ'>1 D EDITERR(.R,"User not found") Q
 K ^TMP("DIERR",$J)
 S IEN=XDUZ_","
 S FDR(200,IEN,9.2)="" ;set Termination Date
 ; Apply the changes.
 S DUZZERO=DUZ(0),DUZ(0)="@"
 I $D(FDR) D FILE^DIE("E","FDR") ;File all the data
 S DUZ(0)=DUZZERO ;Restore original FM access
 I $D(DIERR) D
 . S Y=0
 . F  D  Q:+Y'>0
 . . S Y=$O(^TMP("DIERR",$J,Y))
 . . I +Y>0 D EDITERR(.R,$G(^TMP("DIERR",$J,Y,"TEXT",1))) ;FileMan Error
 E  I +$G(R(0))'=-1 D
 . S R(0)=XDUZ
 Q
 ;
ADDTOLST(XR,XCOUNT,XSHOWSSN,XRESULT) ;Intrinsic Subroutine. Add user to list.
 N XFLAG,XI,XODOB,XONME,XONMEC,XOSEC,XOSSN,XOUPN
 S XFLAG=0
 F XI=1:1:XCOUNT D
 . I XRESULT=$P($G(XR(XI)),U) S XFLAG=1
 I XFLAG=0 D
 . S XCOUNT=XCOUNT+1
 . S XONME=$P($G(^VA(200,XRESULT,0)),U)
 . S XONMEC=$$NAMECOMP(XRESULT)
 . S XOSSN="<Hidden>" I $G(XSHOWSSN)=1 S XOSSN=$P($G(^VA(200,XRESULT,1)),U,9)
 . S XODOB="<Hidden>" I $G(XSHOWSSN)=1 S XODOB=$TR($$FMTE^XLFDT($P($G(^VA(200,XRESULT,1)),U,3),"5DZ"),"/","")
 . S XOUPN=$P($G(^VA(200,XRESULT,205)),U,5)
 . S XOSEC=$TR($P($G(^VA(200,XRESULT,205)),U),"%","^")
 . S XR(XCOUNT)=XRESULT_"^"_XONME_"^"_XONMEC_"^"_XOSSN_"^"_XODOB_"^"_XOUPN_"^"_XOSEC
 Q
 ;
NAMECOMP(IEN) ;Intrinsic Function. Get NAME COMPONENTS.
 N NAME,NC1,NCIEN
 S NCIEN=$O(^VA(20,"BB",200,.01,IEN_",",0))
 Q:'NCIEN ""
 S NC1=$G(^VA(20,NCIEN,1))
 Q $TR($P(NC1,U,1,3)_U_$P(NC1,U,5),U,"`")
 ;
EDITERR(Y,XMSG) ;Intrinsic Subroutine. Add error to list.
 N I
 S:$P(XMSG,"-1^")="" $E(XMSG,1,3)=""
 S I=$O(Y(""),-1)+1,Y(I)=XMSG,Y(0)=-1_U_I
 Q
