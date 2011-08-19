ESPUCM5 ;DALISC/CKA -UNIFORM CRIME REPORT IN MAIL MESSAGE (CONT)- 4/93
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCM4
PRT ;PRINT REPORT CONTINUED- PRINTS 5TH PAGE
 D HDR
 S ESPX=" " D MSG S ESPX="Motor Vehicles                 :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,142,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Government Motor Vehicle       :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,143,"E")) D MSG
 S ESPX="$ Loss                         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,144,"E")) D MSG
 S ESPX="$ Recovered                    :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,145,"E")) D MSG
 S ESPX="Gov't Vehicles Recovered       :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,146,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Private Motor Vehicle          :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,147,"E")) D MSG
 S ESPX="$ Loss                         :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,148,"E")) D MSG
 S ESPX="$ Recovered                    :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,149,"E")) D MSG
 S ESPX="Private Veh's Recovered        :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,150,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,25)_"VANDALISM" D MSG
 S ESPX="Total #                     :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,152,"E")) D MSG
 S ESPX="Total $                     :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,158,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,3)_"Offender" D MSG
 S ESPX=" " D MSG S ESPX="Employee: "_$G(^UTILITY("DIQ1",$J,912.41,DA,153,"E")) D MSG
 S ESPX="Outsider: "_$G(^UTILITY("DIQ1",$J,912.41,DA,154,"E")) D MSG
 S ESPX="Patient : "_$G(^UTILITY("DIQ1",$J,912.41,DA,155,"E")) D MSG
 S ESPX="Unknown : "_$G(^UTILITY("DIQ1",$J,912.41,DA,156,"E")) D MSG
 S ESPX="Visitor : "_$G(^UTILITY("DIQ1",$J,912.41,DA,157,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,25)_"VICE SOLICITING              Total # :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,159,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Bribery                    : "_$G(^UTILITY("DIQ1",$J,912.41,DA,160,"E")) D MSG
 S ESPX="Forgery                    : "_$G(^UTILITY("DIQ1",$J,912.41,DA,161,"E")) D MSG
 S ESPX="Fraud                      : "_$G(^UTILITY("DIQ1",$J,912.41,DA,162,"E")) D MSG
 S ESPX="Gambling                   : "_$G(^UTILITY("DIQ1",$J,912.41,DA,163,"E")) D MSG
 S ESPX="Solicitation/Prostitution  : "_$G(^UTILITY("DIQ1",$J,912.41,DA,164,"E")) D MSG
 S ESPX="Sexual Misconduct          : "_$G(^UTILITY("DIQ1",$J,912.41,DA,165,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,3)_"Offender" D MSG
 S ESPX=" " D MSG S ESPX="Employee: "_$G(^UTILITY("DIQ1",$J,912.41,DA,166,"E")) D MSG
 S ESPX="Outsider: "_$G(^UTILITY("DIQ1",$J,912.41,DA,167,"E")) D MSG
 S ESPX="Patient : "_$G(^UTILITY("DIQ1",$J,912.41,DA,168,"E")) D MSG
 S ESPX="Unknown : "_$G(^UTILITY("DIQ1",$J,912.41,DA,169,"E")) D MSG
 S ESPX="Visitor : "_$G(^UTILITY("DIQ1",$J,912.41,DA,170,"E")) D MSG
 D PRT^ESPUCM6
 QUIT
HDR ;PRINT HEADING
 S PAGE=PAGE+1 S ESPX=$E(SPACES,1,25)_"DEPARTMENT OF VETERANS AFFAIRS"_$E(SPACES,1,(IOM-65))_"PAGE:  "_$J(PAGE,3) D MSG
 S ESPX=$E(SPACES,1,35)_"VA POLICE" D MSG S ESPX=$E(SPACES,1,33)_"UNIFORM CRIME REPORT" D MSG
 S ESPX=" " D MSG S ESPX="VA Facility "_$P(^ESP(912.4,ESPIEN,1,1,0),U) D MSG
 QUIT
MSG S ^TMP($J,"UCM",ESPL)=ESPX,ESPL=ESPL+1
 QUIT
