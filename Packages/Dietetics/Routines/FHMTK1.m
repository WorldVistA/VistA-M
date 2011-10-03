FHMTK1 ; HISC/REL/NCA - Tray Tickets ;4/20/95  15:28
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
F0 ;
 K FHOMF,DFN,IEN200 S FHBY="",FHTTDFN=0
 K DIR S DIR(0)="SBAO^P:Patient;C:Communication Office;L:Location;A:All"
 S DIR("B")="COMM"
 S DIR("A")="Print by PATIENT, COMMUNICATION OFFICE, LOCATION or ALL? "
 D ^DIR I $D(DIRUT) D KIL Q
 S FHBY=Y
 I FHBY="P" D P0 Q
 I FHBY="C" D C0 Q
 I FHBY="L" D NL0 Q
 I FHBY="A" S (DFN,FHP,W1)="" D S0 Q
 Q
C0 ; Sort by Communication Office
 S FHP=$O(^FH(119.73,0))
 I FHP'<1,$O(^FH(119.73,FHP))<1 S (DFN,W1)="" G S0
 K DIC S DIC="^FH(119.73,",DIC("A")="Select COMMUNICATION OFFICE: "
 S DIC(0)="AEQM" W ! D ^DIC K DIC
 G KIL:"^"[X!$D(DTOUT),C0:Y<1 S FHP=+Y,(DFN,W1)="" G S0
NL0 ; Sort by Location
 K DIC S DIC="^FH(119.6,",DIC("A")="Select NUTRITION LOCATION: "
 S DIC(0)="AEQM" W ! D ^DIC K DIC
 G KIL:"^"[X!$D(DTOUT),NL0:Y<1 S W1=+Y,(DFN,FHP)="" G S0
P0 ; Single patient
 S FHALL=1 D ^FHOMDPA S FHTTDFN=FHDFN I 'FHDFN D KIL Q
 I 'DFN D P1 Q
 I $G(^DPT(DFN,.1))="" D P1 Q
 S (FHP,W1)="",SRT="R" G F1
 I $P($G(^DPT(DFN,.35)),"^",1) W !!?5,"  [ Patient has expired. ]" G KIL
S0 ; Start
 I $G(TABREC)="YES" S SRT="A" G F1
 R !!,"Sort Patients: (A=Alphabetically  R=Room-Bed) R// ",SRT:DTIME G:'$T!(SRT["^") KIL S:SRT="" SRT="R" I "ar"[SRT S X=SRT D TR^FH S SRT=X
 I SRT'?1U!("AR"'[SRT) W *7," Enter A or R" G S0
F1 S %DT("A")="Select Date: ",%DT="AEFX",%DT("B")="TODAY",%DT(0)=DT W ! D ^%DT G KIL:"^"[X!$D(DTOUT),F1:Y<1 S (X1,D1)=+Y
 D E1^FHPRC1 I FHCY<1 W *7,!!,"No MENU CYCLE Defined for that Date!" G F1
 I '$D(^FH(116,FHCY,"DA",FHDA,0)) W *7,!!,"MENU CYCLE DAY Not Defined for that Date!" G F1
R1 R !!,"Select MEAL (B,N,E,or ALL): ",MEAL:DTIME G:'$T!("^"[MEAL) KIL S X=MEAL D TR^FH S MEAL=X S:$P("ALL",MEAL,1)="" MEAL="A"
 I "BNEA"'[MEAL!(MEAL'?1U) W *7,!,"Select B for Breakfast, N for Noon, or E for Evening or ALL for all meals" G R1
 S FHOMEAL=MEAL,FHDA=^FH(116,FHCY,"DA",FHDA,0)
 I $D(^FH(116.3,D1,0)) S X=^(0) F LL=2:1:4 I $P(X,"^",LL) S $P(FHDA,"^",LL)=$P(X,"^",LL)
 I MEAL="A" F LP="B","N","E" S FHX1=$P(FHDA,"^",$F("BNE",LP)) I 'FHX1 W *7,!!,"*** NO MENU DEFINED FOR ",$S(LP="B":"BREAKFAST",LP="N":"NOON",1:"EVENING")," ***" G KIL
 S (SUM,UPD)=0 G:MEAL="A" D5
 S FHX1=$P(FHDA,"^",$F("BNE",MEAL)) I 'FHX1 W *7,!!,"*** NO MENU DEFINED FOR THIS MEAL ***" G KIL
 ;I $G(IEN200)'="",$G(FHOMF)=1 Q
 G L0:DFN,R2
D5 G:DFN!($G(IEN200)'="") L0 R !!,"Consolidated List? Y// ",X:DTIME G:'$T!(X="^") KIL S:X="" X="Y" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G D5
 S SUM=X?1"Y".E
R2 I $G(TABREC)="YES" G L0
 R !!,"Print Only Ones With Order Changes related to the Tray Ticket? N // ",X:DTIME G:'$T!(X="^") KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,!,"  Answer YES or NO" G R2
 S UPD=X?1"Y".E
L0 ;I $G(FHOMF)=1 Q
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="B1^FHMTK1A",FHLST="D1^MEAL^IEN200^FHOMEAL^FHOMF^FHBY^FHDFN^FHTTDFN^FHX1^FHP^W1^DFN^FHDA^SUM^UPD^SRT^TABREC" D EN2^FH G KIL
 U IO D B1^FHMTK1A D ^%ZISC K %ZIS,IOP G KIL
KIL K ^TMP($J),TABREC G KILL^XUSCLEAN
 ;
TABREC ; Entry point for separate Print Tab Recipes option
 S TABREC="YES" D F0
 K TABREC Q
P1 ; Tray tickets for single outpatient
 S (FHP,W1)="",SRT="R",FHOMF=1,NBR=0,MFLG=0
 S FHBOT=$P($G(^FH(119.9,1,4)),"^",1) D F1
 S LN=$S(IOST?1"C".E:IOSL-2,1:IOSL-6),SL=40
 I '$D(MEAL) Q
 I MEAL="A" S MFLG=1
 D ^FHOMTK1 Q
 Q
