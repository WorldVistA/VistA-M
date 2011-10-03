VALMW2 ;MJK/ALB - LM workbench (cont.);16 DEC 1992
 ;;1;List Manager;;Aug 13, 1993
 ;
EDIT(VALMTEMP) ; -- call to edit portions of list temp
 N DA,DR,DIE
 W ! S DA=VALMIFN,DR="[VALM "_VALMTEMP_"]",DIE="^SD(409.61," D ^DIE
 I $D(Y)>0 S XQORPOP=1
 I '$D(VALMALL),$D(^SD(409.61,VALMIFN,0)) D
 .D BLD^VALMWB
 .S VALMBCK="R"
 I '$D(^SD(409.61,VALMIFN,0)) D
 .D INIT^VALMWB
 .S:$D(^SD(409.61,VALMIFN,0)) VALMBCK="R" Q
 Q
 ;
RUN(VALMIFN) ; -- call to run list with workbench
 N VALMNAME
 G RUNQ:'$D(^SD(409.61,VALMIFN,0)) S VALMNAME=$P(^(0),U)
 S DIR(0)="409.61,105",DIR("A")="Set-up MUMPS Code"
 S DIR("B")=$S($D(VALMUMPS):VALMUMPS,1:"Q") D ^DIR K DIR
 I $D(DIRUT)!($D(DTOUT)) G RUNQ
 S VALMUMPS=Y X Y
 D CLEAR^VALM1
 W !!,">>> Running the '",VALMNAME,"' List Template."
 W !,"     Select 'QUIT' action to the workbench...",!!
 D EN^VALM(VALMNAME)
RUNQ S VALMBCK="R"
 Q
 ;
EDITOR ; -- routine editor
 S X=VALMWD X ^%ZOSF("RM") D FULL^VALM1
 I ^%ZOSF("OS")["VAX DSM" D ^%EDT G EDITORQ
 I ^%ZOSF("OS")["DTM" D ^%editor G EDITORQ
 ;I ^%ZOSF("OS")["MSM" X ^%E G EDITORQ
 S VALMSG="No compatiable editor for operating system."
EDITORQ S VALMBCK="R",X=0 X ^%ZOSF("RM")
 Q
