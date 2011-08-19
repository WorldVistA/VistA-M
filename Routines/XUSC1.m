XUSC1 ;SFISC/RWF - Interface to Server services. ;10/09/2002  16:53
 ;;8.0;KERNEL;**283**;Jul 10, 1995
 ;XUSC("STAT") is used to pass subroutine status around.
 ;The entry points EN, OPEN, DATA, CLOSE are supported ref.
 ;Calls a server service on a port depending on service.
 ;Service:port; "ECHO":10250, "CRC32":10255, "SHA1":10260, "DSIG":10265,1:23)
 ;Return 0 = OK, else -1^msg
EN(XUSC3,XUSC1,XUSC2) ;
 ;XUSC3 is the service we want.
 ;XUSC1 input data array
 ;XUSC2 return data array.
 N %,R,XUSC ;XUSC holds data not passed as a parameter.
 I "DSIG/ECHO/SHA1/DES/CRC32/CRL /"'[XUSC3 S R="-1^Bad service" G EXIT
 D SAVDEV^%ZISUTL("XUSC-HOME"),IP
 I $G(XUSC("IP"))="" S R="-1^Server not defined" G EXIT
 S R=$$EN^XUSC1C(XUSC1,XUSC2,$G(XUSC3,"MPI"))
EXIT D USE^%ZISUTL("XUSC-HOME"),RMDEV^%ZISUTL("XUSC-HOME")
 Q R
 ;
OPEN(XUSCITE) ;Open Connection, Setup
 K XUSC N R
 D IP(XUSCITE),SAVDEV^%ZISUTL("XUSC-HOME")
 I $G(XUSC("IP"))="" Q "-1^Bad site"
 D SETUP^XUSC1C S XUSC("HOME")=IO
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XUSC1C"
 D OPEN^XUSC1C I 'XUSC("STAT") D SAVDEV^%ZISUTL("XUSC-IP") U IO D HELO^XUSC1C
 D USE^%ZISUTL("XUSC-HOME")
 Q $S('XUSC("STAT"):0,1:XUSC("STAT"))
 ;
DATA(INPUT,OUTPUT,TYPE) ;Pass Data, Get Responce
 S XUSC("STAT")=0 D USE^%ZISUTL("XUSC-IP")
 D DATA^XUSC1C G:XUSC("STAT") ERR
 D TURN^XUSC1C G:XUSC("STAT") ERR
 D GET^XUSC1C G:XUSC("STAT") ERR
 D USE^%ZISUTL("XUSC-HOME")
 Q 0
 ;
CLOSE() ;Close connection
 D USE^%ZISUTL("XUSC-IP"),QUIT^XUSC1C,USE^%ZISUTL("XUSC-HOME")
 D RMDEV^%ZISUTL("XUSC-IP"),RMDEV^%ZISUTL("XUSC-HOME")
 K XUSC Q 0
 ;
ERR ;Report an error
 D TRACE^XUSC1C("ERROR "_XUSC("STAT"))
 D QUIT^XUSC1C,USE^%ZISUTL("XUSC-HOME")
 Q XUSC("STAT")
 ;
IP ;Lookup name pass back parameters in XUSC
 N %,XUSCY,XUSCE
 S %=$P(XUSC3," ") D
 . I $L($T(@%)) D @% Q
 . D ASK Q
 Q
 ;
DSIG S XUSC("IP")=$P($G(^XTV(8989.3,1,"IP1")),"^",1)
 S XUSC("SOCK")=10265
 Q
CRL S XUSC("IP")=$P($G(^XTV(8989.3,1,"IP1")),"^",1)
 S XUSC("SOCK")=10270
 Q
SHA1 S XUSC("IP")=$P($G(^XTV(8989.3,1,"IP1")),"^",1)
 S XUSC("SOCK")=10260
 Q
ASK ; ASK USER FOR IP AND PORT
 S XUSC("IP")="",XUSC("SOCK")=""
 R !,"IP Address to use: ",%:DTIME Q:"^"[%  S XUSC("IP")=%
 R !,"      Port TO use: ",%:DTIME Q:"^"[%  S XUSC("SOCK")=%
 Q
 ;
NOOP() ;
 S XUSC("STAT")=0 D USE^%ZISUTL("XUSC-IP")
 S XUSC("OK")=$$POST^XUSC1C("NOOP")
 D USE^%ZISUTL("XUSC-HOME")
 Q XUSC("OK")
