ESPUCM4 ;DALISC/CKA -UNIFORM CRIME REPORT IN MAIL MESSAGE (CONT)- 4/93
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCM3
PRT ;PRINT REPORT CONTINUED- PRINTS 4TH PAGE
 D HDR
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,15)_"STOPS & ARRESTS                  Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,110,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Physical Arrests           :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,111,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,3)_"Offender" D MSG
 S ESPX=" " D MSG S ESPX="Employee: "_$G(^UTILITY("DIQ1",$J,912.41,DA,112,"E")) D MSG
 S ESPX="Outsider: "_$G(^UTILITY("DIQ1",$J,912.41,DA,113,"E")) D MSG
 S ESPX="Patient : "_$G(^UTILITY("DIQ1",$J,912.41,DA,114,"E")) D MSG
 S ESPX="Visitor : "_$G(^UTILITY("DIQ1",$J,912.41,DA,115,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Stops for Questioning         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,116,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Package Stops                 :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,117,"E")) D MSG
 S ESPX="Non-Package Stops             :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,118,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,25)_"THEFTS                           Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,119,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Coin-Operated Machines         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,120,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Total $ Loss                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,121,"E")) D MSG
 S ESPX="Total $ Recovery               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,122,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Actual Drug Thefts             :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,123,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Controlled Substance           :  "_$G(^UTILITY("DIQ1",$J,912.41,125,DA,125,"E")) D MSG
 S ESPX="Non-Controlled Substance       :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,126,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Attempted Drug Thefts          :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,124,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Controlled Substance           :  "_$G(^UTILITY("DIQ1",$J,912.41,125,DA,127,"E")) D MSG
 S ESPX="Non-Controlled Substance       :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,128,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Total Drug Thefts              :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,129,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Total $ Loss                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,130,"E")) D MSG
 S ESPX="Total $ Recovered              :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,131,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Government Property            :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,132,"E")) D MSG
 S ESPX=" " D MSG S ESPX="$100 & Above                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,133,"E")) D MSG
 S ESPX="< $100                         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,134,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Total $ Loss                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,135,"E")) D MSG
 S ESPX="Total $ Recovered              :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,136,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Personal Property              :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,137,"E")) D MSG
 S ESPX=" " D MSG S ESPX="$100 & Above                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,138,"E")) D MSG
 S ESPX="< $100                         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,139,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Total $ Loss                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,140,"E")) D MSG
 S ESPX="Total $ Recovered              :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,141,"E")) D MSG
 D PRT^ESPUCM5
 QUIT
HDR ;PRINT HEADING
 S PAGE=PAGE+1 S ESPX=$E(SPACES,1,25)_"DEPARTMENT OF VETERANS AFFAIRS"_$E(SPACES,1,(IOM-65))_"PAGE:  "_$J(PAGE,3) D MSG
 S ESPX=$E(SPACES,1,35)_"VA POLICE" D MSG S ESPX=$E(SPACES,1,33)_"UNIFORM CRIME REPORT" D MSG
 S ESPX=" " D MSG S ESPX="VA Facility "_$P(^ESP(912.4,ESPIEN,1,1,0),U) D MSG
 QUIT
MSG S ^TMP($J,"UCM",ESPL)=ESPX,ESPL=ESPL+1
 QUIT
