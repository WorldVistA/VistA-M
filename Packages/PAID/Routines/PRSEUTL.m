PRSEUTL ;HISC/JH/MD-EMPLOYEE EDUCATION REPORT - UTILITY ;4/24/1998
 ;;4.0;PAID;**13,25,32,41**;Sep 21, 1995
INS ; INSERVICE SELECTION
 S DIR(0)="SO^M:Mandatory Training (MI);C:Continuing Education;O:Other/Miscellaneous;W:Ward/Unit-Location Training;A:All",DIR("A")="Select Sort Parameter"
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT)!(U[X) S POUT=1 Q
 S PRSESEL=Y
 Q
INS2 ; INSERVICE SELECTION
 S DIR(0)="SO^M:Mandatory Training (MI);C:Continuing Education;O:Other/Miscellaneous;W:Ward/Unit-Location Training;A:All;L:All without Mandatory;H:All without Hosptial Wide Mandatory"
 S DIR("A")="Select Sort Parameter"
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT)!(U[X) S POUT=1 Q
 S PRSESEL=Y
 Q
DATSEL ;
 S DATSEL=U_$G(DATSEL)_U,DIR(0)="SO^C:Calendar Year;F:Fiscal Year;"
 I DATSEL'["^NS^" S DIR(0)=DIR(0)_"S:Selected Date Range;"
 S DIR("A")="Select a Sort Parameter"
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT)!(U[X) S POUT=1 Q
 S TYP=Y,YR=$E(DT,1,3)+1700 I TYP="F" S MN=$E(DT,4,5) S:MN>9 YR=(YR+1)
 S DIR(0)="DA^^K:X'?4N X"
 S X=YR D ^%DT D:+Y D^DIQ S DIR("B")=Y,DIR("?")="This response must be a year i.e. 1990"
 I TYP["C" S DIR("A")="Select Calendar Year: " W ! D
 .D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S POUT=1 Q
 .S PYR=$G(Y(0)),YR(6)=$E($G(Y),1,3)+1700,%DT="",X=Y D ^%DT S YRST=+Y,%DT="",X="12/31/"_YR(6) D ^%DT S YREND=+Y_".24" K %DT S X1=YRST,X2=-90 D C^%DTC S YRCHK=X
 I TYP["F" S DIR("A")="Select Fiscal Year: " W ! D
 .D ^DIR S PYR=$G(Y(0)),YR(6)=$E(Y,1,3)+1700 K DIR I $D(DTOUT)!$D(DUOUT) S POUT=1 Q
 .S %DT="",X="10/"_(YR(6)-1) D ^%DT S YRST=+Y S %DT="",X="9/30/"_YR(6) D ^%DT S YREND=+Y_".24" K %DT S X1=YRST,X2=-90 D C^%DTC S YRCHK=X
 I TYP["S" K DIR D
 .W ! S X=DT D ^%DT D:+Y D^DIQ S DIR("B")=Y,DIR(0)="DA^"_$S($D(PRSECAL):DT,1:"")_"::ET",DIR("A")="Start With DATE: ",DIR("?")="^S %DT(0)=$S($D(PRSECAL):DT,1:-DT) D HELP^%DTC"
 .I DATSEL["^N+^" S DIR(0)="DA^:"_DT_":ET",DIR("?")="^S %DT(0)=-DT D HELP^%DTC"
 .D ^DIR K %DT(0),DIR I $D(DTOUT)!$D(DUOUT)!(U[X) S POUT=1 Q
 .S YRST=+Y,X=DT,%DT="T" D ^%DT D:+Y D^DIQ S YRST(1)=$E(YRST,4,5)_"/"_$E(YRST,6,7)_"/"_$E(YRST,2,3) W ! S DIR("B")=Y,DIR("A")="     Go to DATE: "
 .S DIR(0)="DA^"_+YRST_"::ET",DIR("?")="^D HELP^%DTC"
 .I DATSEL["^N+^" S DIR(0)="DA^"_+YRST_":"_DT_":ET",DIR("?")="^S %DT(0)=-DT D HELP^%DTC"
 .D ^DIR K %DT(0),DIR I $D(DTOUT)!$D(DUOUT)!(U[X) S POUT=1 Q
 .S X1=YRST,X2=+90 D C^%DTC S YRCHK=X
 .S YREND=+Y_$S(+Y#1:"",1:".24"),YREND(1)=$E(YREND,4,5)_"/"_$E(YREND,6,7)_"/"_$E(YREND,2,3)
 K DATSEL,YR Q
EN2 ; INPUT XFORM: FREQUENCY FIELD IN 452.1
 S X=$S(X="1M":.08,X="3M":.25,X="6M":.5,X="1Y":1,X="2Y":2,X="3Y":3,X="1T":0,1:"")
 Q
EN3 ; OUTPUT XFORM: FREQUENCY FIELD IN 452.1
 S Y=$S(Y=.08:"1M",Y=.25:"3M",Y=.5:"6M",Y=1:"1Y",Y=2:"2Y",Y=3:"3Y",Y=0:"1T",1:"")
 Q
DEV ;
 S %ZIS="QM" D ^%ZIS K %ZIS K:POP IO("Q") I POP S (POUT,NQT)=1 G Q7
 I IO'=IO(0),$E(IOST)="P",'$D(IO("Q")),'$D(IO("S")) W !,$C(7),"THIS REPORT MUST BE QUEUED TO A PRINTER",! G DEV
 I $D(PRSE132),IOM<132 D ^%ZISC W !,$C(7)," ** THIS REPORT MUST BE SENT TO A 132 COLUMN DEVICE **",! K IO("Q"),IO("C") G DEV
 F X="A*","B*","C*","D*","E*","F*","G*","H*","I*","J*","K*","L*","M*","N*","O*","P*","Q*","R*","S*","T*","U*","V*","W*","X*","Y*","Z*","%H" S ZTSAVE(X)=""
 S NQ=0 I $D(IO("Q")) K IO("Q"),IO("C") S NQ=1,ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL D ^%ZTLOAD S NQ=0 S:'$D(ZTSK) POP=1
Q7 K ZTRTN,ZTSAVE
 Q
EN3A ; CLASS DATE
 W ! S X=U,NSP(1)=0,%DT("A")="Start With CLASS DATE (Press return for all dates): ",%DT="AE",X=U D ^%DT K %DT
 I X="" S NSP(1)=1 Q
 I Y'>0!(X=U) S POUT=1 Q
 S NSPC(1)=Y
 W ! S X=U,NSPC(2)=0,%DT("A")="Go To CLASS DATE (Press return for all dates until present date): ",%DT="AE",X=U D ^%DT K %DT
 I X="" S X="T" D ^%DT S NSPC(2)=Y Q
 I Y'>0!(X=U) S POUT=1 Q
 S NSPC(2)=Y
 Q
LAYGO(SER) ; LAYGO NODE IN 452.8 DETERMINE IF
 ; ENTRY CAN BE ADDED. RETURNS 1 IF IT CAN ADD
 S:'(+Y>0) SER=2 N DUP S DUP=0 S:'$D(SER)#2 SER=""
 I SER="" W !,"CANNOT ADD THIS ENTRY, USE OPTIONS PROVIDED BY PACKAGE."
 E  I $D(^PRSE(452.8,"AA",SER,X)) W !,"CANNOT ADD THIS ENTRY AS IT WOULD CREATE A DUPLICATE."
 E  S DUP=1
 Q DUP
DICS(FOUND) ; SCREEN 452.1
 N VA200DA,VA450DA,SSN,PRSX
 S PRSX=0,PRSX(0)=$G(^PRSE(452.1,+Y,0)),SSN=$P($G(^VA(200,DUZ,1)),U,9),VA200DA=DUZ,VA450DA=$O(^PRSPC("SSN",SSN,0))
 I $G(REGSW)=1,$$EN2^PRSEUTL2($G(Y)) D
 .I $S(DUZ(0)["@":0,+$$EN4^PRSEUTL3($G(DUZ)):0,1:1) I $P($G(PRSX(0)),U,7)="M",$G(PRSESLF),'$D(^PRSPC(+VA450DA,6,"B",+Y)) Q
 .I $S(PRSETYP="A":1,1:$P(PRSX(0),U,7)=PRSETYP),($P(PRSX(0),U,8)=PRSESER!($P(PRSX(0),U,9)=0!(DUZ(0)["@"!(+$$EN4^PRSEUTL3($G(DUZ)))))) S (PRSX,FOUND)=1
 .Q
 I 'FOUND,$$LASTDA(+Y) D MSG20^PRSEMSG W ! K PRSEW
 Q PRSX
LASTDA(DA) ; DETERMINE IF DATA IS LAST ENTRY IN 452.1
 N X,Y,LAST S LAST=0
 S X=$P($G(^PRSE(452.1,DA,0)),U),Y=$O(^PRSE(452.1,"B",X))
 I Y="" S Y=$O(^PRSE(452.1,"B",X,DA)) I Y="" S LAST=1
 Q LAST
DICS1(FOUND) ; SCREEN 4 LOOKUP IN 452.1
 N PRSX S PRSX=0
 I '$G(REGSW)=1,$$EN3^PRSEUTL2($G(Y)),$P(^PRSE(452.1,+Y,0),U,7)=PRSETYP,($P(^(0),U,8)=PRSESER!($P(^(0),U,9)=0!(DUZ(0)["@"!(+$$EN4^PRSEUTL3($G(DUZ)))))) S (PRSX,FOUND)=1
 I 'FOUND,$$LASTDA(+Y) D MSG20^PRSEMSG W ! K PRSEW
 Q PRSX
CLOSE ; CLOSE DEVICE
 I '$G(POUT) D ENDPG^PRSEUTL
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
ENDPG ; HANDLE EOP
 I $E(IOST)'="C" Q
 K DIR S DIR(0)="E" D ^DIR K DIR S POUT=$S(+Y'>0:1,1:0)
 Q
