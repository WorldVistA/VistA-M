YTQROPT ;SLC/KCM - MHA Assignment Options ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; ^DPT                 10035
 ; DIC                  10006
 ; DIQ                   2056
 ; XLFDT                10103
 ;
LSTBYPT ; List assignments by patient
 N X,Y,DIC,DUOUT,DTOUT,YSDFN,OUT
 S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC I Y'>0 QUIT
 D BLD4PT(+Y,.OUT)
 I '$D(OUT) W !,?5,"No assignments found for this patient",! QUIT
 W ! D SHO4PT(.OUT) W !
 Q
 ;
BLD4PT(YSDFN,OUT) ; List assignments for patient in OUT
 ; ^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,SETID)=EXPIRE
 N PRV,PRVNM,SET,EXPIRE K OUT
 S PRV=0 F  S PRV=$O(^XTMP("YTQASMT-INDEX","AD",YSDFN,PRV)) Q:'PRV  D
 . S SET=0 F  S SET=$O(^XTMP("YTQASMT-INDEX","AD",YSDFN,PRV,SET)) Q:'SET  D
 . . I $G(^XTMP("YTQASMT-SET-"_SET,1,"entryMode"))'="patient" QUIT
 . . S PRVNM=$$GET1^DIQ(200,PRV_",",.01)
 . . S EXPIRE=^XTMP("YTQASMT-INDEX","AD",YSDFN,PRV,SET)
 . . S OUT(PRVNM,SET)=$$FMTE^XLFDT(EXPIRE)
 Q
SHO4PT(OUT) ; Display assignment information
 N PRVNM,SET
 W !,?5,"Provider",?34,"PIN",?40,"Expires"
 W !,?5,"--------",?34,"---",?40,"-------"
 S PRVNM="" F  S PRVNM=$O(OUT(PRVNM)) Q:'$L(PRVNM)  D
 . S SET=0 F  S SET=$O(OUT(PRVNM,SET)) Q:'SET  D
 . . W !,?5,PRVNM,?32,$J(SET,6),?40,OUT(PRVNM,SET)
 Q
LSTALL ; List all active assignments
 N YSDFN,PTNM,OUT
 S YSDFN=0 F  S YSDFN=$O(^XTMP("YTQASMT-INDEX","AD",YSDFN)) Q:'YSDFN  D
 . D BLD4PT(YSDFN,.OUT) Q:'$D(OUT)
 . S PTNM=$$GET1^DIQ(2,YSDFN_",",.01)
 . W !!,?10,"---- ",PTNM," ----"
 . D SHO4PT(.OUT)
 Q
