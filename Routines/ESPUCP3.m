ESPUCP3 ;DALISC/CKA -PRINT UNIFORM CRIME REPORT (CONT)- 3/93
 ;;1.0;POLICE & SECURITY;**11,12,22**;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCP2
PRT ;PRINT REPORT CONTINUED- PRINTS 3RD PAGE
 D HDR Q:END
 W !!?25,"ROBBERY            Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,100,"E"))
 W !!,"Armed Robbery              :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,101,"E"))
 W ?40,"$100 & Above                :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,102,"E"))
 W !?40,"<$100                       :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,103,"E"))
 W !,"Strong Armed Robbery       :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,104,"E"))
 W ?40,"$100 & Above                :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,105,"E"))
 W !?40,"<$100                       :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,106,"E"))
 W !,"Drugs Only                 :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,107,"E"))
 W ?40,"Robbery Total $ Loss        :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,108,"E"))
 W !?40,"Robbery Total $ Recovered   :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,109,"E"))
 I $Y+15>IOSL D HDR1 Q:END
 W !!!?25,"STOPS & ARRESTS    Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,110,"E"))
 W !!,"Physical Arrests           :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,111,"E"))
 W !!,?15,"Offender"
 W !!?10,"Employee: ",$G(^UTILITY("DIQ1",$J,912.41,DA,112,"E"))
 W ?30,"Outsider: ",$G(^UTILITY("DIQ1",$J,912.41,DA,113,"E"))
 W !?10,"Patient : ",$G(^UTILITY("DIQ1",$J,912.41,DA,114,"E"))
 W ?30,"Visitor : ",$G(^UTILITY("DIQ1",$J,912.41,DA,115,"E"))
 W !!,"Stops for Questioning      :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,116,"E"))
 W ?40,"Package Stops               :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,117,"E"))
 W !?40,"Non-Package Stops           :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,118,"E"))
 I $Y+15>IOSL D HDR1 Q:END
 W !!!?25,"THEFTS             Total # : ",$G(^UTILITY("DIQ1",$J,912.41,DA,119,"E"))
 W !!,"Coin-Operated Machines     :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,120,"E"))
 W ?40,"Total $ Loss                :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,121,"E"))
 W !?40,"Total $ Recovery            :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,122,"E"))
 W !!,"Actual Drug Thefts         :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,123,"E"))
 W ?40,"Controlled Substance        :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,125,"E"))
 W !?40,"Non-Controlled Substance    :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,126,"E"))
 W !!,"Attempted Drug Thefts      :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,124,"E"))
 W ?40,"Controlled Substance        :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,127,"E"))
 W !?40,"Non-Controlled Substance    :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,128,"E"))
 W !!,"Total Drug Thefts          :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,129,"E"))
 W ?40,"Total Drug $ Loss           :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,130,"E"))
 W !?40,"Total Drug $ Recovered      :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,131,"E"))
 I $Y+15>IOSL D HDR1 Q:END
 S ESPBEG=$P(^ESP(912.4,ESPIEN,0),U,1)
 W !!,"Government Property        :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,132,"E"))
 I ESPBEG<2971001 D
 . W ?40,"$100 & Above                :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,133,"E"))
 . W !?40,"< $100                      :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,134,"E"))
 I ESPBEG>2970930.2359 D
 . W ?40,"$1000 & Above                :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,133.1,"E"))
 . W !?40,"< $1000                      :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,134.1,"E"))
 W !?40,"Total Gov't $ Loss          :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,135,"E"))
 W !?40,"Total Gov't $ Recovered     :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,136,"E"))
 I $Y+10>IOSL D HDR1 Q:END
 W !!,"Personal Property          :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,137,"E"))
 I ESPBEG<2971001 D
 . W ?40,"$100 & Above                :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,138,"E"))
 . W !?40,"< $100                      :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,139,"E"))
 I ESPBEG>2970930.2359 D
 . W ?40,"$1000 & Above                :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,138.1,"E"))
 . W !?40,"< $1000                      :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,139.1,"E"))
 W !?40,"Total Personal $ Loss       :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,140,"E"))
 W !?40,"Total Personal $ Recovered  :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,141,"E"))
 W !!,"Government Motor Vehicles  :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,143,"E"))
 W ?40,"Gov't Vehicles Recovered    :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,146,"E"))
 W !?40,"$ Loss Gov't Vehicles       :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,144,"E"))
 W !?40,"$ Recovered Gov't Vehicles  :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,145,"E"))
 W !!,"Private Motor Vehicles     :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,147,"E"))
 W ?40,"Private Vehicles Recovered  :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,150,"E"))
 W !?40,"$ Loss Private Vehicles     :  ",$G(^UTILITY("DIQ1",$J,912.41,DA,148,"E"))
 W !?40,"$ Recovered Private Vehicles:  ",$G(^UTILITY("DIQ1",$J,912.41,DA,149,"E"))
 D PRT^ESPUCP4
 QUIT
EX W !!,"Done." Q
HDR ;PRINT HEADING
 I $E(IOST,1,2)="C-" S END=$$EOP^ESPUTIL() Q:END
 S PAGE=PAGE+1 W @IOF,!?25,"UNIFORM CRIME REPORT",?70,"PAGE ",$J(PAGE,3)
 W !!,"VA Facility ",$P(^ESP(912.4,ESPIEN,1,1,0),U)
BDT W ?45,"BEGINNING DATE: ",$G(^UTILITY("DIQ1",$J,912.4,ESPIEN,.01,"E"))
EDT W !,"Date/Time Printed",?45,"ENDING DATE: ",$G(^UTILITY("DIQ1",$J,912.4,ESPIEN,.02,"E"))
 W !,$$NOW^ESPUTIL()
 QUIT
HDR1 I $E(IOST,1,2)="C-" S END=$$EOP^ESPUTIL() Q:END
 S PAGE=PAGE+1 W @IOF,!?70,"PAGE ",$J(PAGE,3)
 QUIT
