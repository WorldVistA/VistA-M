XUMF5AU  ;ISS/PAVEL - XUMF5 MD5 Hash API ;06/17/05
 ;;8.0;KERNEL;**383**;July 10, 1995
 ;
 ;MD5 based on info from 4.005 SORT BY VUID;;original name was 'VESOUHSH' ; Secure hash functions
 ;;(c) Copyright 1994 - 2004, ESI Technology Corp, Natick MA
 ;; This source code contains the intellectual property of its copyright holder(s),
 ;; and is made available under a license. If you are not familiar with the terms
 ;; of the license, please refer to the license.txt file that is a part of the
 ;; distribution kit.
 ;; This is a routine version where Variables and Commands set to be Upercase.  Pavel
 ;
 Q
 ;;**************************************************
 ;;MD5 'R'egular portion of the code. This will handle
 ;; one string at a time.
 ;;**************************************************
MD5R(STR) ; Construct a 128-bit MD5 hash of the input.
 N TWOTO
 N A,B,C,D
 N AA,BB,CC,DD
 D INITR
PAD1R  ; Pad str out to 56 bytes mod 64
 ; Padding is a 1 bit followed by all zero bits
 N LEN,MOD,NPAD,PAD
 S LEN=$L(STR),MOD=LEN#64
 S NPAD=$S(MOD<56:56-MOD,1:120-MOD)
 S PAD=$C(128)
 S:NPAD>1 $P(PAD,$C(0),NPAD)=""
 S STR=STR_PAD
PAD2R  ; Append length in bits as 64-bit integer, little endian
 S LEN=LEN*8
 S STR=STR_$$UI64BIT(LEN)
PROCESSR ; Main processing and transformation loop
 N J,POS,N,I
 N X ; X(J) is a 4-byte word from a 64-byte block
 S N=$L(STR)/64 ; Number of 64-byte blocks
 F I=0:1:N-1 D
 . F J=0:1:15 S POS=(64*I)+(4*J),X(J)=$E(STR,POS+1,POS+4)
 . D SAVE
 . D ROUND1
 . D ROUND2
 . D ROUND3
 . D ROUND4
 . D INCR
 K X
 Q A_B_C_D
 ;
INITR  ; Initialization
 ; Set up array of powers of two for rotation
 N I,N
 S N=1
 F I=0:1:31 S TWOTO(I)=N,N=N+N
 ; Initialize 4-byte buffers A,B,C,D
 S A=$C(1,35,69,103)
 S B=$C(137,171,205,239)
 S C=$C(254,220,186,152)
 S D=$C(118,84,50,16)
 Q
 ;
 ;;**************************************************
 ;;MD5 'E'nhanced portion of the code. This will handle
 ;; multiple strings and produce a value for them all
 ;; as if they were submitted as one long string.
 ;;**************************************************
MD5E(ABCD,STR,PP,LL) ; Construct a 128-bit MD5 hash of the input.
 N TWOTO
 N A,B,C,D
 N AA,BB,CC,DD
 D INITE(ABCD)
PAD1E  ; Pad str out to 56 bytes mod 64
 ; Padding is a 1 bit followed by all zero bits
 ; PP = 1  Don't pad with $C(128)  !!!  Pavel    Set to 1 if this is not last string !!
 ;                                               Set to 0 if this is last string !!
 ; LL = Lenght passed form outside for pading of little endian  Pavel !!! - 
 ;                                               Seting lenght if this is last value othervise computed lenght used...
 N LEN,MOD,NPAD,PAD
 S LEN=$L(STR),MOD=LEN#64
 S:$G(LL) LEN=LL ;Pavel
 S NPAD=$S(MOD<56:56-MOD,1:120-MOD)
 S PAD=$C(128)
 S:NPAD>1 $P(PAD,$C(0),NPAD)=""
 S:'$G(PP) STR=STR_PAD ;Pavel
 ;S STR=STR_PAD
PAD2E  ; Append length in bits as 64-bit integer, little endian
 S LEN=LEN*8
 S STR=STR_$$UI64BIT(LEN)
PROCESSE ; Main processing and transformation loop
 N J,POS,N,I
 N X ; X(J) is a 4-byte word from a 64-byte block
 ;S N=$L(STR)/64 ; Number of 64-byte blocks
 S N=$L(STR)\64 ; Number of 64-byte blocks
 F I=0:1:N-1 D
 . F J=0:1:15 S POS=(64*I)+(4*J),X(J)=$E(STR,POS+1,POS+4)
 . D SAVE
 . D ROUND1
 . D ROUND2
 . D ROUND3
 . D ROUND4
 . D INCR
 . ;W !,I," ABCD=",$$MAIN^XUMF5BYT($$HEX(A_B_C_D)),!
 K X
 Q A_B_C_D
 ;
INITE(LASTABCD)    ; Initialization
 ; Set up array of powers of two for rotation
 N I,N,L
 S N=1
 F I=0:1:31 S TWOTO(I)=N,N=N+N
 ; Initialize 4-byte buffers A,B,C,D
 S A=$E(LASTABCD,1,4)
 S B=$E(LASTABCD,5,8)
 S C=$E(LASTABCD,9,12)
 S D=$E(LASTABCD,13,16)
 Q
 ;
 ;;**************************************************
 ;;This is where common code starts, used by both
 ;; Regular and Enhanced portions of this routine.
 ;;**************************************************
SAVE ; Save buffers
 S AA=A,BB=B,CC=C,DD=D
 Q
 ;
ROUND1 ; First round of transformation
 D SUB(.A,B,C,D,X(0),7,3614090360,1)
 D SUB(.D,A,B,C,X(1),12,3905402710,1)
 D SUB(.C,D,A,B,X(2),17,606105819,1)
 D SUB(.B,C,D,A,X(3),22,3250441966,1)
 D SUB(.A,B,C,D,X(4),7,4118548399,1)
 D SUB(.D,A,B,C,X(5),12,1200080426,1)
 D SUB(.C,D,A,B,X(6),17,2821735955,1)
 D SUB(.B,C,D,A,X(7),22,4249261313,1)
 D SUB(.A,B,C,D,X(8),7,1770035416,1)
 D SUB(.D,A,B,C,X(9),12,2336552879,1)
 D SUB(.C,D,A,B,X(10),17,4294925233,1)
 D SUB(.B,C,D,A,X(11),22,2304563134,1)
 D SUB(.A,B,C,D,X(12),7,1804603682,1)
 D SUB(.D,A,B,C,X(13),12,4254626195,1)
 D SUB(.C,D,A,B,X(14),17,2792965006,1)
 D SUB(.B,C,D,A,X(15),22,1236535329,1)
 Q
 ;
ROUND2 ; Second round of transformation
 D SUB(.A,B,C,D,X(1),5,4129170786,2)
 D SUB(.D,A,B,C,X(6),9,3225465664,2)
 D SUB(.C,D,A,B,X(11),14,643717713,2)
 D SUB(.B,C,D,A,X(0),20,3921069994,2)
 D SUB(.A,B,C,D,X(5),5,3593408605,2)
 D SUB(.D,A,B,C,X(10),9,38016083,2)
 D SUB(.C,D,A,B,X(15),14,3634488961,2)
 D SUB(.B,C,D,A,X(4),20,3889429448,2)
 D SUB(.A,B,C,D,X(9),5,568446438,2)
 D SUB(.D,A,B,C,X(14),9,3275163606,2)
 D SUB(.C,D,A,B,X(3),14,4107603335,2)
 D SUB(.B,C,D,A,X(8),20,1163531501,2)
 D SUB(.A,B,C,D,X(13),5,2850285829,2)
 D SUB(.D,A,B,C,X(2),9,4243563512,2)
 D SUB(.C,D,A,B,X(7),14,1735328473,2)
 D SUB(.B,C,D,A,X(12),20,2368359562,2)
 Q
 ;
ROUND3 ; Third round of transformation
 D SUB(.A,B,C,D,X(5),4,4294588738,3)
 D SUB(.D,A,B,C,X(8),11,2272392833,3)
 D SUB(.C,D,A,B,X(11),16,1839030562,3)
 D SUB(.B,C,D,A,X(14),23,4259657740,3)
 D SUB(.A,B,C,D,X(1),4,2763975236,3)
 D SUB(.D,A,B,C,X(4),11,1272893353,3)
 D SUB(.C,D,A,B,X(7),16,4139469664,3)
 D SUB(.B,C,D,A,X(10),23,3200236656,3)
 D SUB(.A,B,C,D,X(13),4,681279174,3)
 D SUB(.D,A,B,C,X(0),11,3936430074,3)
 D SUB(.C,D,A,B,X(3),16,3572445317,3)
 D SUB(.B,C,D,A,X(6),23,76029189,3)
 D SUB(.A,B,C,D,X(9),4,3654602809,3)
 D SUB(.D,A,B,C,X(12),11,3873151461,3)
 D SUB(.C,D,A,B,X(15),16,530742520,3)
 D SUB(.B,C,D,A,X(2),23,3299628645,3)
 Q
 ;
ROUND4 ; Fourth round of transformation
 D SUB(.A,B,C,D,X(0),6,4096336452,4)
 D SUB(.D,A,B,C,X(7),10,1126891415,4)
 D SUB(.C,D,A,B,X(14),15,2878612391,4)
 D SUB(.B,C,D,A,X(5),21,4237533241,4)
 D SUB(.A,B,C,D,X(12),6,1700485571,4)
 D SUB(.D,A,B,C,X(3),10,2399980690,4)
 D SUB(.C,D,A,B,X(10),15,4293915773,4)
 D SUB(.B,C,D,A,X(1),21,2240044497,4)
 D SUB(.A,B,C,D,X(8),6,1873313359,4)
 D SUB(.D,A,B,C,X(15),10,4264355552,4)
 D SUB(.C,D,A,B,X(6),15,2734768916,4)
 D SUB(.B,C,D,A,X(13),21,1309151649,4)
 D SUB(.A,B,C,D,X(4),6,4149444226,4)
 D SUB(.D,A,B,C,X(11),10,3174756917,4)
 D SUB(.C,D,A,B,X(2),15,718787259,4)
 D SUB(.B,C,D,A,X(9),21,3951481745,4)
 Q
INCR ;
 S A=$$ADD(A,AA)
 S B=$$ADD(B,BB)
 S C=$$ADD(C,CC)
 S D=$$ADD(D,DD)
 Q
 ;
 ; Auxiliary functions
 ;
SUB(A,B,C,D,X,S,AC,FN) ; FN is 1 (F), 2 (G), 3 (H) or 4 (I)
 N INT,COMB,CMD,DO
 S INT=$$UINT32(A)
 S DO="COMB"_FN
 D @DO
 S INT=$$ADDIW(INT,COMB)
 S INT=$$ADDIW(INT,X)
 S INT=$$ADDII(INT,AC)
 S INT=$$ROTLI(INT,S)
 S INT=$$ADDIW(INT,B)
 S A=$$UI32BIT(INT)
 Q
COMB ; Choose F, G, H or I
COMB1 S COMB=$$OR($$AND(B,C),$$AND($$NOT(B),D)) Q  ; F
COMB2 S COMB=$$OR($$AND(B,D),$$AND(C,$$NOT(D))) Q  ; G
COMB3 S COMB=$$XOR($$XOR(B,C),D) Q  ; H
COMB4 S COMB=$$XOR(C,$$OR(B,$$NOT(D))) Q  ; I
 Q
 ;
 ; Boolean functions assume args are 4-character strings
 ;
AND(X,Y) ;
 Q $ZBOOLEAN(X,Y,1)  ;;EOCONDCD;CACHE
 Q X  ; Placeholder for other M implementations
 ;
OR(X,Y) ;
 Q $ZBOOLEAN(X,Y,7)  ;;EOCONDCD;CACHE
 Q X  ; Placeholder for other M implementations
 ;
XOR(X,Y) ;
 Q $ZBOOLEAN(X,Y,6)  ;;EOCONDCD;CACHE
 Q X  ; Placeholder for other M implementations
 ;
NOT(X) ;
 Q $ZBOOLEAN(X,X,12)  ;;EOCONDCD;CACHE
 Q X  ; Placeholder for other M implementations
 ;
 ; Functions to add and rotate 32-bit words
 ; X and Y are 4-character strings
 ; m, n and s are integers
 ; ADD and ROTL return 4-character strings
 ; ADDIW, ADDII and ROTLI return integers
 ;
ADD(X,Y) ; modulo 2**32
 Q $$UI32BIT($$UINT32(X)+$$UINT32(Y)#4294967296)
 ;
ADDIW(M,Y) ; modulo 2**32
 Q M+$$UINT32(Y)#4294967296
 ;
ADDII(M,N) ; modulo 2**32
 Q M+N#4294967296
 ;
ROTL(X,S) ; rotate left by s bits
 N INT,RIGHT,SWAP
 S INT=$$UINT32(X)
 S RIGHT=INT#TWOTO(32-S)
 S SWAP=RIGHT*TWOTO(S)+(INT\TWOTO(32-S))
 Q $$UI32BIT(SWAP)
 ;
ROTLI(N,S) ; rotate left by s bits
 N RIGHT,SWAP
 S RIGHT=N#TWOTO(32-S)
 S SWAP=RIGHT*TWOTO(S)+(N\TWOTO(32-S))
 Q SWAP
 ; 
 ; Utility functions
 ;
UI64BIT(N) ; Convert unsigned integer to 64-bit form, little endian
 ; code from CORBA ULONGLONG marshaling
 N D,X,I
 S D=""
 F I=7:-1:1 D
 . S X=0
 . F  Q:(N<(256**I))  S X=X+1,N=N-(256**I)
 . S X(I)=X
 S D=D_$C(N)
 F I=1:1:7 S D=D_$C(X(I))
 Q D
 ;
UI32BIT(N) ; Convert unsigned integer to 32-bit form, little endian
 ; code from CORBA ULONG marshaling
 Q $C(N#256,(N\256#256),(N\(65536)#256),(N\(16777216)#256))
 ;
UINT32(STR) ; Get integer value from bits of 4-character string
 ; code from CORBA ULONG unmarshaling
 Q $A(STR,1)+(256*$A(STR,2))+(65536*$A(STR,3))+(16777216*$A(STR,4))
 ;
HEX(STR) ; Printable hex representation of characters in string
 N DIGITS,RET,I,J,BYTE,OFFSET
 S DIGITS="0123456789abcdef"
 S RET=""
 S OFFSET=$L(STR)#4
 S:OFFSET STR=STR_$E($C(0,0,0),1,4-OFFSET) ; PAD
 F I=0:4:$L(STR)-4 F J=4:-1:1 D  ; Reverse byte order in each word
 . S BYTE=$A(STR,I+J)
 . S RET=RET_$E(DIGITS,1+(BYTE\16)) ; High nibble
 . S RET=RET_$E(DIGITS,1+(BYTE#16)) ; Low nibble
 Q RET
 ;
CHR2OCT(STR) ; convert hex string to decimal byte values
 N RET,I,BYTE,HIGH,LOW
 S RET=""
 F I=1:2:$L(STR) D
 . S BYTE=$E(STR,I,I+1)
 . Q:BYTE'?2NL
 . S HIGH=$$CHAR1($E(BYTE,1))
 . S LOW=$$CHAR1($E(BYTE,2))
 . S RET=RET_(16*HIGH+LOW)_" "
 Q RET
 ;
CHAR1(DIGIT) ; convert one char to its hex value
 N X
 S X=$F("0123456789abcdef",DIGIT)
 Q:X=0 0
 Q X-2
