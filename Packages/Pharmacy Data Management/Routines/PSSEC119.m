PSSEC119 ;RJS-Environment check routine for PSS*1*119 ; 05/30/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**119**;9/30/97;Build 9
 N PSSFL1,PSSFL2
 S PSSFL1="",PSSFL2=""
 I $O(^PSX(550,"C",0))!(^XMB("NETNAME")?1"CMOP-".E) W !!,?10,"Consolidated Mail Outpatient Pharmacy Install.",!! S XPDQUIT=1 Q
 ; Not a CMOP site.  Check for required patches.
 ; Required patches are PSJ*5.0*194 and PSO*7.0*282
 I '$$PATCH^XPDUTL("PSJ*5.0*194") S PSSFL1=1 ; Required patch
 I '$$PATCH^XPDUTL("PSO*7.0*282") S PSSFL2=1 ; Required patch
 I PSSFL1=1!(PSSFL2=1) D
 . ; Logic to notify the IRM
 .W !!,"****************************************************************************"
 .W !,"*",?34,"WARNING",?75,"*",!,"*",?75,"*"
 .I PSSFL1=1 W !,"*",?14,"Required patch PSJ*5.0*194 is not installed.",?75,"*"
 .I PSSFL2=1 W !,"*",?14,"Required patch PSO*7.0*282 is not installed.",?75,"*",!,"*",?75,"*"
 .W !,"*",?10,"Please install the above mentioned required patch(es).",?75,"*"
 .W !,"*Once the required patch(es) are installed, you can reinstall(PSS*1.0*119).*"
 .W !,"****************************************************************************"
 .S XPDQUIT=1 ; This will cause the install to quit and delete the transport global.
 Q
