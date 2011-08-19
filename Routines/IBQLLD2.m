IBQLLD2 ;LEB/MRY - LOAD UMR FILE/EDIT CHECK ORDER ; 21-AUG-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
ORDCHK ; -- edit check the UR procedure in entering reviews.
 S IBTRV=0 K IBORDER
 F  S IBTRV=$O(^IBT(356.1,"C",IBTRN,IBTRV)) Q:'IBTRV  D  Q:IBQUIT
 .; -- check for bad cross-reference in Reviews
 .S IBTRVD=$G(^IBT(356.1,IBTRV,0)) I '+IBTRVD S IBQUIT=1 Q
 .; -- ignore reviews that are INACTIVE
 .I '$P(IBTRVD,"^",19)!'$P(IBTRVD,"^",21) Q
 .; -- check for no DAY entered in Review.
 .I '$P(IBTRVD,"^",3) S IBQUIT=1 Q
 .; -- check for Reviews with a same DAY.
 .I $D(IBORDER($P(IBTRVD,"^",3))) S IBQUIT=1 Q
 .I 'IBQUIT S IBORDER($P(IBTRVD,"^",3))=IBTRV
 G:IBQUIT END S IBDAY=0
 ; -- check for Reviews that are not in consecutive order.
 F IBCNT=1:1 S IBDAY=$O(IBORDER(IBDAY)) Q:'IBDAY  D  Q:IBQUIT
 .I IBDAY'=IBCNT S IBQUIT=1
 ;
END ; -- clean up
 Q:$D(IBQLR3)
 I $O(^TMP("IBQLPL",$J,IB(.03),IBDDT,0)) S ^TMP("IBQLPL",$J,IB(.03),IBDDT)=IBNAM
 K IBDAY,IBCNT
 Q
