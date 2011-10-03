WVPATE ;HCIOFO/FT,JR-PATIENT CASE DATA EDIT; ;4/3/01  13:13
 ;;1.0;WOMEN'S HEALTH;**3,13,14**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLED BY OPTION: "WV EDIT PATIENT CASE DATA".
 ;
 ; This routine uses the following IAs:
 ; #1625 - $$GET^XUA4A72      (supported)
 ;
 D SETVARS^WVUTL5
 F  D PATIENT Q:WVPOP
 ;
EXIT ;EP
 D KILLALL^WVUTL8
 Q
 ;
 ;
PATIENT ;EP
 D TITLE^WVUTL5("EDIT PATIENT CASE DATA")
PATIENT1 ;EP
 ;---> TO AVOID @IOF AND TITLE.
 ;---> SELECT PATIENT.
 ; Quit if no default case manager
 I '$$DCM^WVUTL9(DUZ(2)) D NODCM^WVUTL9 S WVPOP=1 Q
 N Y
 W !!,"   Select the patient you wish to add or edit."
 D PATLKUP^WVUTL8(.Y,"ADD")
 I Y<0 S WVPOP=1 Q
 S WVDFN=+Y
 D SCREEN(WVDFN) S WVPOP=0
 Q
 ;
 ;
SCREEN(WVDFN) ;EP
 ;---> EDIT PATIENT CASE DATA WITH SCREENMAN.
 ;---> REQUIRED VARIABLES: WVDFN=DFN OF PATIENT.
 I '$P($G(^WV(790,WVDFN,0)),U,10) D STUFF
 N DR
 S DR="[WV PATIENT-FORM-1]"
 D DDS^WVFMAN(790,DR,WVDFN,"","",.WVPOP)
 N DIR W !,"Do you wish to PRINT this patient's Case Data?"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR W !
 D:Y PRTCASE^WVPATP(WVDFN)
 Q
 ;
CASEDATA(WVDFN) ;EP
 ;---> CALLED AFTER ADD/EDIT OF NOTIFICATIONS.
 N DIR W !,"Do you wish to EDIT this patient's Case Data?"
 S DIR("?",1)="   Enter YES to edit this patient's Case Manager, "
 S DIR("?")="   PAP Regimen, Current Need, etc."
 S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR W !
 D:Y SCREEN(WVDFN)
 Q
 ;
AUTOADD(DFN,SITE,Y,WVPRMT) ;EP
 ;---> AUTOMATIC ADD OF A NEW PATIENT TO "WV PATIENT FILE".
 ;---> SET CASEMANAGER TO SITE PARAMETER DEFAULT.
 ;---> SET PAP TX NEED (#.11), PAP REGIMEN (#.16)="Undetermined",
 ;---> MAM TX NEED (#.18)="Undetermined".
 ;---> PARAMETERS:
 ;     1 - DFN     (REQUIRED) IEN OF PATIENT IN ^DPT(
 ;     2 - SITE    (REQUIRED) DUZ(2) FOR DEFAULT CASE MANAGER
 ;     3 - Y       (RETURNED) FROM ^DICN: IEN OR -1 FAILURE TO ADD PT
 ;     4 - WVPRMT  (OPTIONAL) EQUALS 1 IF PROMPT WHEN FAILURE
 ;
 ;---> SET CASE MANAGER DEFAULT.
 N WVCMGR,DIC S WVCMGR=$S($D(SITE):$P(^WV(790.02,SITE,0),U,2),1:"")
 S:'$G(WVPRMT) WVPRMT=0
 S DIC("DR")=".1////"_WVCMGR_";.11///Undetermined;.16///Undetermined"
 S DIC("DR")=DIC("DR")_";.18///Undetermined"
 S DIC("DR")=DIC("DR")_";.21////"_DT
 S (DINUM,X)=DFN
 K DD,DO S DIC="^WV(790,",DIC(0)="ML",DLAYGO=790
 D FILE^DICN K DIC
 ;---> IF Y<0, CHECK PERMISSIONS.
 I Y<0,WVPRMT D  Q
 .W !!?5,"* UNABLE to add this patient to the Women's Health database."
 .W !?5,"  Please contact your site manager to check permissions."
 .D DIRZ^WVUTL3
 S Y=+Y
 Q
 ;
STUFF ; Stuff case manager if none
 Q:'+$G(WVDFN)
 Q:'+$G(DUZ(2))
 S $P(^WV(790,WVDFN,0),U,10)=$P($G(^WV(790.02,DUZ(2),0)),U,2)
 Q
