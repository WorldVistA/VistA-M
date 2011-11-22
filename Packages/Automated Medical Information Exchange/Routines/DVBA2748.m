DVBA2748 ;GT-CAPRI FULL ;10/10/02
 ;;2.7;AMIE;**48**;Apr 10, 1995
 ;
 ;This pre-install routine set file 396.1 fields (.11 and 9) to 999.
 ; 999 represent the number of days to keep data. 
START ;
 N VAR S VAR=""
 I $D(^DVB(396.1,0)) D
 . F  S VAR=$O(^DVB(396.1,VAR)) Q:VAR="B"  D
 . . S $P(^DVB(396.1,VAR,0),"^",10)=999
 . . S $P(^DVB(396.1,VAR,0),"^",11)=999
 K VAR
 Q
