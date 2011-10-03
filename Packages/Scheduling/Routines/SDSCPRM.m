SDSCPRM ;ALB/JAM/RBS - ASCD Site Parameter Edit ; 1/19/07 12:43pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ;**Program Description**
 ;   This program allows the supervisor to modify the number of days
 ;   to check for 'checked out' encounters that need to evaluate the 
 ;   Service Connected flag.
 Q
EN ;  Entry point
 N SITE,SDTYPE,DIC,PARAM
 S SITE=+$$SITE^VASITE() Q:'SITE
 S PARAM=$O(^XTV(8989.51,"B","SDSC SITE PARAMETER",0)) Q:'PARAM
 D EDIT^XPAREDIT(SITE_";DIC(4,",PARAM_"^SDSC SITE PARAMETER")
 Q
