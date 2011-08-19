SPNPRTUP ;HIRMFO/WAA-Up front questions ;11/6/97  13:22
 ;;2.0;Spinal Cord Dysfunction;**3**;01/02/1997
 ;;
 ; This routine will ask the up front question for the sort/
 ; search questions.
 ; The routine will store the data in the global
 ; ^TMP($J,"SPNPRT","AUP",SEQUENCE...
 ; 
EN1 ; Main Entry Point
 S SPNFILTR=$G(SPNFILTR,1)
 Q:'SPNFILTR
 N ACTION,SEQUENCE
 S ACTION="AUP",SPNLEXIT=0
 K ^TMP($J,"SPNPRT",ACTION)
 W !!,"Up Front Filters:"
 S SEQUENCE=0 F  S SEQUENCE=$O(^SPNL(154.92,ACTION,SEQUENCE)) Q:SEQUENCE<1  D  Q:SPNLEXIT
 . N SPNIEN,EXECUTE
 . S SPNIEN=$O(^SPNL(154.92,ACTION,SEQUENCE,0)) Q:SPNIEN<1
 . S EXECUTE=$G(^SPNL(154.92,SPNIEN,2))
 . Q:EXECUTE=""
 . X EXECUTE Q:SPNLEXIT
 . Q
 I SPNLEXIT K ^TMP($J,"SPNPRT",ACTION)
 Q
 ;
FILYN() ;This is to ask the user if he or she want to use filters
 N DIR,FLAG
 K ^TMP($J)
 S FLAG=""
 S DIR("A")="Do you wish to use the SCD filters with the reports"
 S DIR("?")="Answer YES if you want to use the filters or NO to bypass the filters."
 S DIR(0)="Y",DIR("B")="YES" D ^DIR
 I '$D(Y) S Y=""
 S FLAG=$S(Y=1:1,Y=0:0,1:"")
 S:FLAG="" XQUIT=1
 Q FLAG
