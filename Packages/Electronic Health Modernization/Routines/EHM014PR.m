EHM014PR ;ALB/WTC - EHRM TRANSITION ; Jan 23, 2024@13:44:25
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**14**;Apr 19, 2021;Build 6
 ;
 ;  Pre-install routine for EHM*1*14.
 ;
 ;  DEL^XPDKEY - ICR #1367
 ;
 Q  ;
 ;
ENTRY ;
 ;
 ;  Purge options and keys if installing the patch a second time.
 ;
 I '$D(^DIC(19,"B","EHM-00001")) Q  ;
 ;
 D BMES^XPDUTL("Patch has already been installed at this site.  Clearing existing options and keys.") ;
 ;
 ;  Delete options created by 1st install.
 ;
 N EHMOPTN ;
 S EHMOPTN="EHM-A" F  S EHMOPTN=$O(^DIC(19,"B",EHMOPTN),-1) Q:EHMOPTN'?1"EHM-"5N  D DELTOPTN(EHMOPTN) ;
 D DELTOPTN("EHM MAIN MENU") ;
 ;
 D DEL^XPDKEY("EHM MGR"),DEL^XPDKEY("EHM HITT MENU") ;
 ;
 D BMES^XPDUTL("Pre-install complete.")
 Q  ;
 ;
DELTOPTN(OPTNAME) ;
 ;
 N DIC,X,IEN,Y,DIK,DA ;
 ;
 K DIC S DIC=19,DIC(0)="",X=OPTNAME D ^DIC S IEN=+Y Q:IEN<0  ;
 S DIK="^DIC(19,",DA=IEN D ^DIK ;
 Q  ;
 ;
