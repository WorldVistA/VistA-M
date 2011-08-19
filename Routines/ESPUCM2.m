ESPUCM2 ;DALISC/CKA -UNIFORM CRIME REPORT IN MAIL MESSAGE (CONT)- 3/93
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCM1
PRT ;PRINT REPORT CONTINUED- PRINTS 2ND PAGE
 D HDR
 S TOT=$G(^UTILITY("DIQ1",$J,912.41,DA,37,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,38,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,39,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,40,"E"))
 S ESPX=" " D MSG S ESPX="Weapons Total #              :  "_TOT D MSG
 S ESPX=" " D MSG S ESPX="Firearms                     :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,37,"E")) D MSG
 S ESPX="Knives/Hatchets/Clubs        :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,38,"E")) D MSG
 S ESPX="Explosives                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,39,"E")) D MSG
 S ESPX="Other                        :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,40,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,3)_"Offender" D MSG
 S ESPX=" " D MSG S ESPX="Employee: "_$G(^UTILITY("DIQ1",$J,912.41,DA,41,"E")) D MSG
 S ESPX="Outsider: "_$G(^UTILITY("DIQ1",$J,912.41,DA,42,"E")) D MSG
 S ESPX="Patient : "_$G(^UTILITY("DIQ1",$J,912.41,DA,43,"E")) D MSG
 S ESPX="Unknown : "_$G(^UTILITY("DIQ1",$J,912.41,DA,44,"E")) D MSG
 S ESPX="Visitor : "_$G(^UTILITY("DIQ1",$J,912.41,DA,45,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,25)_"DISTURBANCES       Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,46,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Bomb Threats               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,47,"E")) D MSG
 S ESPX="Demonstrations             :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,48,"E")) D MSG
 S ESPX="Disorderly Conduct         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,49,"E")) D MSG
 S ESPX="Employee Threat            :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,50,"E")) D MSG
 S ESPX="Other Threat               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,51,"E")) D MSG
 S ESPX="Smoking Violation          :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,52,"E")) D MSG
 S ESPX="Trespassing                :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,53,"E")) D MSG
 S ESPX="Unauthorized Photograph    :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,54,"E")) D MSG
 S ESPX="Unauth/Poss/Use/Keys/Cards :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,55,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,3)_"Offender" D MSG
 S ESPX=" " D MSG S ESPX="Employee: "_$G(^UTILITY("DIQ1",$J,912.41,DA,56,"E")) D MSG
 S ESPX="Outsider: "_$G(^UTILITY("DIQ1",$J,912.41,DA,57,"E")) D MSG
 S ESPX="Patient : "_$G(^UTILITY("DIQ1",$J,912.41,DA,58,"E")) D MSG
 S ESPX="Unknown : "_$G(^UTILITY("DIQ1",$J,912.41,DA,59,"E")) D MSG
 S ESPX="Visitor : "_$G(^UTILITY("DIQ1",$J,912.41,DA,60,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,25)_"MANSLAUGHTER/MURDER       Total # : "_($G(^UTILITY("DIQ1",$J,912.41,DA,61,"E"))+$G(^UTILITY("DIQ1",$J,912.41,DA,62,"E"))) D MSG
 S ESPX=" " D MSG S ESPX="Manslaughter/Murder/Negligent         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,61,"E")) D MSG
 S ESPX="Manslaughter/Murder/Non-Neg.          :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,62,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,3)_"Offender"_$E(SPACES,1,20)_"Victim" D MSG
 S ESPX=" " D MSG S ESPX="Employee: "_$G(^UTILITY("DIQ1",$J,912.41,DA,63,"E"))_$E(SPACES,1,20)_"Employee      : "_$G(^UTILITY("DIQ1",$J,912.41,DA,68,"E")) D MSG
 S ESPX="Outsider: "_$G(^UTILITY("DIQ1",$J,912.41,DA,64,"E"))_$E(SPACES,1,20)_"Outsider      : "_$G(^UTILITY("DIQ1",$J,912.41,DA,69,"E")) D MSG
 S ESPX="Patient : "_$G(^UTILITY("DIQ1",$J,912.41,DA,65,"E"))_$E(SPACES,1,20)_"Patient       : "_$G(^UTILITY("DIQ1",$J,912.41,DA,70,"E")) D MSG
 S ESPX="Unknown : "_$G(^UTILITY("DIQ1",$J,912.41,DA,66,"E"))_$E(SPACES,1,20)_"Visitor       : "_$G(^UTILITY("DIQ1",$J,912.41,DA,71,"E")) D MSG
 S ESPX="Visitor : "_$G(^UTILITY("DIQ1",$J,912.41,DA,67,"E")) D MSG
 D PRT^ESPUCM3
 QUIT
HDR ;PRINT HEADING
 S PAGE=PAGE+1 S ESPX=$E(SPACES,1,25)_"DEPARTMENT OF VETERANS AFFAIRS"_$E(SPACES,1,(IOM-65))_"PAGE:  "_$J(PAGE,3) D MSG
 S ESPX=$E(SPACES,1,35)_"VA POLICE" D MSG S ESPX=$E(SPACES,1,33)_"UNIFORM CRIME REPORT" D MSG
 S ESPX=" " D MSG S ESPX="VA Facility "_$P(^ESP(912.4,ESPIEN,1,1,0),U) D MSG
 QUIT
MSG S ^TMP($J,"UCM",ESPL)=ESPX,ESPL=ESPL+1
 QUIT
