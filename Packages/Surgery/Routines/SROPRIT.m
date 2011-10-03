SROPRIT ;B'HAM ISC/MAM - TOTAL OPERATIONS (BY PRIORITY) ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
BEG W @IOF,!,"Report of Surgical Priorities",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 S SRD=SRSD-.0001
CHOICE W !!,"Do you want to review this information sorted by Surgical Specialty ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter RETURN if you want the totals for each Surgical Specialty, or 'NO' to",!,"display the total cases sorted by surgical priority for the entire Medical",!,"Center." G CHOICE
 S SRSS="" I "Yy"[SRYN S SRSS="ALL" D SPEC I SRSOUT G END
 W ! K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="Q" D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="LIST OF OPERATIONS",ZTRTN="EN^SROPRIT",(ZTSAVE("SRD"),ZTSAVE("SRED"),ZTSAVE("SRSD"),ZTSAVE("SRSITE*"),ZTSAVE("SRSS"))="",%ZIS="QM" D ^%ZTLOAD G END
EN ; entry when queued
 N SRFRTO S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y,Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y
 S SRINST=SRSITE("SITE"),SRD=SRSD-.0001,SRED1=SRED+.9999,SRSOUT=0
 I SRSS D ^SROPRI1 G END
 D ^SROPRI2
END I $E(IOST)="P" W @IOF
 K ^TMP("SRLIST",$J) I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC W @IOF D ^SRSKILL K SRTN
 Q
PLIST ;; get list of priorities   
 N SRLIST,SRC,SRP,I,J,X,Y D HELP^DIE(130,"",.035,"S","SRLIST")
 F I=2:1:SRLIST("DIHELP") S X=SRLIST("DIHELP",I),Y=$F(X," "),SRC=$E(X,1,Y-2) F J=Y:1 I $E(X,J)'=" " S SRP=$E(X,J,99),SRCODE(SRC)=SRP Q
 S SRCODE("ZZ")="PRIORITY NOT ENTERED"
 S X="",Y=1 F  S X=$O(SRCODE(X)) Q:X=""  S SRCODE(X)=Y_". "_SRCODE(X),Y=Y+1
 Q
SPEC ; select specialty
 W !!,"Do you want to print this report for all Surgical Specialties ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter 'YES' to print this report for all specialties, or 'NO' to select a",!,"specific specialty." G SPEC
 I "Yy"[SRYN Q
 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the report for which Surgical Specialty ? " W ! D ^DIC I Y<0 S SRSOUT=1 Q
 S SRSS=+Y
 Q
