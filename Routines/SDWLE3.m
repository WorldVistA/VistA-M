SDWLE3 ;IOFO BAY PINES/TEH - WAITING LIST-ENTER/EDIT;06/12/2002 ; 12/14/05 1:28pm  ; Compiled April 25, 2006 10:42:02
 ;;5.3;scheduling;**263,417,446**;AUG 13 1993;Build 77
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   08/01/2005                SD*5.3*417              Permit multiple teams
 ;   04/21/2006                SD*5.3*446              Inter-Facility Transfer
 ;   
 ;
EN ;
 ;ASK FOR SPECIFIC TEAM (404.51)
 K DIR,DIC,DR,DIE,SDTMENT S (DA,SDTMENT)=SDWLDA K SDWLTH,SDWLMAX
 S SDWLYN=5,SDWLTYE=1,SDWLVBR="SDWLST"
 I $D(SDWLST),'SDWLST K SDWLST
 I $G(SDWLCP3)'="" D
 .W !,"This patient is already on the ",SDWLCP3,"." S DIR(0)="Y^A0",DIR("B")="NO",DIR("A")="Are you sure you want to continue" D ^DIR
 .I 'Y!(Y["^") S DUOUT=1 Q
 I $D(DUOUT),DUOUT G END
 D GETLIST
 S SDWLERR=0,SDWLY="Team",SDWLVAR=$S($D(SDWLST):SDWLST,1:0),SDWLSCR=""
 S SDWLVBR="SDWLST"
EN1 W ! S SDWLS=SDWLY,SDWLX=$S(SDWLTYE=1:"T",SDWLTYE=2:"P",1:""),SDWLSX="     "_SDWLS
 S SDWLF="SCTM(404.51,"
 S SDWLA=0 F  S SDWLA=$O(^SCTM(404.58,"B",SDWLA)) Q:SDWLA=""  D
 .I $D(SDWLCT),SDWLCT=SDWLA Q
 .I $P($G(^SCTM(404.51,SDWLA,0)),U,7)'=SDWLIN Q
 .I +$$ACTTM^SCMCTMU(SDWLA)=0 S SDWLTH(SDWLA)=""
 .S SDWLMAX=0,X=$$TEAMCNT^SCAPMCU1(SDWLA,DT),SDWLMAX(SDWLA)=""  D
 ..I X<$P($G(^SCTM(404.51,SDWLA,0)),U,8) K SDWLMAX(SDWLA)
 N SDWLT S SDWLT=0 F  S SDWLT=$O(SDWLPLST(1,SDWLT)) Q:SDWLT<1  K SDWLMAX(SDWLT)
 S SDWLSCR="I $P(^(0),U,7)=SDWLIN,'$D(SDWLTH(+Y)),$D(SDWLMAX(+Y)),'$D(SDWLPLST(SDWLTYE,+Y,SDWLIN))"
 D EN2 G END:$D(DUOUT)
 ;DA=SDWLDA, see EN
 S DR="5////^S X=SDWLVAR",DIE=409.3 D ^DIE
 N FLG D FLAGS(.FLG,DFN,SDWLVAR)
 I 'FLG S DA=SDTMENT,DIE=409.3 D
 .S SDINTR=FLG(1),SDREJ=FLG(2),SDMTM=FLG(3)
 .S DR="32////^S X=SDREJ;34////^S X=SDINTR;38////^S X=SDMTM" D ^DIE
 ;
 S @SDWLVBR=SDWLVAR
 I $D(SDWLVARO),SDWLVARO,SDWLVAR'=SDWLVARO D DELPOS
 G END
EN2 ;-DIR READ
 I '$D(SDWLDATA),$D(SDWLMAX)'=11 W !,"No TEAMS are available for this INSTITUTION.",! S DUOUT="" Q
 K DIR,DR,DIE,DIC,DUOUT
 S DIR("?")="^S X=""?"",DIC(""S"")=""I $P(^SCTM(404.51,+Y,0),U,7)=SDWLIN,'$D(SDWLTH(+Y)),$D(SDWLMAX(+Y)),'$D(SDWLPLST(1,+Y,SDWLINE))"" S DIC=404.51,DIC(0)=""EQMNZ"" D ^DIC"
 I $D(SDWLVAR),SDWLVAR S X=SDWLVAR,SDWLMPX=$$EXTERNAL^DILFD(409.3,SDWLYN,,SDWLVAR),DIR("B")=SDWLMPX,SDWLVARO=SDWLVAR K X
 S DIR(0)="FAO",DIR("A")="Select "_SDWLY_": "
 D ^DIR
 I X["^" S DUOUT=1 Q
 S DUOUT=$S(X=0:1,X="@":1,$D(DTOUT):1,1:0) I 'DUOUT K DUOUT
 I X="@" W *7," No deleting allowing." G EN2
 S DIC("S")=SDWLSCR
 S DIC(0)="EMNZ",DIC=404.51 D ^DIC I $D(DTOUT) S DUOUT=1
 I $D(DUOUT) Q
 I Y<0 W "??" G EN2
 S SDWLVAR=+Y
 Q
 ;identify flags
FLAGS(FLG,DFN,TEAM) ;
 N SDTEAM S SDTEAM=$G(TEAM)
 ; check if transfer and if multiple teams in institution
 S SDCNT=0,SDINTR=0,SDREJ=0,SDMTM=0 D
 .S SDWLIN=$P($G(^SCTM(404.51,TEAM,0)),U,7)
 .I $P(^SCTM(404.51,TEAM,0),U,5)'=1 Q  ; cannot be primary care provider team   
 .;identify INTRA-transfer
 .;- is patient assigned to PC provider?
 .I $$GETALL^SCAPMCA(DFN) D
 ..I $G(^TMP("SC",$J,DFN,"PCPOS",0)) S SDTM=$P(^(1),U,3) I SDTM>0 D
 ...I $P($G(^SCTM(404.51,SDTM,0)),U,7)'=SDWLIN S SDINTR=1 D  ; inter transfer ; different institution
 ..I '$G(^TMP("SC",$J,DFN,"PCPOS",0)) D
 ...;check available PCMM teams in other institutions and if so set up rejection flag
 ...S SDINS=""
 ...F  S SDINS=$O(^SCTM(404.51,"AINST",SDINS)) Q:SDINS=""  I SDINS'=SDWLIN D  Q:SDREJ
 ....S SDCNT=0,SDT=""
 ....F  S SDT=$O(^SCTM(404.51,"AINST",SDINS,SDT)) Q:SDT=""  D  Q:SDREJ
 .....I $$ACTTM^SCMCTMU(SDT,DT)&($P($G(^SCTM(404.51,SDT,0)),U,5))&'$P($G(^SCTM(404.51,SDT,0)),U,10) D
 ......S SCTMCT=$$TEAMCNT^SCAPMCU1(SDT) ;currently assigned
 ......S SCTMMAX=$P($$GETEAM^SCAPMCU3(SDT),"^",8) ;maximum set
 ......I SCTMCT<SCTMMAX S SDREJ=1
 ..;find all teams from institution SDWLIN
 ..I SDINTR S SDCNT=0,SDT="" D
 ...F  S SDT=$O(^SCTM(404.51,"AINST",SDWLIN,SDT)) Q:SDT=""  I $P(^SCTM(404.51,SDT,0),U,5)=1 S TEAM(SDT)="",SDCNT=SDCNT+1
 S FLG(1)=SDINTR,FLG(2)=SDREJ,FLG(3)=SDMTM
 I SDCNT>1 S SDMTM=1,FLG(3)=SDMTM,FLG=1 S SDCC="" F  S SDCC=$O(TEAM(SDCC)) Q:SDCC=""  S TEAM=SDCC N DR,Y D WMT
 I SDCNT>1 S TEAM=$G(SDTEAM) Q
 I SDCNT'>1 N DR,Y S FLG=0 S TEAM=$G(SDTEAM) Q
WMT D INPUT^SDWLRP1(.RES,DFN_U_1_U_TEAM_U_U_DUZ_"^^"_U_SDINTR_U_SDREJ_U_SDMTM)
 ;I $G(RES) S OK=0,DA=+$P(RES,U,2),DIE="^SDWL(409.3,",DR="25;S OK=1" D ^DIE  I '$G(OK) S DIK=DIE D ^DIK W !,"Wait list entry deleted"
 Q
GETLIST ;GET LIST OF TEAM ASSIGNMENTS - SD*5.3*417
 N SDWLDAX,X,Z,SDWLIN K SDWLPLST S SDWLPLST=""
 S SDWLDAX=0 F  S SDWLDAX=$O(^SDWL(409.3,"B",SDWLDFN,SDWLDAX)) Q:SDWLDAX=""  D
 .S Z=$G(^SDWL(409.3,SDWLDAX,0)),X=$P(Z,U,5),SDWLINE=+$P(Z,U,3) Q:X'=1&(X'=2)  D
 ..S Y=+$S(X=1:$P(Z,U,6),X=2:$P(Z,U,7),1:0) Q:'Y  D
 ...I $P(Z,U,17)["O" S SDWLPLST(X,Y,SDWLINE)="" I $D(SDWLST),SDWLST=+Y K SDWLPLST(X,Y,SDWLINE)
 S Y=0 F  S Y=$O(SDWLCPT(Y)) Q:Y=""  D
 .S SDWLPLST(1,Y,SDWLINE)="" I $D(SDWLST),SDWLST=+Y K SDWLPLST(1,Y,SDWLINE)
 Q
DELPOS ;DELETE POSITIONS FOR OLD TEAM
 S SDWLA=0,CNT=0 F  S SDWLA=$O(^SDWL(409.3,"B",SDWLDFN,SDWLA)) Q:SDWLA<1  D
 .S X=$G(^SDWL(409.3,SDWLA,0)) Q:$P(X,U,7)=""
 .I $P(X,U,5)'=2 Q
 .I $P(X,U,17)["C" Q
 .S SDWLPX=+$P(X,U,7) I $P($G(^SCTM(404.57,SDWLPX,0)),U,2)'=SDWLVARO Q
 .S CNT=CNT+1,^XTMP("SDWLE3",$J,CNT)=SDWLA_";"_X W !
 I 'CNT Q
 W !,"This patient has one or more Wait List entries for PCMM Positions",!
 W !,"Wait List Type",?30,"Waiting For",?45,"Institution",?60,"Date Entered",!
 S Y=0 F  S Y=$O(^XTMP("SDWLE3",$J,Y)) Q:Y<1  S X=$G(^XTMP("SDWLE3",$J,Y)),SDWLIEN=$P(X,";",1) D
 .W !,$$GET1^DIQ(409.3,SDWLIEN,4),?30,$$GET1^DIQ(409.3,SDWLIEN,6),?45,$$GET1^DIQ(409.3,SDWLIEN,2),?60,$$GET1^DIQ(409.3,SDWLIEN,1)
 W ! S SDWLET=$$EXTERNAL^DILFD(409.3,SDWLYN,,SDWLVARO)
 K DIR S DIR("?",1)="This patient has one or more Wait List entries for PCMM positions."
 S DIR("?",2)="By answering 'YES' you will close the Wait List entries which were listed."
 S DIR("?")="Answer 'NO' to keep those Wait List entries open."
 S DIR("A")="Do you wish to close these POSITION(S) entries? ",DIR(0)="Y",DIR("B")="YES" D ^DIR
 I 'Y W *7," No POSITIONS closed." Q
 N DA S SDWLA=0 F  S SDWLA=$O(^SDWL(409.3,"B",SDWLDFN,SDWLA)) Q:SDWLA<1  D
 .S X=$G(^SDWL(409.3,SDWLA,0)) Q:$P(X,U,7)=""  D
 ..S SDWLP=$P(X,U,7) I $P(^SCTM(404.57,SDWLP,0),U,2)=SDWLVARO D
 ...K DIE,DIC,DR,DICR,DIR S DA=SDWLA,SDWLDISP="NN"
 ...S DIE="^SDWL(409.3,",DR="21////^S X=SDWLDISP" D ^DIE
 ...S DR="19////^S X=DT" D ^DIE
 ...S DR="20////^S X=SDWLDUZ" D ^DIE
 ...S DR="23////""C""" D ^DIE
 Q
END K SDWLA,SDWLMAX,SDWLTH,SDWLSCR,DIR,DIC,DIE,DR,SDWLPLST,SDWLDAX,DTOUT,SDWLCP3,SDWLINE
 K X,Y,Z,SDWLPLST,SDWLB,SDWLA,SDWLSX,SDWLS,SDWLVBR,SDWLVAR,SDWLSCR,SDWLF,SDWLYN,SDWLMPX
 Q
