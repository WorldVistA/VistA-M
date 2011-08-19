ZTMCHK1 ;SEA/RDS-Taskman: Option, ZTMCHECK, Part 2 ;5/31/07  12:13
 ;;8.0;KERNEL;**127,446**;Jul 10, 1995;Build 35
 ;
LINKS ;Check Required Volume Sets' Links
 W !!,"Checking the links to the required volume sets..."
 S (ZTJ,ZTV)=0
 F  S ZTV=$O(^%ZIS(14.5,ZTV)) Q:'ZTV  S ZTS=$P(^(ZTV,0),U) I $P(^(0),U,5)="Y",ZTS'=ZTVOL D LK
 I 'ZTJ W !?5,"There are no volume sets whose links are required!"
 W !!,"Checks completed...Taskman's environment is okay!"
 ;
EOP ;Pause at end of page
 W ! S Y="" F ZT=0:0 R !,"Press RETURN to continue or '^' to exit: ",Y:$S($D(DTIME)#2:DTIME,1:60) S:'$T DTOUT="" S:Y="^" DUOUT="" Q:Y=""!(Y="^")  W !!,"Enter either RETURN or '^'",! W:Y'["?" $C(7)
 I $D(DUOUT)!$D(DTOUT) W:$D(DTOUT) $C(7) G EXIT
 ;
INFO ;Display Task Manager's Information
 W @IOF,!!,"Here is the information that Taskman is using:"
 W !?5,"Operating System:  ",$P(ZTOS,U)
 W !?5,"Volume Set:  ",ZTVOL
 W !?5,"Cpu-volume Pair:  ",ZTPAIR
 W !?5,"TaskMan Files UCI and Volume Set:  ",$P(ZTVSS,U,6),"," S X=$P(ZTVSS,U,7) W $S(X="":ZTVOL,$D(^%ZIS(14.5,X,0))[0:ZTVOL,$P(^(0),U)="":ZTVOL,1:$P(^(0),U)) K X
 W !!?5,"Log Tasks?  ",$P(ZTPS,U,3)
 ;W !?5,"Default Task Priority: ",ZTPT ;p446
 I ZTOS["DSM"&(ZTOS'["VAX"),ZTSIZ]"" W !?5,"Task Partition Size: ",ZTSIZ
 W !?5,"Submanager Retention Time: ",ZTRET
 W !?5,"Min Submanager Count: ",$P(ZTPS,U,12)
 W !?5,"Taskman Hang Between New Jobs: ",ZTSLO
 W !?5,"TaskMan running as a type: ",$P("^COMPUTE^PRINT^GENERAL^","^",$F("CPG",$P(ZTPS,U,9)))
 I $P(ZTPS,U,10)]"" W !?5,"TaskMan is using VAX enviroment: ",$P(ZTPS,U,10) ;p446
 I $G(^%ZIS(14.7,+ZTPN,2))]"" D
 . W !?5,"TaskMan is using '",^(2),"' for load balancing"
 . W !?5,"Balance Interval: ",$P(ZTPS,U,14) ;p446
 . Q
 ;
STATUS ;Display Task Manager's Status-Related Information
 W !!?5,"Logons Inhibited?:  ",ZTVLI
 W !?5,"Taskman Job Limit:  ",ZTVMJ
 I $D(^XTV(8989.3,0)) S %=$O(^XTV(8989.3,1,4,"B",ZTVOL,0)) W !?5,"Max sign-ons: ",$P($G(^XTV(8989.3,1,4,+%,0)),U,3)
 X ^%ZOSF("ACTJ") W !?5,"Current number of active jobs: ",Y
 ;
DONE ;Prompt To Continue And Quit
 W ! R !,"End of listing.  Press RETURN to continue: ",Y:$S($D(DTIME)#2:DTIME,1:60) S:'$T DTOUT="" S:Y="^" DUOUT=""
EXIT Q
 ;
MGR ;LINKS--lookup name of another volume set's library uci
 S Y=ZTX I Y]"" S Y=$O(^%ZIS(14.5,"B",Y,""))
 I Y]"" S Y=$S($D(^%ZIS(14.5,Y,0))#2:$P(^(0),U,6),1:"")
 I Y="" S Y=$P($P(^%ZIS(14.5,ZTVSN,0),U,6),",")
 Q
 ;
LK ;Check one link
 N $ES,$ET S $ET="D ERLINKS^ZTMCHK1"
 S ZTJ=ZTJ+1,ZTX=ZTS D MGR S ZTX=$D(^[Y,ZTS]%ZOSF("PROD")) W !?5,"The link to volume set ",ZTS," is present!"
 Q
 ;
ERLINKS ;Error Trap For LINKS Code
 W !?5,"The link to volume set ",ZTS," appears to be down!",$C(7)
 S $EC=""
 Q
 ;
