SROUNV ;B'HAM ISC/MAM - UNVERIFIED CASES ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
 S SRSOUT=0
SPEC W @IOF,!,"Do you want the list for all Surgical Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you would like to list the unverified cases for",!,"all Surgical Specialties, or 'NO' to select a specific specialty.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 S SRSPEC="" I "Yy"'[SRYN W ! K DIC S DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select Surgical Specialty: ",DIC("S")="I '$P(^(0),""^"",3)" D ^DIC K DIC S:Y<0 SRSOUT=1 G:Y<0 END S SRSPEC=+Y,SRSPECN=$P(Y(0),"^")
DATE D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS("A")="Print the List of Unverified Cases to which Printer ? ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="UNVERIFIED CASES",(ZTSAVE("EDATE"),ZTSAVE("SDATE"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRSPEC*"))="",ZTRTN="EN^SROUNV" D ^%ZTLOAD S SRSOUT=1 G END
EN I SRSPEC D ^SROUNV1 G END
 D ^SROUNV2
END I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SRTN D ^SRSKILL W @IOF
 Q
