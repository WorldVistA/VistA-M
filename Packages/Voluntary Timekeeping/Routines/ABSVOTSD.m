ABSVOTSD ;VAMC ALTOONA/CTB_CLH - DELETE OCCASIONAL TIME SHEET ENTRIES ;6/6/94  3:27 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;;JULY 6, 1994
 D ^ABSVSITE Q:'%
 D NOW^ABSVQ S XDATE=X I +$E(X,4,5)=1 S XDATE=$E(X,1,3)-1_1200
 E  S MO=0_($E(X,4,5)-1),MO=$E(MO,$L(MO)-1,$L(MO)) S XDATE=$E(X,1,3)_MO_"00"
 S ABSVXA="This option will delete ALL entries in the Occasional Time Sheet File for the",ABSVXA(1)="month specified.  Do you wish to continue",ABSVXB="",%=1 D ^ABSVYN I %'=1 S X="  NO ACTION TAKEN" D MSG^ABSVQ G OUT
 W ! S %DT("A")="Select Month/Year to be deleted: ",%DT="AE" D ^%DT I Y<0 S X="  No month selected" D MSG^ABSVQ G OUT
 S Y=$E(Y,1,5)_"00" I Y'<XDATE W !,"You may not delete entries for: Last month, the current month or",!,"any future months using this option.",*7 G OUT
 S MONTH=Y D D^ABSVQ S FULLMON=Y I '$D(^ABS(503336,"AD",MONTH)) S X=" No entries in file for "_FULLMON_".*" W ! D MSG^ABSVQ G OUT
 S ABSVXA="Are you sure you want to delete all entries for "_Y_" for Station "_ABSV("SITE"),ABSVXB="",%=2 D ^ABSVYN I %'=1 S MSG="  Option terminated*" D MSG^ABSVQ G OUT
 S ZTRTN="DQ^ABSVOTSD",ZTDESC="DELETE VOLUNTARY TIME SHEET ENTRIES FOR "_FULLMON,ZTSAVE("MONTH")="",ZTSAVE("FULLMON")="",ZTSAVE("ABSV*")="" D ^ABSVQ
OUT K %DT,COUNT,DA,FULLMON,MO,MONTH,POP,X,XDATE,Y,ABSVXX Q
 ;
DQ ;ENTRY POINT FROM TASK MANAGER FOR DAILY RECORD DELETION
 D NOW^ABSVQ W "Beginning Deletion on ",ABSVXX
 S COUNT=0,DA=0 F I=1:1 S DA=$O(^ABS(503336,"AD",MONTH,DA)) Q:'DA  Q:$P(^ABS(503336,DA,0),"^",9)<3  I $D(^(0)),$P(^(0),"^",16)=MONTH,$P(^(0),"^",3)=ABSV("SITE") D DEL S COUNT=COUNT+1 W "."
 W !!,"FINISHED DELETION PASS FOR ",FULLMON,", FOR STATION ",ABSV("SITE"),".  ",!,COUNT," ENTRIES DELETED." D NOW^ABSVQ W !,"Deletion completed on ",ABSVXX
 I $D(ZTQUEUED) D KILL^%ZTLOAD
 D OUT
 QUIT
 ;
DEL ;DELETE SINGLE ENTRY IN FILE 503336
 K A,X S A=^ABS(503336,DA,0) I $D(ABSV("SITE"))'[0,$P(A,"^",3)'=ABSV("SITE") Q
 S X=$P(A,"^",1) I X]"" K ^ABS(503336,"B",$E(X,1,30),DA)
 S X=$P(A,"^",4) I X]"" K ^ABS(503336,"D",$E(X,1,30),DA)
 S X=$P(A,"^",8) I X]"" K ^ABS(503336,"AC",$E(X,1,30),DA)
 S X=$P(A,"^",9) I X]"" K ^ABS(503336,"AF",$E(X,1,30),DA)
 S X=$P(A,"^",14) I X]"" K ^ABS(503336,"C",$E(X,1,30),DA)
 S X=$P(A,"^",16) I X]"" K ^ABS(503336,"AD",$E(X,1,30),DA)
 K A,X,^ABS(503336,DA,0),^(2)
 L +^ABS(503336,0):15 Q:'$T
 S $P(^(0),"^",4)=$P(^ABS(503336,0),"^",4)-1
 L -^ABS(503336,0)
 QUIT
