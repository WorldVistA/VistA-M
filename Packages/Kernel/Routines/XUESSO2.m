XUESSO2 ;ISD/HGW Enhanced Single Sign-On Utilities ;11/21/2019  09:45
 ;;8.0;KERNEL;**655,659,630,701**;Jul 10, 1995;Build 11
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This utility will identify a VistA user for auditing and HIPAA requirements.
 ;   NONE of the fields listed below can contain a caret (^) character as it is used as a delimiter in VistA!
 ;
 ; $$FINDUSER() - At least one of the following attributes is required to uniquely identify an existing user in the
 ;                NEW PERSON file (#200):
 ;
 ;   XATR(7) = unique Security ID [SecID, assigned by Identity and Access Management]
 ;   XATR(8) = unique National Provider Identifier [assigned by Centers for Medicare and Medicaid Services (CMS)]
 ;   XATR(9) = unique Social Security (SSN) or Taxpayer Identification Number (TIN) [assigned by the Social Security Administration]
 ;   XATR(2) and XATR(3) = combination of a unique Subject Organization ID (OID) with a Unique User ID (UID) [see below]
 ;
 ; $$ADDUSER() - If an existing user is not found in the NEW PERSON file (#200), then the following minimum attributes
 ;               are required to provision a new user:
 ;
 ;   XATR(1) = Subject Organization [free text, 3-50 characters]
 ;   XATR(2) = Subject Organization ID [free text, 1-50 characters, unique to Subject Organization]
 ;   XATR(3) = Unique User ID [free text, 1-40 characters, unique within OID]
 ;   XATR(4) = Subject ID [person's name, to be entered into the NAME field (#.01) of the NEW PERSON file (#200)]
 ;
 ; The following attributes are optional for adding or updating a user, but may be required by a particular VistA application
 ;               for further Identity and Access Management:
 ;
 ;   XATR(5) = Application ID [Security Phrase to identify and authenticate the client application and establish the context option]
 ;   XATR(6) = Network Username [Active Directory Login]
 ;   XATR(9) = unique Social Security (SSN) or Taxpayer Identification Number (TIN) [assigned by the Social Security Administration]
 ;   XATR(10)= AD UPN [Active Directory User Principle Name (UPN)]
 ;   XATR(11)= E-Mail Address
 Q
 ;
FINDUSER(XATR) ;Function. Find user using minimum attributes for user identification
 ; Input:  XATR    = Array containing user attributes (see above).
 ; Return: Fail    = "-1^Error Message"
 ;         Success = IEN of NEW PERSON file (#200) entry (Note: this routine will NOT set DUZ to the identified IEN)
 ;
 N TODAY,DT,IEN,DIC,XUNAME,ERRMSG
 S U="^",TODAY=$$HTFM^XLFDT($H),DT=$P(TODAY,"."),ERRMSG=""
 ; Check for unique identifier (SecID, NPI, SSN, or OID+UID)
 I ($G(XATR(7))="")&($G(XATR(8))="")&($G(XATR(9))="")&(($G(XATR(2))="")&($G(XATR(3))="")) Q "-1^Array does not contain a unique identifier"
 ; Format user attributes to match FileMan fields
 S XATR(1)=$$TITLE^XLFSTR($E($G(XATR(1)),1,50))                      ;Subject Organization
 S XATR(2)=$$LOW^XLFSTR($E($G(XATR(2)),1,50))                        ;Subject Organization ID
 S XATR(3)=$TR($$LOW^XLFSTR($E($G(XATR(3)),1,40)),"^","%")           ;Unique User ID
 ;p701
 ;I $G(XATR(4))'="" D  Q:ERRMSG'="" ERRMSG
 ;. S XUNAME=XATR(4) S XATR(4)=$$FORMAT^XLFNAME7(.XUNAME,3,35,,0,,,2) ;Subject ID converted to standard format
 ;. I $G(XATR(4))'?1U.E1","1U.E S ERRMSG="-1^Subject ID could not be converted to 'LAST,FIRST MIDDLE SUFFIX' VistA standard format"
 S XATR(6)=$$UP^XLFSTR($E($G(XATR(6)),1,50))                         ;AD Network Username
 S XATR(7)=$TR($E($G(XATR(7)),1,40),"^","%")                         ;SecID
 Q $$TALL(.XATR)
 ;
TALL(XATR) ;Function. Find an existing user.
 N OID,UID,SECID,NPI,SSN,NEWDUZ,ERRMSG,AOIUID,X,Y,Z
 S $ECODE="" ;look at current stack, not error stack
 S X=$ST($ST-1,"PLACE"),Y=$P(X,"+"),Z=$P(X,"^",2),X=Y_"^"_$P(Z," ")
 I X'="FINDUSER^XUESSO2" Q "-1^Not authorized"
 I $G(DUZ("LOA"))<2 Q "-1^Not authorized"
 S OID=$G(XATR(2))
 S UID=$G(XATR(3))
 S SECID=$G(XATR(7))
 S NPI=$G(XATR(8))
 S SSN=$G(XATR(9))
 S ERRMSG="",NEWDUZ=0,Y=0
 ;See if match SECID, to be assigned by Identification and Access Management (IAM) services.
 I $L(SECID)>0 D  Q:ERRMSG'="" ERRMSG
 . S Y=$$SECMATCH(SECID) Q:Y<1
 . I NPI'="" D  Q:ERRMSG'=""
 . . I NPI'=$P($G(^VA(200,Y,"NPI")),U) S ERRMSG="-1^NPI mismatch for user ID'd by SecID" Q
 . I SSN'="" D  Q:ERRMSG'=""
 . . I SSN'=$P($G(^VA(200,Y,1)),U,9) S ERRMSG="-1^SSN mismatch for user ID'd by SecID" Q
 . S NEWDUZ=Y
 . S ERRMSG=$$UPDU(.XATR,NEWDUZ) ; Update fields if changes are needed
 . Q
 I NEWDUZ>0 Q NEWDUZ ;Quit here if we found a match on SECID
 ;See if match NPI
 I $L(NPI)>0 D  Q:ERRMSG'="" ERRMSG
 . S Y=+$O(^VA(200,"ANPI",NPI,0)) Q:Y<1
 . I SECID'="" D  Q:ERRMSG'=""
 . . I $$SECMATCH(SECID)<1 S ERRMSG="-1^SecID mismatch for user ID'd by NPI" Q
 . I SSN'="" D  Q:ERRMSG'=""
 . . I SSN'=$P($G(^VA(200,Y,1)),U,9) S ERRMSG="-1^SSN mismatch for user ID'd by NPI" Q
 . S NEWDUZ=Y
 . S ERRMSG=$$UPDU(.XATR,NEWDUZ) ; Update fields if changes are needed
 . Q
 I NEWDUZ>0 Q NEWDUZ ;Quit here if we found a match on NPI
 ;See if match SSN
 I $L(SSN)>0 D  Q:ERRMSG'="" ERRMSG
 . S Y=+$O(^VA(200,"SSN",SSN,0)) Q:Y<1
 . I SECID'="" D  Q:ERRMSG'=""
 . . I $$SECMATCH(SECID)<1 S ERRMSG="-1^SecID mismatch for user ID'd by SSN" Q
 . I NPI'="" D  Q:ERRMSG'=""
 . . I NPI'=$P($G(^VA(200,Y,"NPI")),U) S ERRMSG="-1^NPI mismatch for user ID'd by SSN" Q
 . S NEWDUZ=Y
 . S ERRMSG=$$UPDU(.XATR,NEWDUZ) ; Update fields if changes are needed
 . Q
 I NEWDUZ>0 Q NEWDUZ ;Quit here if we found a match on SSN
 ;See if match OID+UID ("AOIUID" cross-reference).
 S Y=$$AOIUID(OID,UID) I Y>0 D  Q:ERRMSG'="" ERRMSG
 . I SECID'="" D  Q:ERRMSG'=""
 . . I $$SECMATCH(SECID)<1 S ERRMSG="-1^SecID mismatch for user ID'd by OID+UID" Q
 . I NPI'="" D  Q:ERRMSG'=""
 . . I NPI'=$P($G(^VA(200,Y,"NPI")),U) S ERRMSG="-1^NPI mismatch for user ID'd by OID+UID" Q
 . I SSN'="" D  Q:ERRMSG'=""
 . . I SSN'=$P($G(^VA(200,Y,1)),U,9) S ERRMSG="-1^SSN mismatch for user ID'd by OID+UID" Q
 . S NEWDUZ=Y
 . S ERRMSG=$$UPDU(.XATR,NEWDUZ) ; Update fields if changes are needed
 . Q
 I NEWDUZ>0 Q NEWDUZ ;Quit here if we found a match on OID+UID
 Q "-1^User not found"
 ;
ADDUSER(XATR) ;Function. Add user using minimum attributes for user identification
 ; Input:  XATR    = Array containing user attributes (see above).
 ; Return: Fail    = "-1^Error Message"
 ;         Success = IEN of NEW PERSON file (#200) entry (Note: this routine will NOT set DUZ to the identified IEN)
 ;
 N SID,NEWDUZ,ERRMSG
 I '$$AUTH() Q "-1^Not an authorized calling routine"
 I $G(DUZ("LOA"))<2 Q "-1^Not authorized"
 S ERRMSG=""
 ;Minimum 4 Attributes are required to add a new user
 I ($G(XATR(1))="")!($L($G(XATR(1)))<4) Q "-1^Subject Organization is required to add a new user"
 I ($G(XATR(2))="")!($L($G(XATR(2)))<4) Q "-1^Subject Organization ID is required to add a new user"
 I $G(XATR(3))="" Q "-1^Unique User ID is required to add a new user"
 I $G(XATR(4))="" Q "-1^Subject ID is required to add a new user"
 ; Format user attributes to match FileMan fields
 S XATR(1)=$$TITLE^XLFSTR($E($G(XATR(1)),1,50))                      ;Subject Organization
 S XATR(2)=$$LOW^XLFSTR($E($G(XATR(2)),1,50))                        ;Subject Organization ID
 S XATR(3)=$TR($$LOW^XLFSTR($E($G(XATR(3)),1,40)),"^","%")           ;Unique User ID
 I $G(XATR(4))'="" D  Q:ERRMSG'="" ERRMSG ;
 . S SID=XATR(4) S XATR(4)=$$FORMAT^XLFNAME7(.SID,3,35,,0,,,2) ; Subject ID converted to standard format
 . I $G(XATR(4))'?1U.E1","1U.E S ERRMSG="-1^Subject ID could not be converted to VistA standard format"
 S XATR(6)=$$UP^XLFSTR($E($G(XATR(6)),1,15))                         ;AD Network Username
 S XATR(7)=$TR($E($G(XATR(7)),1,40),"^","%")                         ;SecID
 S NEWDUZ=$$ADDU(XATR(4)) ;Put the name in the .01 field first
 I +NEWDUZ<1 Q "-1^Create of new user record failed"
 S ERRMSG=$$UPDU(.XATR,NEWDUZ) ;Then update the remaining fields
 I +ERRMSG<0 D CLEAN(NEWDUZ) Q ERRMSG ;Delete the added user if update fails (incomplete record)
 I +NEWDUZ<1 Q "-1^Create or update of user record failed"
 Q NEWDUZ  ;Every thing OK
 ;
SECMATCH(SECID) ;Function. Find match for SECID.
 N Y,Z
 I $G(SECID)="" Q ""
 S Y=0,Z=0
 F  D  Q:Y=""
 . S Y=$O(^VA(200,"ASECID",$E(SECID,1,30),Y))
 . I Y>0 D  Q
 . . I SECID=$P($G(^VA(200,Y,205)),U,1) S Z=Y,Y=""
 Q Z
 ;
UPNMATCH(ADUPN) ;Function. Find match for ADUPN.
 N W,Y,Z
 I $G(ADUPN)="" Q ""
 S W=$E(ADUPN,1,30),Y=0,Z=0
 F  D  Q:Y=""
 . S Y=$O(^VA(200,"ADUPN",$G(ADUPN),Y))
 . I Y>0 D  Q
 . . I ADUPN=$P($G(^VA(200,Y,205)),U,5) S Z=Y,Y=""
 Q Z
 ;
AOIUID(OID,UID) ;Function. Find match for OID+UID cross-reference.
 N W,X,Y,Z
 I ($G(OID)="")!($G(UID)="") Q ""
 S W=$E(OID,1,30),X=$E(UID,1,30),Y=0,Z=0
 F  D  Q:Y=""
 . S Y=$O(^VA(200,"AOIUID",W,X,Y))
 . I Y>0 D  Q
 . . I (OID=$P($G(^VA(200,Y,205)),U,3))&(UID=$P($G(^VA(200,Y,205)),U,4)) S Z=Y,Y=""
 Q Z
 ;
NETMAIL(NETNAME,MAIL) ;Function. Find match for NETWORK USERNAME and EMAIL ADDRESS
 N L1,L2,N,Y,Z
 S NETNAME=$G(NETNAME),MAIL=$G(MAIL)
 S L1=$L(NETNAME),L2=$L(MAIL)
 Q:(L1=0)&(L2=0) 0
 S Y=0,Z=0,N=0
 F  D  Q:Y=""
 . S Y=$O(^VA(200,Y))
 . S N=N+1
 . I (N#10000)=0 H 1
 . I Y>0 D
 . . I L1,NETNAME=$P($G(^VA(200,Y,501)),U,1) S Z=Y,Y="" Q
 . . I L2,MAIL=$P($G(^VA(200,Y,.15)),U,1) S Z=Y,Y="" Q
 Q Z
 ;
ADDU(XUNAME) ;Function. Add a new name to the NPF
 N DD,DO,DIC,DA,X,Y,DUZZERO
 K ^TMP("DIERR",$J)
 S DIC="^VA(200,",DIC(0)="F",X=XUNAME
 ; Get a LOCK. Block if can't get.
 L +^VA(200,"HL7"):10 Q:'$T "-1^Addition of new users is blocked"
 S DUZZERO=DUZ(0),DUZ(0)="@" ;Make sure we can add the entry
 D FILE^DICN
 S DUZ(0)=DUZZERO ;Restore original FM access
 L -^VA(200,"HL7")
 Q +Y
 ;
UPDU(XATR,NEWDUZ) ;Function. Update user in the NPF
 N DUZZERO,DIC,ERRMSG,FDR,IEN,XUCODE,XUENTRY
 K ^TMP("DIERR",$J)
 S DIC(0)="",ERRMSG=""
 S IEN=NEWDUZ_","
 I ($G(XATR(1))'=""),(XATR(1)'=$P($G(^VA(200,NEWDUZ,205)),U,2)) S FDR(200,IEN,205.2)=$$TITLE^XLFSTR($E($G(XATR(1)),1,50)) ;SORG
 I ($G(XATR(2))'=""),(XATR(2)'=$P($G(^VA(200,NEWDUZ,205)),U,3)) S FDR(200,IEN,205.3)=$$LOW^XLFSTR($E($G(XATR(2)),1,50)) ;OID
 I ($G(XATR(3))'=""),(XATR(3)'=$P($G(^VA(200,NEWDUZ,205)),U,4)) S FDR(200,IEN,205.4)=$TR($$LOW^XLFSTR($E($G(XATR(3)),1,40)),"^","%") ;UID
 I ($G(XATR(6))'=""),(XATR(6)'=$P($G(^VA(200,NEWDUZ,501)),U,1)) S FDR(200,IEN,501.1)=$$UP^XLFSTR($E($G(XATR(6)),1,15)) ;NETWORK USERNAME
 I ($G(XATR(7))'=""),(XATR(7)'=$P($G(^VA(200,NEWDUZ,205)),U,1)) S FDR(200,IEN,205.1)=$TR($E($G(XATR(7)),1,40),"^","%") ;SecID
 I ($G(XATR(8))'=""),(XATR(8)'=$P($G(^VA(200,NEWDUZ,"NPI")),U,1)) S FDR(200,IEN,41.99)=$G(XATR(8)) ;NPI
 I ($G(XATR(9))'=""),(XATR(9)'=$P($G(^VA(200,NEWDUZ,1)),U,9)) S ERRMSG=$$ADDS(.FDR,NEWDUZ,$G(XATR(9))) I ERRMSG'="" Q ERRMSG ;SSN
 I ($G(XATR(10))'=""),(XATR(10)'=$P($G(^VA(200,NEWDUZ,205)),U,5)) S FDR(200,IEN,205.5)=$$LOW^XLFSTR($G(XATR(10))) ;ADUPN
 I ($G(XATR(11))'=""),(XATR(11)'=$P($G(^VA(200,NEWDUZ,.15)),U,1)) S FDR(200,IEN,.151)=$$LOW^XLFSTR($G(XATR(11))) ;e-mail
 I $G(XATR(5))'="" S ERRMSG=$$SETCNTXT(NEWDUZ,$G(XATR(5))) I ERRMSG'="" Q ERRMSG ;Assign Context Option
 ; Apply all the changes
 S DUZZERO=DUZ(0),DUZ(0)="@" ;Make sure we can update the entry
 I $D(FDR) K IEN D UPDATE^DIE("E","FDR","IEN") ;File all the data
 S DUZ(0)=DUZZERO ;Restore original FM access
 I $D(^TMP("DIERR",$J)) Q "-1^FileMan error"  ;FileMan Error
 I +ERRMSG<1 Q ERRMSG ;Couldn't update user
 I +NEWDUZ<1 Q "-1^Update of user record failed"
 Q ""
 ;
ADDS(FDR,NEWDUZ,SSN) ;Function. Add a SSN to the NPF
 N IEN,ERRMSG
 S IEN=NEWDUZ_",",ERRMSG=""
 I '$$SSNCHECK^XUESSO1(SSN) Q "-1^SSN is not valid per SSA criteria"
 S FDR(200,IEN,9)=SSN
 Q ERRMSG
 ;
CLEAN(Y) ;Subroutine. Clean up (delete) incomplete record in NPF
 ; ZEXCEPT: DA,DIK
 N DUZZERO
 S DUZZERO=DUZ(0),DUZ(0)="@" ;Make sure we can update the entry
 I +Y>0 D
 . K DA,DIK S DIK="^VA(200,",DA=+Y D ^DIK
 S DUZ(0)=DUZZERO ;Restore original FM access
 Q
 ;
SETCNTXT(NEWDUZ,XAPHRASE) ;Function. Assign Context Option to user Secondary Menu Options
 N OPT,XUENTRY,XOPT,XUCONTXT,X
 S XUENTRY=$$GETCNTXT(XAPHRASE) I +XUENTRY<0 Q XUENTRY
 S DUZ("REMAPP")=XUENTRY_U_$$GET1^DIQ(8994.5,XUENTRY_",",.01)
 S XOPT=$P($G(^XWB(8994.5,XUENTRY,0)),U,2)
 I XOPT'>0 Q "-1^Context Option must be identified in the REMOTE APPLICATION file"
 S XUCONTXT="`"_XOPT
 I $$FIND1^DIC(19,"","X",XUCONTXT)'>0 Q "-1^Context Option not in OPTION file"
 ;Have to use $D because of screen in 200.03 keeps FIND1^DIC from working.
 I '$D(^VA(200,NEWDUZ,203,"B",XOPT)) D
 . ; Have to give the user a delegated option
 . N XARR S XARR(200.19,"+1,"_NEWDUZ_",",.01)=XUCONTXT
 . D UPDATE^DIE("E","XARR")
 . ; And now user can give self the context option
 . K XARR S XARR(200.03,"+1,"_NEWDUZ_",",.01)=XUCONTXT
 . D UPDATE^DIE("E","XARR") ; Give context option as a secondary menu item
 . ; But now we have to remove the delegated option
 . S OPT=$$FIND1^DIC(200.19,","_NEWDUZ_",","X",XUCONTXT)
 . I OPT>0 D
 . . K XARR S XARR(200.19,(OPT_","_NEWDUZ_","),.01)="@"
 . . D FILE^DIE("E","XARR")
 . . Q
 . Q
 Q ""
 ;
GETCNTXT(XAPHRASE) ;Function. Identify the REMOTE APPLICATION
 N XUCODE,XUENTRY
 ;Identify Remote Application with SHA256 hash
 S XUCODE=$$SHAHASH^XUSHSH(256,$G(XAPHRASE),"B") ; ICR #6189
 S XUENTRY=$$FIND1^DIC(8994.5,"","X",XUCODE,"ACODE")
 ;If not found, check with old hash and replace with SHA256 hash if found
 I XUENTRY'>0 D
 . S XUCODE=$$EN^XUSHSH($G(XAPHRASE)) ; IA #10045
 . S XUENTRY=$$FIND1^DIC(8994.5,"","X",XUCODE,"ACODE")
 . I XUENTRY>0 D
 . . S XUCODE=$$SHAHASH^XUSHSH(256,$G(XAPHRASE),"B") ; ICR #6189
 . . N FDR
 . . S FDR(8994.5,XUENTRY_",",.03)=XUCODE
 . . D FILE^DIE("E","FDR")
 I XUENTRY'>0 Q "-1^Application ID must be registered in the REMOTE APPLICATION file"
 Q XUENTRY
 ;
AUTH() ;Function. Check if calling routine is authorized
 ; ^XUESSO2 does not address the security issue of user authentication, so a restriction is placed on the calling routine.
 N X,Z
 S $ECODE="" ;look at current stack, not error stack
 S X=$ST($ST-2,"PLACE"),Z=$P(X,"^",2),X="^"_$P(Z," ")
 I $E(X,1,3)="^XU" Q 1          ;Authorized Kernel access
 Q 0
 ;
