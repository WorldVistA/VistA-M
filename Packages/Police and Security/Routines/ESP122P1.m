ESP122P1 ;ALB/JAP; POST-INSTALL FOR ES*1 cont.*22;3/98
 ;;1.0;POLICE & SECURITY;**22,28**;Mar 31, 1994
 ;
EN ;setup for print of conversion reports
 N ESPC,ESPU,DIR,DIRUT,DTOUT,DUOUT,X,Y,PAGE,POP,ZTRTN,ZTDESC,ZTSK,ZTREQ
 S (ESPC,ESPU)=0
 S DIR(0)="S^C:Converted;U:User Input Needed;B:Both"
 S DIR("A")="Type of report to print: ",DIR("B")="B"
 D ^DIR K DIR W !! Q:$G(DIRUT)
 S:"Cc"[Y ESPC=1 S:"Uu"[Y ESPU=1 S:"Bb"[Y (ESPC,ESPU)=1
 S %ZIS="Q" D ^%ZIS
 I POP D  Q
 .W !,"No device selected...exiting.",!
 I $D(IO("Q")) D  Q
 .S ZTRTN="PRINT^ESP122P1",ZTDESC="Print ES*1*22 Conversion Report",ZTREQ="@"
 .S ZTSAVE("ESPC")="",ZTSAVE("ESPU")=""
 .D ^%ZTLOAD
 .I $G(ZTSK)>0 D  Q
 ..W !,"Request queued as Task #",ZTSK,".",!
 .I '$G(ZTSK) D
 ..W !,"Request to queue cancelled...exiting.",!
 ..S POP=1
 S PAGE=0 K ESPUSER,ESPDATE D PRINT
 Q
 ;
PRINT ;print reports
 N LN,RUNDT,PAGE,E S E=0
 U IO
 S $P(LN,"=",80)=""
 D NOW^%DTC S Y=$E(%,1,12),RUNDT=$$FMTE^XLFDT(Y,1)
 I ESPC S PAGE=0 D CONV I 'E,'ESPU,$E(IOST)="C" D EOR
 I 'E,ESPU S PAGE=0 D USER I 'E,$E(IOST)="C" D EOR
 D ^%ZISC
 U 0
 Q
EOR ;Pause at end of report.
 ;  The following two lines were added to prevent the report from
 ;  hanging on the screen.  -  VAD - 09/23/1999.
 D ^%ZISC
 U 0
 ;
 N SS,JJ,DIR
 S SS=22-$Y F JJ=1:1:SS W !
 S DIR(0)="E",DIR("A")="Press ANY Key to Exit" D ^DIR S E=$D(DIRUT)
 Q
 ;
CONV ;converted report
 ;^XTMP("ESP","CONV",ESIEN,ESN)=old subtype^new subtype^user^date/time
 N FLAG,ESIEN,ESN,ESOLD,ESOLDNM,ESLAST,ESLSTNM,ESNEW,ESL,ESPDTR,ESUSER,ESCNVDT,ESPPREV,NN,X,Y,DIC,DR,DA,DIQ
 D HDRC Q:E  S ESIEN=0
 I '$D(^XTMP("ESP","CONV")) D  Q
 .W !!,"There is no data in ^XTMP(""ESP"",""CONV"", to print."
 F  S ESIEN=$O(^XTMP("ESP","CONV",ESIEN)) Q:ESIEN=""  D  Q:E
 .D:$Y+6>IOSL HDRC I E Q
 .S ESPDTR=$P($G(^ESP(912,ESIEN,0)),U,2) Q:ESPDTR=""
 .W !!!,"File #912 ien: ",ESIEN
 .W ?45,"UOR# ",$E(ESPDTR,2,3),"-",$E(ESPDTR,4,5),"-",$E(ESPDTR,6,7),"-",$TR($E($P(ESPDTR,".",2)_"ZZZZ",1,4),"Z",0)
 .K ^UTILITY("DIQ1",$J)
 .S DIC="^ESP(912,",DA=ESIEN,DR=".02;.03;.04;.06;.08;5.02;5.05;5.06;6.01;6.02",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912,DA))
 .W !,"DATE/TIME RECEIVED: ",$G(^UTILITY("DIQ1",$J,912,DA,.02,"E"))
 .W !,"DATE/TIME OF OFFENSE: ",$G(^UTILITY("DIQ1",$J,912,DA,.03,"E"))
 .D:$Y+4>IOSL HDRC I E Q
 .W !,"LOCATION: ",$G(^UTILITY("DIQ1",$J,912,DA,.04,"E"))
 .W !,"INVESTIGATING OFFICER: ",$G(^UTILITY("DIQ1",$J,912,DA,.06,"E"))
 .D:$Y+4>IOSL HDRC I E Q
 .W !,"CASE STATUS: ",$G(^UTILITY("DIQ1",$J,912,DA,.08,"E"))
 .W ?45,"COMPLETED FLAG: ",$G(^UTILITY("DIQ1",$J,912,DA,5.02,"E"))
 .S FLAG=$G(^UTILITY("DIQ1",$J,912,DA,5.05,"E")) D  Q:E
 ..Q:FLAG=""  Q:FLAG["NONE"
 ..D:$Y+3>IOSL HDRC I E Q
 ..W !,"DELETED/REOPENED FLAG: ",FLAG
 ..I $E(FLAG,1)="D" W ?45,"DATE/TIME: ",$G(^UTILITY("DIQ1",$J,912,DA,5.06,"E"))
 ..I ($E(FLAG,1)="R")&($D(^UTILITY("DIQ1",$J,912,DA,6.02,"E"))) W ?45,"DATE/TIME: ",^UTILITY("DIQ1",$J,912,DA,6.02,"E"),!?45,"PREVIOUS ID#: ",$G(^UTILITY("DIQ1",$J,912,DA,6.01,"E"))
 .I $D(^ESP(912,ESIEN,90)) D  Q:E
 ..D:$Y+4>IOSL HDRC I E Q
 ..W !,"LOST/STOLEN PROPERTY:"
 ..S ESL=0 F  S ESL=$O(^ESP(912,ESIEN,90,ESL)) Q:ESL=""  D  Q:E
 ...S DIC="^ESP(912,"_ESIEN_",90,",DA=ESL,DR=".01;.03",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912.1,DA))
 ...D:$Y+3>IOSL HDRC I E Q
 ...W !?5,$G(^UTILITY("DIQ1",$J,912.1,DA,.01,"E"))
 ...W ?45,"LOSS: $",$G(^UTILITY("DIQ1",$J,912.1,DA,.03,"E"))
 .S ESN=0 F  S ESN=$O(^ESP(912,ESIEN,10,ESN)) Q:ESN=""  D
 ..S (ESOLD,ESUSER,ESCNVDT)=0,ESOLDNM=""
 ..S ESOLD=$P($G(^XTMP("ESP","CONV",ESIEN,ESN)),U,1),ESUSER=$P($G(^XTMP("ESP","CONV",ESIEN,ESN)),U,3),ESCNVDT=$P($G(^XTMP("ESP","CONV",ESIEN,ESN)),U,4)
 ..S DIC="^ESP(912,"_ESIEN_",10,",DA=ESN,DR=".01;.02;.03",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
 ..D:$Y+4>IOSL HDRC I E Q
 ..I ESOLD D  Q:E
 ...W !,"Converted to:   ",$G(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
 ...I $G(^UTILITY("DIQ1",$J,912.01,DA,.02,"E"))]"" W "/",^("E")
 ...I $G(^UTILITY("DIQ1",$J,912.01,DA,.03,"E"))]"" W "/",^("E")
 ...W !,"Converted by:   ",$E($P($G(^VA(200,ESUSER,0)),U,1),1,24),?45,"Date/time: ",ESCNVDT
 ...;show previous conversion data, if any
 ...S ESPPREV=$O(^XTMP("ESP","PREV",ESIEN,ESN,""),-1)
 ...I ESPPREV S ESOLD=$P($G(^XTMP("ESP","PREV",ESIEN,ESN,1)),U,1)
 ...I ESPPREV F NN=ESPPREV:-1:1 D  Q:E
 ....D:$Y+3>IOSL HDRC I E Q
 ....S (ESLAST,ESUSER,ESCNVDT)=0,ESLSTNM=""
 ....S ESLAST=$P($G(^XTMP("ESP","PREV",ESIEN,ESN,NN)),U,2),ESUSER=$P($G(^XTMP("ESP","PREV",ESIEN,ESN,NN)),U,3),ESCNVDT=$P($G(^XTMP("ESP","PREV",ESIEN,ESN,NN)),U,4)
 ....Q:'ESLAST
 ....S ESLSTNM=$P($G(^ESP(912.9,ESLAST,0)),U,1)
 ....W !,"Converted to:   ",$G(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
 ....I $G(^UTILITY("DIQ1",$J,912.01,DA,.02,"E"))]"" W "/",^("E")
 ....W "/",ESLSTNM
 ....W !,"Converted by:   ",$E($P($G(^VA(200,ESUSER,0)),U,1),1,24),?45,"Date/time: ",ESCNVDT
 ...S ESOLDNM=$P($G(^ESP(912.9,ESOLD,0)),U,1)
 ...D:$Y+3>IOSL HDRC I E Q
 ...W !,"Original",!,"Classification: ",$G(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
 ...I $G(^UTILITY("DIQ1",$J,912.01,DA,.02,"E"))]"" W "/",^("E")
 ...W "/",ESOLDNM
 ..I 'ESOLD D
 ...W !,"Classification: ",$G(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
 ...I $G(^UTILITY("DIQ1",$J,912.01,DA,.02,"E"))]"" W "/",^("E")
 ...I $G(^UTILITY("DIQ1",$J,912.01,DA,.03,"E"))]"" W "/",^("E")
 Q
 ;
HDRC ;header for converted report
 N Y,JJ,SS
 I $E(IOST)="C" D  I E Q
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PAGE>1 S DIR(0)="E" D ^DIR S E=$D(DIRUT) K DIR
 W:$Y!($E(IOST)="C") @IOF
 S PAGE=PAGE+1
 W !,"Patch ES*1*22 Conversion Report ",?55,"Page: ",PAGE
 W !,"List of Converted Entries in File #912" W:PAGE=1 ?52,"Printed: ",RUNDT
 I $D(ESPUSER),$D(ESPDATE) D
 .W !,"Patch ES*1*22 Conversion Completion Report (cont.)"
 .W ?52,"Printed: ",RUNDT
 .W !,"Completed by: "_$E($P($G(^VA(200,ESPUSER,0)),U,1),1,24)
 W !,LN
 Q
 ;
USER ;user intervention needed report
 ;^XTMP("ESP","USER",ESIEN,ESN)=old subtype_"^"_total$loss
 N FLAG,ESIEN,ESN,ESOLD,ESOLDNM,ESNEW,ESL,ESPDTR,ESSTAR,NN,X,Y,DIC,DR,DA,DIQ
 D HDRU Q:E  S ESIEN=0
 I '$D(^XTMP("ESP","USER")) D  Q
 .W !!,"There is no data in ^XTMP(""ESP"",""USER"", to print."
 F  S ESIEN=$O(^XTMP("ESP","USER",ESIEN)) Q:ESIEN=""  D  Q:E
 .D:$Y+6>IOSL HDRU I E Q
 .S ESPDTR=$P($G(^ESP(912,ESIEN,0)),U,2) Q:ESPDTR=""
 .W !!!,"File #912 ien: ",ESIEN
 .W ?45,"UOR# ",$E(ESPDTR,2,3),"-",$E(ESPDTR,4,5),"-",$E(ESPDTR,6,7),"-",$TR($E($P(ESPDTR,".",2)_"ZZZZ",1,4),"Z",0)
 .K ^UTILITY("DIQ1",$J)
 .S DIC="^ESP(912,",DA=ESIEN,DR=".02;.03;.04;.06;.08;5.02;5.05;5.06;6.01;6.02",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912,DA))
 .W !,"DATE/TIME RECEIVED: ",$G(^UTILITY("DIQ1",$J,912,DA,.02,"E"))
 .W !,"DATE/TIME OF OFFENSE: ",$G(^UTILITY("DIQ1",$J,912,DA,.03,"E"))
 .D:$Y+4>IOSL HDRU I E Q
 .W !,"LOCATION: ",$G(^UTILITY("DIQ1",$J,912,DA,.04,"E"))
 .W !,"INVESTIGATING OFFICER: ",$G(^UTILITY("DIQ1",$J,912,DA,.06,"E"))
 .D:$Y+4>IOSL HDRU I E Q
 .W !,"CASE STATUS: ",$G(^UTILITY("DIQ1",$J,912,DA,.08,"E"))
 .W ?45,"COMPLETED FLAG: ",$G(^UTILITY("DIQ1",$J,912,DA,5.02,"E"))
 .S FLAG=$G(^UTILITY("DIQ1",$J,912,DA,5.05,"E")) D  Q:E
 ..Q:FLAG=""  Q:FLAG["NONE"
 ..D:$Y+4>IOSL HDRU I E Q
 ..W !,"DELETED/REOPENED FLAG: ",FLAG
 ..I $E(FLAG,1)="D" W ?45,"DATE/TIME: ",$G(^UTILITY("DIQ1",$J,912,DA,5.06,"E"))
 ..I ($E(FLAG,1)="R")&($D(^UTILITY("DIQ1",$J,912,DA,6.02,"E"))) W ?45,"DATE/TIME: ",^UTILITY("DIQ1",$J,912,DA,6.02,"E"),!?45,"PREVIOUS ID#: ",$G(^UTILITY("DIQ1",$J,912,DA,6.01,"E"))
 .I $D(^ESP(912,ESIEN,90)) D  Q:E
 ..D:$Y+4>IOSL HDRU I E Q
 ..W !,"LOST/STOLEN PROPERTY:"
 ..S ESL=0 F  S ESL=$O(^ESP(912,ESIEN,90,ESL)) Q:ESL=""  D  Q:E
 ...S DIC="^ESP(912,"_ESIEN_",90,",DA=ESL,DR=".01;.03",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912.1,DA))
 ...D:$Y+3>IOSL HDRU I E Q
 ...W !?5,$G(^UTILITY("DIQ1",$J,912.1,DA,.01,"E"))
 ...W ?45,"LOSS: $",$G(^UTILITY("DIQ1",$J,912.1,DA,.03,"E"))
 .S ESN=0 F  S ESN=$O(^ESP(912,ESIEN,10,ESN)) Q:ESN=""  D  Q:E
 ..S ESOLD=0 S ESSTAR="   "
 ..S ESOLD=$P($G(^XTMP("ESP","USER",ESIEN,ESN)),U,1) I ESOLD S ESSTAR="** "
 ..S DIC="^ESP(912,"_ESIEN_",10,",DA=ESN,DR=".01;.02;.03",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
 ..D:$Y+3>IOSL HDRU I E Q
 ..W !,ESSTAR W "Classification: ",$G(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
 ..I $G(^UTILITY("DIQ1",$J,912.01,DA,.02,"E"))]"" W "/",^("E")
 ..I $G(^UTILITY("DIQ1",$J,912.01,DA,.03,"E"))]"" W "/",^("E")
 Q
 ;
HDRU ;header for user report
 N Y,JJ,SS
 I $E(IOST)="C" D  I E Q
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PAGE>1!(ESPC) S DIR(0)="E" D ^DIR S E=$D(DIRUT) K DIR
 W:$Y!($E(IOST)="C") @IOF
 S PAGE=PAGE+1
 W !,"Patch ES*1*22 Conversion Report ",?55,"Page: ",PAGE
 W !,"List of Unconverted Entries in File #912" W:PAGE=1 ?52,"Printed: ",RUNDT
 W !,"   to be Reviewed by User"
 I $D(ESPUSER),$D(ESPDATE) D
 .W !,"Patch ES*1*22 Conversion Completion Report (cont.)"
 .W ?52,"Printed: ",RUNDT
 .W !,"Completed by: "_$E($P($G(^VA(200,ESPUSER,0)),U,1),1,24)
 W !,LN
 Q
