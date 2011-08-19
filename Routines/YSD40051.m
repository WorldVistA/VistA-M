YSD40051 ;DALISC/LJA - Repoint Gen. Progress Notes data continued... ;04/08/94 0 9:52
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
REP ;  Repoint Generic Progress Notes data  (Called from ^YSD40050)
 ;
 ;  Key Variables...
 ;  YSD4IEN -- req  --> YSD4CFLG Conversion flag
 ;  YSD4ND -- req (Original #;DIC(627.8, pointer.  p(1) of ^(1))
 ;
 ;  Find new DX IEN...
 S YSD4NDN=$$NDN(+YSD4ND)
 ;
 ;  New DX ien located?
 I 'YSD4NDN D  QUIT  ;->
 .  D NOW^%DTC
 .  D PED^YSD4E010(%,"New DSM # not found",121,30,+YSD4IEN,"",+$P($G(^GMR(121,+YSD4IEN,0)),U))
        .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E",YSD4EREP=1
 ;
 ;  New var-pointer reference created
 S YSD4REF=+YSD4NDN_";YSD(627.7,"
 ;
 ;  Reset .01 0;1... (no xrefs...)
 S $P(^GMR(121,+YSD4IEN,30),U)=YSD4REF
 ;
 ;  Change Status to CONVERTED and "trip" flag...
 S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="C",YSD4CFLG=1
 QUIT
 ;
NDN(ONO) QUIT +$P($G(^DIC(627.5,+$G(ONO),0)),U,3)
 ;
EOR ;YSD40051 - Repoint Gen. Progress Notes data continued... ;12/9/93 10:03
