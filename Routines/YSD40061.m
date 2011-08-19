YSD40061 ;DALISC/LJA - Restore Diagnostic Results ; [ 06/20/94  3:45 PM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
DR ;
 ;  YSD40,YSD4CIEN -- req
 ;
 ;  Set needed variables for xrefs...
 S YSD4REF=$P(YSD40,U) ; B xref
 ;
 ;  Get DR data and set variables
 S YSD4DR0=$G(^YSD(627.8,+YSD4REF,0))
 QUIT:YSD4DR0']""  ;->
 S YSD4DT=$P(YSD4DR0,U,3),YSD4IDT=9999999-YSD4DT
 S YSD4DFN=+$P(YSD4DR0,U,2)
 ;
 ;  Quit if not converted...
 QUIT:$P(YSD40,U,2)'="C"  ;->
 ;
 ;  Plus for Diag Result's IEN...
 S YSD4IEN=+YSD40
 QUIT:YSD4IEN'>0  ;->
 ;
 ;  Set present value of DX in Diag Result's 1 node...
 S YSD4NDX=$P($G(^YSD(627.8,+YSD4IEN,1)),U)
 ;
 ;  Get 1 node...
 S YSD41=$G(^YSD(627.99,+YSD4CIEN,1))
 QUIT:YSD41'["DIC(627.5,"  ;->
 S YSD4ODX=$P(YSD41,U) ;Original DX
 ;
 ;  OK.  Reset DR data...
 S $P(^YSD(627.8,+YSD4IEN,1),U)=YSD4ODX
 ;
 ;  Update xrefs...
 I YSD4DFN>0,YSD4DT?7N.E,YSD4NDX["YSD(627.7,",YSD4ODX["DIC(627.5,",YSD4NDX["YSD(627.7," D
 .  K ^YSD(627.8,"AE","D",+YSD4DFN,YSD4DT,YSD4NDX,+YSD4IEN)
 .  S ^YSD(627.8,"AE","D",+YSD4DFN,YSD4DT,YSD4ODX,+YSD4IEN)=""
 .  K ^YSD(627.8,"AG","D",+YSD4DFN,YSD4NDX,+YSD4IEN)
 .  S ^YSD(627.8,"AG","D",+YSD4DFN,YSD4ODX,+YSD4IEN)=""
 I YSD4DFN>0,YSD4IDT?7N.E,YSD4ODX["DIC(627.5,",YSD4NDX["YSD(627.7," D
 .  K ^YSD(627.8,"AF",+YSD4DFN,YSD4IDT,YSD4NDX,+YSD4IEN)
 .  S ^YSD(627.8,"AF",+YSD4DFN,YSD4IDT,YSD4ODX,+YSD4IEN)=""
 ;
 ;  Delete conversion entry...
 K ^YSD(627.99,+YSD4CIEN),^YSD(627.99,"B",YSD4REF,+YSD4CIEN)
 S X=$P(^YSD(627.99,0),U,4)-1,X=$S(X>0:X,1:0),$P(^YSD(627.99,0),U,4)=X
 ;
 ;  Up counter and dot
 S ^TMP($J,"DR")=$G(^TMP($J,"DR"))+1
 S YSD4CT=YSD4CT+1 W:'(YSD4CT#100) "."
 ;
 ;  If any entries are restored, kill "DR" nodes...
 K ^YSD(627.99,"AS","DR CONVERSION COMPLETED")
 K ^YSD(627.99,"AS","DR CONVERSION STARTED")
 K ^YSD(627.99,"AS","DR LAST STARTED")
 K ^YSD(627.99,"AS","DR NUMBER CONVERTED")
 QUIT
 ;
EOR ;YSD40061 - Restore Diagnostic Results ; 4/8/94 13:20
