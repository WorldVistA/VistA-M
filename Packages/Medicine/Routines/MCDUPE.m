MCDUPE ;WASH/DCB-Executed routine for dupr. ;Nov 3, 1993
 ;;2.3;Medicine;;09/13/1996
START ;
 K ^TMP($J,"DUP")
 D ^MCDUPM
 D ^MCDUPP
 K ^TMP($J,"DUP")
 Q
