SDOQMPEN ;ALB/SCK - Environment checked for the PM Extract ; 08/02/96
 ;;5.3;Scheduling;**47**;AUG 13, 1993
 ;
EN ;  Entry point
 W !!,">>> Beginning the environment check",!!
 D CHKDUZ
 W !!,">>> Environment check completed.",!!
 Q
 ;
CHKDUZ ;
 N X
 ;
 W !!,"Checking for valid user..."
 ; 
 I +$G(DUZ)'>0 D  Q
 . S XPDABORT=1
 . W !!,"   User's DUZ is not defined, Please ensure you are logged on"
 . W !,"   correctly, and try again."
 ;
 S X=$O(^VA(200,+$G(DUZ),0))
 I X']""!($G(DUZ(0))'="@") D  Q
 . W !!,"  Installation requires that your DUZ be defined as an active user"
 . W !,"  and that your DUZ(0) be set for programmer access."
 . S XPDABORT=1
 Q
