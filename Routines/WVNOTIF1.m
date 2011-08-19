WVNOTIF1 ;HCIOFO/FT,JR IHS/ANMC/MWR - WV ADD/EDIT WV NOTIFICATIONS;
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  STUFFS A NORMAL LETTER FOR THIS PATIENT.  CALLED BY WVNOTIF.
 ;
 ;
NORMALL(WVDFN,WVACCN,WVSPEC,WVSPTX) ;EP
 ;---> STUFF A NORMAP PAP/MAM RESULT LETTER ENTRY IN WV NOTIF FILE.
 ;---> REQUIRED VARIABLES: WVDFN=IEN OF WV PATIENT (FILE 790),
 ;--->                     WVACCN=ACCESSION# FOR PROCEDURE.
 ;--->                     WVSPEC=1 FOR PAP, 3,4 OR 5 FOR MAM.
 ;--->                     WVSPTX=TEXT OF THE SPECIAL PROCEDURE.
 N WVPC,WVPURP,X
 ;
 I '$D(WVDFN)!('$D(WVACCN))!('$D(WVSPEC)) D  D NOLETT Q
 .W !!?5,"* Patient DFN or Accession# or Special Procedure Code "
 .W "undefined.",!,"  Contact Site Manager."
 ;
 I '$D(^WV(790.02,DUZ(2),0)) D  D NOLETT Q
 .W !!?5,"* Site Parameters for ",$$INSTTX^WVUTL6(DUZ(2))
 .W " have not been set."
 ;
 ;---> FIND PIECE OF ^WV(790.02, THAT IDENTIFIES PAP/MAM NORMAL LETTER.
 S WVPC=$S(WVSPEC=1:4,WVSPEC=2:8,1:0)
 S WVPURP=$P(^WV(790.02,DUZ(2),0),U,WVPC)
 I 'WVPURP D  D NOLETT Q
 .W !!?5,"* The Normal ",WVSPTX," Result Letter is not identified in"
 .W !?7,"the Site Parameter file.  Check the Site Parameter File."
 ;
 I '$O(^WV(790.404,WVPURP,1,0)) D  D NOLETT Q
 .W !!?5,"* In the Site Parameter file, the Normal ",WVSPTX
 .W " Result letter"
 .W !?7,"chosen has no letter text entered.  Check the Notification "
 .W !?7,"Purpose&Letter File."
 ;
 ;---> NOW STUFF A PAP/MAM RESULT NORMAL LETTER WITH ALL FIELDS ENTERED,
 ;---> QUEUED TO BE PRINTED TODAY.
 N DIC,Y
 S X=WVDFN
 K DD,DO S DIC="^WV(790.4,",DIC(0)="ML",DLAYGO=790
 S DIC("DR")=".02///T;.03///LETTER, FIRST;.04///"_WVPURP
 S DIC("DR")=DIC("DR")_";.05///"_WVSPTX_" NORMAL LETTER SENT;.06///"
 S DIC("DR")=DIC("DR")_WVACCN_";.07////"_DUZ(2)_";.08///T;.11///T"
 S DIC("DR")=DIC("DR")_";.13///T;.14///CLOSED"
 D FILE^DICN
 ;---> IF Y<0, CHECK PERMISSIONS.
 D:Y<0
 .W !!?5,"COULD NOT ADD NOTIFICATION, PERMISSION PROBLEM."
 .W !?5,"CONTACT YOUR SITE MANAGER."  D NOLETT
 Q
 ;
NOLETT ;EP
 W !?5,"* NO LETTER QUEUED!" D DIRZ^WVUTL3
 Q
