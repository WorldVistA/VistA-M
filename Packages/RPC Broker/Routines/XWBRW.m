XWBRW ;ISF/RWF - Read/Write for Broker TCP ;09/15/15  06:26
 ;;1.1;RPC BROKER;**35,49,64**;Mar 28, 1997;Build 12
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;XWBRBUF is global
 ;SE is a flag to skip error for short read. From PRSB+41^XWBBRK
BREAD(L,TO,SE) ;read tcp buffer, L is length, TO is timeout
 N R,S,DONE,C,MODE
 I L'>0 Q ""
 I $L(XWBRBUF)'<L S R=$E(XWBRBUF,1,L),XWBRBUF=$E(XWBRBUF,L+1,999999) Q R
 S R="",DONE=0,L=+L,C=0
 S TO=$S($G(TO)>0:TO,$G(XWBTIME(1))>0:XWBTIME(1),1:60)/2+1,MODE=(XWBOS="GT.M")
 U XWBTDEV
 F  D  Q:DONE
 . S S=L-$L(R),R=R_$E(XWBRBUF,1,S),XWBRBUF=$E(XWBRBUF,S+1,999999)
 . I ($L(R)=L)!(R[$C(4))!(C>TO) S DONE=1 Q
 . I MODE R XWBRBUF#S:2 S:'$T C=C+1 ;p49
 . I 'MODE R XWBRBUF:2 S:'$T C=C+1 ;p49
 . S:$L(XWBRBUF) C=0 I $DEVICE S DONE=1 Q  ;p49
 . I $G(XWBDEBUG)>2,$L(XWBRBUF) D LOG^XWBDLOG("rd: "_$E(XWBRBUF,1,252))
 . Q
 I $L(R)<L,'$G(SE) S $ECODE=",U411," ;Throw Error, Did not read full length
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
 . I $E($G(XWBR))'="^" Q
 . S I=$G(XWBR) Q:I=""  S T=$E(I,1,$L(I)-1)
 . ;Only send root node if non-null.
 . I $D(@I)>10 S D=@I I $L(D) D WRITE(D),WRITE($C(13,10)):XWBWRAP&(D'=$C(13,10))
 . F  S I=$Q(@I) Q:I=""!(I'[T)  S D=@I D WRITE(D),WRITE($C(13,10)):XWBWRAP&(D'=$C(13,10))
 . I $D(@XWBR),XWBR'["^XTMP(" K @XWBR  ;p64
 ; -- global instance
 I XWBPTYPE=5 D  Q
 . I $E($G(XWBR))'="^" Q
 . S XWBR=$G(@XWBR) D WRITE(XWBR) Q
 ; -- variable length records only good upto 255 char)
 I XWBPTYPE=6 D
 . S I="" F  S I=$O(XWBR(I)) Q:I=""  D WRITE($C($L(XWBR(I)))),WRITE(XWBR(I))
 Q
 ;
SNDERR ;send error information
 ;XWBSEC is the security packet, XWBERROR is application packet
 N X
 S $X=0 ;Start with zero
 S X=$E($G(XWBSEC),1,255)
 D WRITE($C($L(X))_X)
 S X=$E($G(XWBERROR),1,255)
 D WRITE($C($L(X))_X)
 S XWBERROR="",XWBSEC="" ;clears parameters
 Q
 ;
WRITE(STR) ;Write a data string
 ; send data for DSM (requires buffer flush (!) every 511 chars)
 ;IF XWBOS="DSM"!(XWBOS="UNIX")!(XWBOS="OpenM) next line
 N MAX S MAX=255 ;p49
 F  Q:'$L(STR)  D
 . I $L(XWBSBUF)+$L(STR)>MAX D WBF
 . S XWBSBUF=XWBSBUF_$E(STR,1,MAX),STR=$E(STR,MAX+1,99999) ;p49
 Q
WBF ;Write Buffer Flush
 Q:'$L(XWBSBUF)
 I $G(XWBDEBUG)>2,$L(XWBSBUF) D LOG^XWBDLOG("wrt ("_$L(XWBSBUF)_"): "_$E(XWBSBUF,1,247))
 W XWBSBUF,@XWBT("BF")
 S XWBSBUF=""
 Q
