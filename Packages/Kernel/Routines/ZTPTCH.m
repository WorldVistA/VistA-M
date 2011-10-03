ZTPTCH ;557/THM,SFISC/RSD-DISPLAY PATCHES FOR SELECTED ROUTINES ;08/06/97  10:52
 ;;8.0;KERNEL;**44,65**;Jul 10, 1995
 N ZTSK,%ZIS,IOP
 K ^UTILITY($J)
 W !,"Display Patches for Selected Routines",!!
 X ^%ZOSF("RSEL") I '$D(^UTILITY($J)) W !!,*7,"No routines were selected.",!! H 2 G EXIT
 W !! S %ZIS="MQ" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="Installed Patch Listing",ZTRTN="TASK^ZTPTCH",ZTSAVE("^UTILITY($J,")="" D ^%ZTLOAD
 I $D(ZTSK) W !!,"Request queued.",!! G EXIT
 ;
TASK ;
 N CNT,CNTR,DATE,LINE,PNUM,PG,QUIT,RTN,UCI,X,Y,Z,Z1
 K ^TMP("ZTPTCH",$J)
 W:'$D(ZTQUEUED) !!,"Processing routines..."
 S RTN=0 F  S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""  D  W:'$D(ZTQUEUED) "."
 .S X=$T(+2^@RTN) Q:X=""  S Y=$P(X,"**",2)
 .F Z=1:1 S Z1=$P(Y,",",Z) Q:(Z1="")  S ^TMP("ZTPTCH",$J,Z1,RTN)=""
 ;
 S U="^" D NOW^%DTC S Y=% D DD^%ZTPP S DATE=Y
 X ^%ZOSF("UCI") S UCI=Y,$P(LINE,"-",IOM)=""
 S (CNT,CNTR,PG,QUIT)=0
 U IO D HDR S PNUM=""
 F  S PNUM=$O(^TMP("ZTPTCH",$J,PNUM)) Q:PNUM=""!QUIT  W !! S RTN="",Z1=0 F Z=2:1 S RTN=$O(^TMP("ZTPTCH",$J,PNUM,RTN)) Q:RTN=""  D  Q:QUIT
 .I Z1=0 W PNUM S CNT=CNT+1
 .W ?Z-1#8*10,RTN S CNTR=CNTR+1
 .I (Z#8)=0,$O(^TMP("ZTPTCH",$J,PNUM,RTN))]"" D:$Y>(IOSL-6) HDR S Z=1 W !?Z-1#8*10 ;end of line
 .I $Y>(IOSL-6),(Z#8)=0,$O(^TMP("ZTPTCH",$J,PNUM,RTN))]"" D HDR S Z=1 W !?Z-1#8*10 ;end of page, more of same patch
 .I $Y>(IOSL-6),$O(^TMP("ZTPTCH",$J,PNUM,RTN))="" D HDR S Z=1 W !?Z-1#8*10 ;end of page, no more on same patch.
 .S Z1=1
 .Q
 W !!?10,"Total Patches = ",CNT,"  Total Routines = ",CNTR
 I IOST?1"C-".E,'QUIT S X=$$RD(0)
EXIT K ^UTILITY($J),^TMP("ZTPTCH",$J)
 D ^%ZISC
 Q
RD(X) ;
 W !!,"Enter RETURN to "_$S(X:"continue or '^' to exit: ",1:"end: ")
 R X:300
 Q ($E(X)="^")
 ;
HDR I IOST?1"C-".E,PG'=0,'$D(ZTQUEUED),$$RD(1) S QUIT=1 Q
 W:PG>0 @IOF S PG=PG+1 W !,"Installed Patches for Selected Routines ",UCI,?(IOM-8),"Page: ",PG,!,?60,DATE,!
 W "Patch #",?9,"|",$E(LINE,1,29)," Routines ",$E(LINE,1,29),"|",!
 Q
