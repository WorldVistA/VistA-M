YSD40041 ;DALISC/LJA - Repoint Diag Results data continued... ;12/17/93 11:58 [ 04/08/94  12:01 PM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
REP ;  Repoint Diagnostic Results data  (Called from ^YSD40040)
 ;
 ;  Key Variables...
 ;  YSD4IEN -- req  --> YSD4CFLG   Conversion flag)
 ;  YSD4ND -- req   (Original #;DIC(627.8, pointer.  p(1) of ^(1))
 ;
 ;  Set Conversion Entry flag...
 S (YSD4CFLG,YSD4EREP)=0
 ;
 ;  Repoint data here...
 S YSD4NDN=$$NDN(+YSD4ND)
 I 'YSD4NDN D  QUIT  ;->
 .  D NOW^%DTC
 .  D PED^YSD4E010(%,"New DSM # not found",627.8,"",+YSD4IEN,"",+$P($G(^YSD(627.8,+YSD4IEN,0)),U,2))
 .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E",YSD4EREP=1
 ;
 ;  ^(0)
 S YSD40=$G(^YSD(627.8,+YSD4IEN,0))
 I YSD40']"" D  QUIT  ;->
 .  D NOW^%DTC
 .  D PED^YSD4E010(%,"Null 0 node",627.8,"",+YSD4IEN,"",+$P($G(^YSD(627.8,+YSD4IEN,0)),U,2))
 .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E",YSD4EREP=1
 ;
 ;  ^(1)
 S YSD41=$G(^YSD(627.8,+YSD4IEN,1)),YSD4COND=$P(YSD41,U,4)
 I $P(YSD41,U)']"" D  QUIT  ;->
 .  D NOW^%DTC
 .  D PED^YSD4E010(%,"Null 1 node",627.8,"",+YSD4IEN,"",+$P($G(^YSD(627.8,+YSD4IEN,0)),U,2))
 .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E",YSD4EREP=1
 ;
 S YSD4REF=+YSD4NDN_";YSD(627.7,"
 ;
 ;  Reset .01 0;1...
 S $P(^YSD(627.8,+YSD4IEN,1),U)=YSD4REF
 ;
 ;  Set XRef-required variables
 S YSD4DFN=+$P(YSD40,U,2),YSD4DT=+$P(YSD40,U,3)
 ;
 ;  AG Xref-required variables existent?
 I YSD4DFN,YSD4ND D
 .  K ^YSD(627.8,"AG","D",+YSD4DFN,YSD4ND,+YSD4IEN)
 .  S ^YSD(627.8,"AG","D",+YSD4DFN,YSD4REF,+YSD4IEN)=""
 ;
 ;  AE,AF Xref-required variables existent?
 I YSD4DFN,YSD4ND,YSD4DT D
 .  K ^YSD(627.8,"AE","D",+YSD4DFN,+YSD4DT,YSD4ND,+YSD4IEN)
 .  S ^YSD(627.8,"AE","D",+YSD4DFN,+YSD4DT,YSD4REF,+YSD4IEN)=""
 .  K ^YSD(627.8,"AF",+YSD4DFN,9999999-YSD4DT,YSD4ND,+YSD4IEN)
 .  S ^YSD(627.8,"AF",+YSD4DFN,9999999-YSD4DT,YSD4REF,+YSD4IEN)=""
 ;
 ;  AC Xref-required variables existent?
 I YSD4DFN,YSD4ND,YSD4DT,YSD4COND]"" D
 .  K ^YSD(627.8,"AC",+YSD4DFN,9999999-YSD4DT,YSD4ND,YSD4COND,+YSD4IEN)
 .  S ^YSD(627.8,"AC",+YSD4DFN,9999999-YSD4DT,YSD4REF,YSD4COND,+YSD4IEN)=""
 ;  Change Status to CONVERTED
 S:'YSD4EREP $P(^YSD(627.99,+YSD4CIEN,0),U,2)="C"
 S YSD4CFLG=1
 QUIT
 ;
NDN(ONO) QUIT +$P($G(^DIC(627.5,+$G(ONO),0)),U,3)
 ;
EOR ;YSD40041 - Repoint Diag Results data continued... ;12/9/93 10:03
