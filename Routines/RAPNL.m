RAPNL ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Radiology Personnel Menu ;9/12/94  11:15
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
1 ;;Classification Edit
 W ! S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Select Personnel: " D ^DIC K DIC Q:Y<0
 S DA=+Y,DIE="^VA(200,",DR="[RA PERSONNEL]" D ^DIE K %,%X,%Y,C,D0,D1,DA,DE,DQ,DIE,DR G 1
 ;
2 ;;Technologist List
 S DIC="^VA(200,",L=0,FLDS="[RA PERSONNEL LIST]",DHD="Technologist List",BY="[RA PERSONNEL LIST]",FR="@",TO="",DIS(0)="I $D(^VA(200,""ARC"",""T"",D0))" D EN1^DIP K FLDS,BY,FR,TO,DHD,ZZ Q
 ;
3 ;;Resident Interpreting Physician List
 S DIC="^VA(200,",L=0,FLDS="[RA RESIDENT RADIOLOGIST]",BY="[RA PERSONNEL LIST]",FR="@",TO="",DIS(0)="I $D(^VA(200,""ARC"",""R"",D0))" D EN1^DIP K FLDS,BY,FR,TO,DHD,ZZ Q
 ;
4 ;;Staff Interpreting Physician List
 S DIC="^VA(200,",L=0,FLDS="[RA PERSONNEL LIST]",DHD="Interpreting Staff List",BY="[RA PERSONNEL LIST]",FR="@",TO="",DIS(0)="I $D(^VA(200,""ARC"",""S"",D0))" D EN1^DIP K FLDS,BY,TO,FR,DHD,ZZ Q
 ;
5 ;;Radiology/Nuclear Medicine Clerk List
 S DIC="^VA(200,",L=0,FLDS="[RA PERSONNEL LIST]"
 S DHD="Radiology/Nuclear Medicine Clerk List"
 S FR="@",TO="",BY="[RA PERSONNEL LIST]"
 S DIS(0)="I $D(^VA(200,""ARC"",""C"",D0))"
 D EN1^DIP K FLDS,BY,TO,FR,DHD,ZZ
 Q
KEYS(RAD0) ; List keys for user
 ; Called from [RA PERSONNEL LIST] and [RA RESIDENT RADIOLOGIST]
 ; print templates.  RAHD is used for formatting text.  RAHD's value
 ; is printed inside the above templates.
 N RAD1,RAFLG,RAHD,RAKEY,RANODE
 S (RAD1,RAFLG)=0,RAHD="   Rad/Nuc Med Keys: "
 F  S RAD1=$O(^VA(200,RAD0,51,RAD1)) Q:RAD1'>0  D
 . S RANODE=$G(^VA(200,RAD0,51,RAD1,0)) Q:RANODE']""
 . S RAKEY=$$LKUP^XPDKEY(+RANODE) Q:$E(RAKEY,1,2)'="RA"
 . I $X>(IOM-30) W !?($X+$L(RAHD)) S RAFLG=0
 . W:RAFLG ", " W RAKEY S RAFLG=1
 . Q
 Q
