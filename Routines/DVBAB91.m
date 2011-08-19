DVBAB91 ;GT-CAPRI FULL ;05/08/02
 ;;2.7;AMIE;**44**;Apr 10, 1995
 ;
 ;
START ;
 N VAR S VAR=""
 I $D(^DVB(396.1,0)) D
 . F  S VAR=$O(^DVB(396.1,VAR)) Q:VAR="B"  D
 . . S $P(^DVB(396.1,VAR,0),"^",10)=""
 . . S $P(^DVB(396.1,VAR,0),"^",11)=""
 K VAR
 Q
