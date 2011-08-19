PRCSP1A1 ;WISC/SAW-CONTROL POINT ACTIVITY PRINT OPTIONS CON'T ;7-16-91/12:32
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DEV K IO("Q") S IOP="HOME" D ^%ZIS Q
DEV1 K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q
W1 W !!,"Would you like to run another running balances report" S %=2 D YN^DICN G W1:%=0 Q
W2 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W4 W !!,"Enter information for another report or an uparrow to return to the menu.",! Q
W I (IO=IO(0))&('$D(ZTQUEUED)) W !!,"Press return to continue:  " R X:DTIME
 I (IO'=IO(0))!($D(ZTQUEUED)) D ^%ZISC U IO
EXIT K %,%IS,%DT,BY,C0,C2,C3,D,D0,DA,DHD,DIC,DIE,P,PRCS,FLDS,FR,I,L,N,PRCZZ,T,TO,X,X1,Y,Z,Z1,ZTRTN,ZTSAVE Q
OAR ;OUTSTANDING REQUESTS REPORTS
 D EN6^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0
 N C1 S C1=$P(PRC("CP")," "),BY="@15,.01,@1,@48,44",FR=C1_" ,"_PRC("SITE")_"-"_"-,O,@",TO=C1_" ZZ,"_PRC("SITE")_"-"_PRC("FY")_"z,O,@,"_DT,FLDS="[PRCSOAR]"
 S L=0,DIC="^PRCS(410," D EN1^DIP W !,"End of report",! Q
SUBTOT ;BOC Detail Totals Report
 W !,"This report displays item costs from 2237 orders, sorted",!,"by budget object code.",!!
 D EN1^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0
 N PRCX S PRCX=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 S DIS(0)="I $P($G(^PRCS(410,D0,0)),""-"",1,4)=PRCX"
 S L=0,DIC="^PRCS(410,",BY="[PRCSASRT]",FR=PRCX_"-0001,@",TO=PRCX_"-9999",FLDS="[PRCSSA]"
 D EN1^DIP
 N REPORT2 S REPORT2=1 D T2^PRCSAPP1 W !,"End of report",! Q
CPT ;STATUS OF OBLIGATION TRANSACTIONS
 D EN^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0 S PRCSZZ=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 S FLDS="[PRCSCPT]",DHD="STATUS OF OBLIGATION TRANSACTIONS   CP: "_PRC("CP")_" FY: "_PRC("FY"),BY="@.01,@1",FR=PRCSZZ_"-0001,O",TO=PRCSZZ_"-9999,OZ" D S K PRC("CP"),PRCSZZ G CPT
S S L=0,DIC="^PRCS(410," D EN1^DIP Q
