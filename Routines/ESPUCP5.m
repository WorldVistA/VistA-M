ESPUCP5 ;DALISC/CKA -PRINT UNIFORM CRIME REPORT (CONT)- 3/93
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCP4
PRT ;PRINT REPORT CONTINUED- PRINTS 5TH PAGE
 D HDR Q:END
 W !!,"Motor Vehicles                 :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,142,"E"))
 W !!,"Government Motor Vehicle       :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,143,"E"))
 W !,"$ Loss                         :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,144,"E"))
 W !,"$ Recovered                    :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,145,"E"))
 W !,"Gov't Vehicles Recovered       :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,146,"E"))
 W !!,"Private Motor Vehicle          :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,147,"E"))
 W !,"$ Loss                         :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,148,"E"))
 W !,"$ Recovered                    :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,149,"E"))
 W !,"Private Veh's Recovered        :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,150,"E"))
 W !!?25,"VANDALISM"
 W !,"Total #                     :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,152,"E"))
 W !,"Total $                     :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,158,"E"))
 W !!,?10,"Offender"
 W !!,"Employee: ",$G(^UTILITY("DIQ1",$J,912.41,DA,153,"E"))
 W !,"Outsider: ",$G(^UTILITY("DIQ1",$J,912.41,DA,154,"E"))
 W !,"Patient : ",$G(^UTILITY("DIQ1",$J,912.41,DA,155,"E"))
 W !,"Unknown : ",$G(^UTILITY("DIQ1",$J,912.41,DA,156,"E"))
 W !,"Visitor : ",$G(^UTILITY("DIQ1",$J,912.41,DA,157,"E"))
 W !!?25,"VICE SOLICITING               Total # :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,159,"E"))
 W !!,"Bribery                    : ",$G(^UTILITY("DIQ1",$J,912.41,DA,160,"E"))
 W !,"Forgery                    : ",$G(^UTILITY("DIQ1",$J,912.41,DA,161,"E"))
 W !,"Fraud                      : ",$G(^UTILITY("DIQ1",$J,912.41,DA,162,"E"))
 W !,"Gambling                   : ",$G(^UTILITY("DIQ1",$J,912.41,DA,163,"E"))
 W !,"Solicitation/Prostitution  : ",$G(^UTILITY("DIQ1",$J,912.41,DA,164,"E"))
 W !,"Sexual Misconduct          : ",$G(^UTILITY("DIQ1",$J,912.41,DA,165,"E"))
 W !!,?10,"Offender"
 W !!,"Employee: ",$G(^UTILITY("DIQ1",$J,912.41,DA,166,"E"))
 W !,"Outsider: ",$G(^UTILITY("DIQ1",$J,912.41,DA,167,"E"))
 W !,"Patient : ",$G(^UTILITY("DIQ1",$J,912.41,DA,168,"E"))
 W !,"Unknown : ",$G(^UTILITY("DIQ1",$J,912.41,DA,169,"E"))
 W !,"Visitor : ",$G(^UTILITY("DIQ1",$J,912.41,DA,170,"E"))
 D PRT^ESPUCP6
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
