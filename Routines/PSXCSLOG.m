PSXCSLOG ;BIR/JMB-Checks for Active Cost Tasks Before Queuing/View Cost Task Log ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
CHECK ;Looks for jobs queued or running for same or overlapping date range.
 Q:'$D(^PSX(554,"ARUN"))  K PSXLOC S $P(PSXSLN,"-",80)=""
 F PSXSTA=-1:0 S PSXSTA=$O(^PSX(554,"ARUN",PSXSTA)) Q:PSXSTA=""  F PSXIEN=0:0 S PSXIEN=$O(^PSX(554,"ARUN",PSXSTA,PSXIEN)) Q:'PSXIEN  D
 .Q:'$D(^PSX(554,1,2,PSXIEN,0))
 .I PSXBDT'<$P(^PSX(554,1,2,PSXIEN,0),"^",3)&(PSXEDT'>$P(^PSX(554,1,2,PSXIEN,0),"^",4)) S PSXLOC(PSXIEN)="" Q
 .I PSXBDT'>$P(^PSX(554,1,2,PSXIEN,0),"^",3)&(PSXEDT'>$P(^PSX(554,1,2,PSXIEN,0),"^",4))&(PSXEDT'<$P(^PSX(554,1,2,PSXIEN,0),"^",3)) S PSXLOC(PSXIEN)="" Q
 .I PSXBDT'<$P(^PSX(554,1,2,PSXIEN,0),"^",3)&(PSXBDT'>$P(^PSX(554,1,2,PSXIEN,0),"^",4))&(PSXEDT'<$P(^PSX(554,1,2,PSXIEN,0),"^",4)) S PSXLOC(PSXIEN)="" Q
 .I PSXBDT'<$P(^PSX(554,1,2,PSXIEN,0),"^",3)&(PSXEDT'>$P(^PSX(554,1,2,PSXIEN,0),"^",4)) S PSXLOC(PSXIEN)="" Q
 .Q:+$G(PSXCOM)
 .S PSXBDTE=$E($P(^PSX(554,1,2,PSXIEN,0),"^",3),1,5),PSXEDTE=$E($P(^PSX(554,1,2,PSXIEN,0),"^",4),1,5)
 .I ($E(PSXBDT,1,5)'<PSXBDTE&($E(PSXBDT,1,5)'>PSXEDTE))!($E(PSXEDT,1,5)'<PSXBDTE&($E(PSXEDT,1,5)'>PSXEDTE)) S PSXLOC(PSXIEN)="" W !,"OH NO!"
 Q:'$O(PSXLOC(0))
 ;Error msg
 W !!,"Your task cannot be queued. The following active task(s) is for the same",!,"date range you have selected or for dates that overlap your date range.",!! S PSXERR=1,$P(PSXSLN,"-",57)=""
 W "Status   Activity  Data Date Range   Task#  Task Started",!,PSXSLN
 F PSXIEN=0:0 S PSXIEN=$O(PSXLOC(PSXIEN)) Q:'PSXIEN  D DISP
 Q
VIEW ;Displays cost entries in 554
 I '$O(^PSX(554,1,2,0)) W !!,"There are no cost entries in the CMOP OPERATIONS file." G EXIT
 S $P(PSXSLN,"-",80)="",(PSXOUT,PSXPAGE)=0,PSXFIRST=$O(^PSX(554,1,2,0)),PSXFIRST=$$FMTE^XLFDT($P($P($G(^PSX(554,1,2,PSXFIRST,0)),"^"),"."))
 F PSXIEN=0:0 S PSXIEN=$O(^PSX(554,1,2,PSXIEN)) Q:'PSXIEN  S PSXLAST=PSXIEN
 S PSXLAST=$$FMTE^XLFDT($P($P($G(^PSX(554,1,2,PSXLAST,0)),"^"),".")) D HD
 F PSXIEN=0:0 S PSXIEN=$O(^PSX(554,1,2,PSXIEN)) Q:'PSXIEN  D:$Y+3>IOSL HD D:'PSXOUT DISP Q:PSXOUT
EXIT K PSXBDT,PSXBY,PSXEDT,PSXEND,PSXFIRST,PSXIEN,PSXLAST,PSXNODE,PSXOUT,PSXPAGE,PSXSTART
 Q
DISP ;Displays one entry in cost task log.
 Q:'$D(^PSX(554,1,2,PSXIEN,0))  S PSXNODE=^(0)
 W !,$S('+$P(PSXNODE,"^",2):"Queued",+$P(PSXNODE,"^",2)=1:"Running",+$P(PSXNODE,"^",2)=2:"Complete",1:"Unknown")
 W ?10,$S($P(PSXNODE,"^",6)="C":"Compile",$P(PSXNODE,"^",6)="P":"Purge",1:"Unknown")
 S PSXBDT=$P(PSXNODE,"^",3),PSXEDT=$P(PSXNODE,"^",4)
 W ?18,$E(PSXBDT,4,5)_$S(+$E(PSXBDT,6,7):"/"_$E(PSXBDT,6,7),1:"")_"/"_$E(PSXBDT,2,3)_"-"_$E(PSXEDT,4,5)_$S(+$E(PSXEDT,6,7):"/"_$E(PSXEDT,6,7),1:"")_"/"_$E(PSXEDT,2,3),?36,$P(PSXNODE,"^",8)
 S PSXSTART=$P(PSXNODE,"^"),PSXEND=$P(PSXNODE,"^",7) W ?43,$E($P(PSXSTART,"."),4,5)_"/"_$E($P(PSXSTART,"."),6,7)_"/"_$E($P(PSXSTART,"."),2,3)_"@"_$E($P(PSXSTART,".",2),1,4)
 I $L($E($P(PSXSTART,".",2),1,4))<4 F PSXI=$L($E($P(PSXSTART,".",2),1,4)):1:3 W 0
 I +PSXEND W ?57,$E($P(PSXEND,"."),4,5)_"/"_$E($P(PSXEND,"."),6,7)_"/"_$E($P(PSXEND,"."),2,3)_"@"_$E($P(PSXEND,".",2),1,4) D
 .I $L($E($P(PSXEND,".",2),1,4))<4 F PSXI=$L($E($P(PSXEND,".",2),1,4)):1:3 W 0
 .W ?71,$$FMDIFF^XLFDT(PSXEND,PSXSTART,3)
 S PSXBY=$S(+$P(PSXNODE,"^",5):$P($G(^VA(200,+$P(PSXNODE,"^",5),0)),"^"),1:"UNKNOWN")
 W !?18,"Queued by: "_PSXBY,!
 Q
HD S PSXPAGE=PSXPAGE+1
 I PSXPAGE>1 K DIR S DIR(0)="E" D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSXOUT=1 Q
 W @IOF,!?11,"CONSOLIDATED MAIL OUTPATIENT PHARMACY COST ACTIVITY SUMMARY",!?23,"From "_PSXFIRST_" thru "_PSXLAST,!!
 W "Status   Activity Data Date Range   Task#  Task Started  Task Ended   Task Time",!,PSXSLN
 Q
