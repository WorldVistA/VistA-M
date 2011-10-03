YSD40032 ;DALISC/LJA - Make MR Conversion File Entry ;[ 04/08/94  11:52 AM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
CONVNTRY ;
 ;  Set Multiple roots, B xref, etc
 S (YSD4CIEN,YSD4EREP)=0,YSD40="",YSD4REF=+YSD4IEN_";MR("
 S YSD4CIEN=$O(^YSD(627.99,"B",YSD4REF,0)),YSD4OK=0
 ;  ----------------------------------------------------------------
 ;  Following check: Was the IEN returned in YSD4CIEN???
 ;  If so, some portion of the conversion has "hit" this record.
 ;  Therefore, the Status is either...
 ;      Null, <S>tarted, <R>ecorded, <C>onverted, or <E>rrored...
 I YSD4CIEN D  QUIT:'YSD4OK!(YSD4EREP)
 .  S YSD4OK=1 ;  Assume all is OK...
 .  S YSD40=$G(^YSD(627.99,+YSD4CIEN,0))
 .
 .  ;  -------- No 0 node error...
 .  I YSD40']"" D  QUIT  ;->
 .  .  S YSD4OK=0
 .  .  D NOW^%DTC
 .  .  D PED^YSD4E010(%,"Null 0 node",90," ",+YSD4IEN,"",+$P($G(^MR(+YSD4IEN,0)),U,2))
 .  .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E",YSD4EREP=1
 .
 .  ;  -------- Null status error...
 .  I $P(YSD40,U,2)']"" D  QUIT  ;->
 .  .  S YSD4OK=0
 .  .  D NOW^%DTC
 .  .  D PED^YSD4E010(%,"Can't convert 'null status' entries",90," ",+YSD4IEN,"",+$P($G(^MR(+YSD4IEN,0)),U,2))
 .  .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E",YSD4EREP=1
 .
 .  ;  -------- If status=<E>rror, error has already been recorded...
 .  ;           Don't try to convert again...
 .  I $P(YSD40,U,2)["E" S YSD4OK=0 QUIT  ;->
 .
 .  ;  -------- If status=<C>onverted, do not reconvert!!!
 .  I $P(YSD40,U,2)["C" S YSD4OK=0 QUIT  ;->
 .
 .  ;  -------- If status=<R>ecorded, report an error...
 .  ;           (... conversion has started, and progressed to
 .  ;           an unknown state.)
 .  I $P(YSD40,U,2)["R" D  QUIT  ;->
 .  .  S YSD4OK=0
 .  .  D NOW^%DTC
 .  .  D PED^YSD4E010(%,"Can't convert 'Recorded' entries",90," ",+YSD4IEN,"",+$P($G(^MR(+YSD4IEN,0)),U,2))
 .  .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E",YSD4EREP=1
 .
 .
 .  ;  -------- So, by elimination, the Status is <S>tarted...
 .  ;           Therefore, it can be restarted from the beginning...
 .  K ^YSD(627.99,+YSD4CIEN)
 .  K ^YSD(627.99,"AS","MR LAST STARTED")
 .  S ^YSD(627.99,+YSD4CIEN,0)=YSD4REF_U_"S"
 .  S ^YSD(627.99,"AS","MR LAST STARTED")=+YSD4IEN_U_$H
 .
 .  ;  Record as OK in YSD4OK...
 .  S YSD4OK=1
 ;  ----------------------------------------------------------------
 ;  If entry does not already exist, make new entry
 I 'YSD4CIEN D  QUIT:'YSD4CIEN  ;->
 .  S X=^YSD(627.99,0),YSD4CIEN=+$P(X,U,3)+1,$P(X,U,3)=YSD4CIEN,$P(X,U,4)=$P(X,U,4)+1 S ^YSD(627.99,0)=X
 .  S ^YSD(627.99,"B",YSD4REF,+YSD4CIEN)=""
 .  S ^YSD(627.99,+YSD4CIEN,0)=YSD4REF_U_"S"
 .  S ^YSD(627.99,"AS","MR LAST STARTED")=+YSD4IEN_U_$H
 .  S YSD4OK=1
 ;
 ;  Final check for creation/detection of Conversion file entry
 QUIT
 ;
STARTNO ;
 I $G(^YSD(627.99,"AS","MR CONVERSION COMPLETED"))]"" D   QUIT  ;->
 .  S YSD4IEN="Done"
 .  W:$X>1 ! W "Conversion of Medical Record data already completed ...",!
 S YSD4IEN=+$G(^YSD(627.99,"AS","MR LAST STARTED"))
 I YSD4IEN>0 S YSD4IEN=YSD4IEN-1 ;  Reevaluate last entry
 QUIT
 ;
EOR ;YSD40032 - Make MR Conversion File Entry ; 4/7/94 15:17
