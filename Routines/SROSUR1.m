SROSUR1 ;B'HAM ISC/MAM - SURGEON STAFFING REPORT ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
EN ; entry point
 W @IOF,!,"Surgeon Staffing Report",!
 D DATE^SROUTL(.SRSD,.SRED,.SRQ) G:SRQ END
 S SRINST=SRSITE("SITE")
ALL ; print for one surgeon or all
 W !!,"Do you want to print this report for an individual surgeon ?  YES//  " R X:DTIME S:'$T X="^" S:X="" X="Y" I "^"[X G END
 S X=$E(X) I "YyNn"'[X W !!,"Enter RETURN if you would like to print the report for a specific surgeon, or",!,"'NO' to print the report for all surgeons." G ALL
 I "Yy"[X G ^SROSUR2
 W ! K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="SURGEON STAFFING REPORT",ZTRTN="EN1^SROSUR",(ZTSAVE("SRED"),ZTSAVE("SRSD"),ZTSAVE("SRINST"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
 G EN1^SROSUR
END W ! D ^SRSKILL K SRTN D ^%ZISC W @IOF
 Q
OTHER ; set ^TMP for other assistants
 S SROTH=0 F I=0:0 S SROTH=$O(^SRF(SRTN,28,SROTH)) Q:'SROTH  S SROTHER=^SRF(SRTN,28,SROTH,0),SROTHER=$P(^VA(200,SROTHER,0),"^"),^TMP("SRO",$J,SROTHER,"OTH",DATE,SRTN)=""
 Q
