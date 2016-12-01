XUSAML ;ISD/HGW Kernel SAML Token Implementation ;10/01/15  14:40
 ;;8.0;KERNEL;**655,659**;Jul 10, 1995;Build 22
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Implements the Kernel SAML Token message framework for the Identification and
 ; Access Management (IAM) Single Sign-On (SSO) security model.
 ;
 Q
EN(DOC) ;Function. Main entry point
 ;This function parses and processes the VA Identity and Access Management (IAM) STS SAML token
 ; (version 1.2) and returns the DUZ of the user, if found. It does not log the user into VistA.
 ; Input:     DOC     = Closed reference to global root containing XML document (loaded STS SAML Token)
 ;                      Example: S Y=$$EN^XUSAML($NA(^TMP($J,1)))
 ; Return:    Fail    = "-1^Error Message"
 ;            Success = DUZ
 ;ZEXCEPT: XOBDATA ;environment variable
 N HDL,XASSRT,XUPN,Y
 K ^TMP("XUSAML",$J)
 S Y="-1^Error parsing STS SAML Token",XUPN="",XASSRT=""
 S XOBDATA("XOB RPC","SECURITY","STATE")="notauthenticated"
 S XOBDATA("XOB RPC","SAML","ASSERTION")="notvalidated"
 ;--- Call parser
 S HDL=$$EN^MXMLDOM(DOC,"W")
 I HDL>0 D
 . D ND(HDL,1,1,.XUPN,.XASSRT) ;Traverse and process document
 . S Y="-1^Invalid SAML assertion"
 . ;Interim solution, code to be deprecated and removed after ???? (date and time)
 . I $$LOW^XLFSTR($G(^TMP("XUSAML",$J,"Name","authnsystem")))="m4a" D
 . . S Y=$$FINDUSER()
 . . I +Y>0 H $E(DT,1,3)-316 ; Add "hang time" as this interface ages to encourage migration
 . E  D
 . . ;End of Interim solution, code to be deprecated and removed after ???? (date and time)
 . . D VALASSRT(.XASSRT,DOC) ;Validate SAML assertion
 . . I $G(XOBDATA("XOB RPC","SAML","ASSERTION"))="validated" D
 . . . S Y=$$FINDUSER()
 . D DELETE^MXMLDOM(HDL)
 I +Y>0 S XOBDATA("XOB RPC","SECURITY","STATE")="authenticated"
 K ^TMP("XUSAML",$J)
 Q Y
ND(HDL,ND,FS,XUPN,XASSRT) ;SR. Traverse tree
 N CH,SIB,TX
 D SH(HDL,ND,.XUPN,.XASSRT)
 S CH=0
 S CH=$$CHILD^MXMLDOM(HDL,ND,CH)
 I CH D ND(HDL,CH,1,.XUPN,.XASSRT)
 Q:'FS  ;Don't follow the siblings of siblings
 S SIB=ND
 F  S SIB=$$SIBLING^MXMLDOM(HDL,SIB) Q:'SIB  D ND(HDL,SIB,0,.XUPN,.XASSRT)
 Q
SH(HDL,ND,XUPN,XASSRT) ;SR. Process node elements
 ;ZEXCEPT: XOBDATA ;environment variable
 N ELE,I,NM,V,VV,XCHILD,XERR,XTEXT,XVALUE
 S ELE=$$NAME^MXMLDOM(HDL,ND)
 ; --------------------  saml:Subject Event Processing  --------------------------------
 I (ELE="Subject")!(ELE="saml:Subject")!(ELE="ns2:Subject") D  Q  ;Subject element is required
 . S XASSRT("Subject")="yes"
 I (ELE="SubjectConfirmationData")!(ELE="saml:SubjectConfirmationData")!(ELE="ns2:SubjectConfirmationData") D  Q
 . D EL(HDL,ND,.NM,.XUPN)
 . S XASSRT("SubjectConfirmationData@Address")=$O(^TMP("XUSAML",$J,"SubjectConfirmationData@Address",""))
 . S XASSRT("SubjectConfirmationData@Recipient")=$O(^TMP("XUSAML",$J,"SubjectConfirmationData@Recipient",""))
 ;
 ; --------------------  saml:Conditions Event Processing  -------------------------
 I (ELE="Conditions")!(ELE="saml:Conditions")!(ELE="ns2:Conditions") D  Q
 . D EL(HDL,ND,.NM,.XUPN)
 . S XASSRT("NotBefore")=$O(^TMP("XUSAML",$J,"NotBefore",""))
 . S XASSRT("NotOnOrAfter")=$O(^TMP("XUSAML",$J,"NotOnOrAfter",""))
 ;
 ; --------------------  saml:AuthnStatement Event Processing  -------------------------
 I (ELE="AuthnStatement")!(ELE="saml:AuthnStatement")!(ELE="ns2:AuthnStatement") D  Q
 . D EL(HDL,ND,.NM,.XUPN)
 . S XASSRT("AuthnInstant")=$O(^TMP("XUSAML",$J,"AuthnInstant",""))
 I (ELE="AuthnContextClassRef")!(ELE="saml:AuthnContextClassRef")!(ELE="ns2:AuthnContextClassRef") D  Q
 . S XUPN="AuthnContextClassRef"
 . D CH(HDL,ND,XUPN)
 . S XASSRT("AuthnContextClassRef")=$G(^TMP("XUSAML",$J,"AuthnContextClassRef"))
 ;
 ; --------------------  saml:Attribute Event Processing  ------------------
 I (ELE="Attribute")!(ELE="saml:Attribute")!(ELE="ns2:Attribute") D  Q
 . S XCHILD=$$CHILD^MXMLDOM(HDL,ND) ;Identify child (AttributeValue) of node ND
 . S XTEXT="" S XERR=$$TEXT^MXMLDOM(HDL,XCHILD,$NA(VV)) ;Get text of AttributeValue
 . I XERR=1 F I=1:1 Q:'$D(VV(I))  S XTEXT=XTEXT_VV(I)
 . S NM=""
 . F  S NM=$$ATTRIB^MXMLDOM(HDL,ND,NM) Q:'$L(NM)  D  ;Get name of Attribute
 . . I $G(NM)="Name" D
 . . . S XVALUE=$$VALUE^MXMLDOM(HDL,ND,NM)
 . . . S ^TMP("XUSAML",$J,NM,XVALUE)=XTEXT ;Set up the ^TMP global for the Attribute
 Q
CH(HDL,ND,XUPN) ;SR. Process text node
 N I,VV,Y
 I $G(XUPN)'="" D
 . S Y=""
 . D TEXT^MXMLDOM(HDL,ND,$NA(VV))
 . I $D(VV)>2 F I=1:1 Q:'$D(VV(I))  S Y=Y_VV(I)
 . I $P(XUPN,"^",2)="" D
 . . S ^TMP("XUSAML",$J,$P(XUPN,"^",1))=Y
 . E  D
 . . S ^TMP("XUSAML",$J,$P(XUPN,"^",1),$P(XUPN,"^",2))=Y
 Q
EL(HDL,ND,NM,XUPN) ;SR. Process element
 K XUPN S (NM,XUPN)=""
 F  S NM=$$ATTRIB^MXMLDOM(HDL,ND,NM) Q:'$L(NM)  D
 . I $L(NM) S XUPN=NM_"^"_$$VALUE^MXMLDOM(HDL,ND,NM)
 . I $P(XUPN,"^",2)="" D
 . . S ^TMP("XUSAML",$J,$P(XUPN,"^",1))=""
 . E  D
 . . S ^TMP("XUSAML",$J,$P(XUPN,"^",1),$P(XUPN,"^",2))=""
 Q
FINDUSER() ;Function. Identify user
 ;ZEXCEPT: XOBDATA ;environment variable
 ;ZEXCEPT: XTMUNIT,XTU ;set for unit testing
 N VISTAID,X,XARRY,XAUTH,XUIAM,XUHOME,Y,Z
 I '$$AUTH^XUESSO2() Q "-1^Not an authorized calling routine"
 S Y="-1^User could not be identified"
 S XUIAM=1 ;Do not trigger IAM updates
 S XARRY(1)=$$TITLE^XLFSTR($E($G(^TMP("XUSAML",$J,"Name","urn:oasis:names:tc:xspa:1.0:subject:organization")),1,50)) ;Subject Organization
 S XARRY(2)=$$LOW^XLFSTR($E($G(^TMP("XUSAML",$J,"Name","urn:oasis:names:tc:xspa:1.0:subject:organization-id")),1,50)) ;Subject Organization ID
 S XARRY(3)=$G(^TMP("XUSAML",$J,"Name","uniqueUserId")) ;Unique User ID
 S XARRY(4)=$G(^TMP("XUSAML",$J,"Name","urn:oasis:names:tc:xspa:1.0:subject:subject-id")) ;Subject ID
 ;S XARRY(5)=$G(XASSRT("SubjectConfirmationData@Address")) ;Use to authorize application with REMOTE APPLICATION file? Or see SSOe below.
 S XARRY(6)=$G(^TMP("XUSAML",$J,"Name","urn:va:ad:samaccountname")) ;Network Username
 S XARRY(7)=$G(^TMP("XUSAML",$J,"Name","urn:va:vrm:iam:secid")) ;SecID
 S XARRY(8)=$G(^TMP("XUSAML",$J,"Name","urn:oasis:names:tc:xspa:2.0:subject:npi")) ;NPI
 ;S XARRY(9)=$G(^TMP("XUSAML",$J,"Name","SSN")) ;SSN is not part of STS Token specification v1.2
 S XARRY(10)=$G(^TMP("XUSAML",$J,"Name","upn")) ;Active Directory User Principle Name (UPN)
 S XARRY(11)=$G(^TMP("XUSAML",$J,"Name","email")) ;E-Mail Address
 ;S XARRY(12)=$G(^TMP("XUSAML",$J,"Name","urn:oasis:names:tc:xacml:2.0:subject:role")) ;Role is not part of STS Token specification v1.2
 S XAUTH=$$LOW^XLFSTR($G(^TMP("XUSAML",$J,"Name","authnsystem"))) ;SSOi, SSOe, or Other authentication
 S XUHOME=$$LOW^XLFSTR($G(^TMP("XUSAML",$J,"Name","urn:nhin:names:saml:homeCommunityId"))) ;Home Community ID
 S VISTAID=$G(^TMP("XUSAML",$J,"Name","urn:va:vrm:iam:vistaid")) ;VISTAID
 ;S ???=$G(^TMP("XUSAML",$J,"Name","urn:va:vrn:iam:mviicn")) ;ICN - tie PATIENT file (#2) to NEW PERSON file (#200)?
 ;For SSOi and SSOe, the token should come from IAM. Validate using "saml:Issuer" or something from the certificate?
 ;<saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity">https://ssoi.sts.domain.ext/Issuer/SAML2</saml:Issuer>
 I (XUHOME=$P($G(^XTV(8989.3,1,200)),U,3))&(XAUTH="ssoi") D  ;SSOi
 . S XARRY(3)=XARRY(7) ;UID=SecID
 . S Y=$$FINDUSER^XUESSO2(.XARRY) ;Identify user
 . S DUZ("AUTHENTICATION")="SSOI"
 . ;I +Y<0 D
 . ;. ;Future: Add SSOi "VISITOR" entry if not provisioned? Require some sort of Role-based access or REMOTE APPLICATION file entry?
 E  I (XUHOME=$P($G(^XTV(8989.3,1,200)),U,3))&(XAUTH="ssoe") D  ;SSOe
 . S XARRY(3)=XARRY(7) ;UID=SecID
 . S Y=$$FINDUSER^XUESSO2(.XARRY) ;Identify user
 . S DUZ("AUTHENTICATION")="SSOE"
 . I +Y<0 D
 . . I $$GETCNTXT^XUESSO2($G(XARRY(2)))>0 D
 . . . ;For SSOe the XARRY(1) and XARRY(2) will be the CSP that authenticated the user.
 . . . ; The values will be the CSP friendly name and the mapped SiteID as maintained in MVI.
 . . . ; Use REMOTE APPLICATION file (#200) where XARRY(1) is application and hashed XARRY(2) is authorization code
 . . . I XARRY(1)'=$P($G(^XTV(8989.3,1,200)),U,2) S Y=$$ADDUSER^XUESSO2(.XARRY)  ;If authorized application, add the SSOe user
 . . . S X=$$SETCNTXT^XUESSO2(Y,$G(XARRY(2)))  ;Add the context option for SSOe
 E  I (XUHOME=$P($G(^XTV(8989.3,1,200)),U,3))&(XAUTH="m4a") D  ;m4a
 . S Y=$$FINDUSER^XUESSO2(.XARRY) ;Identify user
 . S DUZ("AUTHENTICATION")="M4A"
 E  I (XARRY(2)["http://")!(XARRY(2)["https://")!((XARRY(2)["urn:oid:")&(XARRY(2)'=$P($G(^XTV(8989.3,1,200)),U,3))) D  ; NHIN
 . I $G(XARRY(3))="" S XARRY(3)=XARRY(8) ;NHIN: UID is NPI if available (preferred)
 . I $G(XARRY(3))="" S XARRY(3)=XARRY(11) ;NHIN: UID is e-mail if available (alternative to NPI)
 . S Y=$$FINDUSER^XUESSO2(.XARRY) ;Identify user by NPI or Unique User ID
 . I +Y<0 D
 . . S XARRY(8)=""
 . . S Y=$$FINDUSER^XUESSO2(.XARRY) ;Identify user by Unique User ID only
 . S DUZ("AUTHENTICATION")="NHIN"
 ;E  I VISTAID'="" D  ;If there is a VISTAID attribute, check that a DUZ and STATION combination exists for this user
 ;. ;SAML v1.2 specification shows (but current parsing methods will only return a single attribute value):
 ;. ; <saml:Attribute Name="urn:va:vrm:iam:vistaid">
 ;. ; <saml:AttributeValue>404-11128439</saml:AttributeValue>
 ;. ; <saml:AttributeValue>322-22228439</saml:AttributeValue>
 ;. ; </saml:Attribute>
 ;. ;Example from IAM shows:
 ;. ; <saml:Attribute Name="urn:va:vrm:iam:vistaid" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified">
 ;. ; <saml:AttributeValue>200M|33328439^PN^200M^USVHA|A,508|22228439^PN^508^USVHA|A,590|11128439^PN^590^USVHA|A</saml:AttributeValue>
 ;. ; </saml:Attribute>
 ;. ;***** If VISTAID match, set SECID for user ID'd by DUZ and run $$FINDUSER again to update user attributes and authenticate? Self-provisioning!
 ;. S VID=""
 ;. F J=1:1 D  Q:VID=""
 ;. . S VID=$P(VISTAID,",",J)
 ;. . W !,VID,! ;VID should be "200M|33328439^PN^200M^USVHA|A" where 200M is STATION and 33328439 is DUZ
 ;. ;***** Development of identification by VISTAID abandoned in XU*8*659 due to discrepancies between standard and IAM example, plus lack of good test data
 Q Y
VALASSRT(XASSRT,DOC) ;Intrinsic Subroutine. Validate SAML assertion
 ;ZEXCEPT: XOBDATA ;environment variable
 N XD,XNOW
 S XOBDATA("XOB RPC","SAML","AUTHENTICATION TYPE")=$G(^TMP("XUSAML",$J,"Name","authenticationtype"))
 S XOBDATA("XOB RPC","SAML","PROOFING AUTHORITY")=$G(^TMP("XUSAML",$J,"Name","proofingauthority"))
 ;Validate timestamps (e.g., NotBefore, NotOnOrAfter)
 S XNOW=$$NOW^XLFDT
 S XD=$$CONVTIME($G(XASSRT("AuthnInstant"))) I XD=-1 Q  ;invalid timestamp
 S XD=$$CONVTIME($G(XASSRT("NotBefore"))) I (XD=-1)!(XD>XNOW) Q  ;token not valid yet
 S XD=$$CONVTIME($G(XASSRT("NotOnOrAfter"))) I (XD=-1)!(XD'>XNOW) Q  ;token expired
 ;Validate endpoints (Optional based on scenario)
 I '$D(XASSRT("Subject")) Q  ;very basic check for "Subject" tag
 ; - TBD
 ;  a) Validate Subject::SubjectConfirmation::SubjectConfirmationData@Address
 ;     matches the requestor (e.g., common name in this attribute matches that
 ;     from the certificate which secured the session). Note: This Subject will
 ;     be the system that requested the token - it may or may not be the System
 ;     handing the token to VistA.
 ;     As of patch 659, IAM SAML tokens are missing this information
 ;  b) Validate Service Endpoint using
 ;     Subject::SubjectConfirmation::SubjectConfirmationData@Recipient
 ;     VistA shall accept an endpoint of "domain.ext"
 ;     As of patch 659, IAM SAML tokens have this information in the wrong place:
 ;     <saml:SubjectConfirmationData Recipient="http://SSOi/AppliesTo/SAML2"/>
 ;     <saml:AudienceRestriction><saml:Audience>https://*.domain.ext/*</saml:Audience></saml:AudienceRestriction>
 I '$D(XASSRT("AuthnContextClassRef")) Q
 ; - TBD
 ; Verify Level of Assurance (VA requires LOA-1 through LOA-3, but LOA-4 is currently the best)
 K XOBDATA("XOB RPC","SAML","ASSURANCE LEVEL")
 S XD=$G(^TMP("XUSAML",$J,"Name","assurancelevel")) I (+XD<1)!(+XD="") S XD=1
 S XOBDATA("XOB RPC","SAML","ASSURANCE LEVEL")=XD
 S DUZ("LOA")=XD ;Set LOA environment variable for SIGN-ON log and permissions
 ;Validate Digital Signature
 I '$$VALIDATE^XUCERT(DOC) Q
 ;Validate Token Issuer (Subject of X509 Certificate used to sign token)
 I '($G(XOBDATA("XOB RPC","SAML","ISSUER"))[$P($G(^XTV(8989.3,1,200)),U,1)) Q
 ;Token has been validated
 S XOBDATA("XOB RPC","SAML","ASSERTION")="validated"
 Q
CONVTIME(TIME) ;Intrinsic Function. Convert XML time to FileMan format
 ;ZEXCEPT: %DT ;environment variable
 N X,XD,XOUT,XT,XZ,Y
 S XZ=0 I $G(TIME)["Z" S XZ=1 ;Zulu time (GMT)
 S XD=$P($G(TIME),"T",1) ;Date
 S XD=$P(XD,"-",2)_"/"_$P(XD,"-",3)_"/"_$P(XD,"-",1) ;Convert date to MM/DD/YYYY
 S XT=$P($G(TIME),"T",2) ;Time
 I XZ=1 S XT=$P(XT,"Z",1) ;Strip "Z" from time
 S X=XD_"@"_XT S %DT="RTS"
 D ^%DT S XOUT=Y
 I XZ=1 S XOUT=$$FMADD^XLFDT(XOUT,0,+$E($$TZ^XLFDT,1,3),0,0) ;Adjust from GMT
 K %DT(0)
 Q XOUT
