PSJ010 ;BIR/RSB-UTILITY ROUTINE FOR PSJ*5.0*10 ; 15 Apr 98 / 8:01 AM
 ;;5.0; INPATIENT MEDICATIONS ;**10**;16 DEC 97
 ;
 D 1,2,3 Q
 ; ***** Convert field .13 and .14 in 59.6 to fields .19 and .2
1 N X,PSJW,PSJP,PSJN,PSJF
 F PSJW=0:0 S PSJW=$O(^PS(59.6,PSJW)) Q:'PSJW  D
 .F PSJF=13,14 D
 ..I $L($P($G(^PS(59.6,PSJW,0)),"^",PSJF)) S PSJN=$P(^(0),"^",PSJF) D
 ...K DIC S X=PSJN,DIC="^%ZIS(1,",DIC(0)="XOS" D ^DIC S:+Y>0 $P(^PS(59.6,PSJW,0),"^",(PSJF+6))=+Y
 Q
 ;
 ;
 ; ***** Convert field .07 in 53.45 to field .13
2 N X,PSJW,PSJP,PSJN,PSJF
 F PSJW=0:0 S PSJW=$O(^PS(53.45,PSJW)) Q:'PSJW  D
 .F PSJF=7 D
 ..I $L($P($G(^PS(53.45,PSJW,0)),"^",PSJF)) S PSJN=$P(^(0),"^",PSJF) D
 ...K DIC S X=PSJN,DIC="^%ZIS(1,",DIC(0)="XOS" D ^DIC S:+Y>0 $P(^PS(53.45,PSJW,0),"^",(PSJF+6))=+Y
 Q
 ;
 ;
 ; ***** Convert field 30 in 57.5 to field 32
3 N X,PSJW,PSJP,PSJN,PSJF
 F PSJW=0:0 S PSJW=$O(^PS(57.5,PSJW)) Q:'PSJW  D
 .F PSJF=1 D
 ..I $L($P($G(^PS(57.5,PSJW,3)),"^",PSJF)) S PSJN=$P(^(3),"^",PSJF) D
 ...K DIC S X=PSJN,DIC="^%ZIS(1,",DIC(0)="XOS" D ^DIC S:+Y>0 $P(^PS(57.5,PSJW,3),"^",(PSJF+2))=+Y
 Q
