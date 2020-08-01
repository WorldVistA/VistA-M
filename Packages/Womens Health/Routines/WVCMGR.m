WVCMGR ;HCIOFO/FT,JR - ADD/EDIT CASE MANAGER ;07/22/2016  14:35
 ;;1.0;WOMEN'S HEALTH;**24**;Sep 30, 1998;Build 582
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLED BY OPTION: "WV ADD/EDIT CASE MANAGERS" TO ADD AND EDIT
 ;;  CASE MANAGERS.
 ;
 ;---> DIE ADD/EDIT CASE MANAGERS LOOP.
 D SETVARS^WVUTL5
 N Y,WVDD,WVPER
 D SETVARS
 Q:'$G(WVDD)
 F  D  Q:$G(Y)<0
 .D TITLE^WVUTL5("ADD/EDIT "_$P(WVPER,U))
 .S WVDICW="S WVY=Y N Y S Y=$P($G(^WV("_$P(WVDD,U)_",+WVY,0)),U,2) D DD^%DT W:$L(Y)>10 ?32,""DATE INACTIVATED:  "",Y"
 .D DIC^WVFMAN($P(WVDD,U),"QEMAL",.Y,"   Select "_$P(WVPER,U,2)_": ","","","","",WVDICW)
 .K WVDICW Q:Y<0
 .D DIE^WVFMAN($P(WVDD,U),$P(WVDD,U,2),+Y,.WVPOP)
 .S:WVPOP Y=-1
 ;
EXIT ;EP
 D KILLALL^WVUTL8
 Q
 ;
SETVARS ;INITIALIZE VARIABLES USED IN THIS ROUTINE
 ;WVDD=PERSON FILE #^INACTIVATION DATE FIELD #^FILE 790 INDEX^FILE 790 FIELD
 I $G(WVTYPE)="CM" S WVDD=790.01_U_.02_U_"C"_U_.1,WVPER="CASE MANAGERS"_U_"CASE MANAGER"
 I $G(WVTYPE)="MCC" S WVDD=790.011_U_2_U_"D"_U_.29,WVPER="MATERNITY CARE COORDINATORS"_U_"MATERNITY CARE COORDINATOR"
 Q
 ;
TRANS ;EP
 ;---> TRANSFER ONE CASE MANAGER'S PATIENTS TO ANOTHER CASE MANAGER.
 ;
 D TRANS1
 D EXIT
 Q
 ;
TRANS1 ;EP
 N WVDD,WVPER
 D SETVARS
 Q:'$G(WVDD)
 D TITLE^WVUTL5("TRANSFER A "_$P(WVPER,U,2)_"'S PATIENTS")
 D:$G(WVTYPE)="CM" TEXT1
 D:$G(WVTYPE)="MCC" TEXT2
 S WVJOPEN=1
 S WVDICW="S WVY=Y N Y S Y=$P($G(^WV("_$P(WVDD,U)_",+WVY,0)),U,2) D DD^%DT W:$L(Y)>10 ?32,""DATE INACTIVATED:  "",Y"
 D DIC^WVFMAN($P(WVDD,U),"QEMA",.Y,"   Select OLD "_$P(WVPER,U,2)_": ","","","","",WVDICW)
 K WVJOPEN,WVDICW
 Q:Y<0
 S WVCMGR=+Y
 S WVDICW="S WVY=Y N Y S Y=$P($G(^WV("_$P(WVDD,U)_",+WVY,0)),U,2) D DD^%DT W:$L(Y)>10 ?32,""DATE INACTIVATED:  "",Y"
 S WVDICS="I $P($G(^WV("_$P(WVDD,U)_",+Y,0)),U,2)="""""
 D DIC^WVFMAN($P(WVDD,U),"QEMA",.Y,"   Select NEW "_$P(WVPER,U,2)_": ","",WVDICS,"","",WVDICW)
 K WVDICW,WVDICS Q:Y<0
 S WVCMGR1=+Y
 W !!?3,"All patients currently assigned to: ",$$PERSON^WVUTL1(WVCMGR)
 W !?3,"will be reassigned to.............: ",$$PERSON^WVUTL1(WVCMGR1)
 ;
 ;---> YES/NO
 W !!?3,"Do you wish to proceed?"
 S DIR("?")="     Enter YES to swap "_$$TITLE^XLFSTR($P(WVPER,U))_"."
 S DIR(0)="Y",DIR("A")="   Enter Yes or No"
 D ^DIR W !
 Q:$D(DIRUT)!('Y)
 N M,N
 S N=0,M=0
 F  S N=$O(^WV(790,$P(WVDD,U,3),WVCMGR,N)) Q:'N  D
 .D DIE^WVFMAN(790,$P(WVDD,U,4)_"////"_WVCMGR1,N,.WVPOP)
 .Q:WVPOP  S M=M+1
 W !?3,M," patients transferred from ",$$PERSON^WVUTL1(WVCMGR)
 W " to ",$$PERSON^WVUTL1(WVCMGR1),"."  D DIRZ^WVUTL3
 Q
 ;
TEXT1 ;EP
 ;;The purpose of this utility is to aid in the transfer of all of one
 ;;Case Manager's patients to another Case Manager, such as when there
 ;;is a turnover in staff.  The program will ask you for an "OLD" Case
 ;;Manager and then for a "NEW" Case Manager.  All patients who were
 ;;previously assigned to the "OLD" Case Manager will be reassigned to
 ;;the "NEW" Case Manager.
 ;;
 ;;If the "NEW" Case Manager you are looking for cannot be selected,
 ;;that person must first be added to the file of Case Managers by
 ;;using the "Add/Edit Case Managers" option.
 ;;
 S WVTAB=5,WVLINL="TEXT1" D PRINTX
 Q
 ;
TEXT2 ;HELP TEXT
 ;;The purpose of this utility is to aid in the transfer of all of one
 ;;Maternity Care Coordinator's patients to another Maternity Care
 ;;Coordinator, such as when there is a turnover in staff.
 ;;The program will ask you for an "OLD" Maternity Care Coordinator
 ;;and then for a "NEW" Maternity Care Coordinator.  All patients who
 ;;were previously assigned to the "OLD" Maternity Care Coordinator
 ;;will be reassigned to the "NEW" Maternity Care Coordinator.
 ;;
 ;;If the "NEW" Maternity Care Coordinator you are looking for cannot
 ;;be selected, that person must first be added to the file of
 ;;Maternity Care Coordinators by using the "Add/Edit Maternity Care
 ;;Coordinators" option.
 ;;
 S WVTAB=5,WVLINL="TEXT2" D PRINTX
 Q
 ;
PRINTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  W !,T,$P(X,";;",2)
 Q
