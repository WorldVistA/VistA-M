FHDCR1 ; HISC/REL/NCA/RVD - Diet Cards ;4/21/95  10:10
 ;;5.5;DIETETICS;;Jan 28, 2005
F0 R !!,"Print by PATIENT or COMMUNICATION OFFICE or LOCATION or ALL? COMM// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="C" D TR^FH
 I $P("PATIENT",X,1)'="",$P("LOCATION",X,1)'="",$P("COMMUNICATION OFFICE",X,1)'="",$P("ALL",X,1)'="" W *7,!,"  Answer with P or C or A or L" G F0
 G P0:X?1"P".E,W0:X?1"L".E I X?1"A".E S (DFN,FHP,W1)="" G S0
 S FHP=$O(^FH(119.73,0)) I FHP'<1,$O(^FH(119.73,FHP))<1 S (DFN,W1)="" G S0
D0 K DIC S DIC="^FH(119.73,",DIC("A")="Select COMMUNICATION OFFICE: ",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:"^"[X!$D(DTOUT),D0:Y<1 S FHP=+Y,(DFN,W1)="" G S0
W0 K DIC S DIC("A")="Select DIETETIC LOCATION: ",DIC="^FH(119.6,",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:"^"[X!$D(DTOUT),W0:Y<1 S W1=+Y,(DFN,FHP)="" G S0
P0 S FHALL=1 D ^FHOMDPA G:'FHDFN KIL S (FHP,W1)="",UPD=0,SORT="R" G F1
 I $G(DFN),($P($G(^DPT(DFN,.35)),"^",1)) W *7,!!?5,"  [ Patient has expired. ]" G KIL
S0 R !!,"Sort Patients: (A=Alphabetically  R=Room-Bed) R// ",SORT:DTIME G:'$T!(SORT["^") KIL S:SORT="" SORT="R" I "ar"[SORT S X=SORT D TR^FH S SORT=X
 I SORT'?1U!("AR"'[SORT) W *7," Enter A or R" G S0
F1 S %DT("A")="Select Date: ",%DT="AEFX",%DT("B")="TODAY",%DT(0)=DT W ! D ^%DT G KIL:"^"[X!$D(DTOUT),F1:Y<1 S (X1,D1)=+Y
 D E1^FHPRC1 S FLG=0 I FHCY<1 S FLG=1,(FHDA,FHX1)="" G R0
 I '$D(^FH(116,FHCY,"DA",FHDA,0)) S FLG=1,(FHDA,FHX1)=""
R0 R !!,"Print Three Per Page? N//",X:DTIME G:'$T!(X="^") KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G R0
 S TPP=$E(X,1),TPP=TPP="Y" I 'TPP S MEAL="A",FLG=1,(FHDA,FHX1)="" G P1
R1 R !!,"Select MEAL (B,N,E,or ALL): ",MEAL:DTIME G:'$T!("^"[MEAL) KIL S X=MEAL D TR^FH S MEAL=X S:$P("ALL",MEAL,1)="" MEAL="A"
 I "BNEA"'[MEAL!(MEAL'?1U) W *7,!,"Select B for Breakfast, N for Noon, or E for Evening or ALL for all meals" G R1
P1 I FLG G L0:DFN,R2
 S FHDA=^FH(116,FHCY,"DA",FHDA,0)
 I $D(^FH(116.3,D1,0)) S X=^(0) F LL=2:1:4 I $P(X,"^",LL) S $P(FHDA,"^",LL)=$P(X,"^",LL)
 S FHX1=FHDA G:DFN L0
R2 R !!,"Print Only Ones With Order Changes related to the Diet Card? N // ",X:DTIME G:'$T!(X="^") KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,!,"  Answer YES or NO" G R2
 S UPD=X?1"Y".E
L0 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="B1^FHDCR1A",FHLST="D1^MEAL^FHX1^FHP^FLG^W1^FHDFN^DFN^UPD^TPP^SORT" D EN2^FH G KIL
 U IO D B1^FHDCR1A D ^%ZISC K %ZIS,IOP G KIL
KIL K ^TMP($J) G KILL^XUSCLEAN
