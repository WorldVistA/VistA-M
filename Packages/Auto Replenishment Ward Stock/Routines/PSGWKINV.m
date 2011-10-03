PSGWKINV ;BHAM ISC/MPH,CML-Purge ^PSI(58.19,"AINV") Global of Inventory Over 100 days Old ; 14 Feb 1989  1:53 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 F QQ=0:0 S QQ=$O(^PSI(58.19,"AINV",QQ)) Q:'QQ  D COMPARE
 K QQ,X Q
COMPARE S X1=DT,X2=$S($D(^PSI(58.19,QQ,0))#2:$P(^(0),"^",1),1:"") D ^%DTC
 I X'<100 K ^PSI(58.19,"AINV",QQ)
 Q
