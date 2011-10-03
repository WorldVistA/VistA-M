ESPUCFP1 ;DALISC/CKA -PRINT UNIFORM CRIME REPORT (CONT)- 3/99
 ;;1.0;POLICE & SECURITY;**27**;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCFP
PRT ;PRINT REPORT CONTINUED- PRINTS FIRST PAGE
 S DIC="^ESP(912.3,"_ESPIEN_",1,",DA=ESPN,DR="1:188",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912.31,DA))
 W !!?25,"ASSAULTS         Total # : ",$G(^UTILITY("DIQ1",$J,912.31,DA,1,"E"))
 W !!,"Aggravated          :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,2,"E"))
 W ?40,"Dangerous           :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,3,"E"))
 W !,"Kidnapping          :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,4,"E"))
 W ?40,"No Weapon           :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,5,"E"))
 W !,"Simple              :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,6,"E"))
 W !!,?15,"Offender",?50,"Victim"
 W !!?10,"Employee: ",$G(^UTILITY("DIQ1",$J,912.31,DA,7,"E")),?45,"Employee         : ",$G(^UTILITY("DIQ1",$J,912.31,DA,12,"E"))
 W !?10,"Outsider: ",$G(^UTILITY("DIQ1",$J,912.31,DA,8,"E")),?45,"Police Officer   : ",$G(^UTILITY("DIQ1",$J,912.31,DA,13,"E"))
 W !?10,"Patient : ",$G(^UTILITY("DIQ1",$J,912.31,DA,9,"E")),?45,"Outsider         : ",$G(^UTILITY("DIQ1",$J,912.31,DA,14,"E"))
 W !?10,"Unknown : ",$G(^UTILITY("DIQ1",$J,912.31,DA,10,"E")),?45,"Patient          : ",$G(^UTILITY("DIQ1",$J,912.31,DA,15,"E"))
 W !?10,"Visitor : ",$G(^UTILITY("DIQ1",$J,912.31,DA,11,"E")),?45,"Unknown          : ",$G(^UTILITY("DIQ1",$J,912.31,DA,16,"E"))
 W !,?45,"Visitor          : ",$G(^UTILITY("DIQ1",$J,912.31,DA,17,"E"))
 I $Y+10>IOSL D HDR1 Q:END
 W !!!?25,"BURGLARIES       Total # : ",$G(^UTILITY("DIQ1",$J,912.31,DA,18,"E"))
 W !!,"All Other Areas            :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,19,"E"))
 W ?40,"Canteen                    :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,20,"E"))
 W !,"Agent Cashier              :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,21,"E"))
 W ?40,"Locker Areas               :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,22,"E"))
 W !,"Office                     :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,23,"E"))
 W ?40,"Pharmacy                   :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,24,"E"))
 W !,"Vehicles                   :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,25,"E"))
 W ?40,"Burglary Total $ Loss      :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,26,"E"))
 W !?40,"Burglary Total $ Recovered :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,27,"E"))
 W !!
 I $Y+15>IOSL D HDR1 Q:END
 W !?25,"CONTRABAND       Total # : ",$G(^UTILITY("DIQ1",$J,912.31,DA,28,"E"))
 S TOT=$G(^UTILITY("DIQ1",$J,912.31,DA,29,"E"))+$G(^UTILITY("DIQ1",$J,912.31,DA,30,"E"))+$G(^UTILITY("DIQ1",$J,912.31,DA,31,"E"))+$G(^UTILITY("DIQ1",$J,912.31,DA,32,"E"))+$G(^UTILITY("DIQ1",$J,912.31,DA,33,"E"))
 W !!,"Drugs Total #              :  ",TOT
 W ?40,"Forged Prescriptions       :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,29,"E"))
 W !?40,"Introduction               :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,30,"E"))
 W !?40,"Possession                 :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,31,"E"))
 W !?40,"Sale                       :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,32,"E"))
 W !?40,"Under the Influence        :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,33,"E"))
 S TOT=$G(^UTILITY("DIQ1",$J,912.31,DA,34,"E"))+$G(^UTILITY("DIQ1",$J,912.31,DA,35,"E"))+$G(^UTILITY("DIQ1",$J,912.31,DA,36,"E"))
 W !!,"Alcohol Total #            :  ",TOT
 W ?40,"Introduction               :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,34,"E"))
 W !?40,"Possession                 :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,35,"E"))
 W !?40,"Under the Influence        :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,36,"E"))
 S TOT=$G(^UTILITY("DIQ1",$J,912.31,DA,37,"E"))+$G(^UTILITY("DIQ1",$J,912.31,DA,38,"E"))+$G(^UTILITY("DIQ1",$J,912.31,DA,39,"E"))+$G(^UTILITY("DIQ1",$J,912.31,DA,40,"E"))
 W !!,"Weapons Total #            :  ",TOT
 W ?40,"Firearms                   :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,37,"E"))
 W !?40,"Knives/Hatchets/Clubs      :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,38,"E"))
 W !?40,"Explosives                 :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,39,"E"))
 W !?40,"Other                      :  ",$G(^UTILITY("DIQ1",$J,912.31,DA,40,"E"))
 I $Y+7>IOSL D HDR1 Q:END
 W !,?15,"Offender"
 W !!?10,"Employee: ",$G(^UTILITY("DIQ1",$J,912.31,DA,41,"E"))
 W !?10,"Outsider: ",$G(^UTILITY("DIQ1",$J,912.31,DA,42,"E"))
 W !?10,"Patient : ",$G(^UTILITY("DIQ1",$J,912.31,DA,43,"E"))
 W !?10,"Unknown : ",$G(^UTILITY("DIQ1",$J,912.31,DA,44,"E"))
 W !?10,"Visitor : ",$G(^UTILITY("DIQ1",$J,912.31,DA,45,"E"))
 D PRT^ESPUCFP2
 QUIT
EX W !!,"Done." Q
HDR ;PRINT HEADING
 I $E(IOST,1,2)="C-" W !,"Press RETURN to continue or '^' to exit: " R X:DTIME S END='$T!(X="^") Q:END
 S PAGE=PAGE+1 W @IOF,!?25,"UNIFORM CRIME REPORT",?70,"Page ",$J(PAGE,3)
 S ESPFACI=$P(^ESP(912.3,ESPIEN,1,ESPN,0),U)
 S ESPFACI=$P($G(^DG(40.8,ESPFACI,0)),U,1)
 W !!,"VA Facility ",ESPFACI
BDT W ?45,"BEGINNING DATE: ",$G(^UTILITY("DIQ1",$J,912.3,ESPIEN,.01,"E"))
EDT W !,"Date/Time Printed",?45,"ENDING DATE: ",$G(^UTILITY("DIQ1",$J,912.3,ESPIEN,.02,"E"))
 D NOW^%DTC S Y=% X ^DD("DD") W !,$P(Y,":",1,2)
 QUIT
HDR1 I $E(IOST,1,2)="C-" W !,"Press RETURN to continue or '^' to exit: " R X:DTIME S END='$T!(X="^") Q:END
 S PAGE=PAGE+1 W @IOF,!?25,"UNIFORM CRIME REPORT",?70,"PAGE ",$J(PAGE,3)
 QUIT
