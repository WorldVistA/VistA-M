ECXLPRO1 ;ALB/JAP - PRO Extract YTD Lab Report (cont) ; 5/9/05 3:25pm
 ;;3.0;DSS EXTRACTS;**21,84**;Dec 22, 1997
 ;
PRINT ;print report
 N PG,LN,QFLG,NODE1,NODE2,DESC,AVE,JJ,SS,X1,X2
 U IO
 S QFLG=0,$P(LN,"-",132)=""
 S Y=ECXARRAY("START") D DD^%DT S ECXSTART=Y
 S Y=$S(LASTDAY:LASTDAY,ECXARRAY("END")>DT:DT,1:ECXARRAY("END")) D DD^%DT S ECXEND=Y
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 F ECXTYPE="N","X" D  Q:QFLG
 .S PG=0 D HEADER
 .S ECXHCPC=""
 .;it's possible that no extract data was found
 .I '$D(^TMP($J,"ECXP",ECXTYPE)) D  Q
 ..W !!,?37,"No extract data available."
 ..I $E(IOST)="C" D  Q:QFLG
 ...S SS=22-$Y F JJ=1:1:SS W !
 ...S DIR(0)="E" D ^DIR K DIR S:'Y QFLG=1
 .F  S ECXHCPC=$O(^TMP($J,"ECXP",ECXTYPE,ECXHCPC)) Q:ECXHCPC=""  D  Q:QFLG
 ..S DESC=$G(^TMP($J,"HCPCS",ECXHCPC)) S:DESC="" DESC="(Unknown)" S DESC=ECXHCPC_" "_DESC
 ..S NODE1=^TMP($J,"ECXP",ECXTYPE,ECXHCPC,"SAME"),NODE2=^TMP($J,"ECXP",ECXTYPE,ECXHCPC,"OTHER")
 ..;node holds - lab qty^lab labor cost^lab matrl cost
 ..F I=1:1:3 S X1(I)=+$P(NODE1,U,I),X2(I)=+$P(NODE2,U,I)
 ..S AVE("O")=0,AVE("S")=0,TOT("O")=0,TOT("S")=0
 ..S TOT("S")=X1(2)+X1(3),TOT("O")=X2(2)+X2(3)
 ..S:X1(1)>0 AVE("S")=TOT("S")/X1(1) S:X2(1)>0 AVE("O")=TOT("O")/X2(1)
 ..D:($Y+3>IOSL) HEADER Q:QFLG
 ..W !,DESC,?33,$J(X1(1),8,0),?43,$J(X1(2),8,0),?54,$J(X1(3),8,0),?65,$J(AVE("S"),8,2),?82,$J(X2(1),8,0),?93,$J(X2(2),8,0),?104,$J(X2(3),8,0),?115,$J(AVE("O"),8,2)
 .I 'QFLG,$E(IOST)="C" D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" D ^DIR K DIR S:'Y QFLG=1
 W @IOF
 Q
 ;
HEADER ;header & page control
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W "Prosthetics (PRO) Extract YTD Laboratory Report",?122,"Page "_PG
 W !,"FY Date Range: "_ECXSTART_" to "_ECXEND
 W !,"Facility:      "_$P(ECXPRIME,U,3)_" ("_$P(ECXPRIME,U,2)_")"
 W !,"Run Date/Time: "_ECXRUN
 W:ECXTYPE="N" !!,"REPORT OF NEW PROSTHETICS ACTIVITIES (Initial, Replacement, or Spare)",!
 W:ECXTYPE="X" !!,"REPORT OF REPAIR PROSTHETICS ACTIVITIES",!
 W !,?37,"Produced for Station #"_$P(ECXPRIME,U,2),?86,"Produced for all other stations"
 W !,"PSAS HCPCS",?37,"Qty.",?44,"Labor $",?55,"Mat'l $",?67,"Ave. $",?86,"Qty.",?94,"Labor $",?105,"Mat'l $",?117,"Ave. $"
 W !,LN,!
 Q
