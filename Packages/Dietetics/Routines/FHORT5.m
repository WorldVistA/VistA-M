FHORT5 ; HISC/REL/NCA/RVD - Tubefeeding Reports ;3/1/04  13:31
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
ALL ; Print All Reports
 S FHOPT=1 G A0
PREP ; Print Preparation Report Only
 S FHOPT=2 G A0
COST ; Print Tubefeed Cost Report
 S FHOPT=3 G A0
LAB ; Print Tubefeed Labels
 S FHOPT=4 G A0
PULL ; Product Pick List
 S FHOPT=5 G A0
A0 R !!,"Select C=COMMUNICATION OFFICE or L=LOCATION: ",FHXX:DTIME G:'$T!("^"[FHXX) KIL I "cl"[FHXX S X=FHXX D TR^FH S FHXX=X
 I FHXX'?1U!("CL"'[FHXX) W *7,"Enter C or L" G A0
 I FHXX="C" G A2
A1 R !!,"Select LOCATION (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHP=0,FHXX="L",WRD=0
 E  K DIC S DIC="^FH(119.6,",DIC(0)="EQM" D ^DIC G:Y<1 A1 S FHP=+Y,WRD=$P(Y,"^",2)
 G A3
A2 S FHP=$O(^FH(119.73,0)) I FHP'<1,$O(^FH(119.73,FHP))<1 G A3
 R !!,"Select COMMUNICATION OFFICE (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHP=0,FHXX="C",WRD=0
 I X'="ALL" K DIC S DIC="^FH(119.73,",DIC(0)="EMQ" D ^DIC G:Y<1 A2 S FHP=+Y
A3 S (SUM,MUL)=0 G A5:FHOPT=4,A6:FHP
A4 R !!,"Consolidated Report Only? Y// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="Y" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G A4
 S SUM=X?1"Y".E G A6
A5 W ! K DIR,LABSTART S DIR(0)="NA^1:10",DIR("A")="If using laser label sheets, what row do you want to begin printing at? ",DIR("B")=1 D ^DIR
 Q:$D(DIRUT)  S LABSTART=Y
 R !!,"Do you want multiple labels? N// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Enter YES or NO" G A5
 S MUL=X?1"Y".E
A6 I FHOPT'>2 W !!,"The report requires a 132 column printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select "_$S(FHOPT=4:"LABEL",1:"LIST")_" Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHORT5A",FHLST="FHXX^FHOPT^FHP^WRD^SUM^MUL^LABSTART" D EN2^FH G KIL
 U IO D Q1^FHORT5A D ^%ZISC K %ZIS,IOP G KIL
KIL K ^TMP($J) G KILL^XUSCLEAN
