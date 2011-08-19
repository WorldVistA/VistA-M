WVSITE ;HCIOFO/FT,JR-EDIT SITE PARAMETERS; ;2/12/04  14:17
 ;;1.0;WOMEN'S HEALTH;**16**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLED BY OPTION: "WV EDIT SITE PARAMETERS".
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
 ; The following entry point(s) are documented by IAs:
 ; GETPARAM  -  4101   (private)
 ;
 D EDIT
 ;
EXIT ;EP
 W @IOF
 D KILLALL^WVUTL8
 Q
 ;
EDIT ;EP
 D SETVARS^WVUTL5
 N A,B
 D TITLE^WVUTL5("EDIT SITE PARAMETERS") W !
 S A="   Select SITE/FACILITY: ",B=""
 S:$D(DUZ(2)) B=$$INSTTX^WVUTL6(DUZ(2))
 D DIC^WVFMAN(790.02,"QEMAL",.Y,A,B)
 Q:Y<0
 S $P(^WV(790.02,+Y,0),U,15)="v" ;set AGENCY (.15) for VA
 ;---> EDIT WITH SCREENMAN.
 D DDS^WVFMAN(790.02,"[WV SITE PARAMS-FORM-1]",+Y)
 Q
 ;
REF ;EP
 ; WV ADD/EDIT REFERRAL SOURCE option
 N DIC,DIE
 D TITLE^WVUTL5("ADD/EDIT REFERRAL SOURCES") W !
N S DLAYGO=790.07,DIC="^WV(790.07,",DIC("A")="Referral Source Name: "
 S DIC(0)="AELMNQZ" D ^DIC I Y'>0 K DA,DR,DLAYGO,WVJDA Q
 S DIE=DIC,DR=".01:1",(WVJDA,DA)=+Y
 L +^WV(790.07,WVJDA):0 I $T D ^DIE L -^WV(790.07,WVJDA) K DIE,DA,DR,DIC,DLAYGO W ! G N
 W !!?5,"Another user is editing this entry.",!! G N
 Q
 ;
GETPARAM(RESULT,FIEN) ; Return WH site parameters for the facility indicated.
 ;  Input: RESULT - Array name to return data in. Passed by reference
 ;                  (Required)
 ;           FIEN - FILE 4 IEN (Required)
 ; Output: RESULT(0)=1st piece is 1 (for Success) or -1 (for Failure)
 ;                   2nd piece is the reason for failure
 ;         RESULT(1)=1st piece is 1 (for Yes) or 0 (for No) to
 ;                                UPDATE RESULTS/DX 
 ;                   2nd piece is 1 (for Yes) or 0 (for No) to
 ;                                UPDATE TREATMENT NEEDS
 N WVNODE
 I '$G(FIEN) S RESULT(0)="-1^Facility IEN is not greater than zero." Q
 S WVNODE=$G(^WV(790.02,FIEN,0))
 I WVNODE="" D  Q
 .S RESULT(0)="-1^No parameters in the Women's Health package for this facility."
 .Q
 S RESULT(0)="1^"
 S RESULT(1)=$P(WVNODE,U,11)_U_$P(WVNODE,U,12)
 S:$P(RESULT(1),U,1)="" $P(RESULT(1),U,1)=0
 S:$P(RESULT(1),U,2)="" $P(RESULT(1),U,2)=0
 Q
SNOMED ; [WV PAP SMEAR SNOMED CODES] option entry point
 ; This option is used to associate SNOMED codes with the PAP SMEAR
 ; entry in FILE 790.2.
 N DA,DIC,DTOUT,DUOUT,WVDA,X,Y
 S WVDA=$O(^WV(790.2,"B","PAP SMEAR",0))
 Q:'WVDA
 F  D  Q:(Y'>0)!($D(DTOUT))!($D(DUOUT))
 .S DIC(0)="AELMQZ",DA(1)=WVDA,DLAYGO=790.2
 .S DIC("A")="Select a MORPHOLOGY SNOMED CODE: "
 .S DIC="^WV(790.2,DA(1),1,"
 .D ^DIC
 .Q:+Y'>0
 .S DIE=DIC K DIC
 .S DA=+Y
 .S DR=".01;1"
 .D ^DIE
 .K DA,DIE,DR
 .S:'+$G(Y) Y=.5
 .Q
 I $D(DTOUT)!($D(DUOUT)) Q
 ;
 K DA,DIC,DIE,DR,X,Y
 F  D  Q:(Y'>0)!($D(DTOUT))!($D(DUOUT))
 .S DIC(0)="AELMQZ",DA(1)=WVDA,DLAYGO=790.2
 .S DIC("A")="Select a TOPOGRAPHY SNOMED CODE: "
 .S DIC="^WV(790.2,DA(1),2,"
 .D ^DIC
 .Q:+Y'>0
 .S DIE=DIC K DIC
 .S DA=+Y
 .S DR=".01"
 .D ^DIE
 .K DA,DIE,DR
 .S:'+$G(Y) Y=.5
 .Q
 Q
