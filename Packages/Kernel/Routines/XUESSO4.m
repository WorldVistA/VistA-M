XUESSO4 ;ISD/HGW Enhanced Single Sign-On Utilities ;04/12/17  10:23
 ;;8.0;KERNEL;**659,630**;Jul 10, 1995;Build 13
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
IAMBU(Y,SECID,AUTHCODE,ADUPN) ;RPC. XUS IAM BIND USER - ICR #6294
 ;Identity and Access Management Edit User RPC for SSOi binding
 ; Input:  SECID     = unique Security ID [SecID, assigned by Identity and Access Management]
 ;         AUTHCODE  = Security Phrase for IAM Binding Application
 ;         ADUPN     = Active Directory UPN
 ; Return: Fail    Y = "-1^Error Message"
 ;         Success Y = DUZ
 ;
 ; ZEXCEPT: DIERR ;FileMan special variables
 N DUZZERO,FDR,IEN,XARRY,XRESULT,XUENTRY,XUIAM
 I DUZ'>1 S Y="-1^Unauthorized access" Q
 I $G(SECID)="" S Y="-1^Missing Security ID (SecID)" Q
 I $G(AUTHCODE)="" S Y="-1^Missing Security Phrase" Q
 S XUENTRY=$$GETCNTXT^XUESSO2($G(AUTHCODE)) I +XUENTRY<0 S Y=XUENTRY Q
 I $P($G(^XWB(8994.5,XUENTRY,0)),U,1)'="IAM BINDING" S Y="-1^Unauthorized access" Q
 S XUIAM=1 ;Do not trigger IAM updates
 S XARRY(7)=$G(SECID) ;SecID
 I $G(SECID)'="" S XRESULT=$$FINDUSER^XUESSO2(.XARRY)
 I (+XRESULT>0)&(XRESULT'=DUZ) S Y="-1^This SecID has already been assigned to another user" Q
 ;Use FM calls to edit the user
 K ^TMP("DIERR",$J)
 S IEN=DUZ_","
 S FDR(200,IEN,205.1)=$TR($E($G(SECID),1,40),"^","%")              ;SecID
 S FDR(200,IEN,205.2)=$P($G(^XTV(8989.3,1,200)),U,2)               ;Subject Organization
 S FDR(200,IEN,205.3)=$P($G(^XTV(8989.3,1,200)),U,3)               ;Subject Organization ID
 S FDR(200,IEN,205.4)=$TR($E($G(SECID),1,40),"^","%")              ;Unique User ID
 I $D(ADUPN) S FDR(200,IEN,205.5)=$$LOW^XLFSTR($E($G(ADUPN),1,50)) ;ADUPN
 ; Apply all the changes: File valid values and reject invalid values (no "T" flag).
 S DUZZERO=DUZ(0),DUZ(0)="@" ;Make sure we can update the entry
 I $D(FDR) D FILE^DIE("ET","FDR") ;File all the data
 S DUZ(0)=DUZZERO ;Restore original FM access
 I $D(DIERR) S Y="-1^Error binding VistA user to IAM" Q
 S Y=DUZ
 Q
 ;
VACAA(INARRAY,AUTHCODE) ; Veterans Access, Choice, and Accountability Act of 2014 (VACAA)
 ; Bulk-load non-VA provider information.
 ; This interface is available under a private Integration Agreement (#6230) for support
 ; of VACAA only, and should not be used under any other circumstances.
 ; Input:  INARRAY(0)  = VISN
 ;         INARRAY(1)  = NAME
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
 ;         INARRAY(13) = Subject Organization
 ;         INARRAY(14) = Subject Organization ID
 ; Return: Fail        = "-1^Error Message"
 ;         Neutral     = 0 (not an error, but entry should not be made at this site)
 ;         Success     = IEN of NEW PERSON file (#200) entry
 ;
 ; ZEXCEPT: DA,DD,DIC,DIE,DINUM,DLAYGO,DO,DR
 N FADA,FDR,IEN,VIEN,VISN,X,XATTRIB,XDUZ,XIP,XSEC,XSTATE,XTAXID,XUIAM,XUVISN,Y
 I $$SHAHASH^XUSHSH(256,AUTHCODE)'="69AB5CA7FF413ACA7422D52E466B0C1220BE64C25AFB354E2915A572E251E560" Q "-1^Unauthorized access"
 I '$$PROD^XUPROD Q "-1^Not a production account"
 I $G(INARRAY(0))="" Q "-1^Missing VISN"
 I $G(INARRAY(1))="" Q "-1^Missing Name"
 I $G(INARRAY(4))="" Q "-1^Missing Street Addr"
 I $G(INARRAY(7))="" Q "-1^Missing City"
 I $G(INARRAY(8))="" Q "-1^Missing State"
 I $G(INARRAY(9))="" Q "-1^Missing Zip Code"
 I $G(INARRAY(10))="" Q "-1^Missing NPI"
 I $G(INARRAY(13))="" Q "-1^Missing Subject Organization"
 I $G(INARRAY(14))="" Q "-1^Missing Subject Organization ID"
 I '$$CHKDGT^XUSNPI($G(INARRAY(10))) Q "-1^Invalid NPI"
 D PARENT^XUAF4("XUVISN","`"_DUZ(2),"VISN") ;Returns XUVISN("P",pien)="VISN #^"
 S VIEN=$O(XUVISN("P",0)) S VISN=$TR($P($G(XUVISN("P",VIEN)),U),"VISN ") ;Return VISN number (no text)
 I VISN'=INARRAY(0) Q 0  ; Only load data appropriate for the site's VISN (not an error)
 S DUZ(0)="@",XUIAM=1 ;Temporary high-level access to edit NPF, do not trigger IAM updates
 S XATTRIB(8)=INARRAY(10) ; NPI
 S XDUZ=$$FINDUSER^XUESSO2(.XATTRIB) ; First find user based on NPI alone
 ;Set minimum 4 attributes
 S XATTRIB(1)=INARRAY(13) ; Subject Organization
 S XATTRIB(2)=INARRAY(14) ; Subject Organization ID
 S XATTRIB(3)=XATTRIB(8) ; Unique User ID = NPI per NHIN standard
 S XATTRIB(4)=INARRAY(1) ; Subject ID = NAME
 I (+XDUZ>0)&('+$$ACTIVE^XUSER(XDUZ)) S XDUZ=$$FINDUSER^XUESSO2(.XATTRIB) ; If not active user, lookup on NPI again, update M4A
 I +XDUZ<1 S XDUZ=$$ADDUSER^XUESSO2(.XATTRIB) ;Add the new user with M4A
 I +XDUZ<1 Q XDUZ  ;Quit with error code from ^XUESSO2
 S IEN=XDUZ_","
 I $G(INARRAY(2))'="" S FDR(200,IEN,10.6)=$E($G(INARRAY(2)),1,10)  ; DEGREE
 I (($G(INARRAY(3))="M")!($G(INARRAY(3))="F")) S FDR(200,IEN,4)=$E($G(INARRAY(3)),1,1)  ; SEX
 I $L($G(INARRAY(4)))>2 S FDR(200,IEN,.111)=$E($G(INARRAY(4)),1,50)  ; STREET ADDRESS 1
 I $L($G(INARRAY(5)))>2 S FDR(200,IEN,.112)=$E($G(INARRAY(5)),1,50)  ; STREET ADDRESS 2
 I $L($G(INARRAY(6)))>2 S FDR(200,IEN,.113)=$E($G(INARRAY(6)),1,50)  ; STREET ADDRESS 3
 I $L($G(INARRAY(7)))>2 S FDR(200,IEN,.114)=$E($G(INARRAY(7)),1,30)  ; CITY
 I $G(INARRAY(8))'="" D
 . I $L($G(INARRAY(8)))>2 S XSTATE="" S XSTATE=$O(^DIC(5,"B",$G(INARRAY(8)),XSTATE))
 . I $L($G(INARRAY(8)))=2 D
 . . S XIP=""
 . . D POSTAL^XIPUTIL($G(INARRAY(9)),.XIP)
 . . S XSTATE=$G(XIP("STATE POINTER"))
 . I XSTATE'="" S FDR(200,IEN,.115)=XSTATE ; STATE (pointer to ^DIC(5))
 I $G(INARRAY(9))'="" S FDR(200,IEN,.116)=$G(INARRAY(9))  ; ZIP CODE
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
 S DUZ(0)=$P($G(^VA(200,DUZ,0)),U,4)
 Q XDUZ
 ;
APPLY(FDR,IEN) ; Apply the changes, used by "VACAA"
 ;ZEXCEPT: DIC
 K ^TMP("DIERR",$J)
 S DIC(0)=""
 I $D(FDR) K IEN D UPDATE^DIE("E","FDR","IEN") ;File all the data
 Q
 ;
ESSO(RET,DOC) ; RPC. XUS ESSO VALIDATE - IA #6295
 ;This API/RPC uses the VA Identity and Access Management (IAM) SAML token definition version 1.2 attributes
 ; from a STS SAML token for user sign-on.
 ; Input:     DOC    = Closed reference to global root containing XML document (loaded STS SAML Token).
 ;                     See $$EN^MXMLDOM instructions in the VistA Kernel Developers Guide for required
 ;                     format of the DOC global.
 ; Return:    RET(0) = DUZ if sign-on was OK, zero if not OK.
 ;            RET(1) = (0=OK, 1,2...=Can't sign on for some reason).
 ;            RET(2) = 0
 ;            RET(3) = Message.
 ;            RET(4) = 0
 ;            RET(5) = count of the number of lines of text, zero if none.
 ;            RET(5+n) = message text.
 ;
 N VCCH,XARRY,XDIV,XDIVA,XOPT,XUDEV,XUF,XUHOME,XOPTION,XUM,XUMSG,XUVOL,X,Y
 S U="^",RET(0)=0,RET(5)=0,XUF=$G(XUF,0),XUM=0,XUMSG=0,XUDEV=0
 ; Begin user sign-on
 S DUZ=0,DUZ(0)="" D NOW^XUSRB
 S VCCH=0 ;VC not needed per: Password Policy When Alternate Authentication Is Available (VAIQ #7781071)
 S XOPT=$$STATE^XWBSEC("XUS XOPT")
 S XUVOL=^%ZOSF("VOL")
 S XUMSG=$$INHIBIT^XUSRB() I XUMSG S XUM=1 G VAX^XUSRB ;Logon inhibited
 ;3 Strikes
 I $$LKCHECK^XUSTZIP($G(IO("IP"))) S XUMSG=7 G VAX^XUSRB ;IP locked
 S DUZ=$$EN^XUSAML(DOC) ;Process SAML token
 I DUZ'>0,$$FAIL^XUS3 D  G VAX^XUSRB
 . S XUM=1,XUMSG=7,X=$$RA^XUSTZ H 5 ;3 Strikes
 I DUZ'>0 S XUMSG=63 G VAX^XUSRB
 D USER^XUS(DUZ) ;Build USER
 S XUMSG=$$UVALID^XUS() G:XUMSG VAX^XUSRB ;Check if user is locked out, terminated, or disusered
 I DUZ>0 S XUMSG=$$POST^XUSRB(1)
 I XUMSG>0 S DUZ=0
 D:DUZ>0 POST2^XUSRB
 I +$G(DUZ("REMAPP"))>0 D  ;Role-based access
 . S XOPTION=$P($G(^XWB(8994.5,+DUZ("REMAPP"),0)),U,2)
 . I XOPTION>0 D SETCNTXT^XUSBSE1(XOPTION)
 S RET(0)=DUZ,RET(1)=XUM,RET(2)=0,RET(3)=$S(XUMSG:$$TXT^XUS3(XUMSG),1:""),RET(4)=0
 Q
 ;
