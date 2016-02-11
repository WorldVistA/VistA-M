DG53890P ;ALB/DHS/DRP - CONTRIBUTE SPOUSE POST-INIT ;12/09/14
 ;;5.3;Registration;**890**;Aug 13, 1993;Build 40
 ;
 Q
 ;
RCMP ; -- re-compile all compiled input templates.
 N X,Y,DA,DMAX,DGERR,DGDUZSV,DGINTP
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 S DGDUZSV=DUZ(0),DUZ(0)="@"
 ;
 D BMES^XPDUTL("Compiling Input Templates....")
 ;
 F DGINTP="DGMT ENTER/EDIT DEPENDENTS","DGMT V1 ENTER/EDIT DEPENDENTS","DGMT ENTER/EDIT MARITAL STATUS" S Y=$O(^DIE("B",DGINTP,0)) S DGERR=0 D  I DGERR D BMES^XPDUTL("** "_DGINTP_" input template could not be updated")
 .I 'Y S DGERR=1 Q
 .S X=$P($G(^DIE(Y,"ROU")),U,2) I X="" S DGERR=1 Q
 .S DMAX=$$ROUSIZE^DILF D EN^DIEZ
 ;
 S DUZ(0)=DGDUZSV
 Q
