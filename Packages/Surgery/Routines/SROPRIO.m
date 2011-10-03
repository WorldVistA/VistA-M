SROPRIO ;B'HAM ISC/MAM - LIST OF OPERATIONS (BY PRIORITY) ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
BEG S (SRSP,SRQ)=0,SRORD=1 W @IOF,!,"List of Operations by Surgical Priority:",!!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRQ) G:SRQ END
PRIO W @IOF,! K DIR S DIR("A")="Print List of Operations for all priorities ",DIR("B")="Y",DIR(0)="Y"
 S DIR("?",1)="Enter RETURN to print the report for all priorities,or 'N' to print the",DIR("?")="report for a specific specialty."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I Y S SRPRIO="ALL" G SORT
 D PRIORITY S X="",Z=1 F  S X=$O(SRCODE(X)) Q:X=""  S SRL(Z)=X,Z=Z+1
 W ! K DIR S DIR("A",1)="Print report for which Priority ?",DIR("A",2)="",X="",Z=0 F  S X=$O(SRCODE(X)) Q:X=""  S Z=Z+1,DIR("A",Z+2)=Z_".  "_SRCODE(X)
 S DIR("A",Z+3)="",DIR("A")="Select Number: ",DIR("B")=1,DIR("?")="Enter a number between 1 and "_Z_".",DIR(0)="NA^1:"_Z_":0" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 G END
 S SRPRIO=SRL(Y)
SORT W !!,"Do you want the report sorted by surgical specialty ?  Y// " R SRYN:DTIME I '$T!(SRYN["^") S SRQ=1 G END
 S:SRYN="" SRYN="Y" S SRYN=$E(SRYN)
 I "YyNn"'[SRYN W !!,"Enter RETURN to sort the report by surgical specialty, or 'N' to not sort",!,"by surgical specialty." G SORT
 I "Nn"[SRYN S SRORD=0 G DEVICE
SER W !!,"Print for all surgical specialties ?  Y// " R SRYN:DTIME I '$T!(SRYN["^") S SRQ=1 G END
 S:SRYN="" SRYN="Y" S SRYN=$E(SRYN)
 I "YyNn"'[SRYN W !!,"Enter RETURN to print the report for all surgical specialties, or 'N' to print",!,"the report for a specific specialty." G SER
 I "Nn"[SRYN D SP I SRQ G END
DEVICE K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="LIST OF OPERATIONS",ZTRTN="^SROPRI",(ZTSAVE("SRORD"),ZTSAVE("SRSP*"),ZTSAVE("SRED"),ZTSAVE("SRPRIO"),ZTSAVE("SRSD"),ZTSAVE("SRSITE*"))="",%ZIS="QM" D ^%ZTLOAD G END
 D ^SROPRI
 Q
PRIORITY ; get list of priorities
 N SRLIST,SRC,SRP,I,J,X,Y D HELP^DIE(130,"",.035,"S","SRLIST")
 F I=2:1:SRLIST("DIHELP") S X=SRLIST("DIHELP",I),Y=$F(X," "),SRC=$E(X,1,Y-2) F J=Y:1 I $E(X,J)'=" " S SRP=$E(X,J,99),SRCODE(SRC)=SRP Q
 S SRCODE("ZZ")="PRIORITY NOT ENTERED"
 Q
SP W ! S SRSP=1 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the report for which Specialty ?  " D ^DIC I Y<0 S SRQ=1 Q
 S SRSP(+Y)=+Y
MORE ; more specialties?
 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select An Additional Specialty:  " D ^DIC I Y>0 S SRSP(+Y)=+Y G MORE
 Q
END I 'SRQ,($E(IOST,1)'="P") W !!,"Press RETURN to continue  " R X:DTIME
 W ! D ^SRSKILL K SRTN D ^%ZISC W @IOF
 Q
RET W !!,"  Press RETURN to continue, or '^' to quit: " R X:DTIME I '$T!(X["^") S SRQ=1 Q
 I X["?" W !!,"Press RETURN to continue with the List of Surgical Cases sorted by Surgical",!,"Priority, or '^' if you do not want to review any additional information." G RET
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRQ=1 Q
 I SRHDR,$E(IOST)'="P" D RET Q:SRQ
 W:$Y @IOF W !,?(132-$L(SRINST)\2),SRINST,?125,"PAGE:",!,?58,"SURGICAL SERVICE",?127,PAGE
 W !,?47,"LIST OF OPERATIONS BY SURGICAL PRIORITY",?100,SRPRINT
 W !,?(132-$L(SRFRTO)\2),SRFRTO,?100,"REVIEWED BY:"
 I SRPRIO'="ALL" S SRP=SRPRIO
 I SRP'="" S SRTP="SURGICAL PRIORITY: "_SRCODE(SRP) W !,?(132-$L(SRTP)\2),SRTP,?100,"DATE REVIEWED:"
 I SRP="" W !,?100,"DATE REVIEWED:"
 W !!,"DATE",?13,"PATIENT",?38,"OPERATION(S)",?90,"SURGEON",?114,"ANESTHESIA TECH",!,"CASE #",?15,"ID#",?90,"1ST ASST",!,?90,"2ND ASST" W ! F I=1:1:132 W "-"
 I $D(SRSPEC) W !,?(132-$L(">> "_SRSPEC_" <<")\2),">> "_SRSPEC_" <<",!
 S SRHDR=1,PAGE=PAGE+1
 Q
