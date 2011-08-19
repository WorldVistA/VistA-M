ESPUCM1 ;DALISC/CKA -UNIFORM CRIME REPORT IN MAIL MESSAGE (CONT)- 4/93
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCM
PRT ;PRINT REPORT CONTINUED- PRINTS FIRST PAGE
 S DIC="^ESP(912.4,"_ESPIEN_",1,",DA=ESPN,DR="1:188",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912.41,DA))
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,25)_"ASSAULTS       Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,1,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Aggravated          :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,2,"E")) D MSG
 S ESPX="Dangerous           :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,3,"E")) D MSG
 S ESPX="Kidnapping          :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,4,"E")) D MSG
 S ESPX="No Weapon           :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,5,"E")) D MSG
 S ESPX="Simple              :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,6,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,3)_"Offender"_$E(SPACES,1,20)_"Victim" D MSG
 S ESPX=" " D MSG S ESPX="Employee: "_$G(^UTILITY("DIQ1",$J,912.41,DA,7,"E"))_$E(SPACES,1,10)_"Employee         : "_$G(^UTILITY("DIQ1",$J,912.41,DA,12,"E")) D MSG
 S ESPX="Outsider: "_$G(^UTILITY("DIQ1",$J,912.41,DA,8,"E"))_$E(SPACES,1,10)_"Police Officer   : "_$G(^UTILITY("DIQ1",$J,912.41,DA,13,"E")) D MSG
 S ESPX="Patient : "_$G(^UTILITY("DIQ1",$J,912.41,DA,9,"E"))_$E(SPACES,1,10)_"Outsider         : "_$G(^UTILITY("DIQ1",$J,912.41,DA,14,"E")) D MSG
 S ESPX="Unknown : "_$G(^UTILITY("DIQ1",$J,912.41,DA,10,"E"))_$E(SPACES,1,10)_"Patient          : "_$G(^UTILITY("DIQ1",$J,912.41,DA,15,"E")) D MSG
 S ESPX="Visitor : "_$G(^UTILITY("DIQ1",$J,912.41,DA,11,"E"))_$E(SPACES,1,10)_"Unknown          : "_$G(^UTILITY("DIQ1",$J,912.41,DA,16,"E")) D MSG
 S ESPX=$E(SPACES,1,21)_"Visitor          : "_$G(^UTILITY("DIQ1",$J,912.41,DA,17,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,25)_"BURGLARIES       Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,18,"E")) D MSG
 S ESPX=" " D MSG S ESPX="All Other Areas            :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,19,"E")) D MSG
 S ESPX="Canteen                    :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,20,"E")) D MSG
 S ESPX="Agent Cashier              :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,21,"E")) D MSG
 S ESPX="Locker Areas               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,22,"E")) D MSG
 S ESPX="Office                     :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,23,"E")) D MSG
 S ESPX="Pharmacy                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,24,"E")) D MSG
 S ESPX="Vehicles                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,25,"E")) D MSG
 S ESPX="Burglary Total $ Loss      :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,26,"E")) D MSG
 S ESPX="Burglary Total $ Recovered :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,27,"E")) D MSG
 S ESPX=" " D MSG S ESPX="CONTRABAND       Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,28,"E")) D MSG
 S TOT=$G(^UTILITY("DIQ1",$J,912.41,DA,29,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,30,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,31,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,32,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,33,"E"))
 S ESPX=" " D MSG S ESPX="Drugs Total #                :  "_TOT D MSG
 S ESPX=" " D MSG S ESPX="Forged Prescriptions         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,29,"E")) D MSG
 S ESPX="Introduction                 :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,30,"E")) D MSG
 S ESPX="Possession                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,31,"E")) D MSG
 S ESPX="Sale                         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,32,"E")) D MSG
 S ESPX="Under the Influence          :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,33,"E")) D MSG
 S TOT=$G(^UTILITY("DIQ1",$J,912.41,DA,34,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,35,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,36,"E"))
 S ESPX=" " D MSG S ESPX="Alcohol Total #              :  "_TOT D MSG
 S ESPX=" " D MSG S ESPX="Introduction                 :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,34,"E")) D MSG
 S ESPX="Possession                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,35,"E")) D MSG
 S ESPX="Under the Influence          :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,36,"E")) D MSG
 D PRT^ESPUCM2
 QUIT
HDR ;PRINT HEADING
 S PAGE=PAGE+1 S ESPX=$E(SPACES,1,25)_"DEPARTMENT OF VETERANS AFFAIRS"_$E(SPACES,1,(IOM-65))_"PAGE:  "_$J(PAGE,3) D MSG
 S ESPX=$E(SPACES,1,35)_"VA POLICE" D MSG S ESPX=$E(SPACES,1,33)_"UNIFORM CRIME REPORT" D MSG
 S ESPX=" " D MSG S ESPX="VA Facility "_$P(^ESP(912.4,ESPIEN,1,1,0),U) D MSG
 QUIT
MSG S ^TMP($J,"UCM",ESPL)=ESPX,ESPL=ESPL+1
 QUIT
