%ZTBKC ;SF/GJL - GLOBAL BLOCK COUNT ;05/24/2007  686246.738699
 ;;7.3;TOOLKIT;**80**;Apr 25, 1995;Build 6
 ;
 ;X = FULL Global Reference: NAME(SUB1,...,SUBn)
 ;
 N %ZIS,DIRUT,DTOUT,DUOUT,POP
 S U="^",%BS="",XX1=0 K ^XUTL($J)
 I $P($G(^%ZOSF("OS")),"^")["OpenM-NT" N %ZTBKVER D  G QUIT:$G(%ZTBKVER)']""!$D(DUOUT)!$D(DIRUT)
 . S %ZTBKVER=$P($$VERSION^%ZOSV,".",1,2)
 . I %ZTBKVER="5.0"!(%ZTBKVER'<5.2) D ASKDIR^%ZTBKC1 Q
 . W !,"This version of the Block Count Utility does not support this version of Cache'"
 . S %ZTBKVER=""
READ W !!,"Block Count for Global ^" I %BS]"" W %BS,"//"
 R X:$S($D(DTIME):DTIME,1:300),! G:'$T!(X="^") QUIT I X="" S X=%BS
STRIP I (X?1"^".E)!(X?1" ".E) S X=$E(X,2,256) G STRIP
 I X="" G READY
 I X="*" S ZTBKCALL=1 G READY
 I X["*" W !,$C(7),"Wild cards not allowed as part of the global name." G SYNTAX
 I X?1"??".E D QQ G READ
 I X?1"?".E G SYNTAX
 I X?1"(".E S %BS="" G SYNTAX
 I $P(X,"(")'?.1"^".1"%"1A.AN W !,$C(7),"Only alphanumerics are allowed in global names." G SYNTAX
 I $L(X,"(")>1,$E(X,$L(X))'=")" G SYNTAX
 I $L(X,"(")>1,$P($E(X,1,$L(X)-1),"(",2,255)']"" G SYNTAX
 S %T=X,%Z=1 F %A=1:1 Q:$E(%T,%A)=""  I $E(%T,%A)="""" D QUOTES
 I %Z-1 G SYNTAX2
 S %BS=X,X=U_%T,Y=$D(@(U_%BS)) W $S(Y=0:" doesn't exist.",1:"OK") I Y S XX1=XX1+1,^XUTL($J,XX1)=%BS_X
 S %BS="" G READ
QUOTES I ((%Z=0)&($E(%T,%A+1)="""")) S %T=$E(%T,0,%A)_$E(%T,%A+2,999)
 E  S %T=$E(%T,0,%A-1)_$E(%T,%A+1,999),%A=%A-1,%Z=1-%Z
 Q
SYNTAX W !,"Enter: * for all globals in current directory, or"
 W !,"Enter: a FULL Global Reference, e.g. ^DD(3,""GL""), or"
 W !,"       ^ " W:%BS="" "or NULL " W "to quit."
 W !!,"Enter: ? for this help, or"
 W !,"       ?? for more help."
 G READ
SYNTAX2 W !,?5,"I'm sorry, but I don't understand your use of quotes."
 W !,"Please surround string subscripts with quotes and any quote"
 W !,"which is a part of the subscript should be doubled."
 G READ
QQ ;Double question mark response
 K DIR S DIR(0)="SO^S:Show current selection"
 S DIR(0)=DIR(0)_";D:De-select from current selection"
 S DIR(0)=DIR(0)_";M:More help"
 D ^DIR
 I Y="S" D SHOW G QQ
 I Y="D" D DSEL G QQ
 I Y="M" D XTNDHELP G QQ
 Q
SHOW ;Show current selection
 I '$D(IOF) D HOME^%ZIS
 I $O(^XUTL($J,0))'>0 D  Q
 . W !!,?20,"You have not selected any globals.",!
 . K DIR S DIR(0)="E" D ^DIR
 W @IOF,!,"You have selected the following globals:",!
 S %U="" F %I=1:1 S %A=$G(^XUTL($J,%I)) Q:%A=""  D
 .  W !,?8,"^"_$P(%A,U)
 K DIR S DIR(0)="E" D ^DIR
 Q
DSEL ;Ask directory
 N ZTBKCLST
 I $O(^XUTL($J,0))'>0 D  Q
 . W !!,?20,"You have not selected any globals.",!
 . K DIR S DIR(0)="E" D ^DIR
 K DIR S DIR("A",1)="To de-select from the selected globals:"
 S %U="" F %I=1:1 S %A=$G(^XUTL($J,%I)) Q:%A=""  D
 .  S DIR("A",%I+1)=$J("",3)_$J(%I,3)_$J("^",7)_$P(%A,U)
 .  S ZTBKCLST(%I)=%A
 S DIR("A")="Enter a list or a range of numbers: "
 S DIR(0)="L^"_"1:"_(%I-1)
 W ! D ^DIR
 Q:$D(DTOUT)!$D(DIRUT)
 W !
 F %I=1:1 S %A=$P(Y,",",%I) Q:%A']""  Q:(%A'=+%A)  K ZTBKCLST(%A) W "."
 S %A=$O(ZTBKCLST("")) I %A="" D  Q
 . F %I=0:0 S %I=$O(^XUTL($J,%I)) Q:%I'>0  Q:%I'=+%I  K ^XUTL($J,%I)
 . S XX1=0
 F %I=1:1 Q:%A']""&($G(^XUTL($J,%I))']"")  D
 . I %A]"" S ^XUTL($J,%I)=ZTBKCLST(%A),%A=$O(ZTBKCLST(%A))
 . E  K ^XUTL($J,%I)
 S XX1=$O(XUTL($J,"@"),-1) I XX1'=+XX1 S XX1=0
 Q
XTNDHELP ;Extended help
 I '$D(IOF) D HOME^%ZIS
 W @IOF,!,?35,"More Help",!
 W !,?10,"Globals that contain commas in subscripts may not produce accurate"
 W !,?10,"block counts.  Also, avoid specifying full global references"
 W !,?10,"that contain commas in the subscripts when entering globals"
 W !,?10,"at the 'Block Count for Global ^' prompt."
 W !,?10,""
 W !,?10,"After entering a double question mark ('??') response to the"
 W !,?10,"'Block Count for Global ^' prompt, enter 'S' for a listing"
 W !,?10,"of globals selected or 'D' to de-select globals from this list."
 W ! K DIR S DIR(0)="E" D ^DIR
 Q
READY I '$D(ZTBKCALL),$O(^XUTL($J,0))'>0 D  G QUIT
 . W !!,?20,"No globals have been selected!!!",!
 W !,"Output results on" S %ZIS="Q" D ^%ZIS G QUIT:POP
 I $D(IO("Q")) S ZTRTN=$S($D(ZTBKCALL):"ALL^%ZTBKC1",1:"DQ^%ZTBKC"),ZTDESC="Global block count",ZTSAVE("^XUTL($J,")="" D ^%ZTLOAD K ZTSK U IO(0) D ^%ZISC K ZTRTN,ZTDESC,ZTSAVE G QUIT
 I $D(ZTBKCALL) U IO D ALL^%ZTBKC1 U IO(0) D ^%ZISC G QUIT
DQ ;
 U IO F XX1=0:0 S XX1=$O(^XUTL($J,XX1)) Q:XX1'>0  S %T=^(XX1),%BS=$P(%T,U,1),X=$P(%T,U,2) W !,"Global ^",%BS D ENCOUNT W $S(X'>0:" doesn't exist",1:" has "_X_" data block") W:X>1 "s"
QUIT U:$D(IO(0))#2 IO(0) D ^%ZISC K DIR,X,XX1,Y,ZTBKCALL,%A,%I,%T,%U,%Z,%BS I $D(ZTQUEUED) S ZTREQ="@"
 Q
ALL ;All Globals in Directory
 S %A=$P(^%ZOSF("OS"),"^",1)
 D ALL^%ZTBKC1 G ALLEXIT
 ;I %A="DSM-3" D ALL^%ZTBKC1 G ALLEXIT
 ;I %A="M/11" D ALLM11 G ALLEXIT
 ;I %A="M/11+" D ALL^%ZTBKC1 G ALLEXIT
 ;I %A="M/VX" D ALL^%ZTBKC1 G ALLEXIT
 ;I %A["MSM" D ALL^%ZTBKC1 G ALLEXIT
 ;I %A["VAX DSM" G ALL^%ZTBKC1
ALLEXIT K %A
 Q
ALLM11 ;Directory at
 W $C(7),"  NOT AVAILABLE!!!!"
 Q
ENCOUNT ;  X = Full Global Reference: NAME(SUB1,...,SUBn)
 ;  Surrounding/doubled quotes should have been removed from subscripts
 ;  The count is not accurate for subscripts containing commas
 S %T=-1,%A=$P(^%ZOSF("OS"),"^") I X?1"^".E S X=$E(X,2,255)
 D ^%ZTBKC1
 ;I "^MSM-UNIX^MSM-PC^VAX DSM(V5)^DSM-3^M/11^M/11+^M/VX^"[("^"_%A_"^") D ^%ZTBKC1
EXIT S X=%T K %A,%T
 Q
