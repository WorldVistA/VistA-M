SPNPRTAU ;HIRMFO/WAA- Automatic questions ; 8/20/96
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;;
 ; This routine will ask the Automatic question for the sort/
 ; search questions.
 ; The routine will store the data in the global
 ; ^TMP($J,"SPNPRT","AUTO",SEQUENCE...
 ; 
EN1 ; Main Entry Point
 N ACTION,SEQUENCE
 S SPNLEXIT=$G(SPNLEXIT,0)
 W !!,"Automatic Filters:"
 S ACTION="AUTO",SPNLEXIT=0
 K ^TMP($J,"SPNPRT",ACTION)
 S SEQUENCE=0 F  S SEQUENCE=$O(^SPNL(154.92,ACTION,SEQUENCE)) Q:SEQUENCE<1  D  Q:SPNLEXIT
 . N SPNIEN,EXECUTE
 . S SPNIEN=$O(^SPNL(154.92,ACTION,SEQUENCE,0)) Q:SPNIEN<1
 . S EXECUTE=$G(^SPNL(154.92,SPNIEN,2))
 . Q:EXECUTE=""
 . X EXECUTE Q:SPNLEXIT
 . Q
 I SPNLEXIT K ^TMP($J,"SPNPRT",ACTION)
 Q
