XUCERT1 ;ISD/HGW Kernel PKI Certificate Utilities (cont) ;09/17/2019  15:25
 ;;8.0;KERNEL;**659,701**;Jul 10, 1995;Build 11
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
VAL1(DOC,SIG) ;Function. Validate Document (Cache 2015.2 or greater)
 ;ZEXCEPT: Document,ValidateDocument ;Object Script
 N XUDOC,XUSTATUS
 S XUDOC=DOC.Document ;Create the OREF
 I $G(XUDOC)="" Q "-1^Failed to import XML document"
 D XUDOC.AddIDs() ; p701
 S XUSTATUS=SIG.ValidateDocument(XUDOC)
 I $G(XUSTATUS)["Failed" Q "-1^Failed data integrity or signature validation check"
 Q 1
 ;
VAL2(DOC,SIG,ERR) ;Function. Validate Document (Less than Cache 2015.2)
 N ERROR,STATUS
 S STATUS=1
 S ERROR=""
 I '$$CHKDATA(DOC,SIG) S ERR("DIGEST")="" S STATUS=0 ; check integrity
 I '$$CHKSIGN(DOC,SIG,.ERR) S STATUS=0 ; check signature is valid
 Q STATUS=1
 ;
READER(DOC) ;Function. Reads XML Document
 ;ZEXCEPT: %New,%XML,OpenFile,OpenStream,Reader,class ;Object Script
 N XUIN,XUREAD,XUSC
 S XUREAD=##class(%XML.Reader).%New() ;Create OREF instance in memory
 I $E(DOC)="^" D
 . S XUIN=$$LOADSTRM(DOC) ;Extract stream from global
 . S XUSC=XUREAD.OpenStream(XUIN) ;Import from stream
 E  D
 . S XUSC=XUREAD.OpenFile(DOC) ;Import from file
 I $G(XUSC)'=1 Q "-1^"_$G(XUSC)
 Q XUREAD
 ;
SGNTR(READER) ;Function. Finds digital signature
 N SIGNATURE,STATUS
 D READER.Correlate("Signature","%XML.Security.Signature")
 D READER.Next(.SIGNATURE,.STATUS)
 I $G(SIGNATURE)="" Q "-1^NO-SIGNATURE"
 Q SIGNATURE
 ;
CHKDATA(READER,SIG) ;Function. Check integrity of signed data
 ; by comparing computed digest with incoming digest value
 N COMPUTED
 S COMPUTED=$$DIGESTCP(READER,SIG)
 Q COMPUTED=$$DIGEST(SIG)
 ;
DIGESTCP(READER,SIG) ;Function. Compute SHA digest value
 ;ZEXCEPT: %New,%XML,ComputeSha1Digest,Document,GetNode,NodeId,Writer,class
 N NODE,WRITER,BITLENGT,ISSTR,MIME,SIGNNODE,PREFIXL,CANONTXT
 S NODE=READER.Document.GetNode("")
 S NODE.NodeId=$$REFNODE(READER)
 S SIGNNODE=SIG.NodeId
 S WRITER=##class(%XML.Writer).%New()
 ; p701
 S PREFIXL="" ; explicit, xml-exc-c14n#
 ;S BITLENGT=160
 S BITLENGT=256 ;
 ; end p701
 S ISSTR=0
 S MIME=""
 Q SIG.ComputeSha1Digest(NODE,SIGNNODE,WRITER,.PREFIXL,BITLENGT,ISSTR,.CANONTXT,MIME)
 ;
REFNODE(READER) ;Function. Get reference node which is Assertion node since GetNodeById can't find "ID"
 ;ZEXCEPT: NodeId,STATUS
 N ASSERTION
 D READER.Rewind()
 D READER.Correlate("Assertion","%SAML.Assertion")
 D READER.Next(.ASSERTION,.STATUS)
 Q ASSERTION.NodeId
 ;
DIGEST(SIGNATURE) ;Function. Find incoming digest value
 ;ZEXCEPT: DigestValue,GetAt,Reference,SignedInfo
 N REF
 S REF=SIGNATURE.SignedInfo.Reference.GetAt(1)
 Q REF.DigestValue
 ;
CHKSIGN(READER,SIGNATURE,ERR) ;Function. Validate digital signature
 ; Return value: 1 if the signature was successfully verified, 0 otherwise.
 ;ZEXCEPT: %New,%XML,Canonicalize,Certificate,Document,Encryption,GetNode,GetXMLString,KeyInfo,NodeId,OutputToString,RSASHAVerify,SignatureValue,SignedInfo,ValidateTokenRef,Writer,X509Credentials,class
 N BITLENGT,CAFILE,CERT,CRLFILE,ERROR,SIGNTXT,SIGNVAL,STATUS
 S ERROR=""
 S BITLENGT=256 ; (Integer) Length in bits of desired hash, where 256 is SHA-256
 S SIGNTXT=$$SIGNTEXT(READER,SIGNATURE) ; (String) Data that was signed
 S SIGNVAL=SIGNATURE.SignatureValue ; (String) Signature to be verified
 S CERT=$$CERT(SIGNATURE) ; (String) X.509 certificate containing the RSA public key to validate the signature
 ;P701
 I +CERT=-1 S ERR("CERT")=""
 S CAFILE=$System.Util.ManagerDirectory()_"cache.cer"
 I '##class(%File).Exists(CAFILE) S ERR("CAFILE")=""
 ;S CRLFILE=$zu(12)_"cache.crl"
 ;I $zu(140,4,CRLFILE)'=0 Set CRLFILE=""
 ;RSASHAVerify works with OpenSSL on Windows and Linux, but crashes with VMS.
 I $$VERSION^%ZOSV(1)["OpenVMS" Q 1  ;Quit if VMS, skip signature validation
 I $D(ERR("CAFILE")) D
 . S STATUS=$System.Encryption.RSASHAVerify(BITLENGT,SIGNTXT,SIGNVAL,CERT)
 E  S STATUS=$System.Encryption.RSASHAVerify(BITLENGT,SIGNTXT,SIGNVAL,CERT,CAFILE)
 I 'STATUS S ERR("SIGNATURE")="" Q 0
 Q 1
 ;
SIGNTEXT(READER,SIGNATURE) ;Function. Retrieves the SignedInfo text
 ;ZEXCEPT: %New,%XML,Canonicalize,Document,GetNode,GetXMLString,NodeId,OutputToString,SignedInfo,Writer,class ;ObjectScript
 N NODE,PREFARR,WRITER,SC
 S NODE=READER.Document.GetNode("")
 S NODE.NodeId=SIGNATURE.SignedInfo.NodeId
 ; p701 explicit canonicalization, xml-exc-c14n#, make PREFARR undefined
 ;S PREFARR="c14n" ; signing prefix array
 S WRITER=##class(%XML.Writer).%New()
 S SC=WRITER.OutputToString()
 S SC=WRITER.Canonicalize(NODE,.PREFARR)
 Q WRITER.GetXMLString(.SC) ; SignedInfo
 ;
CERT(SIG) ;Function. Retrieves a certificate
 ;ZEXCEPT: Certificate,KeyInfo,ValidateTokenRef,X509Credentials ;ObjectScript
 N KEYINFO,ERROR
 S KEYINFO=SIG.KeyInfo
 S ERROR=KEYINFO.ValidateTokenRef("")
 I ERROR'="" Q "-1^Invalid KeyInfo"
 Q KEYINFO.X509Credentials.Certificate
 ;
LOADSTRM(GLO) ;Intrinsic Function. Load global into stream
 ;ZEXCEPT: %New,%Stream,GlobalCharacter,class ;ObjectScript
 N GLOREF,I,X,XMLSTRM,XQ,Y
 S Y=GLO
 S XQ=$P(Y,")") ;or use $$OREF^DILF(closed_root) to convert closed root to open root?
 S XMLSTRM=##class(%Stream.TmpCharacter).%New() ;Create OREF instance in memory. p701 instead of GlobalCharacter
 ;Read XML from global, starting at the beginning, into XMLSTRM
 F I=0:0 D  Q:Y'[XQ
 . S Y=$Q(@Y) Q:Y'[XQ
 . S X=$G(@Y)
 . D XMLSTRM.Write(X)
 Q XMLSTRM
 ;
ADDERR(RES,ERR) ;
 S RES(ERR)=""
 Q
 ;
