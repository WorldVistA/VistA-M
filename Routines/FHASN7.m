FHASN7 ; HISC/NCA - Print Status Average ;3/10/95  08:55
 ;;5.5;DIETETICS;;Jan 28, 2005
F0 R !!,"Print by CLINICIAN or WARD? WARD// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="W" D TR^FH I $P("CLINICIAN",X,1)'="",$P("WARD",X,1)'="" W *7,"  Answer with C or W" G F0
 S SRT=$E(X,1)
DT ; Get From/To Dates
D1 S %DT="AEPX",%DT("A")="Starting Date: " W ! D ^%DT S:$D(DTOUT) X="^" G KIL:U[X,D1:Y<1 S SDT=+Y
 I SDT'<DT W *7,"  [Must Start before Today!] " G D1
D2 S %DT="AEPX",%DT("A")=" Ending Date: " D ^%DT S:$D(DTOUT) X="^" G KIL:U[X,D2:Y<1 S EDT=+Y
 I EDT>DT W *7,"  [Greater than Today?] " G D1
 I EDT<SDT W *7,"  [End before Start?] " G D1
L0 K IOP,%ZIS,ZTRTN,ZTSAVE,ZTDESC
 W !!,"The report requires a 132 column printer.",!
 S %ZIS="QM",%ZIS("B")="",IOP="Q" W !! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) D  G KIL
 .K IO("Q")
 .S ZTRTN="TSK^FHASN7",ZTREQ="@"
 .S ZTSAVE("SRT")="",ZTSAVE("SDT")="",ZTSAVE("EDT")="",ZTSAVE("ZTREQ")=""
 .S ZTDESC="Nutrition Status Average"
 .D ^%ZTLOAD
 .Q
 E  D  G L0
 .D ^%ZISC
 .W !?5,"This is a very time consuming report,"
 .W !?5,"it must be queued to print.",*7
 .Q
 G KIL
TSK ; Tasking the Report
 U IO D Q0^FHASN71 D ^%ZISC K %ZIS,IOP,ZTSK G KIL
KIL K ^TMP($J) G KILL^XUSCLEAN
