SPNPRTSR ;HIRMFO/WAA- Selective search questions ; 8/20/96
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;;
 ; This routine will ask the Selective Search question for the sort/
 ; search questions.
 ; The routine will store the data in the global
 ; ^TMP($J,"SPNPRT","POST",SEQUENCE...
 ; 
EN1 ; Main Entry Point
 N ACTION,SEQUENCE,SPNLIEN
 S SPNLEXIT=$G(SPNLEXIT,0)
 W !!,"User Selectable Filters:"
 S ACTION="POST",SPNLEXIT=0
 K ^TMP($J,"SPNPRT",ACTION)
SORT ; Select the fields to sort bye
 S SPNLIEN=0
 F SEQUENCE=1:1:3 D  Q:SPNLEXIT!(SPNLIEN=-1)
 . N EXECUTE
 . I $D(^TMP($J,"SPNPRT",ACTION)) D DISPLAY
 . D SELECT
 . Q:SPNLIEN=-1!(SPNLEXIT)
 . S SPNLIEN=+SPNLIEN,EXECUTE=$G(^SPNL(154.92,SPNLIEN,2))
 . Q:EXECUTE=""
 . X EXECUTE
 . Q
EXIT ; Exit
 I SPNLEXIT K ^TMP($J,"SPNPRT",ACTION) Q
 Q
SELECT ; DIC call to select the field
 N DIC
 S DIC="^SPNL(154.92,",DIC(0)="AMEQ"
 S DIC("A")="Select Filter: "
 S DIC("S")="I '$$POST^SPNPRTSR(Y)"
 D ^DIC
 I $D(DUOUT)!($D(DTOUT)) S SPNLEXIT=1 Q
 S SPNLIEN=Y
 Q
DISPLAY ; This subroutine will display all the fields that have been selected
 ; by the user.
 N SEQUENCE,ACTION,FIELD,IEN
 S SEQUENCE=0,ACTION="POST"
 F  S SEQUENCE=$O(^TMP($J,"SPNPRT",ACTION,SEQUENCE)) Q:SEQUENCE<1  D
 . W !,"Sequence: ",SEQUENCE
 . S FIELD=0 F  S FIELD=$O(^TMP($J,"SPNPRT",ACTION,SEQUENCE,FIELD)) Q:FIELD=""  D
 .. I $G(^TMP($J,"SPNPRT",ACTION,SEQUENCE,FIELD))'="" W !,?10,FIELD,"=",$P(^(FIELD),U,2)
 .. S IEN="" F  S IEN=$O(^TMP($J,"SPNPRT",ACTION,SEQUENCE,FIELD,IEN)) Q:IEN=""  D
 ... W !,?20,FIELD,"=",$P(^TMP($J,"SPNPRT",ACTION,SEQUENCE,FIELD,IEN),U,2)
 ... Q
 .. Q
 . Q
 Q
POST(SPNIEN) ; This Function is to determine if the search is a pre action
 ; INPUT:
 ;   SPNIEN = The interneal entry number of the search
 ; Output
 ;   SPNFLG = 1 the action is a pre action 0 not a pre action
 ;
 N SPNFLG
 S SPNFLG=0
 I $G(^SPNL(154.92,SPNIEN,3))>0 S SPNFLG=1
 I $G(^SPNL(154.92,SPNIEN,4))>0 S SPNFLG=1
 Q SPNFLG
