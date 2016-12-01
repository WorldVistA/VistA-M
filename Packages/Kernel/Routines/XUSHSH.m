XUSHSH ;ISF/STAFF - ENCRYPTION/DECRYPTION UTILITIES ;01/20/16  14:33
 ;;8.0;KERNEL;**655,659**;Jul 10, 1995;Build 22
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;; This is the public domain version of the VA Kernel.
 ;; Use this routine for your own encryption algorithm
 ;; Input in X
 ;; Output in X
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
 Q
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
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 Q ""
 ;
B64ENCD(X) ;Base 64 Encode, IA #6189
 ;
 ;
 ;
 ;
 Q ""
 ;
B64DECD(X) ;Base 64 Decode, IA #6189
 ;
 ;
 ;
 ;
 Q ""
 ;
RSAENCR(TEXT,CERT,CAFILE,CRLFILE,ENC) ;RSA Encrypt, IA #6189
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 Q ""
 ;
RSADECR(TEXT,KEY,PWD,ENC) ;RSA Decrypt, IA #6189
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 Q ""
 ;
AESENCR(TEXT,KEY,IV) ;AES Encrypt, IA #6189
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 Q ""
 ;
AESDECR(TEXT,KEY,IV) ;AES Decrypt, IA #6189
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 Q ""
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
