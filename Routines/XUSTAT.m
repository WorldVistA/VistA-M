XUSTAT ;SF/RWF - User/CPU stats from sign-on log ;01/13/99  08:02
 ;;8.0;KERNEL;**111**;Jul 10, 1995
 K ^TMP($J),XUSS,DIR S U="^" D NOW^%DTC S DT=X,XUSS=0
SORT ;
 S DIR(0)="SO^D:Device;S:Service/Section;U:User;V:Volume set",DIR("A")="Sort method",DIR("?")="Enter either 'D', 'S', 'U', or 'V' to indicate the report breakdown." D ^DIR G:$D(DIRUT) END S XUSORT=X,XUSNM=Y(0) K DIR
 S DIR(0)="SO^T:Taskman only;U:User only;B:Both",DIR("A")="Entry types" D ^DIR G:$D(DIRUT) END S XUSTSK=Y K DIR
 S DIR("A")="All  "_XUSNM_"s",DIR(0)="Y",DIR("B")="Y",DIR("?")="Enter either 'Y' or 'N'"
 S DIR("?",1)="You may run this report for all "_XUSNM_"s, or selected ones only.",DIR("?",2)="Note it will not reduce the report processing time to select ",DIR("?",3)="specific "_XUSNM_"s."
 D ^DIR K DIR G:$D(DIRUT) END G:Y=1 HRDA
SPSORT ;
 S DIC(0)="AEQMZ",DIC=$S(XUSORT="U":200,XUSORT="S":49,XUSORT="D":3.5,1:0),DIC("A")=$S(XUSORT="U":"Enter user name: ",XUSORT="S":"Enter Service/Section name: ",1:"Enter Device name: ")
 I DIC F XUI=1:1 D ^DIC Q:Y<0  S:XUSORT="U" ^TMP($J,0,$P(Y(0),U,1))=$P(Y,U,1) S XUSS($P(Y,U,1))="",XUSS=XUSS+1
 K DIC
 I XUSORT="V" S DIC="^XTV(8989.3,1,4,",DIC(0)="AEMQ" F XUI=1:1 D ^DIC Q:$D(DUOUT)!(Y'>0)  S XUSS($P(Y,U,2))="",XUSS=XUSS+1 W " OK, any others?"
 ;
HRDA S DIR(0)="S^H:Hourly;D:Daily",DIR("A")="Time interval",DIR("B")="D",DIR("?")="Enter either 'H' or  'D' to indicate whether you want to track by hour or day." D ^DIR K DIR G:$D(DIRUT) END S XUDH=Y
 ;
DATE S DIR(0)="D^:"_DT_":EX",DIR("B")="T-7" S:XUDH="H" DIR(0)=DIR(0)_"R",DIR("B")="T-1@0001" S DIR("A")="Enter a start date" D ^DIR K DIR G:$D(DIRUT) END S XUST=Y
 ;
TIMINT S DIR("A")="Enter a time interval in "_$S(XUDH="H":"hours (not to exceed  24)",1:"days"),DIR(0)="N;1:"_$S(XUDH="H":24,1:999),DIR("B")=$S(XUDH="H":24,1:7)
 S DIR("?")="Specify the number of "_$S(XUDH="H":"Hours",1:"days")_" you wish to track."
 D ^DIR K DIR G:$D(DIRUT) END S XUINT=X
 I XUDH="D" S X1=XUST,X2=X D C^%DTC S XUEN=X
 I XUDH="H" I XUINT>24 W !,*7,"Your time interval cannot exceed 24 hours !!" S XUINT=0 G TIMINT
 I XUDH="H" S XUEN=XUST+(X*.01) S XUI=$P(XUEN,".",2),XUI=XUI_$E("000",1,4-$L(XUI)) I XUI>2400 S X1=$P(XUST,".",1),X2=1 D C^%DTC S XUEN=X+(XUI-2400*.0001)
 S %ZIS="Q" D ^%ZIS G:POP END
QUE I '$D(IO("Q")) G GO
 F I="XUSS*","XUSORT","XUST","XUEN","XUDH","XUSTSK","^TMP($J,0," S ZTSAVE(I)=""
 S ZTRTN="XUSTAT1" D ^%ZTLOAD G END
GO K DIR,DIC,Y W !!,"Building .....",*7 G ^XUSTAT1
END K DIC,DIR,^TMP($J),XUST,XUEN,XUDH,X,Y,X1,X2,XUSS,XUI,XUINT,XUSNM,XUSORT,ZTSAVE
 K %H,D,DIRUT,XQM,XQPSM,XQTY,Y,Z,%,%T,XU1,XU2,XUDATE,XUDH,XUDT,XUDUZ,XUEN,XUEQ,XUHDR,XUI,XUINT,XULI,XUNAME,XUNODT,XUNOSER,XUOFF,XUON,XUPA,XUSER,XUSNM,XUSORT
 K XUSS,XUST,XUTIME,XUTREC,XUTTIME,XUTUSER,XUVAL,XUPA,XUCPU,XUDEV,XUNAME,XUREC,XUT1
 D ^%ZISC Q
