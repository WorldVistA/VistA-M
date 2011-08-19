OOPSLOG ;HINES CIOFO/GB-Log of Federal Occupational Injuries and Illnesses ;8/15/96
 ;;2.0;ASISTS;;Jun 03, 2002
 N CN,CL,DA,DASHES,DATE,EX,FCILL,FCINJ,FCINJILL,FYR,FY,HDR,HDR1,HDR2
 N HDRFLG,ILL,INC,INJ,INJILL,LIN,LP1,LTILL,LTINJ,LTINJILL,LYR,OUT,PG,STA
 N RANGE
SDED N DIR,DIRUT,DUOUT,X,Y,SD,ED,SDT,EDT
 S DIR(0)="D^2981001:DT:EX"
 S DIR("A")="Starting Date for the Report"
 S DIR("?")="Select a Starting Date from the range displayed."
 D ^DIR
 G:$D(DIRUT) EXIT
 S SD=Y,SDT=Y(0)
 K DIR,DIRUT,DUOUT,X,Y S DIR(0)="D^2981001:DT:EX"
 S DIR("A")="Ending Date for the Report"
 S DIR("?")="Select a Ending Date from the range displayed"
 D ^DIR
 G:$D(DIRUT) EXIT
 S ED=Y,EDT=Y(0)
 I $$FMDIFF^XLFDT(ED,SD,1)'>0 W !?5,"The Ending Date cannot be before or on the Starting Date, please re-enter this data." G SDED
 S RANGE="for Period "_SDT_" - "_EDT
 I $D(EV) S INC=0,HDR1="Employees and volunteers only" G PREDEV
 K DIR S DIR(0)="SA^E/V:Employees and volunteers only;A:All cases",DIR("A")="Cases to be included: " D ^DIR K DIR
 G:$D(DIRUT) EXIT
 S EV=Y
 K DIR S DIR(0)="Y",DIR("A")="Include names of persons involved",DIR("B")="Yes" D ^DIR K DIR
 G:$D(DIRUT) EXIT
 S INC=Y
 ; Patch 5 -Get Station Number
PREDEV S OUT=""
 D STATION(.STA,.OUT)
 G:$D(DIRUT)!(OUT) EXIT
DEV K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP EXIT
 I $D(IO("Q")) D TASK G EXIT
 U IO D PRT D ^%ZISC K %ZIS,IOP G EXIT
PRT S PG=0
 S (INJ,ILL,FCINJ,FCILL,LTINJ,LTILL)=0
 S EX="",LIN=$S(IOST?1"C".E:IOSL-4,1:IOSL-5)  ; was 5 and 6
 K DASHES S $P(DASHES,"-",80)="-"
 D NOW^%DTC S DATE=%,Y=DATE X ^DD("DD") S DATE=Y
 S HDR=$S($G(NS):"Log of Needlestick Incidents ",1:"Log of Federal Occupational Injuries and Illnesses ")
 S HDR1=$S(EV="E/V":"Employees and volunteers only",1:"All cases")
 ; Patch 5 - change for Station Number looping
 S LP1=""
 I STA="A" D  G EXIT
 . F  S LP1=$O(^OOPS(2260,"D",LP1)) Q:LP1=""!(EX=U)  S HDRFLG=0 D
 .. S DA=0 F  S DA=$O(^OOPS(2260,"D",LP1,DA)) D:DA="" LOGSUM Q:DA=""!(EX=U)  D DATA
 I STA'="A" D  G EXIT
 . S LP1=STA,HDRFLG=0
 . S DA=0 F  S DA=$O(^OOPS(2260,"D",LP1,DA)) D:DA="" LOGSUM Q:DA=""!(EX=U)  D DATA
EXIT ; Clean up and exit
 K POP,X,Y,%,NS,EV
 Q
DATA ;
 N CASE,OOPS,YR,DIC,DIQ,DR,CD
 S CASE=$$GET1^DIQ(2260,DA,.01)
 S YR=$E(CASE,1,4)
 S CD=($P(^OOPS(2260,DA,0),"^",5))\1
 I ($$FMDIFF^XLFDT(CD,SD,1)<0)!($$FMDIFF^XLFDT(CD,ED,1)>0) Q 
 K OOPS
 S DIC="^OOPS(2260,"
 S DR=".01;2;3;4;1;15;14;29;30;33;37;51;52;82;83;84;85;86"
 S DIQ="OOPS",DIQ(0)="IE" D EN^DIQ1
 I $G(NS),OOPS(2260,DA,3,"I")<11 Q
 I EV="E/V","1,2,6,"'[OOPS(2260,DA,2,"I")_"," Q
 Q:OOPS(2260,DA,51,"E")="Deleted"
 Q:OOPS(2260,DA,51,"E")="Replaced by amendment"
 ; Patch 9 fix summary logic
 I OOPS(2260,DA,52,"E")="Injury" S INJ=INJ+1 D
 . S:OOPS(2260,DA,29,"E")="Death" FCINJ=FCINJ+1
 . S:OOPS(2260,DA,33,"E")="Yes" LTINJ=LTINJ+1
 I OOPS(2260,DA,52,"E")="Illness/disease" S ILL=ILL+1 D
 . S:OOPS(2260,DA,29,"E")="Death" FCILL=FCILL+1
 . S:OOPS(2260,DA,33,"E")="Yes" LTILL=LTILL+1
 S:INC=0 OOPS(2260,DA,1,"E")="",OOPS(2260,DA,15,"E")="",OOPS(2260,DA,14,"E")=""
 I 'HDRFLG D HDR S HDRFLG=1
 W !,CASE,?12,$P(OOPS(2260,DA,4,"E"),"@",1),?26,OOPS(2260,DA,1,"E")
 W ?58,OOPS(2260,DA,15,"E"),?64,$E(OOPS(2260,DA,14,"E"),1,4)
 W ?70,OOPS(2260,DA,33,"E") D P Q:EX=U 
 W !,$E(OOPS(2260,DA,52,"E"),1,7),?12,$E(OOPS(2260,DA,51,"E"),1,12)
 W ?26,OOPS(2260,DA,3,"E") D P Q:EX=U
 I OOPS(2260,DA,86,"I")'="" W ?58,$E($$GET1^DIQ(49,OOPS(2260,DA,86,"I"),.01),1,22) D P Q:EX=U
 W !,$E(OOPS(2260,DA,29,"E"),1,35),?58,$E(OOPS(2260,DA,30,"E"),1,21) D P Q:EX=U
 ; patch 11 - if NS then print new prompts
 I $G(NS) D  Q:EX=U
 . W ! I $G(OOPS(2260,DA,37,"I"))'="" W $$GET1^DIQ(2261.6,OOPS(2260,DA,37,"I"),.01) D P Q:EX=U
 . ; patch 11 v3 08/03/01
 . W !,$$GET1^DIQ(2260,DA,"38:.01") D P Q:EX=U
 . W !,$$GET1^DIQ(2260,DA,"82:.01") D P Q:EX=U
 . W !,$$GET1^DIQ(2260,DA,108) D P Q:EX=U
 . S OPFLD=28 D WP K OPFLD
 W !,DASHES
 Q
LOGSUM ;Log Summary
 Q:EX=U
 ; Patch 9 - if nothing to summarize, don't print
 I 'INJ&('ILL)&('FCINJ)&('FCILL)&('LTINJ)&('LTILL) Q
 I IOST?1"C".E,$Y>14 D  Q:EX=U
 .W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .W @IOF S PG=PG+1
 .W !,HDR,?72,"Page",$S($L(PG)=2:" ",1:"  "),PG
 .W !?(40-($L(RANGE)/2)),RANGE
 .W !,DASHES
 W !,"Log Summary" D P Q:EX=U
 W !,DASHES D P Q:EX=U
 W !,"Injuries.: ",$J(INJ,3),?16,"Fatal Injuries....: ",$J(FCINJ,3)
 W ?41,"Lost Time Injuries....: ",$J(LTINJ,3) D P Q:EX=U
 W !,"Illnesses: ",$J(ILL,3),?16,"Fatal Illnesses...: ",$J(FCILL,3)
 W ?41,"Lost Time Illnesses...: ",$J(LTILL,3) D P Q:EX=U
 W !,"--------------",?16,"-----------------------",?41,"---------------------------" D P Q:EX=U
 S INJILL=INJ+ILL,FCINJILL=FCINJ+FCILL,LTINJILL=LTINJ+LTILL
 W !,"Total....: ",$J(INJILL,3),?16,"Total.............: ",$J(FCINJILL,3)
 W ?41,"Total.................: ",$J(LTINJILL,3)
 W !,DASHES
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 S (INJ,FCINJ,LTINJ,ILL,FCILL,LTILL,INJILL,FCINJILL,LTINJILL)=0
 Q
P ;Display Data
 I $Y'<LIN D  Q:EX=U
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HDR
 Q
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRT^OOPSLOG",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Log of Federal Occupational Injuries and Illnesses"
 S ZTSAVE("FY")="",ZTSAVE("INC")="",ZTSAVE("NS")="",ZTSAVE("EV")=""
 ; Patch 5 - added STA
 S ZTSAVE("STA")=""
 ; Patch 11 - Added date Ranges
 S ZTSAVE("SD")="",ZTSAVE("SDT")="",ZTSAVE("ED")="",ZTSAVE("EDT")=""
 ; patch 11 v3 8/2/01 add new variables
 S ZTSAVE("RANGE")="",ZTSAVE("HDR")="",ZTSAVE("HDR1")=""
 S ZTSAVE("HDR2")=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K ZTSK Q
HDR ;Header
 S HDR2="Station Name: "_$$GET1^DIQ(4,LP1,.01,"E")
 W @IOF S PG=PG+1
 W !?(40-($L(HDR)/2)),HDR,?72,"Page",$S($L(PG)=2:" ",1:"  "),PG
 W !?(40-($L(RANGE)/2)),RANGE
 W !?(40-($L(HDR1)/2)),HDR1,!?(40-($L(HDR2)/2)),HDR2,!
 W:INC=1 !,"Case #",?12,"Date",?26,"Name",?58,"Occ",?64,"CC",?69,"Lost Time"
 W:INC=0 !,"Case #",?12,"Date",?69,"Lost Time"
 W !,"Inj/Ill",?12,"Status",?26,"Type of Incident",?58,"Service"
 W !,"Char. of Injury",?58,"Body Part Affected"
 I $G(NS) D
 . W !,"Activity at time of Injury"
 . ; Patch 11 v3 08/02/01
 . W !,"Object Causing Injury"
 . W !,"Model and Brand of Object Causing Injury"
 . W !,"Location of Injury"
 . ; W !,"Description of Injury"
 W !,DASHES
 Q
STATION(STA,OUT) ; Get 'ALL' or one station
 S STA=""
 N DIC,DIR,DIRUT,Y
 S DIR(0)="Y",DIR("A")="Run report for 'ALL' Stations",DIR("B")="Yes"
 S DIR("?")="Enter 'Y'es to run for all Stations or 'N'o to run "
 S DIR("?")=DIR("?")_"for just one Station."
 D ^DIR I Y S STA="A" Q
 I $D(DIRUT)!($D(DUOUT)) S OUT=1 Q
S1 ; if get here user <CR>
 S DIC("A")="Select STATION NUMBER: "
 S DIC="^DIC(4,",DIC(0)="AEMQZ"
 D ^DIC
 I $D(DUOUT) S OUT=1 Q
 I Y=-1 W !?5,"No Station selected, report will not run" S OUT=1 Q
 S STA=+Y
 I '$D(^OOPS(2260,"D",STA)) W !?5,"No data for that Station Number, Please select again." G S1
 Q
WP ;Process Word Processing Fields
 N DIWL,DIWR,DIWF,OPGLB,OPI,OPNODE,OPT,OPC
 K ^UTILITY($J,"W")
 S DIWL=1,DIWR="",DIWF="|C76"
 S OPNODE=$P($$GET1^DID(2260,OPFLD,"","GLOBAL SUBSCRIPT LOCATION"),";")
 S OPI=0 F  S OPI=$O(^OOPS(2260,DA,OPNODE,OPI)) Q:'OPI  S X=$G(^OOPS(2260,DA,OPNODE,OPI,0)) D:X]"" ^DIWP
 S OPT=$G(^UTILITY($J,"W",1))+0
 I OPT D
 . W !,"Description of Injury:"
 . S OPI=0 F OPC=1:1 S OPI=$O(^UTILITY($J,"W",1,OPI)) Q:'OPI!(EX=U)  D
 .. W !?2,^UTILITY($J,"W",1,OPI,0) D P Q:EX=U
 K ^UTILITY($J,"W"),X
 Q
