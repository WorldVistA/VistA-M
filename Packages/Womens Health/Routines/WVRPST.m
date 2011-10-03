WVRPST ;HCIOFO/JR,FT-Sexual Trauma Summary ;4/11/01  09:16
 ;;1.0;WOMEN'S HEALTH;**7,14**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ;  #2716 - $$GETSTAT^DGMSTAPI  (supported)
 ; #10035 - ^DPT(DFN,.351       (supported)
 ;
 ; EP for List Sexual Trauma Data [WV SEXUAL TRAUMA LIST] option
 W @IOF,!?33,"WOMEN'S HEALTH"
 W !?19,"* * *  SEXUAL TRAUMA SUMMARY REPORT  * * *",!
 S WVE="",(WVMGR,WVPOP)=0
 D CMGR^WVMSTL ;select one or all case mgrs to sort by
 I WVPOP D EXIT Q
 K IO("Q") S %ZIS="Q" D ^%ZIS G EXIT:POP I $D(IO("Q")) D  Q
 .S ZTRTN="GET^WVRPST",ZTDESC="WH SEXUAL TRAUMA SUMMARY"
 .S ZTSAVE("WVE")="",ZTSAVE("WVMGR")=""
 .D ^%ZTLOAD D HOME^%ZIS K IO("Q")
 .Q
GET ; Get data for report
 U IO
 Q:WVE=""  ;no case mgr selection
 S (WVBOTH,WVDFN,WVCIVCNT,WVCNALL,WVETCNT,WVZSTOP)=0
 S (WVCSTV("Y"),WVCSTV("N"),WVCSTV("D"),WVCSTV("U"))=0
 S (WVCSTNV("Y"),WVCSTNV("N"),WVCSTNV("D"),WVCSTNV("U"))=0
 S (WVMSTV("Y"),WVMSTV("N"),WVMSTV("D"),WVMSTV("U"))=0
 S WVLINE=$$REPEAT^XLFSTR("-",76)
 S WVDASH=$$REPEAT^XLFSTR("=",80)
 F  S WVDFN=$O(^WV(790,WVDFN)) Q:WVDFN'>0!($G(ZSTOP)=1)  S WV0=$G(^(WVDFN,0)) D
 .S WVZSTOP=WVZSTOP+1
 .;If background task, then every 100 records check if user wants to
 .;stop the task.
 .I $D(ZTQUEUED),WVZSTOP#100=0 D STOPCHK^WVUTL10(0) Q:$G(ZTSTOP)=1
 .I '$$NOT(WVDFN) Q  ;active patient in WH package?
 .I WVE=0,WVMGR'=$P(WV0,U,10) Q  ;not the case mgr selected by user
 .S WVCST=$P(WV0,U,28) ;CST value
 .S WVMST=$P($$GETSTAT^DGMSTAPI(WVDFN),U,2) ;get MST status
 .S WVCNALL=WVCNALL+1 ;count of active patients in WH
 .S WVET=$E($$VET^WVUTL1A(WVDFN)) ;check veteran status
 .S:WVET="Y" WVETCNT=WVETCNT+1 ;count of veterans
 .S:WVET'="Y" WVCIVCNT=WVCIVCNT+1 ;count of non-veterans
 .I WVET="Y" D  ;CST count for veterans
 ..I WVCST="Y" S WVCSTV("Y")=WVCSTV("Y")+1 Q
 ..I WVCST="N" S WVCSTV("N")=WVCSTV("N")+1 Q
 ..I WVCST="D" S WVCSTV("D")=WVCSTV("D")+1 Q
 ..S WVCSTV("U")=WVCSTV("U")+1
 ..Q
 .I WVET'="Y" D  ;CST count for non-veterans
 ..I WVCST="Y" S WVCSTNV("Y")=WVCSTNV("Y")+1 Q
 ..I WVCST="N" S WVCSTNV("N")=WVCSTNV("N")+1 Q
 ..I WVCST="D" S WVCSTNV("D")=WVCSTNV("D")+1 Q
 ..S WVCSTNV("U")=WVCSTNV("U")+1
 ..Q
 .I WVET="Y" D  ;MST count - applies to veterans only
 ..I WVMST="Y" S WVMSTV("Y")=WVMSTV("Y")+1 S:WVCST="Y" WVBOTH=WVBOTH+1 Q
 ..I WVMST="N" S WVMSTV("N")=WVMSTV("N")+1 Q
 ..I WVMST="D" S WVMSTV("D")=WVMSTV("D")+1 Q
 ..S WVMSTV("U")=WVMSTV("U")+1
 ..Q
 .Q
 I $G(ZTSTOP)=1 D EXIT Q
 D PRINT
EXIT ;
 D ^%ZISC
 K WV0,WVBOTH,WVCIVCNT,WVCNALL,WVCRT,WVCST,WVCSTNV,WVCSTV,WVDASH,WVDFN
 K WVE,WVET,WVETCNT,WVJRNOW,WVLINE,WVLINL,WVMGR,WVMST,WVMSTV,WVPOP,WVTAB,WVZSTOP
 K POP,X,Y
 Q
PRINT ; Print counts
 S WVCRT=$S($E(IOST)="C":1,1:0)
 D HEAD
 W !,"MST",?18,"YES",?29,"NO",?35,"DECLINED",?45,"UNKNOWN"
 W !,WVLINE
 W !,"VETERANS",?15,$J(WVMSTV("Y"),6),?25,$J(WVMSTV("N"),6),?35,$J(WVMSTV("D"),6),?45,$J(WVMSTV("U"),6)
 W !!,WVDASH
 W !!,"CST",?18,"YES",?29,"NO",?35,"DECLINED",?45,"UNKNOWN"
 W !,WVLINE
 W !,"VETERANS",?15,$J(WVCSTV("Y"),6),?25,$J(WVCSTV("N"),6),?35,$J(WVCSTV("D"),6),?45,$J(WVCSTV("U"),6)
 W !,"NON-VETS",?15,$J(WVCSTNV("Y"),6),?25,$J(WVCSTNV("N"),6),?35,$J(WVCSTNV("D"),6),?45,$J(WVCSTNV("U"),6)
 W !,WVDASH
 W !?5,"# OF PATIENTS ---------------->",$J(WVCNALL,5)
 W !?5,"# WHO ARE VETERANS ----------->",$J(WVETCNT,5)
 W !?5,"# WHO ARE NON-VETERANS ------->",$J(WVCIVCNT,5)
 W !?5,"# WITH MST & CST ------------->",$J(WVBOTH,5)
 W !!?12,"Above numbers are based on Active Women's Health patients"
 I WVE=1 W !?12,"for all case managers."
 I WVE=0 W !?12,"for "_$$PERSON^WVUTL1(WVMGR)_"."
 S WVPOP=0
 I WVCRT&('$D(IO("S")))&('POP) D DIRZ^WVUTL3 W @IOF,!
 Q
HEAD ; Print the report header
 W:$Y>0 @IOF
 W !?26,"SEXUAL TRAUMA SUMMARY REPORT"
 W !,$$RUNDT^WVUTL1A("C")
 W !,WVDASH
 Q
NOT(WVDFN) ;Screen out patients for Inactive & Dead
 N TEST
 S TEST=$$GET1^DIQ(2,WVDFN,.351,"I")
 Q:TEST>0 0
 S TEST=$P($G(^WV(790,WVDFN,0)),U,24)
 Q:TEST>0 0
 Q 1
