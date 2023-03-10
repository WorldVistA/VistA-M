YTQROPT ;SLC/KCM - MHA Assignment Options ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130,141,217**;Dec 30, 1994;Build 12
 ;
 ; Reference to ^DPT in ICR #10035
 ; Reference to ^DIC in ICR #10006
 ; Reference to $$GET1^DIQ,EN^DIQ in ICR #2056
 ; Reference to $$FMTE^XLFDT in ICR #10103
 ;
LSTBYPT ; List assignments by patient
 ; Option: YTQR ASSIGNMENT BY PATIENT
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
ADMDTL ; List details of an administration
 ; Option: YTQR ADMINISTRATION DETAIL
 N X,Y,DIC,DIR,DUOUT,DTOUT,DIRUT,DIROUT
 N YSDFN,YSDT,YSDTX,YSTST,YSAD,YSCNT,YSDETAIL
 W !,"--- List Administration Details ---",!
 S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC I Y'>0 QUIT
 S YSDFN=+Y
 S DIR(0)="D^::EP",DIR("A")="Date of Administration(s)" D ^DIR Q:$D(DIRUT)
 S YSDT=$P(Y,"."),YSTST=0,YSCNT=0
 S YSDETAIL=$$OKDETAIL()
 W !
 S YSAD=0 F  S YSAD=$O(^YTT(601.84,"C",YSDFN,YSAD)) Q:'YSAD  D
 . I $P($P($G(^YTT(601.84,YSAD,0)),U,4),".")'=YSDT Q
 . S YSCNT=YSCNT+1
 . D SHOADM(YSAD)
 . I YSDETAIL D SHOFULL(YSAD)
 I YSCNT=0 W !,"No administrations found."
 Q
OKDETAIL() ; return 1 if OK to show details
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR("A")="Show full details for each administration"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR
 Q +Y
 ;
SHOADM(YSAD) ; Show all fields for administration
 N DIC,DA,DR
 S DIC="^YTT(601.84,",DA=YSAD
 D EN^DIQ
 Q
SHOFULL(YSAD) ; Show answers & results for administration
 N I,J,X
 ; show answer index & records
 W !,"  --- Answer Records ---"
 S I=0 F  S I=$O(^YTT(601.85,"AD",YSAD,I)) Q:'I  D
 . W !,?2,I,"=",$G(^YTT(601.85,I,0))
 . I $D(^YTT(601.85,I,1)) S J=0 F  S J=$O(^YTT(601.85,I,1,J)) Q:'J  D
 . . W !,?4,$G(^YTT(601.85,I,1,J,0))
 ; show result index & records
 W !,"  --- Result Records ---"
 S I=0 F  S I=$O(^YTT(601.92,"AC",YSAD,I)) Q:'I  D
 . W !,?2,I,"=",$G(^YTT(601.92,I,0))
 W !
 Q
