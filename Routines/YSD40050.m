YSD40050 ;DALISC/LJA - Repoint Gen.Progress Notes data to DSM ;04/12/94  08:19 [ 07/13/94  2:52 PM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
CTRL ;
 D INIT
 D CHECK QUIT:'YSD4OK  ;->
 D REPOINT
 QUIT
 ;
INIT ;
 S YSD4MLC=0 ;Dot-generator counter
 S YSD4NC=+$G(^YSD(627.99,"AS","GPN NUMBER CONVERTED"))
 S ^YSD(627.99,"AS","GPN CONVERSION STARTED")=$H
 QUIT
 ;
CHECK ;
 S YSD4OK=1
 QUIT:$G(^YSD(627.99,"AS","GPN CONVERSION COMPLETED"))']""  ;->
 W !!,"Generic Progress Notes Conversion has already been completed..."
 S YSD4OK=0
 QUIT
 ;
REPOINT ;  Loop thru all Generic Progress Notes entries
 D STARTNO^YSD40052
 I YSD4IEN'?1.N D  QUIT  ;->
 .  K ^YSD(627.99,"AS","GPN LAST STARTED")
 .  S ^YSD(627.99,"AS","GPN CONVERSION COMPLETED")=$H
 ;
 ;  YSD4IEN - set in STARTNO^YSD40052
 F  S YSD4IEN=$O(^GMR(121,YSD4IEN)) QUIT:YSD4IEN'>0  D
 .  S YSD4ND=$P($G(^GMR(121,+YSD4IEN,30)),U)
 .  I $P(YSD4ND,";",2)[627.5 D RECORD
 ;
 ;  All done...
 S ^YSD(627.99,"AS","GPN CONVERSION COMPLETED")=$H
 ;
 ;  Set DSM-GPN CONVERSION COMPLETION field in Parameter file
 D NOW^%DTC
 S $P(^YSA(602,1,"DSM"),U,2)=%
 ;
 QUIT
 ;
RECORD ;  Repoint 'found' entry...
 S YSD4CIEN=0
 D CONVNTRY^YSD40052 ;  Records "failsafe" info in DSM CONVERSION file
 QUIT:'$G(YSD4CIEN)!('YSD4OK)!(YSD4EREP)  ;->
 ;
 ;  YSD4ND = p(1) of ^(30)... The original DSM-III-R pointer value
 S ^YSD(627.99,+YSD4CIEN,30)=YSD4ND
 ;
 ;  Conversion file entry  made... Repoint PN data now.
 ;  YSD4IEN -- req
 ;
 ;  Actual repointing occurs here!
 L +^GMR(121,+YSD4IEN):60
 ;
 ;  If not locked...
 I '$T D  QUIT  ;->
 .  D NOW^%DTC
 .  D PED^YSD4E010(%,"GPN locking problem",121,30,+YSD4IEN,"",$P($G(^GMR(121,+YSD4IEN,0)),U,2))
 .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E",YSD4EREP=1
 ;
 ;  Set conversion flag now...
 S YSD4CFLG=0
 ;
 ;  Repoint data...
 D REP^YSD40051
 ;
 ;  Unlock
 L -^GMR(121,+YSD4IEN)
 QUIT:'YSD4CFLG  ;->
 ;
 ;  Conversion complete... Update counters
 S YSD4NC=YSD4NC+1,^YSD(627.99,"AS","GPN NUMBER CONVERTED")=+YSD4NC
 ;
 QUIT
 ;
EOR ;YSD40050 - Repoint Gen.Progress Notes data to DSM ;12/7/93 15:12
