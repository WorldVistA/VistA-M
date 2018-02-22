XUSHSH ;ISF/STAFF - ENCRYPTION/DECRYPTION UTILITIES ; 10/30/17 5:28pm
 ;;8.0;KERNEL;**655,659,10001**;Jul 10, 1995;Build 18
 ;Per VA Directive 6402, this routine should not be modified.
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Original Routine authored by Department of Veterans Affairs but completely redacted.
 ; All EPs authored by Sam Habiel 2016.
 ;
 ; Written by VEN/SMH - Verified against Cache code to return same result.
 ;;
 ;ZEXCEPT: X ;Returned global value when called as an extrinsic subroutine.
 S X=$$EN(X)
 Q
 ;
EN(X) ;Extrinsic function $$EN^XUSHSH(X), IA #4758
 N XUA,XUI,XUJ,XUL,XUR,XUX,XUY,XUY1,XUZ D KE Q X
 ;
KE ;Intrinsic subroutine.
 ;
 ;
 ;
 Q
 ;
B ;Intrinsic subroutine.
 ;
 ;
 ;
 ;
 ;
C ;Intrinsic subroutine.
 ;
 ;
 ;
 ;
 ;
 ;
 ;
CL ;Intrinsic subroutine.
 ;
 ;
 ;
SHAHASH(N,X,FLAG) ;One-Way Hash Utility, IA #6189
 ; N -> (Required) Length in bits of the desired hash:
 ; 160 (SHA-1), 224 (SHA-224), 256 (SHA-256), 384 (SHA-384), or 512 (SHA-512)
 ; X -> (Required) String to be hashed.
 ; FLAG -> (Optional) Flag to control format of hash:
 ; - "H" = Hexadecimal (default)
 ; - "B" = Base64 Encoded
 S FLAG=$G(FLAG,"H")
 ;
 ; Capital HASH is return
 I $G(^%ZOSF("OS"))["OpenM" N HASH D  Q HASH
 . n hash s hash=$system.Encryption.SHAHash(N,X)
 . I FLAG="H" S HASH=##class(%xsd.hexBinary).LogicalToXSD(hash)
 . E  S HASH=$$B64ENCD(hash)
 ;
 ; shasum has the -a argument:
 ; -a, --algorithm   1 (default), 224, 256, 384, 512, 512224, 512256
 N ALGO S ALGO=$S(N=160:1,1:N) ; Translate for shasum command
 N %COMMAND,Y
 S %COMMAND="shasum -t -a "_ALGO ; -t = --text
 O "COMM":(SHELL="/bin/sh":COMM=%COMMAND)::"pipe"
 U "COMM" W X S $X=0 W /EOF ; $X of 0 prevents the code from writing LF to the stream
 F  R Y:0 Q:$L(Y)  Q:$ZEOF
 U IO C "COMM"
 S Y=$P(Y," ") ; shasum appends '  *-' to output.
 N UPY S UPY=$$UP^XLFSTR(Y) ; uppercase to be in M friendly mode
 I $G(FLAG)'="B" Q UPY      ; we are done if we don't need base64
 ;
 S %COMMAND="xxd -r -p | base64" ; convert to binary, then base64 encode
 O "COMM":(SHELL="/bin/sh":COMM=%COMMAND)::"pipe"
 U "COMM" W Y S $X=0 W /EOF ; $X of 0 prevents the code from writing LF to the stream
 N B F  R B:0 Q:$L(B)  Q:$ZEOF
 U IO C "COMM"
 Q B
 ;
B64ENCD(X) ;Base 64 Encode, IA #6189
 I $G(^%ZOSF("OS"))["OpenM" Q $System.Encryption.Base64Encode(X)
 N %COMMAND,Y
 S %COMMAND="base64"
 O "COMM":(SHELL="/bin/sh":COMM=%COMMAND)::"pipe"
 U "COMM" W X S $X=0 W /EOF ; $X of 0 prevents the code from writing LF to the stream
 F  R Y:0 Q:$L(Y)  Q:$ZEOF
 U IO C "COMM"
 Q Y
 ;
B64DECD(X) ;Base 64 Decode, IA #6189
 I $G(^%ZOSF("OS"))["OpenM" Q $System.Encryption.Base64Decode(X)
 N %COMMAND,Y
 S %COMMAND="base64 -d"
 I $G(^%ZOSF("OS"))["GT.M",$$VERSION^%ZOSV(1)["Darwin" S %COMMAND="base64 -D"
 O "COMM":(SHELL="/bin/sh":COMM=%COMMAND)::"pipe"
 U "COMM" W X S $X=0 W /EOF ; $X of 0 prevents the code from writing LF to the stream
 F  R Y:0 Q:$L(Y)  Q:$ZEOF
 U IO C "COMM"
 Q Y
 ;
RSAENCR(TEXT,CERT,CAFILE,CRLFILE,ENC) ;RSA Encrypt, IA #6189
 ; TEXT (Required) Plaintext string to be encrypted
 ; CERT (Required) An X.509 certificate containing the RSA 
 ;  public key to be used for encryption, in PEM encoded or binary DER format.
 ;  Note that the length of the plaintext can not be greater than the length of
 ;  the modulus of the RSA public key contained in the certificate minus 42 bytes.
 ; NB: OSE/SMH - This version takes a filename for the cert, not the cert itself!!!!
 ; - Needed so that both GT.M/YDB and Cache will work the same way
 ; CAFILE (Optional) The name of a file containing trusted
 ;  Certificate Authority X.509 Certificates in PEM-encoded format, one of which
 ;  was used to sign the Certificate.
 ; CRLFILE (Optional) The name of a file containing X.509
 ;  Certificate Revocation Lists in PEM-encoded format that should be checked to
 ;  verify the status of the Certificate.
 ; ENC (Optional) Encoding - PKCS #1 v2.1 encoding method:
 ;  1 = OAEP (default)
 ;  2 = PKCS1-v1_5
 N RESULT S RESULT=""
 I $G(^%ZOSF("OS"))["OpenM" D  Q RESULT
 . S ENC=$G(ENC,1)
 . N FILE S FILE=CERT
 . S CERT=""
 . N POP
 . N D ; delimiter
 . I FILE["/" S D="/"
 . E  S D="\"
 . N PATH S PATH=$P(FILE,D,1,$L(FILE,D)-1)_D
 . N FN S FN=$P(FILE,D,$L(FILE,D))
 . D OPEN^%ZISH("XUSHSH",PATH,FN,"R")
 . I POP Q
 . D USE^%ZISUTL("XUSHSH")
 . N % F  R %:2  Q:$$STATUS^%ZISH()  S CERT=CERT_%_$C(10)
 . D CLOSE^%ZISUTL("XUSHSH")
 . S RESULT=$system.Encryption.RSAEncrypt(TEXT,CERT,$G(CAFILE),$G(CRLFILE),ENC)
 ;
 ; VEN/SMH:
 ; 1. CAFILE and CRLFILE are used for revocation, which is hard to implement.
 ; I didn't do it. You need to concatenate the PEM files into a single file
 ; and then run openssl -verify -crl_check. This is just a bit too much for
 ; what we want to do; but I think Harlan was just following the API.
 ; See: https://raymii.org/s/articles/OpenSSL_manually_verify_a_certificate_against_a_CRL.html
 ; 2. OpenSSL has deprecated rsautl, and pkeyutl doesn't have encoding options
 N %CMD S %CMD="openssl pkeyutl -encrypt -certin -inkey "_CERT
 O "COMM":(SHELL="/bin/sh":COMM=%CMD:FIXED:WRAP:CHSET="M")::"pipe" ; THESE PARAMETERS ARE IMPORTANT! I kept fiddling until I got them.
 U "COMM" W TEXT S $X=0 W /EOF
 N OUT
 N Y
 F  R Y:1 S OUT=$G(OUT)_Y Q:$ZEOF
 U IO C "COMM"
 Q OUT
 ;
RSADECR(TEXT,KEY,PWD,ENC) ;RSA Decrypt, IA #6189
 ; TEXT (Required) Ciphertext string to be decrypted.
 ; KEY  (Required) RSA private key corresponding to the RSA
 ;  public key that was used for encryption, PEM encoded.
 ; NB: OSE/SMH - This version takes a filename for the cert, not the cert itself!!!!
 ; - Needed so that both GT.M/YDB and Cache will work the same way
 ; PWD  (Optional) Private key password.
 ; ENC  (Optional) Encoding - PKCS #1 v2.1 encoding method:
 ;  1 = OAEP (default)
 ;  2 = PKCS1-v1_5
 ;
 N RESULT S RESULT=""
 I $G(^%ZOSF("OS"))["OpenM" D  Q RESULT
 . S ENC=$G(ENC,1)
 . N FILE S FILE=KEY
 . S KEY=""
 . N POP
 . N D ; delimiter
 . I FILE["/" S D="/"
 . E  S D="\"
 . N PATH S PATH=$P(FILE,D,1,$L(FILE,D)-1)_D
 . N FN S FN=$P(FILE,D,$L(FILE,D))
 . D OPEN^%ZISH("XUSHSH",PATH,FN,"R")
 . I POP Q
 . D USE^%ZISUTL("XUSHSH")
 . N % F  R %:2  Q:$$STATUS^%ZISH()  S KEY=KEY_%_$C(10)
 . D CLOSE^%ZISUTL("XUSHSH")
 . S RESULT=$system.Encryption.RSADecrypt(TEXT,KEY,$G(PWD),ENC)
 ;
 ; VEN/SMH:
 ; 1. See note above on why I don't support ENC
 ;
 N %CMD S %CMD="openssl pkeyutl -decrypt -inkey "_KEY_" "
 I $G(PWD)'="" S %CMD=%CMD_"-passin pass:"_PWD
 O "COMM":(SHELL="/bin/sh":COMM=%CMD:FIXED:WRAP:CHSET="M")::"pipe"
 U "COMM" W TEXT S $X=0 W /EOF ; $X of 0 prevents the code from writing LF to the stream
 N OUT
 N Y
 F  R Y:1 S OUT=$G(OUT)_Y Q:$ZEOF
 U IO C "COMM"
 Q OUT
 ;
AESENCR(TEXT,KEY,IV) ;AES Encrypt, IA #6189
 ; TEXT (Required) Plaintext string to be encrypted
 ; KEY  (Required) Input key material 16, 24, or 32
 ; IV   (Required) Initialization vector. If this argument is present it must 
 ;  be 16 characters long.
 I $G(^%ZOSF("OS"))["OpenM" Q $system.Encryption.AESCBCEncrypt(TEXT,KEY,IV)
 ;
 N %CMD S %CMD="openssl enc -e -aes-256-cbc -K "_KEY_" -iv "_IV
 O "COMM":(SHELL="/bin/sh":COMM=%CMD:FIXED:WRAP:CHSET="M")::"pipe"
 U "COMM" W TEXT S $X=0 W /EOF
 N OUT
 N Y
 F  R Y:1 S OUT=$G(OUT)_Y Q:$ZEOF
 U IO C "COMM"
 Q OUT
 ;
AESDECR(TEXT,KEY,IV) ;AES Decrypt, IA #6189
 I $G(^%ZOSF("OS"))["OpenM" Q $system.Encryption.AESCBCDecrypt(TEXT,KEY,IV)
 ;
 N %CMD S %CMD="openssl enc -d -aes-256-cbc -K "_KEY_" -iv "_IV
 O "COMM":(SHELL="/bin/sh":COMM=%CMD:FIXED:WRAP:CHSET="M")::"pipe"
 U "COMM" W TEXT S $X=0 W /EOF
 N OUT
 N Y
 F  R Y:1 S OUT=$G(OUT)_Y Q:$ZEOF
 U IO C "COMM"
 Q OUT
 ;
Z ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
