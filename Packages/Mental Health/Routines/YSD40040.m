YSD40040 ;DALISC/LJA - Repoint Diag Results data to DSM ;12/10/93 09:15 [ 07/13/94  2:52 PM ]
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
 S YSD4MLC=0 ; Dot-generator counter
 S YSD4NC=+$G(^YSD(627.99,"AS","DR NUMBER CONVERTED"))
 S ^YSD(627.99,"AS","DR CONVERSION STARTED")=$H
 QUIT
 ;
CHECK ;
 S YSD4OK=1
 QUIT:$G(^YSD(627.99,"AS","DR CONVERSION COMPLETED"))']""  ;->
 W !!,"Diagnostic Results Conversion has already been completed..."
 S YSD4OK=0
 QUIT
 ;
REPOINT ;  Loop thru all Diagnostic Results entries
 ;
 D STARTNO^YSD40042
 I YSD4IEN'?1.N D  QUIT  ;->
 .  K ^YSD(627.99,"AS","DR LAST STARTED")
 .  S ^YSD(627.99,"AS","DR CONVERSION COMPLETED")=$H
 ;
 F  S YSD4IEN=$O(^YSD(627.8,YSD4IEN)) QUIT:YSD4IEN'>0  D
 .  S YSD4MLC=YSD4MLC+1 W:'(YSD4MLC#50) "."
 .  S YSD4ND=$P($G(^YSD(627.8,+YSD4IEN,1)),U)
 .  I $P(YSD4ND,";",2)[627.5 D RECORD
 ;
 S ^YSD(627.99,"AS","DR CONVERSION COMPLETED")=$H
 ;
 ;  Set the DSM-DR CONVERSION COMPLETION field in Parameter file
 D NOW^%DTC
 S $P(^YSA(602,1,"DSM"),U,3)=%
 ;
 QUIT
 ;
RECORD ;  Repoint 'found' entry...
 S YSD4CIEN=0
 D CONVNTRY^YSD40042
 QUIT:'$G(YSD4CIEN)!('YSD4OK)!(YSD4EREP)  ;->
 ;
 ;  YSD4ND = p(1) of ^(1)
 S ^YSD(627.99,+YSD4CIEN,1)=YSD4ND
 ;
 ;  Conversion file entry now made... Repoint DR data now.
 ;  YSD4IEN -- req  (Conversion reloops thru all nodes again...)
 ;
 ;  Lock DR entry...
 L +^YSD(627.8,+YSD4IEN):60
 ;
 ;  Successfully locked?
 I '$T D  QUIT  ;->
 .  D NOW^%DTC
 .  D PED^YSD4E010(%,"DR Locking problem",627.8,1,+YSD4IEN,"",+$P($G(^YSD(627.8,+YSD4IEN,0)),U,2))
 .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E",YSD4EREP=1
 ;
 D REP^YSD40041
 ;
 ;  Now, unlock it...
 L -^YSD(627.8,+YSD4IEN)
 ;
 QUIT:'YSD4CFLG  ;->
 ;
 ;  Update counters...
 S YSD4NC=YSD4NC+1,^YSD(627.99,"AS","DR NUMBER CONVERTED")=+YSD4NC
 QUIT
 ;
EOR ;YSD40040 - Repoint Diag Results data to DSM ;12/7/93 15:12
