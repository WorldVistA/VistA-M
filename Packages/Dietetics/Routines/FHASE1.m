FHASE1 ; HISC/REL/NCA - Encounter Statistics ;3/6/95  11:57
 ;;5.5;DIETETICS;;Jan 28, 2005
 ; Check for multidivisional site
 I $P($G(^FH(119.9,1,0)),U,20)'="N" D ^FHMASE1 Q
 D DT G:U[X KIL G A0
IND ; List Encounters for a clinician
 ; Check for multidivisional site
 I $P($G(^FH(119.9,1,0)),U,20)'="N" D IND^FHMASE1 Q
 D DT G:U[X KIL S FHX1=DUZ,FHX2=0 G F1
A0 R !!,"Statistics for ALL Clinicians? Y// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="Y" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES or NO" G A0
 I X?1"Y".E G F0
A1 K DIC S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="Select CLINICIAN: " W ! D ^DIC K DIC G KIL:"^"[X!$D(DTOUT),A1:Y<1 S FHX1=+Y,FHX2=1 G F2
F0 R !!,"Break-down by Clinician? Y// ",X:DTIME G:'$T!(X=U) KIL S:X="" X="Y" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES or NO" G F0
 S FHX1=X?1"Y".E-1,FHX2=0
F1 I FHX1'<0 R !!,"List Individual Patient Encounters? N// ",X:DTIME G:'$T!(X=U) KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES or NO" G F1
 S:FHX1'<0 FHX2=X?1"Y".E
F2 W !!,"The report requires a 132 column printer.",!
 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHASE1A",FHLST="EDT^SDT^FHX1^FHX2" D EN2^FH G KIL
 U IO D Q1^FHASE1A D ^%ZISC K %ZIS,IOP G KIL
KIL K ^TMP($J) G KILL^XUSCLEAN
DT ; Get From/To Dates
D1 S %DT="AEPX",%DT("A")="Starting Date: " W ! D ^%DT S:$D(DTOUT) X="^" Q:U[X  G:Y<1 D1 S SDT=+Y
 I SDT>DT W *7,"  [Cannot Start after Today!] " G D1
D2 S %DT="AEPX",%DT("A")=" Ending Date: " D ^%DT S:$D(DTOUT) X="^" Q:U[X  G:Y<1 D2 S EDT=+Y
 I EDT<SDT W *7,"  [End before Start?] " G D1
 I EDT>DT W *7,"  [Must Not enter date greater than Today!] " G D1
 Q
