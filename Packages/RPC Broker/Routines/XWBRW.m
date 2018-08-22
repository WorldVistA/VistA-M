XWBRW ;ISF/RWF - Read/Write for Broker TCP ;2018-08-22  1:52 PM
 ;;1.1;RPC BROKER;**35,49,64,10001**;Mar 28, 1997;Build 12
 ; 
 ; *10001* changes (c) Sam Habiel 2018
 Q
 ;
 ;XWBRBUF is global
 ;SE is a flag to skip error for short read. From PRSB+41^XWBBRK
BREAD(L,TO,SE) ;read tcp buffer, L is length, TO is timeout
 ; *10001* conv $L,$E to $ZL,$ZE passim.
 ; *10001* add comments for future maintenance as this is CRITICAL code
 ; *10001* For valid UTF-8 support, client must send L to read all the bytes
 ;         that would make a valid UTF-8 string, otherwise, we crash with BADCHAR.
 ; 
 ; R = Return variable
 ; S = length remaining to read
 ; DONE = Terminate read loop
 N R,S,DONE
 ;
 ; Nothing to read. Quit
 I L'>0 Q ""
 ;
 ; If the requested bytes are in the temp buffer, just return them and quit
 I $ZL(XWBRBUF)'<L S R=$ZE(XWBRBUF,1,L),XWBRBUF=$ZE(XWBRBUF,L+1,999999) Q R
 ;
 ; Initial values and timeout
 S R="",DONE=0,L=+L
 S TO=$S($G(TO)>0:TO,$G(XWBTIME(1))>0:XWBTIME(1),1:60)/2+1
 ;
 ; Switch to TCP Device
 U XWBTDEV
 ;
 ; Read loop
 F  D  Q:DONE
 . ; For later iterations of the loop (loop must execute at least twice)
 . ; append read content (XWBRBUF) to R, and remove it from XWBRBUF, up to L bytes.
 . ; If we read too much, the remainder stays in XWBRBUF.
 . ; S is only used in the line below as a temporary variable.
 . ; S = length remaining to read
 . S S=L-$ZL(R),R=R_$ZE(XWBRBUF,1,S),XWBRBUF=$ZE(XWBRBUF,S+1,999999)
 . ;
 . ; If we read the length or got an EOT or timed out, we are done.
 . I $ZL(R)=L S DONE=1 QUIT
 . I R[$C(4)  S DONE=1 QUIT
 . ;
 . ; Read (NB: XWBRBUF is overwritten. It is possible that this is a latent bug
 . ; if the previous line doesn't quit and XWBRBUF still has content.)
 . R XWBRBUF:TO E  S DONE=1 QUIT  ; *10001* -> Changed to directly use TO
 . ;
 . ; If there is an error, quit reading
 . I $DEVICE S DONE=1 Q  ;p49
 . ;
 . ; If logging, log the read. Please note that we use $E here to prevent 
 . ; Bad Char errors. This is inaccurate--but I don't know how to fix it right now.
 . ; -- trying $ZWRITE. That may work.
 . I $G(XWBDEBUG)>2,$ZL(XWBRBUF) D LOG^XWBDLOG("rd: "_$ZWRITE($ZE(XWBRBUF,1,252)))
 ;
 I $ZL(R)<L,'$G(SE) S $ECODE=",U411," ;Throw Error, Did not read full length
 Q R
 ;
QSND(XWBR) ;Quick send
 S XWBPTYPE=1,XWBERROR="",XWBSEC="" D SND
 Q
 ;
ESND(XWBR) ;Send from ETRAP
 S XWBPTYPE=1 D SND
 Q
 ;
SND ; Send a response
 N XWBSBUF S XWBSBUF=""
 U XWBTDEV
 ;
 D SNDERR ;Send any error info
 D SNDDATA ;Send the data
 D WRITE($C(4)),WBF
 Q
 ;
SNDDATA ;Send the data part
 N I,D
 ; -- single value
 I XWBPTYPE=1 D WRITE($G(XWBR)) Q
 ; -- table delimited by CR+LF
 I XWBPTYPE=2 D  Q
 . S I="" F  S I=$O(XWBR(I)) Q:I=""  D WRITE(XWBR(I)),WRITE($C(13,10))
 ; -- word processing
 I XWBPTYPE=3 D  Q
 . S I="" F  S I=$O(XWBR(I)) Q:I=""  D WRITE(XWBR(I)) D:XWBWRAP WRITE($C(13,10))
 ; -- global array
 I XWBPTYPE=4 D  Q
 . I $E($G(XWBR))'="^" Q  ; *10001* $E here is okay, as global name will start with single byte of ^
 . S I=$G(XWBR) Q:I=""  S T=$E(I,1,$L(I)-1) ; *10001* I think this is okay to leave as $E and $L
 . ;Only send root node if non-null.
 . I $D(@I)>10 S D=@I I $L(D) D WRITE(D),WRITE($C(13,10)):XWBWRAP&(D'=$C(13,10))
 . F  S I=$Q(@I) Q:I=""!(I'[T)  S D=@I D WRITE(D),WRITE($C(13,10)):XWBWRAP&(D'=$C(13,10))
 . I $D(@XWBR),XWBR'["^XTMP(" K @XWBR  ;p64
 ; -- global instance
 I XWBPTYPE=5 D  Q
 . I $E($G(XWBR))'="^" Q  ; *10001* ditto
 . S XWBR=$G(@XWBR) D WRITE(XWBR) Q
 ; -- variable length records only good upto 255 char)
 I XWBPTYPE=6 D
 . S I="" F  S I=$O(XWBR(I)) Q:I=""  D WRITE($C($ZL(XWBR(I)))),WRITE(XWBR(I))  ; *10001* $L -> $ZL S-Pack packets
 Q
 ;
SNDERR ;send error information
 ;XWBSEC is the security packet, XWBERROR is application packet
 N X
 S $X=0 ;Start with zero
 S X=$E($G(XWBSEC),1,255)
 D WRITE($C($ZL(X))_X) ; *10001* $L -> $ZL S-Pack packets
 S X=$E($G(XWBERROR),1,255)
 D WRITE($C($ZL(X))_X) ; *10001* $L -> $ZL S-Pack packets
 S XWBERROR="",XWBSEC="" ;clears parameters
 Q
 ;
WRITE(STR) ;Write a data string
 ; *10001*: Change all $L, $E to $ZL, $ZE
 N MAX S MAX=2**15-1 ; *10001* 32 k - 1; was 255
 F  Q:'$ZL(STR)  D
 . I $ZL(XWBSBUF)+$ZL(STR)>MAX D WBF
 . S XWBSBUF=XWBSBUF_$ZE(STR,1,MAX),STR=$ZE(STR,MAX+1,99999) ;p49
 Q
 ;
WBF ;Write Buffer Flush
 ; *10001*: Change all $L to $ZL
 ; Still need to set the character set of the device (done in %ZISTCPS & XWBTCPM)
 ; -> If we chunk XWBSBUF, we may fail on the write statement due to BADCHAR.
 Q:'$ZL(XWBSBUF)
 I $G(XWBDEBUG)>2,$ZL(XWBSBUF) D LOG^XWBDLOG("wrt ("_$ZL(XWBSBUF)_"): "_$ZWRITE($ZE(XWBSBUF,1,247)))
 W XWBSBUF,@XWBT("BF")
 S XWBSBUF=""
 Q
