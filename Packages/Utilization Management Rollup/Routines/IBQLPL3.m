IBQLPL3 ;LEB/MRY - PATIENTS QUALIFY/MISSING LIST  ; 18-AUG-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**1**;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
ORDCHK ; -- edit check the UR procedure in entering reviews (.001 errors).
 S (IBTRV,IB001)=0 K IBORDER
 F  S IBTRV=$O(^IBT(356.1,"C",IBTRN,IBTRV)) Q:'IBTRV  D
 .S IBTRVD=$G(^IBT(356.1,IBTRV,0)) I '+IBTRVD D  S IB001=1
 ..S IBERR="Bad cross-reference in Reviews (#"_IB(.01)_")"
 ..S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),.001)=IBERR
 .; -- ignore INACTIVE review entries.
 .I '$P(IBTRVD,"^",19)!'$P(IBTRVD,"^",21) Q
 .I '$P(IBTRVD,"^",3) D  S IB001=1
 ..S IBERR="No DAY entered in Reviews (#"_IB(.01)_")"
 ..S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),.002)=IBERR
 .I $D(IBORDER(+$P(IBTRVD,"^",3))) D  S IB001=1
 ..S IBERR="Review entries contain same DAY (#"_IB(.01)_")"
 ..S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),.003)=IBERR
 .I 'IB001 S IBORDER($P(IBTRVD,"^",3))=IBTRV
 S IBDAY=0
 F IBCNT=1:1 S IBDAY=$O(IBORDER(IBDAY)) Q:'IBDAY  D
 .I IBDAY'=IBCNT D  S IB001=1
 ..S IBERR="DAY entries not in consecutive order (#"_IB(.01)_")"
 ..S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),.004)=IBERR
 ;
END ; -- clean up
 I $O(^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),0)) S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03))=IBNAM
 K IBDAY,IBCNT
 Q
