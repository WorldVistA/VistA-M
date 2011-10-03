ESPUCM6 ;DALISC/CKA -UNIFORM CRIME REPORT IN MAIL MESSAGE (CONT)- 4/93
 ;;1.0;POLICE & SECURITY;**13**;Mar 31, 1994
EN Q  ;CALLED FROM ESPUCM5
PRT ;PRINT REPORT CONTINUED- PRINTS 6TH PAGE
 D HDR
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,25)_"VIOLATION CHARGES                Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,171,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Courtesy Warnings  Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,172,"E")) D MSG
 S ESPX=" " D MSG S ESPX="Non-Traffic               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,173,"E"))  D MSG
 S ESPX="Moving                    :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,174,"E")) D MSG
 S ESPX="Parking                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,175,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,3)_"Offender" D MSG
 S ESPX=" " D MSG S ESPX="Employee: "_$G(^UTILITY("DIQ1",$J,912.41,DA,176,"E")) D MSG
 S ESPX="Outsider: "_$G(^UTILITY("DIQ1",$J,912.41,DA,177,"E")) D MSG
 S ESPX="Patient : "_$G(^UTILITY("DIQ1",$J,912.41,DA,178,"E")) D MSG
 S ESPX="Visitor : "_$G(^UTILITY("DIQ1",$J,912.41,DA,179,"E")) D MSG
 S ESPX=" " D MSG S ESPX="USDC Notice       Total # : "_$G(^UTILITY("DIQ1",$J,912.41,DA,180,"E")) D MSG
  S ESPX=" " D MSG S ESPX="Non-Traffic               :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,181,"E")) D MSG
 S ESPX="Moving                    :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,182,"E")) D MSG
 S ESPX="Parking                   :  "_$G(^UTILITY("DIQ1",$J,912.41,DA,183,"E")) D MSG
 S ESPX=" " D MSG S ESPX=$E(SPACES,1,3)_"Offender" D MSG
 S ESPX=" " D MSG S ESPX="Employee: "_$G(^UTILITY("DIQ1",$J,912.41,DA,184,"E")) D MSG
 S ESPX="Outsider: "_$G(^UTILITY("DIQ1",$J,912.41,DA,185,"E")) D MSG
 S ESPX="Patient : "_$G(^UTILITY("DIQ1",$J,912.41,DA,186,"E")) D MSG
 S ESPX="Visitor : "_$G(^UTILITY("DIQ1",$J,912.41,DA,187,"E")) D MSG
 W "..Done.",!!
 I ESPFLG D
 .W "The report will be forwarded to the national database.  You may now enter"
 .W !,"any additional people you would like to forward this report to.",!
SEND ;SEND MAIL MESSAGE
 S XMSUB="UNIFORM CRIME REPORT"
 S XMTEXT="^TMP($J,""UCM"","
 S XMDUN="Police & Security Package"
 D ^XMD
 I ESPFLG D VAPTX
 QUIT
HDR ;PRINT HEADING
 S PAGE=PAGE+1 S ESPX=$E(SPACES,1,25)_"DEPARTMENT OF VETERANS AFFAIRS"_$E(SPACES,1,(IOM-65))_"PAGE:  "_$J(PAGE,3) D MSG
 S ESPX=$E(SPACES,1,35)_"VA POLICE" D MSG S ESPX=$E(SPACES,1,33)_"UNIFORM CRIME REPORT" D MSG
 S ESPX=" " D MSG S ESPX="VA Facility "_$P(^ESP(912.4,ESPIEN,1,1,0),U) D MSG
 QUIT
MSG S ^TMP($J,"UCM",ESPL)=ESPX,ESPL=ESPL+1
 QUIT
 ;
VAPTX S XMY("XXX@Q-VAP.VA.GOV")=""
 D ENT1^XMD
 W !,"...Forwarded to National Database.",!
 Q
