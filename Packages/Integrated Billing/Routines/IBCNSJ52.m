IBCNSJ52 ;ALB/TMP - INSURANCE PLAN MAINTENANCE ACTION PROCESSING  (continued); 16-AUG-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**43**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SAVE(IBCOV) ; Save off original entry, before edits
 N Z
 K ^TMP($J,"IBCAT",IBCOV)
 F Z=0,1 S ^TMP($J,"IBCAT",IBCOV,Z)=$G(^IBA(355.32,IBCOV,Z))
 S ^TMP($J,"IBCAT",IBCOV,2)=$G(^IBA(355.32,IBCOV,2,0))
 S Z=0 F  S Z=$O(^IBA(355.32,IBCOV,2,Z)) Q:'Z  S ^TMP($J,"IBCAT",IBCOV,2,Z)=$G(^IBA(355.32,IBCOV,2,Z,0))
 Q
 ;
DIFFLIM(IBCOV) ; Determine if coverage was changed
 ; Returns 1 if differnce found, 0 if no difference found
 N DIFF,Z
 S DIFF=0
 F Z=0,1 I $G(^TMP($J,"IBCAT",IBCOV,Z))'=$G(^IBA(355.32,IBCOV,Z)) S DIFF=1 G DLEX
 I $G(^TMP($J,"IBCAT",IBCOV,2))'=$G(^IBA(355.32,IBCOV,2,0)) S DIFF=1 G DLEX
 S Z=0 F  S Z=$O(^IBA(355.32,IBCOV,2,Z)) Q:'Z  D  G:DIFF DLEX
 .I $G(^TMP($J,"IBCAT",IBCOV,2,Z))'=$G(^IBA(355.32,IBCOV,2,Z,0)) S DIFF=1 Q
 .K ^TMP($J,"IBCAT",IBCOV,2,Z)
 I $O(^TMP($J,"IBCAT",IBCOV,2,"")) S DIFF=1
DLEX Q DIFF
 ;
