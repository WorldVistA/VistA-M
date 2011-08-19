LBRCSL ;ALB/MRY; Library CoreFLS ;[ 03/15/02 11:35 AM]
 ;;2.5;Library;**9**;Mar 11, 1996
 ;
STAND ; Standalone query.
 I $G(LBRYPTR)="" D  I $G(LBRYPTR)="" W !!,$C(7),"No Site has been selected" Q
 . D ^LBRYASK
 I '$P($G(^LBRY(680.6,LBRYPTR,0)),"^",10) D  Q
 . W !,"CoreFLS Vendor interface is not active."
 D STAND^DGBTCSL
 Q
