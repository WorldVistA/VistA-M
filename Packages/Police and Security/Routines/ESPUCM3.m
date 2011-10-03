ESPUCM3 ;DALISC/CKA -UNIFORM CRIME REPORT IN MAIL MESSAGE (CONT)- 4/93
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCM2
PRT ;PRINT REPORT CONTINUED- PRINTS 3RD PAGE
 D HDR
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,25)_"NON-CRIMINAL INVESTIGATIONS       Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,72,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Missing Patient Reaction   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,73,"E")) D MSG
 S ESPX="Government Veh. Accident   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,75,"E")) D MSG
 S ESPX="Personal Veh. Accident     :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,76,"E")) D MSG
 S ESPX="Assist Law Officer         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,77,"E")) D MSG
 S ESPX="Staff Assist               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,78,"E")) D MSG
 S ESPX="Alarm Response             :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,79,"E")) D MSG
 S ESPX="Safety Hazard              :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,80,"E")) D MSG
 S ESPX="Information Only           :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,188,"E")) D MSG
 S ESPX=$E(SPACES,1,25)_"OTHER OFFENSES                   Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,81,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Arson                         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,82,"E")) D MSG
 S ESPX="Arson $ Damage                :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,83,"E")) D MSG
 S ESPX="Possession of Stolen Property :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,84,"E")) D MSG
 S ESPX="Receive/Sell Stolen Property  :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,85,"E")) D MSG
 S ESPX="Suicide                       :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,86,"E")) D MSG
 S ESPX="Suicide Attempt               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,87,"E")) D MSG
 S ESPX=$E(SPACES,1,25)_"RAPES                            Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,88,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Attempted Rape                :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,89,"E")) D MSG
 S ESPX="Forcible Rape                 :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,90,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,3)_"Offender"_$E(SPACES,1,25)_"Victim" D MSG
 S ESPX=" " D MSG S ESPX="Employee: "_$G(^UTILITY("DIQ1",$J,912.41,DA,91,"E"))_$E(SPACES,1,20)_"Employee      : "_$G(^UTILITY("DIQ1",$J,912.41,DA,96,"E")) D MSG
 S ESPX="Outsider: "_$G(^UTILITY("DIQ1",$J,912.41,DA,92,"E"))_$E(SPACES,1,20)_"Outsider      : "_$G(^UTILITY("DIQ1",$J,912.41,DA,97,"E")) D MSG
 S ESPX="Patient : "_$G(^UTILITY("DIQ1",$J,912.41,DA,93,"E"))_$E(SPACES,1,20)_"Patient       : "_$G(^UTILITY("DIQ1",$J,912.41,DA,98,"E")) D MSG
 S ESPX="Unknown : "_$G(^UTILITY("DIQ1",$J,912.41,DA,94,"E"))_$E(SPACES,1,20)_"Visitor       : "_$G(^UTILITY("DIQ1",$J,912.41,DA,99,"E")) D MSG
 S ESPX="Visitor : "_$G(^UTILITY("DIQ1",$J,912.41,DA,95,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,25)_"ROBBERY                          Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,100,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Armed Robbery              :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,101,"E")) D MSG
 S ESPX=" " D MSG S ESPX="$100 & Above               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,102,"E")) D MSG
 S ESPX="<$100                      :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,103,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Strong Armed Robbery       :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,104,"E")) D MSG
 S ESPX=" " D MSG S ESPX="$100 & Above               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,105,"E")) D MSG
 S ESPX="<$100                      :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,106,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Drugs Only                 :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,107,"E")) D MSG
 S ESPX=" " D MSG S ESPX="$100 & Above               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,108,"E")) D MSG
 S ESPX="<$100                      :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,109,"E")) D MSG
 D PRT^ESPUCM4
 QUIT
HDR ;PRINT HEADING
 S PAGE=PAGE+1 S ESPX=$E(SPACES,1,25)_"DEPARTMENT OF VETERANS AFFAIRS"_$E(SPACES,1,(IOM-65))_"PAGE:  "_$J(PAGE,3) D MSG
 S ESPX=$E(SPACES,1,35)_"VA POLICE" D MSG S ESPX=$E(SPACES,1,33)_"UNIFORM CRIME REPORT" D MSG
 S ESPX=" " D MSG S ESPX="VA Facility "_$P(^ESP(912.4,ESPIEN,1,1,0),U) D MSG
 QUIT
MSG S ^TMP($J,"UCM",ESPL)=ESPX,ESPL=ESPL+1
 QUIT
