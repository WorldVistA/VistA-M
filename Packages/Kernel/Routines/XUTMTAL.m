XUTMTAL ;SEA/RDS - TaskMan: ToolKit, Select List ;06/27/94  14:01
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
START G SELECT
 ;
SETUP ;SELECT--Setup Reader Input Parameters
 S DIR(0)="FAO^^D XFORM^XUTMTAL"
 S DIR("A")=$S($D(XUTMT("A"))#2:XUTMT("A"),1:"Select TASK: ")
 S DIR("?")=$S($D(XUTMT("?"))#2:XUTMT("?"),1:"^D HELP1^XUTMTAL")
 S DIR("??")=$S($D(XUTMT("??"))#2:XUTMT("??"),1:"^D ^XUTMQ")
 I DIR("??")="@" K DIR("??")
 I $D(XUTMT("B"))#2 S DIR("B")=XUTMT("B")
 I $D(DTIME)[0 S DIR("T")=60
 Q
 ;
XFORM ;SELECT--Input Transform
 N ZT,ZT1,ZT2,ZT3,ZT4,ZTIGNORE,ZTOUT,ZTYPE
 K ^TMP($J,"XUTMT") S ZTOUT=0
 I $D(XUTMT("S1"))#2 X XUTMT("S1") I ZTOUT Q
 S ZTIGNORE=0,ZTYPE=$L(X,",")>1!(X["-")
 F ZT=1:1:$L(X,",") S ZT1=$P(X,",",ZT) D ELEMNT
 S ZT1="",ZT3="" F ZT=0:0 S ZT1=$O(^TMP($J,"XUTMT",ZT1)),ZT2="" Q:ZT1=""  S:$D(^(ZT1))=1 ZT3=ZT3_","_ZT1 I $D(^(ZT1))=10 F ZT=0:0 S ZT2=$O(^TMP($J,"XUTMT",ZT1,ZT2)) Q:ZT2=""  S ZT3=ZT3_","_ZT2_"-"_ZT1
 I ZT3'["-",ZT3'["," K ^TMP($J,"XUTMT")
 I ZT3="",'ZTYPE W !!?5,"That is not a valid task number." K X Q
 I ZT3="" W !!?5,"That is not a valid list of task numbers." K X Q
 I ZTIGNORE W !?5,"(Irregular list elements ignored)"
 S Y=$E(ZT3,2,$L(ZT3))
 I $D(XUTMT("S2"))#2 X XUTMT("S2") I '$D(X) K Y,^TMP($J,"XUTMT")
 Q
 ;
ELEMNT ;XFORM--process each element in the list
 S ZT2=ZT1
 I ZT1["-" S ZT1=+ZT1,ZT2=$P(ZT2,"-",2)
 I $S(ZT1=0:1,ZT2=0:1,ZT1'?1N.N:1,1:ZT2'?1N.N) S ZTIGNORE=1 Q
 I ZT1>ZT2 S ZT3=ZT1,ZT1=ZT2,ZT2=ZT3
 D ADDTR
 Q
 ;
ADDTR ;XFORM--Add Task Range To Compression List
 S ZT3=$O(^TMP($J,"XUTMT",ZT1-2)) I ZT3]"",ZT3<ZT2 S:$D(^(ZT3))=1&(ZT1-1=ZT3) ZT1=ZT3 I $D(^(ZT3))>9 S ZT4=$O(^(ZT3,"")) I ZT4<ZT1 S ZT1=ZT4
 S ZT3=$O(^TMP($J,"XUTMT",ZT2-1)) I ZT3]"" S:$D(^(ZT3))=1&(ZT2+1=ZT3) ZT2=ZT3 I $D(^(ZT3))>9 S ZT4=$O(^(ZT3,"")) I ZT4'>(ZT2+1) S ZT2=ZT3
 S ZT3=ZT1-1 F ZT4=0:0 S ZT3=$O(^TMP($J,"XUTMT",ZT3)) Q:ZT3=""!(ZT3>ZT2)  K ^TMP($J,"XUTMT",ZT3)
 S:ZT1'=ZT2 ^TMP($J,"XUTMT",ZT2,ZT1)="" S:ZT1=ZT2 ^TMP($J,"XUTMT",ZT1)="" Q
 ;
HELP1 ;SELECT--Default Help For '?'
 W !!?5,"Answer must be the internal number(s) of the task(s) to be selected."
 W !!?5,"Answer must be an integer between 1 and 999999999."
 W !?5,"Answer may be a range, for example 4000-5000."
 W !?5,"Answer may be a list, for example 4001,4004,4010-4020."
 Q
 ;
SELECT ;Main Section--Select Task
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,ZT
 D SETUP,^DIR K DIR
 I $D(DTOUT) W "     ** TIME-OUT **",$C(7)
 I $D(DUOUT) W "     ** ^-ESCAPE **"
 K XUTMT,ZTSK S ZTSK=$S(U[Y:"",1:Y) Q
 ;
