VIAA01P1 ;ALB/CR - PATCH 1 POST INSTALL ;4/21/16 11:28 am
 ;;1.0;RTLS;**1**;April 22, 2013;Build 44
 ;
 Q
 ; Reference to ^VA(200 supported by ICR #10060
 ; application proxy creation supported by ICR #4677
 ;
PRE ; checks for the connector proxy that the site created with the option
 ; 'Enter/Edit Connector Proxy User' under the 'Foundations Management' menu
 ; of Vistalink
 N X,NAME,NAME1
 S NAME="VIAASERVICE,RTLS CONNECTOR PROXY"
 S NAME1=$E(NAME,1,30) ; B x-ref keeps 30 chars only
 S X=$$FIND1^DIC(200,,"M",NAME1)
 D BMES^XPDUTL("PRE-INIT CHECKS: looking for the '"_NAME_"' user...")
 I 'X D BMES^XPDUTL("...User '"_NAME_"' not found. Please create it soon.") Q
 ;
 I X>0 D
 . D BMES^XPDUTL("...'"_NAME_"' already exists...")
 . D BMES^XPDUTL("...checking required fields...")
 . I $P($G(^VA(200,X,0)),U,3)'=""&($P($G(^VA(200,X,.1)),U,2)'="") D BMES^XPDUTL("...Access/verify codes appear to be in place...")
 . I '$D(^VA(200,X,203,1,0))&('$D(^VA(200,X,201))) D BMES^XPDUTL("...No illegal primary/secondary menus found...")
 . I $D(^VA(200,X,203,1,0))!($D(^VA(200,X,201))) D BMES^XPDUTL("...Illegal menu options found...")
 . I $P($G(^VA(200,X,"USC3",1,0)),U,1,2)["5^1" D BMES^XPDUTL("...User Class looks fine...")
 . I $P($G(^VA(200,X,"USC3",1,0)),U,1,2)'["5^1" D BMES^XPDUTL("...Wrong User Class...")
 . I $P($G(^VA(200,X,200)),U,4)=1 D BMES^XPDUTL("...Multiple sign-on is allowed...")
 . I $P($G(^VA(200,X,200)),U,4)'=1 D BMES^XPDUTL("...Multiple sign-on is not allowed...")
 . D BMES^XPDUTL("PRE-INIT CHECKS FINISHED.")
 ;
 E  D BMES^XPDUTL("...No connector proxy user found - it needs to be created manually.")
 Q
 ;
POST ; create an application proxy for the RTLS RPC menu option
 ; and attach it as a secondary menu
 N USER,USER1,USERIEN,OPT,OPTNAME,R
 S USER="VIAASERVICE,RTLS APPLICATION PROXY"
 S USER1=$E(USER,1,30) ; B x-ref keeps only 30 chars
 S OPTNAME="VIAA01 RTLS RPC MENU"
 S USERIEN=$$FIND1^DIC(200,,"M",USER1) ; get user's IEN
 D BMES^XPDUTL("")
 D BMES^XPDUTL("POST-INIT CHECKS: looking for the '"_USER_"' user...")
 ;
 I USERIEN>0 D  Q
 . D BMES^XPDUTL("...'"_USER_"' already exists...")
 . D BMES^XPDUTL("...checking required fields...")
 . S OPT=$$FIND1^DIC(19,,"M",OPTNAME) I 'OPT D BMES^XPDUTL("...'"_OPTNAME_"' not found...") Q
 . I $P($G(^VA(200,USERIEN,0)),U,3)=""&('$D(^VA(200,USERIEN,.1))) D BMES^XPDUTL("...No illegal access/verify codes found...")
 . I $P($G(^VA(200,USERIEN,0)),U,3)'=""&($D(^VA(200,USERIEN,.1))) D BMES^XPDUTL("...Illegal access/verify codes found...")
 . I $P($G(^VA(200,USERIEN,203,1,0)),U)=OPT D BMES^XPDUTL("...Secondary menu looks fine...")
 . I $P($G(^VA(200,USERIEN,203,1,0)),U)'=OPT D BMES^XPDUTL("...Missing '"_OPTNAME_"'...")
 . I $P($G(^VA(200,USERIEN,"USC3",1,0)),U,1,2)["1^1" D BMES^XPDUTL("...User Class looks fine...")
 . I $P($G(^VA(200,USERIEN,"USC3",1,0)),U,1,2)'["1^1" D BMES^XPDUTL("...Wrong User Class found. Checks finished...")
 . D BMES^XPDUTL("POST-INIT CHECKS FINISHED.")
 ;
 E  D BMES^XPDUTL("POST-INIT INSTALL: No application proxy user found - creating one...stand by...")
 ; set up the application proxy then
 S R=$$CREATE^XUSAP(USER,"",OPTNAME)
 D BMES^XPDUTL("...'"_USER_"'"_$S(R=-1:" creation failed",R=0:" already exists.",1:" user added."))
 D BMES^XPDUTL("POST-INIT INSTALL FINISHED.")
 Q
