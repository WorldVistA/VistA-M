SROPLST1 ;B'HAM ISC/MAM - LIST OF OPERATIONS BY SERVICE; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
EN ; entry point
 W @IOF,!,"List of Operations sorted by Surgical Specialty",!!
DATE S (TC,SRSOUT)=0 D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 S SRD=SRSD-1
SEL W !!,"Do you want to print the report for all Specialties ?  YES// " R ANS:DTIME I '$T!(ANS["^") S SRSOUT=1 G END
 S ANS=$E(ANS) I "YyNn"'[ANS W !!,"Enter RETURN to print the report for all services, or 'N' to print the",!,"report for a specific surgical specialty." G SEL
 I "Yy"'[ANS W ! S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC("A")="Print the report for which Surgical Specialty ? ",DIC(0)="QEAMZ" D ^DIC G:Y'>0 END S SRTS=$P(Y(0),"^"),SRT1=+Y,SRZZ=1
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS I POP S SRSOUT=1 G END
 I $D(SRZZ) I $D(IO("Q")) K IO("Q") S ZTDESC="LIST OF OPERATIONS",ZTRTN="2^SROPLSTS",(ZTSAVE("SRD"),ZTSAVE("SRED"),ZTSAVE("SRSD"),ZTSAVE("SRSITE*"),ZTSAVE("SRT1"),ZTSAVE("SRTS"))="" D ^%ZTLOAD G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="LIST OF OPERATIONS",ZTRTN="1^SROPLSTS",(ZTSAVE("SRD"),ZTSAVE("SRED"),ZTSAVE("SRSD"),ZTSAVE("SRSITE*"))="",%ZIS="Q" D ^%ZTLOAD G END
 G 1^SROPLSTS
END I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 W ! D ^SRSKILL W @IOF
 Q
