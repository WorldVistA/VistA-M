LRNITEGL ;SLC/FHS - LOAD INTERGRITY FILE 69.91 ; 4/7/89  00:05 ;
 ;;5.2;LAB SERVICE;**153**;Sep 27, 1994
LOAD ;load routines into ^LAB(69.91,VNODE
 D STOP S LOAD=1 D VER^LRNITEG G STOP:Y<0
 S %ZIS="Q" D ^%ZIS G STOP:POP I $D(IO("Q")) S ZTRTN="QUE^LRNITEGL",ZTDESC="Loading LR INTEGRITY file #69.91 ",ZTIO=ION F I="LOAD","VNODE","VER","VERDAT" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD G STOP
 U IO
QUE ;
 S U="^",XLOAD=^%ZOSF("LOAD"),DIF="^TMP(""LRNITEG"""_","_$J_",",LROSYS=$S(^%ZOSF("OS")["M/VX"!(^%ZOSF("OS")["M/11")!(^%ZOSF("OS")["Open"):"^ROUTINE(ROU)",1:"^ (ROU)")
 S DA(1)=VNODE,DIE="^LAB(69.91,"_DA(1)_",""ROU"",",DIC(0)="L",DLAYGO=69 S:'$D(@(DIE_"0)")) @(DIE_"0)")="^69.911^^" S DA=$S($D(@(DIE_"0)")):+$P(^(0),U,3)+1,1:1) S CNT=$S(DA=1:1,1:+$P(@(DIE_"0)"),U,4)+1)
 S (DIC(0),ROU)="LR" F CNT=CNT:1 S ROU=$O(@LROSYS) Q:$E(ROU,1)'="L"  W !,ROU D GLB
 S $P(@(DIE_"0)"),U,3)=DA,CNT=CNT-1,$P(^(0),U,4)=CNT W !!,"TOTAL = ",CNT,@IOF S:$D(ZTQUEUED) ZTREQ="@" G STOP
GLB ; Stuff new routine in to global using auto load [if it doesn,t already exist] in global
 Q:$E(ROU,1,5)="LRINI"!($E(ROU,1,5)="LRLSI")
 K ER2,^TMP("LRNITEG",$J) S X=ROU,XCNP=0 X XLOAD I '$D(^TMP("LRNITEG",$J,2,0)) S CNT=CNT-1 W !?10,"ONLY ONE LINE IN ROUTINE ",! Q
 I $P(^TMP("LRNITEG",$J,2,0),";",4)'["LAB" S ER2=1 D ER2 S CNT=CNT-1 Q
 I $P(^TMP("LRNITEG",$J,2,0),";",3)'=VER D ER2 S CNT=CNT-1 Q
 I $D(@(DIE_"""B"","""_ROU_""")")) S CNT=CNT-1 Q
GLB1 I $D(@(DIE_DA_",0)")) S DA=DA+1 G GLB1
 K ^TMP("LRNITEG",$J) S DR=".01///^S X="""_ROU_""";" D ^DIE
 S $P(@(DIE_"0)"),U,3)=DA,$P(^(0),U,4)=CNT Q
STOP ; clean-up
 D ^%ZISC K DIC,DIE,%ZIS,ER2
 K A,BIT,CNT,DLAYGO,DIF,ER,I,II,IX,L,LN,LOAD,LROSYS,NT,ROU,SIZE,VER,VERDDT,VNODE,XBIT,XCMP,XCNP,XLOAD,XSIZE,XTEST,YBIT,^TMP("LRNITEG",$J) Q
ER2 ; Error msg when the version being loaded do not match the version selected for auto loading
 I $D(ER2) W !?10,ROU," WAS NOT LOADED",! K ER2 Q
 W !?10,ROU," is version ",$S($L($P(^TMP("LRNITEG",$J,2,0),";",3)):$P(^(0),";",3),1:"Unknown ")," NOT LOADED",$C(7),! Q
