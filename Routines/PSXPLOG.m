PSXPLOG ;BIR/BAB-Print Interface Log ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 S PSXSYS=1
ZIS S %ZIS="MQ",%ZIS("A")="Print Log on Device: " D ^%ZIS Q:POP
 I '$D(IO("Q")) U IO D EN,^%ZISC Q
 S ZTRTN="EN^PSXPLOG",ZTDTH=$H,ZTIO=ION,ZTSAVE("PSXSYS")="",ZTSAVE("ZTREQ")="@"
 D ^%ZTLOAD
 I '$D(ZTSK) D ^%ZISC U IO W "  not queued" G ZIS
 Q
 ;
 ;Called by Taskman to print the interface log
EN N PSXDT D HEAD S PSXPOP=0
 F K=0:0 S K=$O(^PSX(553,1,"X",K)) Q:'K  S Y=^(K,0) X ^DD("DD") W !,$P(Y,"@")," ",$P(Y,"@",2) D OUT,SCRN Q:PSXPOP
 K PSXMSG,PSXPOP,WORD,K,L,M
 Q
OUT F L=0:0 S L=$O(^PSX(553,1,"X",K,"X",L)) Q:'L  S PSXMSG=^(L,0) F M=1:1 S WORD=$P(PSXMSG," ",M) Q:WORD=""  W:$L(WORD)>(IOM-2-$X) ! W ?21," ",WORD
 Q
SCRN Q:($Y+3)<IOSL  G:IOST["P-" HEAD W !,"Enter ""^"" to quit"
 R X:DTIME E  S X="^"
 I X="^" S PSXPOP=1 Q
HEAD W @IOF,!!,?(IOM\2-9),"CMOP Interface Log",!!
 Q
