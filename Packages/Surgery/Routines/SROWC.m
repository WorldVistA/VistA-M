SROWC ;B'HAM ISC/ADM - WOUND CLASSIFICATION REPORT ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
 S (SRSOUT,SRSP)=0
 W @IOF,!,"Wound Classification Report",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
RPT W @IOF,!,"Print which of the following ?",!!,"1.  Wound Classification Report (Summary)",!,"2.  List of Operations by Wound Classification",!,"3.  Clean Wound Infection Summary"
 W !!,"Select Number:  1// " R X:DTIME I '$T!(X["^") G END
 S:X="" X=1 I X>3!(X<1)!(X'?.N) D HELP G:SRSOUT END G RPT
 S SRFLG=X I SRFLG=2 G CLASS
SPEC W !!!,"Do you want to print the report for all Surgical Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print this report for all surgical specialties, or 'NO' to",!,"select a specific specialty." G SPEC
 I "Nn"[SRYN D SP I SRSOUT G END
DEVICE W ! K IOP,%ZIS,POP,IO("Q") S %ZIS="QM",%ZIS("A")="Print on Device: " D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="WOUND CLASSIFICATION REPORT",ZTRTN="SROWC1",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRSP*"),ZTSAVE("SRFLG"),ZTSAVE("SRCLASS"))="" D ^%ZTLOAD G END
 G ^SROWC1
 Q
SP W !! S SRSP=1 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the report for which Specialty ?  " D ^DIC I Y<0 S SRSOUT=1 Q
 S SRCT=+Y,SRSP(SRCT)=+Y
MORE ; ask for more surgical specialties
 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select An Additional Specialty:  " D ^DIC I Y>0 S SRCT=+Y,SRSP(SRCT)=+Y G MORE
 Q
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC,^SRSKILL W @IOF
 Q
HELP W !!,"Enter '1' or press RETURN to print the Wound Classification Report",!,"which summarizes wound classifications entered for surgical cases performed"
 W !,"during the selected date range.  Enter '2' to print the list of operations",!,"sorted by wound classification and by surgical specialty performed during",!,"the selected date range.  "
 W "Enter '3' to print the summary of clean wound",!,"infections."
 W !!,"Press RETURN to continue, or '^' to quit.  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
CLASS W !!!,"Do you want to print the report for all Wound Classifications ? YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print this report for all wound classifications, or",!,"enter 'NO' to select a specific wound classification." G CLASS
 I "Yy"[SRYN S SRCLASS="ALL" G SPEC
 D CLIST W ! K DIR S DIR("A",1)="Print report for which Wound Classification ?",DIR("A",2)="" F Z=1:1 Q:'$D(SRWC(Z))  S DIR("A",Z+2)=Z_".  "_SRWC(Z),SRCNT=Z
 S Z=Z+2,DIR("A",Z)="",DIR("A")="Select Number:  ",DIR("?")="Enter a number between 1 and "_SRCNT_".",DIR(0)="NAO^1:"_SRCNT_":0" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRSOUT=1 G END
 S SRCLASS=SRCODE(Y) G SPEC
 Q
CLIST ; get list of wound classifications
 N SRLIST,SRC,SRP,J,X,Y,Z D HELP^DIE(130,"",1.09,"S","SRLIST")
 S Z=1 F I=2:1:SRLIST("DIHELP") D  S Z=Z+1
 .S X=SRLIST("DIHELP",I),Y=$F(X," "),SRC=$E(X,1,Y-2),SRCODE(Z)=SRC
 .F J=Y:1 I $E(X,J)'=" " S SRP=$E(X,J,99),SRWC(Z)=SRP Q
 S SRCODE(Z)="",SRWC(Z)="NO CLASS ENTERED"
 Q
