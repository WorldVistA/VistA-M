WVMGRP ;HCIOFO/FT,JR - MANAGER'S PATIENT EDITS;06/14/2017  08:56
 ;;1.0;WOMEN'S HEALTH;**24**;Sep 30, 1998;Build 582
 ;;IHS/ANMC/MWR * MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLED BY DIFFERENT OPTIONS TO EDIT A PATIENT'S PAP REGIMEN LOG
 ;;  AND PREGNANCY/LACTATION STATUS DATA.
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
 .I $P($G(^WV(790.04,+Y,0)),U,2)="" N DIK S WVJR=+Y,DIK="^WV(790.04," D DEL Q
 .D NAME("^WV(790.04,",+Y)
 .S DR=".01;.03"
 .D DIE^WVFMAN(790.04,DR,+Y,.WVPOP)
 .S:WVPOP Y=-1
 .Q
 K WVJR
 D EXIT
 Q
DEL ; Delete File 790.04 entry if no patient
 S DA=WVJR D ^DIK
 W !!?10,"****  Patient Name Required  ---  Entry Deleted  ****",!!
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
PLSDATA ;EDIT PREGNANCY/LACTATION STATUS DATA
 ;---> CALLED BY OPTION: "WV EDIT PREG/LAC STATUS DATA".
 D SETVARS^WVUTL5
 N A,Y,DIK,DIR,X,DTOUT,DUOUT,DIRUT,DIROUT,WVPAT
 F  D  Q:$G(Y)=-1!($D(XQAID))
 .D TITLE^WVUTL5("EDIT PREGNANCY/LACTATION STATUS DATA")
 .I '$D(XQAID) D
 ..S A="   Select PATIENT: "
 ..D DIC^WVFMAN(790,"QEMA",.Y,A,,"I $O(^WV(790.8,""B"",Y,0))'=""""!($$NUMRECS^WVMGRP(Y)>0)")
 ..I +$G(Y)<1 S Y=-1,WVPAT=0 Q
 ..K WVJR,DA
 ..S WVPAT=+Y
 ..W !
 .I $D(XQAID) S WVPAT=+$P(XQAID,",",2)
 .Q:'WVPAT
 .S WVPAT("NAME")=$$EXTERNAL^DILFD(790,.01,"",WVPAT)
 .I $O(^WV(790.8,"B",WVPAT,0))'="" D  Q
 ..D DOCACT^WVMGRP1
 ..I $O(^WV(790.8,"B",WVPAT,0))="" D
 ...N XQAID,XQAKILL
 ...S XQAID="WV,"_WVPAT_",1"
 ...D DELETEA^XQALERT
 .I $D(XQAID),$O(^WV(790.8,"B",WVPAT,0))="" W "There are no status review records for "_WVPAT("NAME")_".",! H 5 Q
 .I $O(^WV(790,WVPAT,4,"B",0))'=""!($O(^WV(790,WVPAT,5,"B",0))'="") D MANAGE Q
 .W "There are no status records for "_WVPAT("NAME")_".",! H 5 Q
 I $D(XQAID) D
 .I $O(^WV(790.8,"B",WVPAT,0))'="" K XQAKILL
 .E  S XQAKILL=0
 D EXIT
 Q
MANAGE ;MANAGE STATUS DATA INDIVIDUALLY
 N WVDIRP2,WVNODE,WVGOTIT,WVDATE,WVIEN,WVENTS,WVEXIT,WVPROMPT,WVRETURN
 S WVNODE(4)="Pregnancy"_U_790.05,WVNODE(5)="Lactation"_U_790.16
 S WVNODE=0 F  S WVNODE=$O(WVNODE(WVNODE)) Q:'+WVNODE  D
 .S WVDATE=0 F  S WVDATE=$O(^WV(790,WVPAT,WVNODE,"B",WVDATE)) Q:'+WVDATE!($G(WVDIRP2(1)))  S WVIEN=0 F  S WVIEN=$O(^WV(790,WVPAT,WVNODE,"B",WVDATE,WVIEN)) Q:'+WVIEN!($G(WVDIRP2(1)))  D
 ..Q:$P($G(^WV(790,WVPAT,WVNODE,WVIEN,0)),U,6)
 ..S WVENTS(WVNODE)=1+$G(WVENTS(WVNODE)),WVENTS=WVENTS(WVNODE),WVENTS(WVNODE,WVENTS)=WVIEN_U_$$FMTE^XLFDT(WVDATE)_" => "_$$GET1^DIQ($P(WVNODE(WVNODE),U,2),WVIEN_","_WVPAT_",",21)
 ..S WVDIRP2(1)=$E(WVNODE(WVNODE),1)_":"_$P(WVNODE(WVNODE),U)
 .I $G(WVDIRP2(1))'="" S WVDIRP2=$S($G(WVDIRP2)'="":WVDIRP2_";",1:"")_WVDIRP2(1)
 .I '$D(WVDIRP2(1)) K WVNODE(WVNODE)
 .K WVDIRP2(1)
 I $D(WVNODE)<10 S Y=-2 Q
 I $L(WVDIRP2,";")>1 D  Q:$G(Y)=-1
 .S DIR(0)="S"_U_WVDIRP2,DIR("A")="   Select DATA TYPE"
 .S DIR("?")="Enter the letter to the left of the type of status data you want to work with."
 .D ^DIR
 .I $D(DIRUT)!($D(DIROUT)) S Y=-1 Q
 .W !
 .S WVNODE=0 F  S WVNODE=$O(WVNODE(WVNODE)) Q:'+WVNODE!($G(WVGOTIT))  I $E(WVNODE(WVNODE),1)=Y S WVGOTIT=WVNODE
 .S WVNODE=$G(WVGOTIT)
 I $L(WVDIRP2,";")=1 S WVNODE=$O(WVENTS(0))
 F  Q:$G(WVEXIT)'=""  D
 .I WVENTS(WVNODE)>1 D  Q:$G(WVEXIT)'=""
 ..N WVLINE,END,X
 ..S WVLINE=1
 ..W !,"   The following "_$$LOW^XLFSTR($P(WVNODE(WVNODE),U))_" status data is on file:",!!
 ..S WVENTS=0 F  S WVENTS=$O(WVENTS(WVNODE,WVENTS)) Q:'+WVENTS!($G(END))  D
 ...I WVLINE=($G(IOSL)-2) W !,"Press RETURN to continue or '^' to exit: " R X:DTIME S END='$T!(X="^") S:END WVEXIT=-1 Q:END  S WVLINE=1
 ...W ?5,$$RJ^XLFSTR(WVENTS," ",3),?11,$P(WVENTS(WVNODE,WVENTS),U,2),!
 ...S WVLINE=WVLINE+1
 ..S DIR(0)="NO"_U_U_"K:'$D(WVENTS(WVNODE,X)) X",DIR("A")="Select the data you want to work with"
 ..S DIR("?")="Enter the number to the left of the status data you want to work with."
 ..D ^DIR
 ..I $D(DTOUT)!($D(DUOUT)) S WVEXIT=-1 Q
 ..W !
 ..I Y="" S WVEXIT=-2 Q
 ..K DIR
 ..S WVENTS("Y")=Y
 .I WVENTS(WVNODE)=1 S WVENTS("Y")=$O(WVENTS(WVNODE,0))
 .I WVENTS(WVNODE)=0 S WVEXIT=-2 Q
 .S WVRETURN=$$SHODATA^WVMGRP1
 .I WVRETURN=-1 S WVEXIT=WVRETURN Q
 .S DIR(0)="Y"_U,DIR("A")="Do you want to mark this status data as entered in error"
 .S DIR("?",1)="If the status displayed is valid as of the date and time it was entered, enter"
 .S DIR("?",2)="'N' for no (you do not want to mark the status as entered in error). If the"
 .S DIR("?",3)="status was never valid, enter 'Y' for yes (you do want to mark the status as"
 .S DIR("?")="entered in error)."
 .D ^DIR
 .I $D(DIRUT)!($D(DIROUT)) S WVEXIT=-1 Q
 .K DIR
 .I Y D  Q
 ..S WVPROMPT=+WVENTS(WVNODE,WVENTS("Y"))_","_WVPAT_",",WVEXIT=$$PACT^WVMGRP2(WVNODE,2) Q:WVEXIT=-1
 ..S WVENTS(WVNODE)=WVENTS(WVNODE)-1
 ..K WVENTS(WVNODE,WVENTS("Y"))
 ..K WVEXIT
 .I 'Y S WVEXIT=1
 I $G(WVEXIT)'="" S Y=WVEXIT
 Q
 ;
ERROR(ACTION,FMERROR,ERROR) ;DISPLAY ERROR MESSAGE
 N LINE
 W !,"   Error while "_$G(ACTION)_":",!
 I $D(FMERROR)>9 W "   "_$$FMERROR^WVUTL11(.FMERROR),!
 I $D(ERROR)=1 F LINE=1:1:$L(ERROR,U) W "   "_$P(ERROR,U,LINE),!
 W "   Please contact your help desk for assistance.",!!
 H 5
 Q -1
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
 I DIC="^WV(790," S WVDFN=Y
 E  S WVDFN=$P(@(DIC_Y_",0)"),U,2)
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
NUMRECS(DFN) ;RETURN THE NUMBER OF PREGNANCY AND LACTATION RECORDS
 N COUNT,NODE,IEN
 S COUNT=0
 F NODE=4,5  S IEN=0 F  S IEN=$O(^WV(790,DFN,NODE,IEN)) Q:'+IEN  D
 .I $P($G(^WV(790,DFN,NODE,IEN,0)),U,6)'=1 S COUNT=COUNT+1
 Q COUNT
