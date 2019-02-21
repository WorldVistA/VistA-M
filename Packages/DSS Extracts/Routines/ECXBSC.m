ECXBSC ;ALB/DAN - Validate stop codes in extracts ;6/14/18  10:53
 ;;3.0;DSS EXTRACTS;**170**;Dec 22, 1997;Build 12
 ;
EN N DIR,DIRUT,X,Y,DTOUT,DUOUT,ECXTYPE,DIC,ECXDA,CNT,ECXARR,ARR,ECXPORT,DIQ,DA,DR
 W @IOF,"This option will identify extract records with an invalid or inactive",!,"stop code."
 S DIR("L",1)="Select one of the following extracts:",DIR("L",2)=""
 S DIR("L",3)="        1 Clinic",DIR("L",4)="        2 Event Capture",DIR("L")="        3 Radiology"
 S DIR("?")="Select the extract type to review for bad stop codes.",DIR(0)="SO^1:Clinic;2:Event Capture;3:Radiology",DIR("A")="Select Extract Type" D ^DIR
 Q:$D(DIRUT)
 S ECXTYPE=Y(0)
 K DIR
 S DIC="^ECX(727,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,3)=$P(ECXTYPE,U),'$D(^(""PURG""))"
 D ^DIC
 Q:Y=-1
 S DIC="^ECX(727,",(ECXDA,DA)=+Y,DR=".01;1;2;3;4;5;15;300",DIQ="ECXARR",DIQ(0)="IE"
 D EN^DIQ1
 W !!,?5,"Extract:      ",ECXARR(727,ECXDA,2,"E")," #",ECXDA
 W !!,?5,"Start date:   ",ECXARR(727,ECXDA,3,"E")
 W !,?5,"End date:     ",ECXARR(727,ECXDA,4,"E")
 W !,?5,"# of Records: ",ECXARR(727,ECXDA,5,"E")
 I $L(ECXARR(727,ECXDA,300,"E"))>0 D  Q:Y'=1
 .W !!,?5,"The extract which you have chosen to audit"
 .W !,?5,"was transmitted to Austin/DSS on ",ECXARR(727,ECXDA,300,"E"),".",!
 .S DIR(0)="Y",DIR("A")="Do you want to continue with this audit report",DIR("B")="NO" D ^DIR
 ;
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D  Q
 .K ^TMP($J,"ECXPORT")
 .S ^TMP($J,"ECXPORT",0)="EXTRACT TYPE^SEQ #^EXTRACT #^FACILITY^SSN^NAME^DAY^FEEDER KEY"_$S(ECXTYPE="Radiology":" (IEN from file 71)",1:"")_"^FEEDER LOCATION^ENCOUNTER #^STOP CODE^CLINIC IEN^CLINIC STOP CODE",CNT=1
 .D PROCESS
 .D EXPDISP^ECXUTL1
 .K ^TMP($J,"ECXPORT")
 W !!
 S ECXPGM="PROCESS^ECXBSC",ECXDESC="Search extract for invalid stop codes",ECXSAVE("*")=""
 W !,"This report requires 132 characters to display correctly.",!
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 Q
 ;
PROCESS ;
 K ^TMP($J,"ECXBSC")
 N ECXSC,ECXSEQ,ECXERR,WARNING,ERR,WRN,X,Y,DIC,ECXFILE,PG,QFLG,ECXRUN,ECXDT
 S (PG,QFLG)=0
 S ECXRUN=$$FMTE^XLFDT($E($$NOW^XLFDT,1,12))
 S ECXFILE=$S(ECXTYPE="Clinic":727.827,ECXTYPE="Radiology":727.814,1:727.815)
 S ECXSEQ=0 F  S ECXSEQ=$O(^ECX(ECXFILE,"AC",ECXDA,ECXSEQ)) Q:'+ECXSEQ  D
 .S ECXSC=$S(ECXTYPE="Clinic":$E($P($G(^ECX(ECXFILE,ECXSEQ,4)),U,10),1,3),ECXTYPE="Radiology":$P($G(^ECX(ECXFILE,ECXSEQ,1)),U,12),1:$E($P($G(^ECX(ECXFILE,ECXSEQ,0)),U,41),1,3))
 .S ECXDT=$P($G(^ECX(ECXFILE,ECXSEQ,0)),U,9),%DT="X",X=ECXDT D ^%DT S ECXDT=Y
 .D STOP^ECXSTOP(ECXSC,"Stop Code",,ECXDT)
 .I $D(ECXERR) S ^TMP($J,"ECXBSC",ECXSEQ)=ECXSC
 .K ERR,WRN,ECXERR,WARNING
 ;Print
 I '$G(ECXPORT) D HEADER I '$D(^TMP($J,"ECXBSC")) W !,"No data to report." Q
 S ECXSEQ=0 F  S ECXSEQ=$O(^TMP($J,"ECXBSC",ECXSEQ)) Q:'+ECXSEQ!$G(QFLG)  D
 .K ARR D GETFLDS(.ARR)
 .I $G(ECXPORT) D  Q
 ..S ^TMP($J,"ECXPORT",CNT)=ECXTYPE_U_ECXSEQ_U_ECXDA_U_ARR("FACILITY")_U_ARR("SSN")_U_ARR("NAME")_U_ARR("DAY")_U_ARR("FK")_U_ARR("FL")_U_ARR("EN")_U_^TMP($J,"ECXBSC",ECXSEQ)_U_ARR("CIEN")_U_ARR("CSTOP"),CNT=CNT+1
 .W !,ECXSEQ,?10,ARR("FACILITY"),?20,ARR("SSN"),?25,ARR("NAME"),?31,ARR("DAY"),?41,ARR("FK"),?72,ARR("FL"),?80,ARR("EN"),?98,^TMP($J,"ECXBSC",ECXSEQ),?104,ARR("CIEN"),?118,ARR("CSTOP")
 .I $Y+3>IOSL D HEADER
 .Q
 Q
 ;
GETFLDS(ARR) ;Get data
 N FLDS,ECXARR
 S FLDS="3;5;6;8"_$S(ECXTYPE="Radiology":";10;20;33;41;42",ECXTYPE="Event Capture":";9;11;62;128",1:";66;130;131")
 D GETS^DIQ(ECXFILE,ECXSEQ_",",FLDS,"I","ECXARR")
 S ARR("FACILITY")=$S(ECXTYPE="Clinic":$$GET1^DIQ(40.8,ECXARR(ECXFILE,ECXSEQ_",",3,"I"),".07:99"),ECXTYPE="Event Capture":$$RADDIV^ECXDEPT(ECXARR(ECXFILE,ECXSEQ_",",3,"I")),1:ECXARR(ECXFILE,ECXSEQ_",",3,"I"))
 S ARR("SSN")=$E(ECXARR(ECXFILE,ECXSEQ_",",5,"I"),6,9)
 S ARR("NAME")=ECXARR(ECXFILE,ECXSEQ_",",6,"I")
 S ARR("DAY")=ECXARR(ECXFILE,ECXSEQ_",",8,"I")
 S ARR("FK")=ECXARR(ECXFILE,ECXSEQ_",",$S(ECXTYPE="Radiology":10,ECXTYPE="Event Capture":11,1:131),"I") S:ECXTYPE="Radiology" ARR("FK")=$E($$GET1^DIQ(71,ARR("FK"),.01),1,19)_" ("_ARR("FK")_")"
 S ARR("FL")="" S:ECXTYPE'="Clinic" ARR("FL")=ECXARR(ECXFILE,ECXSEQ_",",$S(ECXTYPE="Radiology":20,1:9),"I")
 S ARR("EN")=ECXARR(ECXFILE,ECXSEQ_",",$S(ECXTYPE="Radiology":33,ECXTYPE="Event Capture":62,1:66),"I")
 S ARR("CIEN")=ECXARR(ECXFILE,ECXSEQ_",",$S(ECXTYPE="Radiology":41,ECXTYPE="Event Capture":128,1:130),"I")
 S ARR("CSTOP")="" S:ECXTYPE="Radiology" ARR("CSTOP")=ECXARR(ECXFILE,ECXSEQ_",",42,"I")
 Q
 ;
HEADER ;
 N JJ,SS,LN,DIR
 S $P(LN,"-",132)=""
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,ECXTYPE," Extract Stop Code Audit"
 W !,"DSS Extract Log #:    "_ECXDA
 W !,"Report Run Date/Time: "_ECXRUN,?120,"Page: ",$G(PG)
 W !!,"SEQUENCE",?10,"FACILITY",?20,"SSN",?25,"NAME",?31,"DAY",?41,"FEEDER KEY",$S(ECXTYPE="Radiology":" (IEN from file 71)",1:""),?72,"FEEDER",?80,"ENCOUNTER",?98,"STOP",?104,"CLINIC",?118,"CLINIC"
 W !,?10,"NUMBER",?72,"LOC",?80,"NUMBER",?98,"CODE",?104,"IEN",?118,"STOP CODE"
 W !,LN,!
 Q
