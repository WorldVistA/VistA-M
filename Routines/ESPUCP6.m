ESPUCP6 ;DALISC/CKA -PRINT UNIFORM CRIME REPORT (CONT)- 3/93
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCP5
PRT ;PRINT REPORT CONTINUED- PRINTS 6TH PAGE
 D HDR Q:END
 W !!?25,"VIOLATION CHARGES                Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,171,"E"))
 W !!,"Courtesy Warnings  Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,172,"E"))
 W !!,"Non-Traffic               :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,173,"E"))
 W !,"Moving                    :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,174,"E"))
 W !,"Parking                   :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,175,"E"))
 W !!,?10,"Offender"
 W !!,"Employee: ",$G(^UTILITY("DIQ1",$J,912.41,DA,176,"E"))
 W !,"Outsider: ",$G(^UTILITY("DIQ1",$J,912.41,DA,177,"E"))
 W !,"Patient : ",$G(^UTILITY("DIQ1",$J,912.41,DA,178,"E"))
 W !,"Visitor : ",$G(^UTILITY("DIQ1",$J,912.41,DA,179,"E"))
 W !!,"USDC Notice        Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,180,"E"))
 W !!,"Non-Traffic               :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,181,"E"))
 W !,"Moving                    :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,182,"E"))
 W !,"Parking                   :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,183,"E"))
 W !!,?10,"Offender"
 W !!,"Employee: ",$G(^UTILITY("DIQ1",$J,912.41,DA,184,"E"))
 W !,"Outsider: ",$G(^UTILITY("DIQ1",$J,912.41,DA,185,"E"))
 W !,"Patient : ",$G(^UTILITY("DIQ1",$J,912.41,DA,186,"E"))
 W !,"Visitor : ",$G(^UTILITY("DIQ1",$J,912.41,DA,187,"E"))
 QUIT
EX W !!,"Done." Q
HDR ;PRINT HEADING
 I $E(IOST,1,2)="C-" W !,"Press RETURN to continue or '^' to exit: " R X:DTIME S END='$T!(X="^") Q:END
 S PAGE=PAGE+1 W @IOF,!?25,"UNIFORM CRIME REPORT",?(IOM-10),"PAGE:  ",$J(PAGE,3)
 W !!,"VA Facility ",$P(^ESP(912.4,ESPIEN,1,1,0),U)
BDT W ?45,"BEGINNING DATE: ",$G(^UTILITY("DIQ1",$J,912.4,ESPIEN,.01,"E"))
EDT W !,"Date/Time Printed",?45,"ENDING DATE: ",$G(^UTILITY("DIQ1",$J,912.4,ESPIEN,.02,"E"))
 D NOW^%DTC S Y=% X ^DD("DD") W !,$P(Y,":",1,2)
 QUIT
