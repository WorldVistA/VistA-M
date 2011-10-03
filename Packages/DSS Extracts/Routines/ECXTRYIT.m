ECXTRYIT ;BIR/DMA-Test Run for Setup Extract Print Population ; [ 07/24/96  1:30 PM ]
 ;;3.0;DSS EXTRACTS;;Dec 22, 1997
EN ;entry point from ooption
 I '$D(DT) S DT=$$HTFM^XLFDT(+$H)
 W !!,"This option will print the admission data and data for the last",!,"transfer and treating specialty change for all patients who",!,"were in the hospital on the day you select.",!!
 W !!,"NOTE - This will generate a report of your inpatient population on the",!,"BEGINNING of the day you select, not the end of the day as MAS reports do.",!
 W "For example, for this report, if you choose October 1, 1994, the report will",!,"start at midnight at the beginning of the day."
 W "  For the MAS report, you would",!,"choose September 30, 1994.  The MAS report begins at midnight at the end",!,"of the day.",!!!
DATE S DIR(0)="D",DIR("A")="Select the date ",DIR("B")=$$HTE^XLFDT($H-1) D ^DIR K DIR G END:$D(DIRUT) S ECD=Y I Y>DT W !!,"Must be a date in the past",!! G DATE
 W !!,"This report must be queued to a 132 column printer.",!
 S %ZIS="NQ" D ^%ZIS K %ZIS G END:POP S ZTSAVE("ECD")="",ZTDESC="Print inpatient list (DSS)",ZTRTN="START^ECXTRYIT" D ^%ZTLOAD
END K POP,X,Y,ECD D ^%ZISC Q
 ;
START ;queued entry point
 K ^TMP($J) S DFN="",ECD0=9999999.9999999-ECD
 F  S DFN=$O(^DGPM("ATID1",DFN)) Q:'DFN  S EC1=$O(^(DFN,ECD0)) I EC1 S ECDA=$O(^(EC1,0)) I $D(^DGPM(ECDA,0)) S EC=^(0),ECX=+$P(EC,"^",17),ECAS=$P(EC,"^",18)=40 S:$S('ECX:1,$G(^DGPM(ECX,0))>ECD:1,1:0) ^TMP($J,DFN,ECDA)=$P(EC,"^",6) I ECAS D
 .F EC1=EC1:0 S EC1=$O(^DGPM("ATID1",DFN,EC1)) Q:'EC1  S ECDA=$O(^(EC1,0)) I ECDA S EC=^DGPM(ECDA,0) I $P(EC,"^",18)'=40 S ECX=$P(EC,"^",17) Q
 .I EC1,ECDA,$S('ECX:1,'$D(^DGPM(ECX,0)):1,^DGPM(ECX,0)>ECD:1,1:0) S ^TMP($J,DFN,ECDA)=$P(EC,"^",6)
 ;
 S DFN=0 F  S DFN=$O(^TMP($J,DFN)) Q:'DFN  S X=$O(^(DFN,0)) I $O(^(X)) K ^(X)
 ;if he has an NHCU and an ASIH open, get rid of the NHCU one since
 ;he may have been transferred in the hospital and we don't want to
 ;find him twice
 ;
 ;now hunt transfers
 ;
 S DFN=0 F  S DFN=$O(^TMP($J,DFN)),ECCA=0 Q:'DFN  F  S ECCA=$O(^TMP($J,DFN,ECCA)) Q:'ECCA  S ECM=$O(^DGPM("APMV",DFN,ECCA,ECD0)) I ECM S ECDA=$O(^(ECM,0)) I ECDA,ECDA'=ECCA,$D(^DGPM(ECDA,0)) S EC=^(0),^TMP($J,DFN,ECCA)=$P(EC,"^",6)
 ;
 ;now put in name order
 S DFN=0 F  S DFN=$O(^TMP($J,DFN)),ECCA=0 Q:'DFN  F  S ECCA=$O(^TMP($J,DFN,ECCA)) Q:'ECCA  D
 .S W=+^(ECCA),W=$P($G(^DIC(42,W,0)),"^") S:W="" W="unknown" S ^TMP($J,"L",W,$P(^DPT(DFN,0),"^")_"^"_DFN)=$P(^DPT(DFN,0),"^",9)_"^"_$P($P(^DGPM(ECCA,0),"^"),".")
 ;
 S W="" F  S W=$O(^TMP($J,"L",W)),NAM="" Q:W=""  D HEAD F  S NAM=$O(^TMP($J,"L",W,NAM)) Q:NAM=""  S EC=^(NAM) W !,?5,$P(NAM,"^"),?45,$P(EC,"^"),?66,$$FMTE^XLFDT($P(EC,"^",2)) I $Y+4>IOSL,$O(^TMP($J,"L",W,NAM))]"" D HEAD
 K ^TMP($J) S ZTREQ="@" D ^%ZISC Q
 ;
HEAD W:$Y @IOF W !!,?30,"INPATIENT WARD LIST (DSS) FOR ",$$FMTE^XLFDT(ECD),"    FOR WARD ",W,!!,?12,"PATIENT",?50,"SSN",?66,"ADMIT DATE",!
 Q
