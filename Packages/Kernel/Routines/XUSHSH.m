XUSHSH ;ISF/STAFF - PASSWORD ENCRYPTION ;03/18/15  16:07
 ;;8.0;KERNEL;**655**;Jul 10, 1995;Build 16
 ;Per VA Directive 6402, this routine should not be modified.
 S X=$$EN(X)
 Q
EN(X) Q X
KE ;
 Q
B ;
 Q
C ;
 Q
CL ;
 Q
SHAHASH(N,X) ;One-Way Hash Utility
 Q ""
B64ENCD(X) ;Base 64 Encode
 Q X
B64DECD(X) ;Base 64 Decode
 Q X
RSAENCR(TEXT,CERT,CAFILE,CRLFILE,ENC) ;RSA Encrypt
 Q TEXT
RSADECR(TEXT,KEY,PWD,ENC) ;RSA Decrypt
 Q TEXT
AESENCR(TEXT,KEY,IV) ;AES Encrypt
 Q TEXT
AESDECR(TEXT,KEY,IV) ;AES Decrypt
 Q TEXT
Z ;;
 ;;
