XLFCRC ;ISF/RWF - Library Functions to do CRC ;08/04/2000  09:42
 ;;8.0;KERNEL;**166**;Jul 10, 1995
 ; The code below was approved in document X11/1998-32
 ;From the book "M[UMPS] by example" by Ed de Mole.
 ;
CRC32(string,seed) ;
 ; Polynomial X**32 + X**26 + X**23 + X**22 +
 ;          + X**16 + X**12 + X**11 + X**10 +
 ;          + X**8  + X**7  + X**5  + X**4 +
 ;          + X**2  + X     + 1
 N I,J,R
 I '$D(seed) S R=4294967295
 E  I seed'<0,seed'>4294967295 S R=4294967295-seed
 E  S $ECODE=",M28,"
 F I=1:1:$L(string) D
 . S R=$$XOR($A(string,I),R,8)
 . F J=0:1:7 D
 . . I R#2 S R=$$XOR(R\2,3988292384,32)
 . . E  S R=R\2
 . . Q
 . Q
 Q 4294967295-R
 ;
XOR(a,b,w) N I,M,R
 S R=b,M=1
 F I=1:1:w D
 . S:a\M#2 R=R+$S(R\M#2:-M,1:M)
 . S M=M+M
 . Q
 Q R
 ; ===
 ;
 ; The code below was approved in document X11/1998-32
 ;
CRC16(string,seed) ;
 ; Polynomial x**16 + x**15 + x**2 + x**0
 N I,J,R
 I '$D(seed) S R=0
 E  I seed'<0,seed'>65535 S R=seed\1
 E  S $ECODE=",M28,"
 F I=1:1:$L(string) D
 . S R=$$XOR($A(string,I),R,8)
 . F J=0:1:7 D
 . . I R#2 S R=$$XOR(R\2,40961,16)
 . . E  S R=R\2
 . . Q
 . Q
 Q R
 ;
ZXOR(a,b,w) NEW I,M,R
 SET R=b,M=1
 FOR I=1:1:w DO
 . SET:a\M#2 R=R+$SELECT(R\M#2:-M,1:M)
 . SET M=M+M
 . QUIT
 QUIT R
 ;
 
