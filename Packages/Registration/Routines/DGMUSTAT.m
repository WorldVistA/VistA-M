DGMUSTAT ;KNR/WCS - PREFERRED LANGUAGE RECORD FOR ACTIVE PATIENTS ; July 16, 2014
 ;;5.3;Registration;**887**;Aug 13, 1993;Build 57
 ;
EN ;*///*
 D HOME^%ZIS
 W @IOF,"Preferred Language Record for Active Patients",!!!
 W "This program will calculate the number of patients who have designated",!
 W "a preferred language in their record at this facility.",!!
 S %ZIS="AEQ" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) DO  G EXIT
 .S ZTIO=ION,ZTSAVE="",ZTRTN="GO^DGMUSTAT",ZTDESC="Meaningful Use Statistics"
 .D ^%ZTLOAD W:$D(ZTSK) !,"Queued as task: ",ZTSK,!!
 ;
GO S DGPATCNT=0 K DGLANG
 S DGSSN="" F  S DGSSN=$O(^DPT("SSN",DGSSN)) Q:DGSSN=""  DO
 .F DFN=0:0 S DFN=$O(^DPT("SSN",DGSSN,DFN)) Q:DFN=""  DO
 ..Q:$P($G(^DPT(DFN,.35)),U)]""  ; deceased patients
 ..S DGPATCNT=DGPATCNT+1 ; count total patients
 ..S DGDATE="9999999.9999",DGDATE=$O(^DPT(DFN,.207,"B",DGDATE),-1) Q:DGDATE=""
 ..S DA=$O(^DPT(DFN,.207,"B",DGDATE,0)) Q:DA=""
 ..S DGDATA=$G(^DPT(DFN,.207,DA,0)) Q:DGDATA=""
 ..S DGLANGNM=$P(DGDATA,U,2) ; Language name
 ..I DGLANGNM]"" S DGLANG(DGLANGNM)=$G(DGLANG(DGLANGNM))+1 ; count language names
 ;
PRINT U IO S PG=0
 S DGTOTPTL=0 S DGLANGNM="" F  S DGLANGNM=$O(DGLANG(DGLANGNM)) Q:DGLANGNM=""  S DGTOTPTL=DGTOTPTL+DGLANG(DGLANGNM)
 D HDR
 S DOTS="........................."
 W !! S DGLANGNM="",DGLANGCT=0 F  S DGLANGNM=$O(DGLANG(DGLANGNM)) Q:DGLANGNM=""  DO
 .W DGLANGNM," ",$E(DOTS,2,(25-$X)),?25,DGLANG(DGLANGNM),! S DGLANGCT=DGLANGCT+1 I $Y>(IOSL-7) D HDR
 W !!
 I DGLANGCT>0 S X=(DGTOTPTL/DGPATCNT)*100
 I DGLANGCT=0 S X="0.00"
 W ?12,"Total Count of Patient Records: ",DGPATCNT,!
 W ?4,"Total Patients with preferred language: ",DGTOTPTL,!!
 W ?10,"Total unique preferred languages: ",DGLANGCT,!
 W " % Patient records with preferred language: ",$J(X,0,1)," %",!
 ;
EXIT K %ZIS,DA,DFN,DGDATA,DGDATE,DGLANG,DGLANGCT,DGLANGNM,DGLANGPT,DGPATCNT,DGSSN,DGTOTPTL,DOTS,PG,X
 K ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
HDR S PG=PG+1
 W @IOF,"Preferred Language Record for Active Patients",?(IOM-12),"Page: ",PG,!!
 W "Language",?25,"Count",!
 F X=1:1:IOM W "-"
 Q
