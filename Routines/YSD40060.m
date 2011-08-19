YSD40060 ;DALISC/LJA - Restore Files Using Conversion File ;[ 07/13/94  2:38 PM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
 QUIT
 ;
ALL ;
 W !!,"The use of this option will restore the entries in the Medical Record,"
 W !,"Diagnostic Results, and Generic Progress Notes files to their original"
 W !,"condition.  When this occurs, the Conversion file entry used during the"
 W !,"restoration process will be deleted...",!!
 W !!,"Note: Only those entries which have completed the initial conversion will be"
 W !,"restored.  (These entries have a status of <C>onverted.)",!!
 N DIR
 S DIR(0)="Y",DIR("A")="OK to start restoration process",DIR("B")="No"
 D ^DIR
 QUIT:+Y'=1  ;->
 W !!,"Starting restoration..."
 ;
 K ^TMP($J) S (YSD4CT,YSD4GCT)=0
 S YSD4CIEN=0
 F  S YSD4CIEN=$O(^YSD(627.99,YSD4CIEN)) QUIT:YSD4CIEN'>0  D RESTORE
 ;
 W !!,"Restoration complete..."
 W !!,"# Progress Notes Restored:  ",?40,$J($G(^TMP($J,"GPN")),6)
 W !,"# Diagnostic Results Restored: ",?40,$J($G(^TMP($J,"DR")),6)
 W !,"# Medical Records Restored: ",?40,$J($G(^TMP($J,"MR")),6)
 K ^TMP($J)
 QUIT
ONE ;
 K ^TMP($J)
ONE1 ;
 W !!
 N DIR
 S DIR(0)="N",DIR("A")="Enter Conversion file number"
 D ^DIR
 I +Y'>0 K ^TMP($J) QUIT  ;->
 S YSD4CIEN=+Y
 I $G(^YSD(627.99,+YSD4CIEN,0))']"" D  G ONE ;->
 .  W !,"No data found..."
 D RESTORE
 G ONE1
 ;
RESTORE ;  Restore entries to pre-conversion state...
 ;  YSD4CIEN -- required -- YSD4RFLG (Restored flag)
 ;
 ;  Assume restoration failure.  Set to 'success' at end...
 S YSD4RFLG=0
 S YSD4GCT=YSD4GCT+1 W:'(YSD4GCT#30) "."
 ;
 ;  IEN passed?
 I $G(YSD4CIEN)'>0  D  QUIT  ;->
 .  W !,"Entry number not available.  Entry not restored!"
 ;
 ;  OK.  Now, restore...
 S YSD40=$G(^YSD(627.99,+YSD4CIEN,0))
 I YSD40?1.N1";GMR(121,"1"^"1U D GPN QUIT  ;->
 I YSD40?1.N1";YSD(627.8,"1"^"1U D DR^YSD40061 QUIT  ;->
 I YSD40?1.N1";MR("1"^"1U D MR^YSD40062 QUIT  ;->
 ;
 ;  Invalid 0 node!!
 W !,"#",YSD4CIEN," has an invalid 0 node!!!"
 ;
 QUIT
 ;
GPN ;
 N YSD430,YSD4IEN
 ;
 ;  Set Reference...
 S YSD4REF=$P(YSD40,U)
 ;
 ;  Quit if not Converted...
 QUIT:$P(YSD40,U,2)'="C"  ;-> 
 ;
 ;  Plusing gives GPN's IEN
 S YSD4IEN=+YSD40
 ;
 ;  Get 30 node...
 S YSD430=$G(^YSD(627.99,+YSD4CIEN,30))
 ;
 ;  Quit if not valid DSM-III-R pointer...
 QUIT:YSD430'["DIC(627.5,"  ;->
 ;
 ;  OK.  Reset GPN data.  (No xrefs exist...)
 S ^GMR(121,+YSD4IEN,30)=+YSD430_";DIC(627.5,"
 ;
 ;  Delete Conversion entry
 K ^YSD(627.99,+YSD4CIEN),^YSD(627.99,"B",YSD4REF,+YSD4CIEN)
 S X=$P(^YSD(627.99,0),U,4)-1,X=$S(X>0:X,1:0),$P(^YSD(627.99,0),U,4)=X
 ;
 ;  Up counter and "dot"
 S ^TMP($J,"GPN")=$G(^TMP($J,"GPN"))+1
 D DOT
 ;
 ;  If any entries are restored, kill "GPN" nodes...
 K ^YSD(627.99,"AS","GPN CONVERSION COMPLETED")
 K ^YSD(627.99,"AS","GPN CONVERSION STARTED")
 K ^YSD(627.99,"AS","GPN LAST STARTED")
 K ^YSD(627.99,"AS","GPN NUMBER CONVERTED")
 QUIT
 ;
DOT ;
 S YSD4CT=YSD4CT+1 W:'(YSD4CT#100) "."
 QUIT
 ;
EOR ;YSD40060 - Restore Files Using Conversion File ;12/7/93 15:12
