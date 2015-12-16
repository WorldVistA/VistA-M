ECXPLBB ;DALOI/KML - DSS BLOOD BANK PRE-EXTRACT AUDIT REPORT ;11/12/14  13:29
 ;;3.0;DSS EXTRACTS;**78,92,105,136,143,149,153,156**;Dec 22, 1997;Build 8
 ;Per VA Directive 6402, this routine should not be modified.  Medical Device # BK970021
 ;entry point from option
 D SETUP^ECXLBB1 I ECFILE="" Q  ;149
 N ECXINST,ECXPORT,CNT ;149
 D DATES
 Q:ECED']""!(ECSD']"")  ;149 Changed logic so it stops if either start or stop date is null
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D  Q  ;149 Section added
 .W !!,"This report may take a while to generate.  Please be patient.",!
 .S ECSDN=$$FMTE^XLFDT(ECSD),ECEDN=$$FMTE^XLFDT(ECED),ECSD1=ECSD-.1
 .K ^TMP($J,"ECXPORT")
 .S ^TMP($J,"ECXPORT",0)="NAME^SSN^FEEDER LOCATION^TRANSFUSION DATE^COMPONENT^NUMBER OF UNITS",CNT=1
 .D START
 .D EXPDISP^ECXUTL1
 .D ^ECXKILL
 N ECXPOP S ECXPOP=0 D QUE Q:ECXPOP
 ;
START ;  entry point from tasked job
 ; get LAB DATA and build temporary global ^TMP("ECXLBB",$J)
 N ECTRSP,ECADMT,ECTODT,ECXRPT,ECOUT,ECXSTR,ECRDT,ECLINE,ECPG,ECQUIT
 N ECD,ECXDFN,ECARRY,EC66,ECERR,ECTRFDT,ECTRFTM,ECX,ECINOUT,ECXJOB
 N ECXLOGIC,ECXREC ;156
 S ECXJOB=$J
 K ^TMP("ECXLBB",ECXJOB)
 U IO
 I '$G(ECXPORT) I $E(IOST,1,2)="C-" W !,"Retrieving records... " ;149
 S ECXRPT=1 D AUDRPT^ECXLBB1 ;149
OUTPUT ; entry point called by EN tag
 I '$D(^TMP("ECXLBB",ECXJOB)) W:'$G(ECXPORT) !,"There were no records that met the date range criteria" Q  ;149
 S (ECPG,ECDATE,ECQUIT,ECXDFN,ECXREC)=0,ECLINE="",$P(ECLINE,"=",80)="="
 S ECSDN=$$FMTE^XLFDT(ECSD,9),ECEDN=$$FMTE^XLFDT(ECED,9),ECRDT=$$FMTE^XLFDT(DT,9)
 I '$G(ECXPORT) W:$E(IOST,1,2)="C-" @IOF D HED ;149
 F  S ECXDFN=$O(^TMP("ECXLBB",ECXJOB,ECXDFN)) Q:'ECXDFN  D  Q:ECQUIT
 .F  S ECDATE=$O(^TMP("ECXLBB",ECXJOB,ECXDFN,ECDATE))  Q:'ECDATE  D  Q:ECQUIT
 ..F  S ECXREC=$O(^TMP("ECXLBB",ECXJOB,ECXDFN,ECDATE,ECXREC)) Q:'+ECXREC  S ECXSTR=^(ECXREC) D PRINT Q:ECQUIT  ;143,156-added additional for loop
 I '$G(ECXPORT) D ^ECXKILL ;149
 Q
 ;
PRINT ;
 I $G(ECXPORT) S ^TMP($J,"ECXPORT",CNT)=$P(ECXSTR,U,5)_U_$P(ECXSTR,U,4)_U_$P(ECXSTR,U,16)_U_$$FMTE^XLFDT($$HL7TFM^XLFDT($P(ECXSTR,U,8)),2)_U_$P(ECXSTR,U,11)_U_+$P(ECXSTR,U,12),CNT=CNT+1 Q  ;149
 I $Y+5>IOSL D  Q:ECQUIT
 . I $E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR K DIR I 'Y S ECQUIT=1 Q
 . W @IOF D HED
 W !,$P(ECXSTR,"^",5),?11,$P(ECXSTR,"^",4),?26,$P(ECXSTR,"^",16)
 W ?37,$$FMTE^XLFDT($$HL7TFM^XLFDT($P(ECXSTR,"^",8)),2)
 W ?49,$P(ECXSTR,"^",11),?60,$J(+$P(ECXSTR,"^",12),2)
 Q
 ;
HED ;
 S ECPG=ECPG+1
 W !,"LBB Pre-Extract Audit Report",?72,"Page",$J(ECPG,3) ;136
 W !,ECSDN," - ",ECEDN,?58,"Run Date:",$J(ECRDT,12)
 W !,?37,"Transf",?57,"Number"
 W !,"Name",?14,"SSN",?25,"FDR LOC",?37,"Date",?49,"COMP"
 W ?57,"of Units"
 W !,ECLINE
 Q
DATES ;
 N OUT,CHKFLG
 I '$D(ECNODE) S ECNODE=7
 I '$D(ECHEAD) S ECHEAD=" "
 W @IOF,!,"LBB Pre-Extract Audit Report Information for DSS",!! ;136
 ;Added descriptive text DSS FY13 Logic
 W !,"**NOTE: This audit can only be run prior to the LBB Extract being generated." ;136
 W !,"If you have already generated your LBB Extract, refer to the Processing "
 W !,"Guide Chapter 4 section on Regenerating.**",!
 S:'$D(ECINST) ECINST=+$P(^ECX(728,1,0),U)
 S ECXINST=ECINST
 K ECXDIC S DA=ECINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 D EN^DIQ1 S ECINST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 S ECLDT=$S($D(^ECX(728,1,ECNODE)):$P(^(ECNODE),U,ECPIECE),1:2610624)
 S:ECLDT="" ECLDT=2610624
 S ECOUT=0 F  S (ECED,ECSD)="" D  Q:ECOUT
 . K %DT S %DT="AEX",%DT("A")="Starting with Date: " D ^%DT
 . I Y<0 S ECOUT=1 Q
 . S ECSD=Y
 . K %DT S %DT="AEX",%DT("A")="Ending with Date: " D ^%DT
 . I Y<0 S ECOUT=1 Q
 . I Y<ECSD W !!,"The ending date cannot be earlier than the starting date.",!,"Please try again.",!! Q
 . I $E(Y,1,5)'=$E(ECSD,1,5) W !!,"Beginning and ending dates must be in the same month and year.",!,"Please try again.",!! Q
 . S ECED=Y
 . I ECLDT'<ECSD W !!,"The Blood Bank information has already been extracted through ",$$FMTE^XLFDT(ECLDT),".",!,"Please enter a new date range.",!! Q
 . S ECOUT=1
 Q
 ;
QUE ;
 K ZTSAVE
 S ECSDN=$$FMTE^XLFDT(ECSD),ECEDN=$$FMTE^XLFDT(ECED),ECSD1=ECSD-.1
 K ZTSAVE
 F X="ECINST","ECED","ECSD","ECSD1","ECEDN","ECSDN" S ZTSAVE(X)=""
 F X="ECPACK","ECPIECE","ECRTN","ECGRP","ECNODE" S ZTSAVE(X)=""
 F X="ECFILE","ECHEAD","ECVER","ECINST","ECXINST" S ZTSAVE(X)=""
 F X="ECXLOGIC","ECXDATES" S ZTSAVE(X)=""
 S ZTDESC=ECPACK_" EXTRACT AUDIT REPORT: "_ECSDN_" TO "_ECEDN,ZTRTN="START^ECXPLBB",ZTIO="" ;149,153
 S IOP="Q" W ! S %ZIS="QMP" D ^%ZIS S:POP ECXPOP=1 Q:POP  I $D(IO("Q")) K IO("Q"),ZTIO D ^%ZTLOAD W:$D(ZTSK) !,$C(7),"REQUEST QUEUED",!,"Task #: ",$G(ZTSK) K I,ZTSK,ZTIO,ZTSAVE,ZTRTN D HOME^%ZIS S ECXPOP=1
 Q
 ;
EN(ECXJOB,ECSD,ECED) ; entry point used primarily for testing
 ; input:
 ;        ECXJOB = $J that is assigned to the 2nd subscript of 
 ;                 the temporary global array containing the 
 ;                 extracted data that feeds the pre-extract
 ;                 audit report
 ;        ECSD   = starting date range representing the FM
 ;                 date used to retrieve data from file #63
 ;        ECED   = ending date range representing the FM date
 ;                 used to retrieve data from file #63
 ; syntax  of the call: D EN^ECXPLBB(541571372,3000101,3000131)
 D OUTPUT
 Q
 ;
 ;ECXPLBB
