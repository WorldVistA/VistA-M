XUCERT ;ISD/HGW Kernel PKI Certificate Utilities ;10/01/15  14:19
 ;;8.0;KERNEL;**659**;Jul 10, 1995;Build 22
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
VALIDATE(DOC) ;Extrinsic Function.
 ;Validate the signatures in a digitally signed XML document which contains an EncryptedData element and EncryptedKey elements.
 ; Input:     DOC     = This string is either a closed reference to a global root containing the XML document or a filename
 ;                      and path reference identifying the XML document on the host system. See the Kernel Developers Guide
 ;                      documentation on $$EN^MXMLDOM() for detailed requirements for the format of the input global.
 ; Return:    Fail    = "-1^Error Message"
 ;            Success = 1
 ;
 ;ZEXCEPT: %New,%XML,Document,OpenFile,OpenStream,Reader,ValidateDocument,class ;ObjectScript
 N XUREAD,XUSIG,XUSTATUS,XUVER
 S XUREAD=$$READER^XUCERT1(DOC) ;Read XML document
 I $G(XUREAD)["-1^" Q XUREAD
 S XUSIG=$$SGNTR^XUCERT1(XUREAD) ;Find digital signature
 I $G(XUSIG)["-1^" Q XUSIG
 D GETISSUE(XUSIG) ;Save subject of X509 certificate (issuer of signature)
 S XUVER=$$VERSION^%ZOSV() S XUVER=$P(XUVER,".",1)_"."_$P(XUVER,".",2)
 I XUVER'<2015.2 D
 . S XUSTATUS=$$VAL1^XUCERT1(XUREAD,XUSIG)
 E  D
 . S XUSTATUS=$$VAL2^XUCERT1(XUREAD,XUSIG)
 Q XUSTATUS
 ;
GETISSUE(SIG) ;Subroutine. Save X509 Certificate owner to XOBDATA("XOB RPC","SAML",ISSUER")
 ;ZEXCEPT: Encryption,X509GetField,XOBDATA ;ObjectScript and environment variables
 N CERT
 S CERT=$$CERT^XUCERT1(SIG)
 I +CERT=-1 Q  ;Cannot get certificate
 S XOBDATA("XOB RPC","SAML","ISSUER")=$System.Encryption.X509GetField(CERT,"Subject")
 Q
 ;
TEST ;Subroutine. System checks to help with troubleshooting.
 ;Check if Cache version >= 2015.2
 ;    12345678901234567890123456789012345678901234567890123456789012345678901234567890
 W !,"XML digital signature validation is done differently depending on the version"
 W !,"of Cache being used on your system:"
 W !,"   Versions greater than or equal to 2015.2 use $$VAL1^XUCERT1"
 W !,"   Versions less than 2015.2 use $$VAL2^XUCERT1"
 W !,"   Your Cache Version is ",$$VERSION^%ZOSV(),!
 ;
 ;Check if PKI chain of trust to root is available (how?)
 ; ** Apparently Cache uses OpenSSL on underlying server for chain of trust. Check OpenSSL version?
 ;Check if %SuperServer and %TELNET/SSL is available (how? with https?)
 ; ** Is this still needed?
 ;Check if a local X.509 certificate is installed (how? same as %SuperServer check?)
 ; ** Not needed. All sites use SSL, so they have a certificate on the server.
 Q
 ;
