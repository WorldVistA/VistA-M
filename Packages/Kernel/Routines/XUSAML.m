XUSAML ;ISD/HGW Kernel SAML Token Implementation ;03/25/15  07:46
 ;;8.0;KERNEL;**655**;Jul 10, 1995;Build 16
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
 ;                      or filename and path reference identifying the document on the host system (for testing).
 ;                      See $$EN^MXMLDOM instructions in the VistA Kernel Developers Guide for required
 ;                      format of the DOC global.
 ;                      Example: S Y=$$EN^XUSAML($NA(^TMP($J,1)))
 ; Return:    Fail    = "-1^Error Message"
 ;            Success = DUZ
 ;ZEXCEPT: XOBDATA ;environment variable
 N HDL,XASSRT,XUPN,Y
 S Y="-1^Error parsing STS SAML Token",XUPN="",XASSRT=""
 S XOBDATA("XOB RPC","SECURITY","STATE")="notauthenticated"
 S XOBDATA("XOB RPC","SAML","ASSERTION")="notvalidated"
 ;--- Call parser
 S HDL=$$EN^MXMLDOM(DOC,"W")
 I HDL>0 D
 . D ND(HDL,1,1,.XUPN,.XASSRT) ;Traverse and process document
 . S Y="-1^Invalid SAML assertion"
 . D VALASSRT(.XASSRT) ;Validate SAML assertion
 . I $G(XOBDATA("XOB RPC","SAML","ASSERTION"))="validated" D
 . . S Y=$$FINDUSER()
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
 N ELE,NM,V
 S ELE=$$NAME^MXMLDOM(HDL,ND)
 ;I ELE="saml:Assertion" D  Q
 ;. ;TBD
 ;I ELE="saml:Issuer" D  Q
 ;. ;TBD
 ;I ELE="ds:Signature" D  Q
 ;. ;TBD - 3.2.4.4 in NHIN standard for example
 ;
 ; --------------------  saml:Subject Event Processing  --------------------------------
 I ELE="saml:Subject" D  Q  ;a Subject element is required
 . S XASSRT("Subject")="yes"
 ;I ELE="saml:NameID" D  Q
 ;. ;TBD
 ;I ELE="saml:SubjectConfirmation" D  Q
 ;. ;TBD
 ;*****For IAM STS Token validation, need to capture (from X.509 certificate?):
 ;***** Subject::SubjectConfirmation::SubjectConfirmationData@Address
 ;***** Subject::SubjectConfirmation::SubjectConfirmationData@Recipient
 ;      <saml:SubjectConfirmationData>
 ;        <ds:KeyInfo>
 ;          <ds:X509Data>
 ;            <!-- principal's X.509 cert -->
 ;            <ds:X509Certificate>
 ;              MIIciDCCAXACCQDE+9eiWrm64 etc.
 ;            </ds:X509Certificate>
 ;          </ds:X509Data>
 ;        </ds:KeyInfo>
 ; *or*
 ;        <ds:KeyInfo>
 ;          <wsse:SecurityTokenReference
 ;            wsu:Id="uuid_2ca69267-90bd-4785-a28e-ad9cee6d962e"
 ;            wsse11:TokenType="http://docs.oasis-open.org/wss/oasis-wss-saml-token-profile-1.1#SAMLV2.0">
 ;            <wsse:KeyIdentifier
 ;              ValueType="http://docs.oasis-open.org/wss/oasis-wss-saml-token-profile-1.1#SAMLID">
 ;              ed62b6fb-4d73-4011-9f7c-43e0575b6317
 ;            </wsse:KeyIdentifier>
 ;          </wsse:SecurityTokenReference>
 ;        </ds:KeyInfo>
 ;      </saml:SubjectConfirmationData>
 ;I ELE="saml:SubjectConfirmationData" D  Q
 ;. ;TBD
 ;I ELE="ds:KeyInfo" D  Q
 ;. ;TBD
 ;I ELE="ds:X509Data" D  Q
 ;. ;TBD
 ;I ELE="ds:X509Certificate" D  Q  ;X.509 encrypted digital certificate
 ;. ;TBD
 ;
 ; --------------------  saml:Conditions Event Processing  -------------------------
 I ELE="saml:Conditions" D  Q
 . D EL(HDL,ND,.NM,.XUPN)
 . S XASSRT("NotBefore")=$O(^TMP("XUSAML",$J,"NotBefore",""))
 . S XASSRT("NotOnOrAfter")=$O(^TMP("XUSAML",$J,"NotOnOrAfter",""))
 ;
 ; --------------------  saml:AuthnStatement Event Processing  -------------------------
 I ELE="saml:AuthnStatement" D  Q
 . D EL(HDL,ND,.NM,.XUPN)
 . S XASSRT("AuthnInstant")=$O(^TMP("XUSAML",$J,"AuthnInstant",""))
 ;I ELE="saml:SubjectLocality" D  Q
 ;. ;TBD
 ;I ELE="saml:AuthnContext" D  Q
 ;. ;TBD
 I ELE="saml:AuthnContextClassRef" D  Q
 . S XUPN="AuthnContextClassRef"
 . D CH(HDL,ND,XUPN)
 . S XASSRT("AuthnContextClassRef")=$G(^TMP("XUSAML",$J,"AuthnContextClassRef"))
 ;
 ; --------------------  saml:AttributeStatement Event Processing  ------------------
 I ELE="saml:AttributeStatement" D  Q
 . ;TBD
 I ELE="saml:Attribute" D  Q
 . D EL(HDL,ND,.NM,.XUPN)
 I ELE="saml:AttributeValue" D  Q
 . D CH(HDL,ND,XUPN)
 I ELE="SECID" D  Q
 . D EL(HDL,ND,.NM,.XUPN)
 . D CH(HDL,ND,XUPN)
 I ELE="NPI" D  Q
 . D EL(HDL,ND,.NM,.XUPN)
 . D CH(HDL,ND,XUPN)
 I ELE="applicationPassPhrase" D  Q
 . D EL(HDL,ND,.NM,.XUPN)
 . D CH(HDL,ND,XUPN)
 Q
CH(HDL,ND,XUPN) ;SR. Process text node
 N I,NM,VV,Y
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
 N X,XARRY,XUHOME,Y,Z,XAUTH
 S X=$ST($ST-1,"PLACE"),Y=$P(X,"+"),Z=$P(X,"^",2),X=Y_"^"_$P(Z," ")
 I X'="EN^XUSAML" Q "-1^Not authorized"
 S Y="-1^User could not be identified"
 S XARRY(1)=$$TITLE^XLFSTR($E($G(^TMP("XUSAML",$J,"Name","urn:oasis:names:tc:xspa:1.0:subject:organization")),1,50)) ;Subject Organization
 S XARRY(2)=$$LOW^XLFSTR($E($G(^TMP("XUSAML",$J,"Name","urn:oasis:names:tc:xspa:1.0:subject:organization-id")),1,50)) ;Subject Organization ID
 S XARRY(3)=$G(^TMP("XUSAML",$J,"Name","uniqueUserId")) ;Unique User ID
 S XARRY(4)=$G(^TMP("XUSAML",$J,"Name","urn:oasis:names:tc:xspa:1.0:subject:subject-id")) ;Subject ID
 S XARRY(5)=$G(^TMP("XUSAML",$J,"Name","applicationPassPhrase")) ;Application ID
 S XARRY(6)=$G(^TMP("XUSAML",$J,"Name","urn:va:ad:samaccountname")) ;Network Username
 S XARRY(7)=$G(^TMP("XUSAML",$J,"Name","urn:va:vrm:iam:secid")) ;SecID
 S XARRY(8)=$G(^TMP("XUSAML",$J,"Name","urn:oasis:names:tc:xspa:2.0:subject:npi")) ;NPI
 ;S XARRY(9)=$G(^TMP("XUSAML",$J,"Name","")) ;SSN - Currently not an entry in token for SSN
 S XARRY(10)=$G(^TMP("XUSAML",$J,"Name","upn")) ;Active Directory User Principle Name (UPN)
 S XARRY(11)=$G(^TMP("XUSAML",$J,"Name","email")) ;E-Mail Address
 S XAUTH=$$LOW^XLFSTR($G(^TMP("XUSAML",$J,"Name","authnsystem"))) ;SSOi, SSOe, or Other authentication
 S XUHOME=$$LOW^XLFSTR($G(^TMP("XUSAML",$J,"Name","urn:nhin:names:saml:homeCommunityId"))) ;Home Community ID
 I (XUHOME="urn:oid:2.16.840.1.113883.4.349")&((XAUTH="ssoi")!(XAUTH="ssoe")) D  ;SSOi and SSOe
 . S XARRY(3)=XARRY(7) ;SSOi and SSOe: UID=SecID
 . S Y=$$FINDUSER^XUESSO2(.XARRY) ;Identify user
 . ;I (+Y<0)&(XARRY(1)="Department Of Veterans Affairs")&(XAUTH="ssoi") S Y=$$ADDUSER^XUESSO2(.XARRY)  ;If not found, add the SSOi user
 . ;I (+Y<0)&(XARRY(1)'="Department Of Veterans Affairs")&(XAUTH="ssoe") S Y=$$ADDUSER^XUESSO2(.XARRY)  ;If not found, add the SSOe user
 E  I (XARRY(2)["http://")!(XARRY(2)["https://")!((XARRY(2)["urn:oid:")&(XARRY(2)'="urn:oid:2.16.840.1.113883.4.349")) D  ; NHIN
 . I $G(XARRY(3))="" S XARRY(3)=XARRY(8) ;NHIN: UID is NPI if available (preferred)
 . I $G(XARRY(3))="" S XARRY(3)=XARRY(11) ;NHIN: UID is e-mail if available (alternative to NPI)
 . S Y=$$FINDUSER^XUESSO2(.XARRY) ;Identify user by NPI or Unique User ID
 . I +Y<0 D
 . . S XARRY(8)=""
 . . S Y=$$FINDUSER^XUESSO2(.XARRY) ;Identify user by Unique User ID only
 . ;I +Y<0 S Y=$$ADDUSER^XUESSO2(.XARRY) ;If not found, add the NHIN user
 Q Y
VALASSRT(XASSRT) ;SR. Validate SAML assertion
 ;ZEXCEPT: XOBDATA ;environment variable
 N XD,XNOW
 K XOBDATA("XOB RPC","SAML","AUTHENTICATION TYPE")
 S XOBDATA("XOB RPC","SAML","AUTHENTICATION TYPE")=$G(^TMP("XUSAML",$J,"Name","authenticationtype"))
 K XOBDATA("XOB RPC","SAML","PROOFING AUTHORITY")
 S XOBDATA("XOB RPC","SAML","PROOFING AUTHORITY")=$G(^TMP("XUSAML",$J,"Name","proofingauthority"))
 ;***** IAM RSD 2.3.2.1 Validation of Issuer
 ;      * Directly trust the issuer's certificate. In this case, the certificate is received using
 ;        a secure out-of-band mechanism and tagged as trusted.
 ;   or * Indirect trust through an agreement with a trusted third party.This is typically an
 ;        agreement regarding issuing Certificate Authority. Also commonly combined with limiting
 ;        access by SubjectDN of the signer certificate.
 ; Verify PKI certificate (check trust chain and revocation)
 ; - TBD
 ;
 ;***** IAM RSD 2.3.2.2 Validation of Token Digital Signature
 ;      * VistA shall be configured to use the Extensible Markup Language (XML) Digital Signature
 ;        standard to process the signature element within the token.
 ; Verify XML signature of token
 ; - TBD
 ;
 ;***** IAM RSD 2.3.2.3 Evaluation of Data within the Token
 ;      * VistA shall validate timestamps (e.g., NotBefore, NotOnOrAfter)
 S XNOW=$$NOW^XLFDT
 S XD=$$CONVTIME($G(XASSRT("AuthnInstant"))) I XD=-1 Q  ;invalid timestamp
 S XD=$$CONVTIME($G(XASSRT("NotBefore"))) I (XD=-1)!(XD>XNOW) Q  ;token not valid yet
 S XD=$$CONVTIME($G(XASSRT("NotOnOrAfter"))) I (XD=-1)!(XD'>XNOW) Q  ;token expired
 ;      * VistA shall perform Validation of endpoints (Optional based on scenario)
 ;        a) Validate Subject::SubjectConfirmation::SubjectConfirmationData@Address
 ;           matches the requestor (e.g., common name in this attribute matches that
 ;           from the certificate which secured the session). Note: This Subject will
 ;           be the system that requested the token - it may or may not be the System
 ;           handing the token to VistA.
 I '$D(XASSRT("Subject")) Q  ;very basic check for "Subject" tag
 ; - TBD
 I '$D(XASSRT("AuthnContextClassRef")) Q
 ;        b) Validate Service Endpoint using
 ;           Subject::SubjectConfirmation::SubjectConfirmationData@Recipient
 ;           VistA shall accept an endpoint of "domain.ext"
 ;
 ; Verify assurance level (VA requires LOA-1 through LOA-3)
 K XOBDATA("XOB RPC","SAML","ASSURANCE LEVEL")
 S XD=$G(^TMP("XUSAML",$J,"Name","assurancelevel")) I (+XD<1)!(+XD>3)!(+XD="") Q
 S XOBDATA("XOB RPC","SAML","ASSURANCE LEVEL")=XD
 ; Token has been validated
 S XOBDATA("XOB RPC","SAML","ASSERTION")="validated"
 Q
CONVTIME(TIME) ;Function. Convert XML time to FileMan format
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
