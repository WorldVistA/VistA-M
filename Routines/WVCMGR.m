WVCMGR ;HCIOFO/FT,JR IHS/ANMC/MWR - ADD/EDIT CASE MANAGER; ;8/10/98  15:08
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLED BY OPTION: "WV ADD/EDIT CASE MANAGERS" TO ADD AND EDIT
 ;;  CASE MANAGERS.
 ;
 ;---> DIE ADD/EDIT CASE MANAGERS LOOP.
 D SETVARS^WVUTL5
 N Y
 F  D  Q:$G(Y)<0
 .D TITLE^WVUTL5("ADD/EDIT CASE MANAGERS")
 .S WVDICW="S WVY=Y N Y S Y=$P($G(^WV(790.01,+WVY,0)),U,2) D DD^%DT W:$L(Y)>10 ?32,""DATE INACTIVATED:  "",Y"
 .D DIC^WVFMAN(790.01,"QEMAL",.Y,"   Select CASE MANAGER: ","","","","",WVDICW)
 .K WVDICW Q:Y<0
 .D DIE^WVFMAN(790.01,.02,+Y,.WVPOP)
 .S:WVPOP Y=-1
 ;
EXIT ;EP
 D KILLALL^WVUTL8
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
 D TITLE^WVUTL5("TRANSFER A CASE MANAGER'S PATIENTS")
 D TEXT1 S WVJOPEN=1
 S WVDICW="S WVY=Y N Y S Y=$P($G(^WV(790.01,+WVY,0)),U,2) D DD^%DT W:$L(Y)>10 ?32,""DATE INACTIVATED:  "",Y"
 D DIC^WVFMAN(790.01,"QEMA",.Y,"   Select OLD CASE MANAGER: ","","","","",WVDICW)
 K WVJOPEN,WVDICW
 Q:Y<0
 S WVCMGR=+Y
 S WVDICW="S WVY=Y N Y S Y=$P($G(^WV(790.01,+WVY,0)),U,2) D DD^%DT W:$L(Y)>10 ?32,""DATE INACTIVATED:  "",Y"
 D DIC^WVFMAN(790.01,"QEMA",.Y,"   Select NEW CASE MANAGER: ","","","","",WVDICW)
 K WVDICW Q:Y<0
 S WVCMGR1=+Y
 W !!?3,"All patients currently assigned to: ",$$PERSON^WVUTL1(WVCMGR)
 W !?3,"will be reassigned to.............: ",$$PERSON^WVUTL1(WVCMGR1)
 ;
 ;---> YES/NO
 W !!?3,"Do you wish to proceed?"
 S DIR("?")="     Enter YES to swap Case Managers."
 S DIR(0)="Y",DIR("A")="   Enter Yes or No"
 D ^DIR W !
 Q:$D(DIRUT)!('Y)
 N M,N
 S N=0,M=0
 F  S N=$O(^WV(790,"C",WVCMGR,N)) Q:'N  D
 .D DIE^WVFMAN(790,".1////"_WVCMGR1,N,.WVPOP)
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
PRINTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  W !,T,$P(X,";;",2)
 Q
