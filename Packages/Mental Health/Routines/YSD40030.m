YSD40030 ;DALISC/LJA - Repoint MR data to DSM ;[ 07/13/94  2:52 PM ]
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
 S YSD4NC=+$G(^YSD(627.99,"AS","MR NUMBER CONVERTED"))
 S ^YSD(627.99,"AS","MR CONVERSION STARTED")=$H
 QUIT
 ;
CHECK ;
 S YSD4OK=1
 QUIT:$G(^YSD(627.99,"AS","MR CONVERSION COMPLETED"))']""  ;->
 W !!,"Medical Record Conversion has already been completed..."
 S YSD4OK=0
 QUIT
 ;
REPOINT ;  Loop thru all Medical Records and repoint data...
 ;  MR Loop...
 D STARTNO^YSD40032
 I YSD4IEN'?1.N D  QUIT  ;->
 .  K ^YSD(627.99,"AS","MR LAST STARTED")
 .  S ^YSD(627.99,"AS","MR CONVERSION COMPLETED")=$H
 ;
 F  S YSD4IEN=$O(^MR(YSD4IEN)) QUIT:YSD4IEN'>0  D
 .  S YSD4MLC=YSD4MLC+1 W:'(YSD4MLC#100) "."
 .  D HASDATA QUIT:'YSD4OK  ;->
 .  D CONVNTRY ;->
 ;
 S ^YSD(627.99,"AS","MR CONVERSION COMPLETED")=$H
 ;
 ;  Set the DSM-MR CONVERSION COMPLETION field in the Parameter file
 D NOW^%DTC
 S $P(^YSA(602,+1,"DSM"),U)=%
 ;
 QUIT
 ;
CONVNTRY ;  Make a DSM CONVERSION file entry
 ;
 ;  Make Conversion file entry... Quit if not done...
 D CONVNTRY^YSD40032
 QUIT:'YSD4CIEN!('YSD4OK)!(YSD4EREP)  ;->
 ;
RECLP ;  Loop thru individual ^MR entry multiples/nodes and record
 ;
 ;  Lock ^MR entry...
 L +^MR(+YSD4IEN):60
 ;
 ;  Locked?
 I '$T D  QUIT  ;->
 .  D NOW^%DTC
 .  D PED^YSD4E010(%,"MR Locking problem",90,"",+YSD4IEN,"",+$P($G(^MR(+YSD4IEN,0)),U,2))
 .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E",YSD4EREP=1
 ;
 ;
 ;  Locked... Now, repoint data.
 D REP^YSD40031
 ;
 ;  Unlock...
 L -^MR(+YSD4IEN)
 ;
 ;  Was record successfully repointed?
 QUIT:'$G(YSD4CFLG)  ;->
 ;
 ;  Up counter...
 S YSD4NC=YSD4NC+1,^YSD(627.99,"AS","MR NUMBER CONVERTED")=+YSD4NC
 ;
 QUIT
 ;
 ;----------------------------------------------------------------------
HASDATA ;  Does entry have data to convert, or only a header?
 N X
 S YSD4OK=1
 QUIT:$O(^MR(+YSD4IEN,"DX",0))]""  ;->
 S X=$G(^MR(+YSD4IEN,"DX1")) QUIT:$P(X,U,2)]""!($P(X,U,4)]"")  ;->
 QUIT:$O(^MR(+YSD4IEN,"PDX",0))]""  ;->
 QUIT:$O(^MR(+YSD4IEN,"XDX",0))]""  ;->
 S YSD4OK=0
 QUIT
 ;
EOR ;YSD40030 - Repoint MR data to DSM ;12/7/93 15:12
