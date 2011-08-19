WVMGRP ;HCIOFO/FT,JR IHS/ANMC/MWR - MANAGER'S PATIENT EDITS ;7/29/98  16:44
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLED BY DIFFERENT OPTIONS TO EDIT A PATIENT'S PAP REGIMEN LOG
 ;;  AND PREGNANCY LOG.
 ;
PLOG ;EP
 ;---> CALLED BY OPTION: "WV EDIT PAP REGIMEN LOG".
 D SETVARS^WVUTL5
 N A,DR,Y
 F  D  Q:$G(Y)<0
 .D TITLE^WVUTL5("EDIT PAP REGIMEN LOG")
 .D PLOGTX W !
 .S A="   Select PATIENT (or Enter a new BEGIN DATE): "
 .D DIC^WVFMAN(790.04,"QEMAL",.Y,A)
 .Q:Y<0  K WVJR
 .I $P($G(^WV(790.04,+Y,0)),U,2)="" S WVJR=+Y,DIK="^WV(790.04," D DEL Q
 .D NAME("^WV(790.04,",+Y)
 .S DR=".01;.03"
 .D DIE^WVFMAN(790.04,DR,+Y,.WVPOP)
 .S:WVPOP Y=-1
 .Q
 K WVJR
 D EXIT
 Q
DEL ; Delete File 790.04 or 790.05 entry if no patient
 S DA=WVJR D ^DIK D
 .W !!?10,"****  Patient Name Required  ---  Entry Deleted  ****",!!
 D DIRZ^WVUTL3 Q
 ;
PLOGTX ;EP
 ;;WARNING: If you edit the "BEGIN DATE:" of an entry in the PAP REGIMEN
 ;;         Log, be SURE that another entry with the same "BEGIN DATE:"
 ;;         does not already exist for this patient.
 ;;
 ;;         (Ordinarily, the program checks this and will not allow
 ;;         two separate entries for the same patient on the same
 ;;         "BEGIN DATE:".  But under this option you, as the Manager,
 ;;         have greater edit capability.)
 S WVTAB=5,WVLINL="PLOGTX" D PRINTX
 Q
 ;
 ;
EDC ;EP
 ;---> CALLED BY OPTION: "WV EDIT PREGNANCY LOG".
 D SETVARS^WVUTL5
 N A,DR,Y
 F  D  Q:$G(Y)<0
 .D TITLE^WVUTL5("EDIT PREGNANCY LOG")
 .S A="   Select PATIENT (or Enter a new DATE): "
 .D DIC^WVFMAN(790.05,"QEMAL",.Y,A)
 .Q:Y<0  K WVJR
 .I $P($G(^WV(790.05,+Y,0)),U,2)="" S WVJR=+Y,DIK="^WV(790.05," D DEL Q
 .D NAME("^WV(790.05,",+Y)
 .S DR=".01;.03;.04"
 .D DIE^WVFMAN(790.05,DR,+Y,.WVPOP)
 .S:WVPOP Y=-1
 .Q
 K WVJR
 D EXIT
 Q
 ;
EXIT ;EP
 W @IOF
 D KILLALL^WVUTL8
 Q
 ;
PRINTX ;EP
 ;---> PRINTS TEXT.
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  W !,T,$P(X,";;",2)
 Q
 ;
NAME(DIC,Y) ;EP
 N WVDFN
 S WVDFN=$P(@(DIC_Y_",0)"),U,2)
 W !!?3,$$NAME^WVUTL1(WVDFN),"   ",$$SSN^WVUTL1(WVDFN),!
 Q
 ;
 ;
NONE ;EP
 S WVTITLE="* There are no PAP Regimen Log entries for this patient. *"
 D CENTERT^WVUTL5(.WVTITLE)
 W !!!!,WVTITLE,!!
 D DIRZ^WVUTL3
 Q
