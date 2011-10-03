PSSEC123 ;JD-Environment check routine for PSS*1*123 ; 6/6/07 2:27pm
 ;;1.0;PHARMACY DATA MANAGEMENT;**123**;9/30/97;Build 6
 ;Reference to $$PATCH^XPDUTL(X) supported by DBIA #10141
 ;Reference to ^XMB("NETNAME") supported by DBIA #1131  
 N PSSFL1,PSSFL2,PSSSTR
 S PSSFL1="",PSSFL2="",PSSSTR="",$P(PSSSTR,"*",77)=""
 I ^XMB("NETNAME")?1"CMOP-".E W !!,?10,"Consolidated Mail Outpatient Pharmacy Install.",!! Q
 ; Not a CMOP site.  Check for required patches.
 ; Required patches are PSJ*5.0*134 and OR*3.0*243
 I '$$PATCH^XPDUTL("PSJ*5.0*134") S PSSFL1=1 ; Required patch
 I '$$PATCH^XPDUTL("OR*3.0*243") S PSSFL2=1 ; Required patch
 I PSSFL1=1!(PSSFL2=1) D 
 . ; Logic to notify the IRM
 . W !!,?2,PSSSTR
 . W !,?2,"*",?34,"WARNING",?77,"*",!,?2,"*",?77,"*"
 . I PSSFL1=1 W !,?2,"*",?14,"Required patch PSJ*5.0*134 is not installed.",?77,"*"
 . I PSSFL2=1 W !,?2,"*",?14,"Required patch OR*3.0*243 is not installed.",?77,"*",!,?2,"*",?77,"*"
 . W !,?2,"*",?10,"Please install the above mentioned required patch(es).",?77,"*"
 . W !,?2,"*Once the required patch(es) are installed, you can reinstall",?77,"*"
 . W !,?2,"*patch PSS*1.0*123.",?77,"*"
 . W !,?2,PSSSTR
 . S XPDQUIT=1 ; This will cause the install to quit and delete the transport global.
 Q
