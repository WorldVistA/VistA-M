ECXCPRO1 ;ALB/JAP - PRO Extract YTD Report (cont) ;3/4/13  07:44
 ;;3.0;DSS EXTRACTS;**21,84,132,144**;Dec 22, 1997;Build 9
 ;
PRINT ;print report
 N PG,LN,QFLG,NODE,DESC,AVE,JJ,SS,TOTAL,TOT,TQTY
 U IO
 S QFLG=0,$P(LN,"-",132)=""
 S Y=ECXARRAY("START") D DD^%DT S ECXSTART=Y
 S Y=$S(LASTDAY:LASTDAY,ECXARRAY("END")>DT:DT,1:ECXARRAY("END")) D DD^%DT S ECXEND=Y
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;if ecxall=0, then only one subdivision of multidivision facility
 ;if ecxall=1, then either entire facility (i.e., non-divisional), or all subdivisions combined under primary station#
 ;but it's possible that no extract data was found
 S ECXSTAT="",ECXSTAT=$O(^TMP($J,"ECXP",ECXSTAT)) I ECXSTAT="" D  Q
 .I $G(ECXPORT) Q  ;144 Don't display anything if exporting
 .I ECXALL=0 S ECXSTAT=$O(DIVISION(""))
 .F ECXTYPE="N","X","R" D  Q:QFLG
 ..S PG=0 D HEADER
 ..W !!,?36,"No extract data available."
 ..I $E(IOST)="C" D  Q:QFLG
 ...S SS=22-$Y F JJ=1:1:SS W !
 ...S DIR(0)="E" D ^DIR K DIR S:'Y QFLG=1
 F ECXTYPE="N","X","R" D  Q:QFLG
 .S PG=0 I '$G(ECXPORT) D HEADER ;144 Don't print header if exporting
 .S ECXHCPC=""
 .I '$D(^TMP($J,"ECXP",ECXSTAT,ECXTYPE)) D  Q
 ..I $G(ECXPORT) Q  ;144 Don't display anything if exporting
 ..W !!,?36,"No extract data available."
 ..I $E(IOST)="C" D  Q:QFLG
 ...S SS=22-$Y F JJ=1:1:SS W !
 ...S DIR(0)="E" D ^DIR K DIR S:'Y QFLG=1
 .F  S ECXHCPC=$O(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC)) Q:ECXHCPC=""  D  Q:QFLG
 ..S DESC=$G(^TMP($J,"HCPCS",ECXHCPC)) S:DESC="" DESC="(Unknown)" S DESC=ECXHCPC_" "_DESC
 ..S NODE=^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC)
 ..;node holds - com qty^com cost^va nonlab qty^va nonlab cost^lab qty^lab labor cost^lab matrl cost
 ..F I=1:1:7 S X(I)=+$P(NODE,U,I)
 ..S AVE("C")=0,AVE("V")=0,AVE("L")=0,AVE("ALL")=0,TOT("L")=0,TOTAL=0,TQTY=0
 ..S:X(1)>0 AVE("C")=X(2)/X(1) S:X(3)>0 AVE("V")=X(4)/X(3) S TOT("L")=X(6)+X(7) S:X(5)>0 AVE("L")=TOT("L")/X(5)
 ..S TQTY=X(1)+X(3)+X(5),TOTAL=X(2)+X(4)+TOT("L")
 ..S:TQTY>0 AVE("ALL")=TOTAL/TQTY
 ..I '$G(ECXPORT) D:($Y+3>IOSL) HEADER Q:QFLG  ;144 Don't display anything if exporting
 ..I $G(ECXPORT) S ^TMP($J,"ECXPORT",CNT)=$S(ECXTYPE="N":"NEW",ECXTYPE="R":"RENTAL",1:"REPAIR") D  Q  ;144
 ...S ^TMP($J,"ECXPORT",CNT)=^TMP($J,"ECXPORT",CNT)_U_DESC_U_X(1)_U_X(2)_U_$FN(AVE("C"),"",2)_U_X(3)_U_X(4)_U_$FN(AVE("V"),"",2)_U_X(5)_U_TOT("L")_U_$FN(AVE("L"),"",2)_U_$FN(AVE("ALL"),"",2) ;144
 ...S CNT=CNT+1 ;144
 ..W !,DESC,?33,$J(X(1),8,0),?43,$J(X(2),8,0),?53,$J(AVE("C"),8,2),?63,$J(X(3),8,0),?73,$J(X(4),8,0),?83,$J(AVE("V"),8,2),?93,$J(X(5),8,0),?103,$J(TOT("L"),8,0),?113,$J(AVE("L"),8,2),?123,$J(AVE("ALL"),8,2)
 .Q:$G(ECXPORT)  ;144 Don't continue if exporting
 .I 'QFLG,$E(IOST)="C" D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" D ^DIR K DIR S:'Y QFLG=1
 I '$G(ECXPORT) W @IOF ;144 Don't write anything if exporting
 Q
 ;
HEADER ;header & page control
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W "Prosthetics (PRO) Extract YTD HCPCS Report",?122,"Page "_PG
 W !,"FY Date Range: "_ECXSTART_" to "_ECXEND
 I ECXALL=0 W !,"Division:      "_$P(DIVISION(ECXSTAT),U,3)_" ("_$P(DIVISION(ECXSTAT),U,2)_")"
 I ECXALL=1 W !,"Facility:      "_$P(ECXPRIME,U,3)_" ("_$P(ECXPRIME,U,2)_")"
 W !,"Run Date/Time: "_ECXRUN
 W:ECXTYPE="N" !!,"REPORT OF NEW PROSTHETICS ACTIVITIES (Initial, Replacement, or Spare)"
 W:ECXTYPE="R" !!,"REPORT OF RENTAL PROSTHETICS ACTIVITIES"
 W:ECXTYPE="X" !!,"REPORT OF REPAIR PROSTHETICS ACTIVITIES"
 W !,?36,"Qty.",?44,"Total $",?55,"Ave. $",?67,"Qty.",?74,"Total $",?85,"Ave. $",?97,"Qty.",?104,"Total $",?114,"Ave. $",?125,"Ave. $"
 W !,"PSAS HCPCS",?35,"-Comm-",?44,"-Comm-",?55,"-Comm-",?67,"-VA-",?75,"-VA-",?85,"-VA-",?96,"-Lab-",?105,"-Lab-",?114,"-Lab-",?125,"-All-"
 W !,LN,!
 Q
