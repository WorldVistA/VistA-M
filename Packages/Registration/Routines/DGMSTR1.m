DGMSTR1 ;ALB/GRR - GENERATE AND PRINT SUMMARY REPORT ; Jan 6, 1999
 ;;5.3;Registration;**195**; Aug 13, 1993
 ;DGMST("M") - Total Males
 ;DGMST("F") - Total Females
 ;DGMST("T") - Total Males and Females
 ;DGMST("M","Y") - Total Males seen for MST
 ;DGMST("M","N") - Total Males seen not related to MST
 ;DGMST("M","U") - Total Males seen with MST status of 'Unknown'
 ;DGMST("M","D") - Total Males seen with MST status of 'Declined to answer'
 ;DGMST("F",     - Same totals as above four except for Females
 ;DGMST("%M",    - Same breakdown as above except totals are percentages of Males
 ;DGMST("%F",    - Same breakdown as above except totals are percentages of Females
 ;DGMST("%",     - Same breakdown as above except totals are total percentages
 ;DGMST("Y") - Total number seen for MST
 ;DGMST("N") - Total seen not related to MST
 ;DGMST("U") - Total seen with MST status of 'Unknown'
 ;DGMST("D") - Total seen with MST status of 'Declined to answer'
 ;DGSDAT - Start Date of selected range
 ;DGEDAT - End Date of selected range
 ;DGPSDT - Start Date formatted for print
 ;DGPEDT - End Date formatted for print
 ;DGMSTST - Patient's MST Status
 ;
EN ;ENTRY POINT FOR ROUTINE
 N DGMST,DGSDAT,DGPSDT,DGEDAT,DGPEDT,ZTSAVE,X,Y,DGSTAT,DTOUT,DUOUT
 K DGMST
 D DT^DICRW
 F DGSTAT="Y","N","D","U" S DGMST("M",DGSTAT)=0,DGMST("F",DGSTAT)=0 ;INITIALIZE CUMULATORS BY SEX AND MST STATUS
 S DGMST("M")=0,DGMST("F")=0 ;INITIALIZE SEX COUNTERS
 ;GET DATE RANGE
SDAT S DIR(0)="D^:"_DT_":EX",DIR("A")="Start Date"
 D ^DIR K DIR
 Q:$D(DTOUT)!($D(DUOUT))
 S DGSDAT=+Y,Y=+Y D DD^%DT S DGPSDT=Y
TDAT S DIR(0)="D^"_DGSDAT_":"_DT_":EX",DIR("A")="End Date"
 D ^DIR K DIR
 Q:$D(DTOUT)!($D(DUOUT))
 S DGEDAT=+Y_.9999,Y=+Y D DD^%DT S DGPEDT=Y
 F X="DGMST(","DGSDAT","DGPSDT","DGEDAT","DGPEDT" S ZTSAVE(X)=""
 W !!,"This may take long to print, queue the report to free-up your terminal!",!
 D EN^XUTMDEVQ("RPT^DGMSTR1","MST Summary Report",.ZTSAVE)
 D HOME^%ZIS
 Q
RPT ;LOOP THROUGH PATIENT FILE TO CALCULATE UNKNOWN STATUSES
 N DFN,DGMSTST,DGMIFN,SEX
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:DFN'>0  D
 .Q:$$EXCLUDE(DFN)
 .S SEX=$P($G(^DPT(DFN,0)),"^",2) Q:SEX'="M"&(SEX'="F")
 .I '$D(^DGMS(29.11,"C",DFN)) S DGMST(SEX,"U")=DGMST(SEX,"U")+1,DGMST(SEX)=DGMST(SEX)+1
 ;
 ;LOOP THROUGH MST HISTORY FILE TO TABULATE STATUS COUNTS
 ;
 S DFN=0 F  S DFN=$O(^DGMS(29.11,"C",DFN)) Q:DFN'>0  D
 .S Y=$$GETSTAT^DGMSTAPI(DFN,DGEDAT)
 .Q:+Y=0
 .Q:$P(Y,"^",3)<DGSDAT
 .S DGMSTST=$P(Y,"^",2) Q:DGMSTST=""
 .S DGMIFN=$P(Y,"^")
 .S SEX=$P($G(^DPT(DFN,0)),"^",2)
 .Q:SEX'="M"&(SEX'="F")
 .S DGMST(SEX,DGMSTST)=DGMST(SEX,DGMSTST)+1
 .S DGMST(SEX)=DGMST(SEX)+1
 ;COMPUTE REMAINING TOTALS
 S DGMST("T")=DGMST("M")+DGMST("F") ;ADD TOTAL MALES AND TOTAL FEMALES FOR GRAND TOTAL COUNT
 F S="Y","N","D","U" D
 .S DGMST(S)=DGMST("M",S)+DGMST("F",S) ;ADD TOTAL MALE AND FEMALE FOR EACH MST STATUS FOR TOTAL COUNT FOR EACH STATUS
 .S DGMST("%M",S)=0 I DGMST(S)>0 S DGMST("%M",S)=DGMST("M",S)/DGMST(S)*100 ;CALCULATE PERCENT MALE FOR EACH STATUS
 .S DGMST("%F",S)=0 I DGMST(S)>0 S DGMST("%F",S)=DGMST("F",S)/DGMST(S)*100 ;CALCULATE PERCENT FEMALE FOR EACH STATUS
 .S DGMST("%",S)=0 I DGMST(S)>0 S DGMST("%",S)=DGMST(S)/DGMST("T")*100 ;CALCULATE TOTAL PERCENT FOR EACH STATUS
 ;PRINT REPORT
 ;
 I $E(IOST,1,2)="C-" W @IOF
 W !,?20,"MST Summary Report"
 W !,?20,"Date Range: ",DGPSDT," - ",DGPEDT
 S Y=DT D DD^%DT S DGPCDT=Y
 W !,?20,"Date report Printed: ",DGPCDT,!!
 W !,"Total Male with a MST Status",?78-$L(DGMST("M")),DGMST("M")
 W !,"Total Female with a MST Status",?78-$L(DGMST("F")),DGMST("F")
 W !,"Total Patients with a MST Status",?78-$L(DGMST("T")),DGMST("T")
 W !!,"MST STATUS",?47,"Y",?57,"N",?67,"D",?77,"U"
 W !!,"Total Male"
 W ?48-$L(DGMST("M","Y")),DGMST("M","Y")
 W ?58-$L(DGMST("M","N")),DGMST("M","N")
 W ?68-$L(DGMST("M","D")),DGMST("M","D")
 W ?78-$L(DGMST("M","U")),DGMST("M","U")
 W !,"Total Female"
 W ?48-$L(DGMST("F","Y")),DGMST("F","Y")
 W ?58-$L(DGMST("F","N")),DGMST("F","N")
 W ?68-$L(DGMST("F","D")),DGMST("F","D")
 W ?78-$L(DGMST("F","U")),DGMST("F","U")
 W !!,"Total Patients with MST Status"
 W ?48-$L(DGMST("Y")),DGMST("Y")
 W ?58-$L(DGMST("N")),DGMST("N")
 W ?68-$L(DGMST("D")),DGMST("D")
 W ?78-$L(DGMST("U")),DGMST("U")
 W !!,"Percent of Male"
 W ?48-$L($J(DGMST("%M","Y"),3,1)),$J(DGMST("%M","Y"),3,1)
 W ?58-$L($J(DGMST("%M","N"),3,1)),$J(DGMST("%M","N"),3,1)
 W ?68-$L($J(DGMST("%M","D"),3,1)),$J(DGMST("%M","D"),3,1)
 W ?78-$L($J(DGMST("%M","U"),3,1)),$J(DGMST("%M","U"),3,1)
 W !,"Percent of Female"
 W ?48-$L($J(DGMST("%F","Y"),3,1)),$J(DGMST("%F","Y"),3,1)
 W ?58-$L($J(DGMST("%F","N"),3,1)),$J(DGMST("%F","N"),3,1)
 W ?68-$L($J(DGMST("%F","D"),3,1)),$J(DGMST("%F","D"),3,1)
 W ?78-$L($J(DGMST("%F","U"),3,1)),$J(DGMST("%F","U"),3,1)
 W !!,"Percent of all patients"
 W ?48-$L($J(DGMST("%","Y"),3,1)),$J(DGMST("%","Y"),3,1)
 W ?58-$L($J(DGMST("%","N"),3,1)),$J(DGMST("%","N"),3,1)
 W ?68-$L($J(DGMST("%","D"),3,1)),$J(DGMST("%","D"),3,1)
 W ?78-$L($J(DGMST("%","U"),3,1)),$J(DGMST("%","U"),3,1)
 I $E(IOST,1,2)="C-" W ! S DIR(0)="E" D ^DIR K DIR Q:$D(DTOUT)!($D(DUOUT))  W @IOF
 I $E(IOST,1,2)'="C-" W @IOF
 W !!
 W !,"----- LEGEND -----"
 W !,"Y means Yes, Reports MST"
 W !,"N means No, Does not Report MST"
 W !,"D means Declined to Answer"
 W !,"U means Unknown"
 W !
 K X,Y,S,DGPCDT,DGSTAT
 Q
 ;
EXCLUDE(DFN) ;DETERMINE IF PATIENT SHOULD BE EXCLUDED FROM MST TRACKING
 ;
 I $G(^DPT(DFN,"VET"))="Y",'+$G(^(.35))>0!(+$G(^(.35))>0&(+$G(^(.35))'<2921001)) Q 0
 Q 1
