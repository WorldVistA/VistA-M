SROSNR ;B'HAM ISC/MAM - SCRUB NURSE REPORT ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
 S SRSOUT=0,SRINST=SRSITE("SITE")
ALL W @IOF,!,"Scrub Nurse Staffing Report",!!,"Do you want the report for all nurses ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print the Scrub Nurse Staffing Report for all nurses, or 'NO'",!,"to select a specific person.",!!,"Press RETURN to continue  " R X:DTIME G ALL
 S SRALL=$S("Yy"[SRYN:1,1:0) I SRALL S NURSE="" G DATE
 W ! K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Print the Report for which Scrub Nurse ?  " D ^DIC I Y<0 S SRSOUT=1 G END
 S NURSE=+Y,NURSE("NAME")=$P(Y(0),"^")
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 S SRSD1=$E(SRSD,4,5)_"/"_$E(SRSD,6,7)_"/"_$E(SRSD,2,3)
 S SRED1=$E(SRED,4,5)_"/"_$E(SRED,6,7)_"/"_$E(SRED,2,3)
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("A")="Print the Report on which Device: " W !!,"This report is designed to use a 132 column format.",! D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="SCRUB NURSE STAFFING REPORT",ZTRTN="BEG^SROSNR",(ZTSAVE("SRALL"),ZTSAVE("SRINST"),ZTSAVE("SRSD*"),ZTSAVE("SRED*"),ZTSAVE("NURSE*"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
BEG N SRFRTO S Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 I SRALL D BEG^SROSNR1 G END
 D BEG^SROSNR2
END ;
 I $E(IOST)="P" W @IOF S SRSOUT=1
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^SRSKILL K SRTN D ^%ZISC W @IOF
 Q
