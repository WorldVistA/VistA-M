IBTRPR2 ;ALB/AAS - CLAIMS TRACKING - PENDING WORK ACTIONS ; 9-AUG-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G EN^IBTRPR
 ;
PW(IBTRN) ; -- Print worksheet
 W !!,"worksheet not available",!
 D PAUSE^VALM1
 Q
 ;
DIAG ; -- diagnosis editing
 N VALMY,I,J,IBXXT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXT=0 F  S IBXXT=$O(VALMY(IBXXT)) Q:'IBXXT  D
 .S IBT=$G(^TMP("IBTRPRDX",$J,+$O(^TMP("IBTRPR",$J,"IDX",IBXXT,0))))
 .S IBTRN=$P(IBT,"^",4),DFN=$P(^IBT(356,+IBTRN,0),"^",2)
 .I IBTRN D EN^IBTRE3(IBTRN)
 .Q
 Q
 ;
PU ; -- procedure editing
 N VALMY,I,J,IBXXT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXT=0 F  S IBXXT=$O(VALMY(IBXXT)) Q:'IBXXT  D
 .S IBT=$G(^TMP("IBTRPRDX",$J,+$O(^TMP("IBTRPR",$J,"IDX",IBXXT,0))))
 .S IBTRN=$P(IBT,"^",4),DFN=$P(^IBT(356,+IBTRN,0),"^",2)
 .I IBTRN D EN^IBTRE4(IBTRN)
 .Q
 Q
 ;
PRV ; -- provider editing
 N VALMY,I,J,IBXXT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXT=0 F  S IBXXT=$O(VALMY(IBXXT)) Q:'IBXXT  D
 .S IBT=$G(^TMP("IBTRPRDX",$J,+$O(^TMP("IBTRPR",$J,"IDX",IBXXT,0))))
 .S IBTRN=$P(IBT,"^",4),DFN=$P(^IBT(356,+IBTRN,0),"^",2)
 .I IBTRN D EN^IBTRE5(IBTRN)
 .Q
 Q
