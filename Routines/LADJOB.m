LADJOB ;SLC/DLG - JOB DIRECT CONNECTED AUTOMATED LAB ROUTINES ;6/25/90  13:46
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
INST S U="^" W !,"This is an option to start/restart direct connected automated Lab routines. " D STATUS
 S DIC=62.4,DIC(0)="AEMQ",DIC("S")="I Y<99,(Y#10'=1)" D ^DIC K DIC I Y<1 W !,"NO JOB SELECTED",! G END
 S LRJOB="^"_$P(^LAB(62.4,+Y,0),U,3),LRJOBN=+Y,ZTIO=""
 S (LRJOBIO,X)=$S($D(^LAB(62.4,LRJOBN,0)):$P(^(0),U,2),1:"") G END:X']""
 S IOP=X,%ZIS="NQ" D ^%ZIS I POP W !!?7,$C(7),"CAN'T OPEN "_X_" DEVICE" G END
 I ^%ZOSF("VOL")'=$P(^%ZIS(1,IOS,0),U,9),$P(^(0),U,9)]"" G RONG
A W !!!,"System status will tell you if the direct connect routine is running.",!,"Look for the name of the routine ",$P(LRJOB,U,2)," in the system status.",!!
 X $S($D(^%ZOSF("SY")):^("SY"),1:^%ZOSF("SS")) D ^LRPARAM
 W !,"Is the routine name ",$P(LRJOB,U,2)," listed in the system status?" S %=2 D YN^DICN I %=1 W !,"You do not want to start a job that is running!!",$C(7) G END
 W !,"Do you want to start the direct connect ",LRJOB," routine now?" S %=1 D YN^DICN G END:%'=1
 I LRJOBN#10>1 S T=LRJOBN,ZTIO=LRJOBIO D SET^LAB
JOB I '$D(^LA(LRJOBN,"I")) W !!,$C(7),"There is no data in that file to be processed!!!  JOB NOT STARTED!!!",$C(7) G END
 K ^LA("LOCK",LRJOBN) S ZTDESC="Direct Connect Instrument",ZTRTN=LRJOB,ZTDTH=$H D ^%ZTLOAD K ZTSK,ZTRTN,LRJOB,ZTDTH W !,"Check system status to see if job started."
 H 5 W "." H 5 X $S($D(^%ZOSF("SS")):^("SS"),1:^%ZOSF("SY")) D ^LRPARAM
END K I,LRPGM,LRTIME,LRIO,Y,DIC,LRJOB,LRJOBN,% Q
RONG W !!,$C(7),"The job selected is not interfaced to this computer",!! G END
STATUS ;DISPLAY LSI STATUS.
 W !! D DASH W !,?18,"DIRECT CONNECT AUTOINSTRUMENT INTERFACE STATUS",! D DASH
 W !,?6,"INST.",?18,"DATA",?25,"DATA",?34,"++ PROGRAM STATUS LINK +++",?67,"DEVICE"
 W !,?1," #",?6,"NAME",?18,"IN LA?",?25,"IN LAH?",?34,"NAME",?44,"ACTIVE",?52,"BY",?58,"TO",?67,"NAME"
 D DASH F IX=0:0 S IX=$O(^LAB(62.4,IX)) Q:IX<1!(IX>99)  I IX#10>1,($P(^LAB(62.4,IX,0),U,2)]"") D STA2
 W !! K IX Q
STA2 S X=$S($D(^LAB(62.4,IX,0)):^(0),1:"") W !,?1,$J(IX,2),?6,$E($P(X,"^",1),1,10),?18,$S($D(^LA(IX,"I")):"Yes",1:"No"),?25,$S($D(^LAH(+$P(X,"^",4))):"Yes",1:"No")
 W ?34,$P(X,"^",3),?44,$S($D(^LA("LOCK",IX)):"Yes",1:"No"),?52,$E($P(X,"^",7),1,3),?58 S Y=$P(X,"^",6) W $S(Y["LOG":"Acc.",Y["SEQN":"Seq.",Y["IDEN":"Invoice",Y["LLIST":"T/C",1:"")
 W ?67,$E($P(X,"^",2),1,10) Q
DASH S X="",$P(X,"-",79)="" W !,X Q
