ESPUCP2 ;DALISC/CKA -PRINT UNIFORM CRIME REPORT (CONT)- 3/93
 ;;1.0;POLICE & SECURITY;**11**;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCP1
PRT ;PRINT REPORT CONTINUED- PRINTS 2ND PAGE
 D HDR Q:END
 S TOT=$G(^UTILITY("DIQ1",$J,912.41,DA,37,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,38,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,39,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,40,"E"))
 W !!?25,"DISTURBANCES         Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,46,"E"))
 W !!,"Bomb Threats               :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,47,"E"))
 W ?40,"Demonstrations              :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,48,"E"))
 W !,"Disorderly Conduct         :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,49,"E"))
 W ?40,"Employee Threat             :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,50,"E"))
 W !,"Other Threat               :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,51,"E"))
 W ?40,"Smoking Violation           :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,52,"E"))
 W !,"Trespassing                :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,53,"E"))
 W ?40,"Unauthorized Photograph     :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,54,"E"))
 W !,"Unauth/Poss/Use/Keys/Cards :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,55,"E"))
 W !!,?15,"Offender"
 W !!?10,"Employee: ",$G(^UTILITY("DIQ1",$J,912.41,DA,56,"E"))
 W ?30,"Outsider: ",$G(^UTILITY("DIQ1",$J,912.41,DA,57,"E"))
 W !?10,"Patient : ",$G(^UTILITY("DIQ1",$J,912.41,DA,58,"E"))
 W ?30,"Unknown : ",$G(^UTILITY("DIQ1",$J,912.41,DA,59,"E"))
 W !?10,"Visitor : ",$G(^UTILITY("DIQ1",$J,912.41,DA,60,"E"))
 I $Y+15>IOSL D HDR1 Q:END
 W !!!?21,"MANSLAUGHTER/MURDER      Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,61,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,62,"E"))
 W !!,"Manslaughter/Murder/Negligent :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,61,"E"))
 W !,"Manslaughter/Murder/Non-Neg.  :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,62,"E"))
 W !!,?15,"Offender",?50,"Victim"
 W !!?10,"Employee: ",$G(^UTILITY("DIQ1",$J,912.41,DA,63,"E")),?45,"Employee      : ",$G(^UTILITY("DIQ1",$J,912.41,DA,68,"E"))
 W !?10,"Outsider: ",$G(^UTILITY("DIQ1",$J,912.41,DA,64,"E")),?45,"Outsider      : ",$G(^UTILITY("DIQ1",$J,912.41,DA,69,"E"))
 W !?10,"Patient : ",$G(^UTILITY("DIQ1",$J,912.41,DA,65,"E")),?45,"Patient       : ",$G(^UTILITY("DIQ1",$J,912.41,DA,70,"E"))
 W !?10,"Unknown : ",$G(^UTILITY("DIQ1",$J,912.41,DA,66,"E")),?45,"Visitor       : ",$G(^UTILITY("DIQ1",$J,912.41,DA,71,"E"))
 W !?10,"Visitor : ",$G(^UTILITY("DIQ1",$J,912.41,DA,67,"E"))
 W !!!?16,"NON-CRIMINAL INVESTIGATIONS    Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,72,"E"))
 W !!,"Missing Patient Reaction   :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,73,"E"))
 W ?40,"Government Veh. Accident    :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,75,"E"))
 W !,"Personal Veh. Accident     :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,76,"E"))
 W ?40,"Assist Law Officer          :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,77,"E"))
 W !,"Staff Assist               :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,78,"E"))
 W ?40,"Alarm Response              :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,79,"E"))
 W !,"Safety Hazard              :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,80,"E"))
 W ?40,"Information Only            :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,188,"E"))
 I $Y+10>IOSL D HDR1 Q:END
 W !!!?25,"OTHER OFFENSES        Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,81,"E"))
 W !!,"Arson                       :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,82,"E"))
 W ?40,"Arson $ Damage              :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,83,"E"))
 W !,"Possession/Stolen Property  :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,84,"E"))
 W ?40,"Receive/Sell Stolen Property:  ",$G(^UTILITY("DIQ1",$J,912.41,DA,85,"E"))
 W !,"Suicide                     :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,86,"E"))
 W ?40,"Suicide Attempt             :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,87,"E"))
 W !!!?25,"RAPES               Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,88,"E"))
 W !!,"Attempted Rape              :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,89,"E"))
 W !,"Forcible Rape               :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,90,"E"))
 W !!,?15,"Offender",?50,"Victim"
 W !!?10,"Employee: ",$G(^UTILITY("DIQ1",$J,912.41,DA,91,"E")),?45,"Employee      : ",$G(^UTILITY("DIQ1",$J,912.41,DA,96,"E"))
 W !?10,"Outsider: ",$G(^UTILITY("DIQ1",$J,912.41,DA,92,"E")),?45,"Outsider      : ",$G(^UTILITY("DIQ1",$J,912.41,DA,97,"E"))
 W !?10,"Patient : ",$G(^UTILITY("DIQ1",$J,912.41,DA,93,"E")),?45,"Patient       : ",$G(^UTILITY("DIQ1",$J,912.41,DA,98,"E"))
 W !?10,"Unknown : ",$G(^UTILITY("DIQ1",$J,912.41,DA,94,"E")),?45,"Visitor       : ",$G(^UTILITY("DIQ1",$J,912.41,DA,99,"E"))
 W !?10,"Visitor : ",$G(^UTILITY("DIQ1",$J,912.41,DA,95,"E"))
 D PRT^ESPUCP3
 QUIT
EX W !!,"Done." Q
HDR ;PRINT HEADING
 I $E(IOST,1,2)="C-" W !,"Press RETURN to continue or '^' to exit: " R X:DTIME S END='$T!(X="^") Q:END
 S PAGE=PAGE+1 W @IOF,!?25,"UNIFORM CRIME REPORT",?70,"PAGE ",$J(PAGE,3)
 W !!,"VA Facility ",$P(^ESP(912.4,ESPIEN,1,1,0),U)
BDT W ?45,"BEGINNING DATE: ",$G(^UTILITY("DIQ1",$J,912.4,ESPIEN,.01,"E"))
EDT W !,"Date/Time Printed",?45,"ENDING DATE: ",$G(^UTILITY("DIQ1",$J,912.4,ESPIEN,.02,"E"))
 D NOW^%DTC S Y=% X ^DD("DD") W !,$P(Y,":",1,2)
 QUIT
HDR1 I $E(IOST,1,2)="C-" W !,"Press RETURN to continue or '^' to exit: " R X:DTIME S END='$T!(X="^") Q:END
 S PAGE=PAGE+1 W @IOF,!?70,"Page ",$J(PAGE,3)
 QUIT
