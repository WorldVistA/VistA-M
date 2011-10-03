PRCSP1A ;WISC/SAW/BGJ-CONTROL POINT ACTIVITY PRINT OPTIONS CON'T ;5/1/92  9:20 AM [2/18/99 9:02am]
V ;;5.1;IFCAP;**90,145**;Oct 20, 2000;Build 3
 ;Per VHA Directive 10-93-142, this routine should not be modified.
CPB ;CP BAL
 N PRCSST
 S PRCSST=1 D EN1^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0 S PRCSZ=Z
CPB1 K C1 W !,"Summary Balances Report Only" S %=2 D YN^DICN G EXIT:%<0,CPB1:%=0 S:%=1 C1=1
 D DEV1 G EXIT:POP I $D(IO("Q")) S ZTRTN="QUE^PRCSP1A",ZTDESC="RUNNING BALANCE REPORT",ZTSAVE("PRC*")="" S:$D(C1) ZTSAVE("C1")="" D ^%ZTLOAD D ^%ZISC D W1 G EXIT:%'=1 W !! G CPB
 D QUE D ^%ZISC D W1 G EXIT:%'=1 K C1 W !! G CPB
QUE ;
 N PRCC,PRCD,PRCE
 N A,B
 S PRC("CP")=$P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),"^",1)
 U IO S Z1="",P=0 D NOW^%DTC S Y=% D DD^%DT S TDATE=Y,PRCS("A")=1 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),"^",11)="Y" S PRCS("A")=1
 S PRCC=$P($$QTRDATE^PRC0D(PRC("FY"),PRC("QTR")),"^",7)
 S PRCC=PRCC_"-"_PRC("SITE")_"-"_$P(PRC("CP")," ")_"-",PRCD=PRCC_"~"
 S (N,Z,Z(0))=PRCSZ,Z(0)=Z(0)_"-",(PRCS("O"),PRCS("C"))=0,N(1)="" D:'$D(C1) HDR D:$D(C1) HDR2
 I $G(C1)=1 W !,"STATION: ",PRC("SITE"),"   FUND CONTROL POINT: ",PRC("CP"),!,?5,"FISCAL YEAR: ",PRC("FY"),"   QTR: ",PRC("QTR")
 F  S PRCC=$O(^PRCS(410,"RB",PRCC)),N(1)=0 QUIT:PRCC]PRCD!'PRCC  D
 . F  S N(1)=$O(^PRCS(410,"RB",PRCC,N(1))),J=" " QUIT:'N(1)  D
 .. S:'PRCS("A") J=$S($D(^PRCS(410,N(1),7)):$P(^PRCS(410,N(1),7),"^",6),1:"")
 .. I J'=""!($P(^PRCS(410,N(1),0),"^",2)'="O"),$P(^(0),"^",2)]"" D TOT
 Q:Z1=U  D CRT:$E(IOST,1,2)="C-" QUIT:Z1=U  D ^PRCSFMS Q:Z1=U
 D:IOSL-$Y<8 HOLD Q:Z1=U
 W !!!,"Balance Summary",?20,$J("1st Quarter",15),$J("2nd Quarter",15),$J("3rd Quarter",15),$J("4th Quarter",15)
 S PRCC=$$FCPBAL^PRC0D(PRC("SITE"),PRC("CP"),PRC("FY"),2)
 S PRCD=$$FCPBAL^PRC0D(PRC("SITE"),PRC("CP"),PRC("FY"),1)
 W !!,"Actual CP Bal:",?20 F A=1:1:4 W $J($P(PRCC,"^",A),15,2)
 W !,"Actual Fiscal Bal:",?20 F A=1:1:4 W $J($P(PRCD,"^",A),15,2)
 W !,"Tot Commit, not Obl:",?20 F A=1:1:4 W $J($J($P(PRCD,"^",A),0,2)-$J($P(PRCC,"^",A),0,2),15,2)
 I $J(PRCS("C"),0,2)-$J($P(PRCC,"^",PRC("QTR")),0,2)!($J(PRCS("O"),0,2)-$J($P(PRCD,"^",PRC("QTR")),0,2)) W ! D EN^DDIOL("Report balances do not agree with actual balances. Please recalculate"),EN^DDIOL("your control point.")
 W !!,"SECTION 1 CODES  # - cancelled order   * - order not obligated or signed",!,?17,"@ - purchase card order for reconciliation",!,?17,"& - reconciled order with final charge - ready for approval",!,?17,"R - total reconciled charges"
 W !,"SECTION 2 CODES",!,?17,"@ - purchase card CC transaction is not reconciled",!
 W !,"The symbols '*','@', and '&' indicate incomplete items.",!,"Please take the necessary steps to clear these items."
 D EXIT D:$D(ZTSK) KILL^%ZTLOAD Q
TOT N PRCA,PRCB,PRCG,PRCF,PRCH,PRCJ,PRCK
 S T="" S:$D(^PRCS(410,N(1),4)) T=^(4) S X=^(0),Z=$P(X,"^",2),T(0)=$P(T,"^",5),T(1)=$J($P(T,"^",8),0,2),T(3)=$P(T,"^",14),T=$J($P(T,"^",3),0,2),PRCA=$G(^(4)),PRCB=$G(^(7)),PRCH="*^*"
 I $P($G(^PRCS(410,N(1),1)),"^",2)=9999999 S PRCH=""
 S PRCF=$G(^PRCS(410,N(1),0)),PRCG=$P(PRCF,"^",2),PRCK=$P(PRCF,"^"),PRCF=$P(PRCF,"^",4),PRCK=$P(PRCK,"-",2)_$P(PRCK,"-",3)_$P(PRCK,"-",5)
 I PRCG="A",PRCF=1 S:$P(PRCB,"^",6)]"" PRCS("C")=PRCS("C")-T(1),$P(PRCH,"^")="" S:$P(PRCA,"^",10)]"" PRCS("O")=PRCS("O")-T,$P(PRCH,"^",2)="" Q:$D(C1)  G WRT
 I PRCG="O" S:$P(PRCB,"^",6)]"" PRCS("C")=PRCS("C")-T(1),$P(PRCH,"^")="" S:$P(PRCA,"^",10)]"" PRCS("O")=PRCS("O")-T,$P(PRCH,"^",2)=""
 I PRCG="C" S PRCH="",PRCS("C")=PRCS("C")+T(1),PRCS("O")=PRCS("O")+T
 I PRCG="A" S PRCH="",PRCS("C")=PRCS("C")-T(1) S:T(3)'="Y" PRCS("O")=PRCS("O")-T
 I PRCG="CA" S PRCH="#^#"
 S PRCJ=$P($G(^PRCS(410,N(1),4)),"^",5)
 I PRCH'["#",PRCJ'="" S PRCJ=$P(^PRCS(410,N(1),0),"-")_"-"_PRCJ,PRCJ=$O(^PRC(442,"B",PRCJ,0)) I +PRCJ'=0,$P($G(^PRC(442,PRCJ,0)),"^",2)=25 S X=$G(^(7)) D
 . S:PRCG'="A" PRCH="@" S:$P($G(X),"^",2)=40!($P($G(X),"^",2)=41) PRCH="^" S:$P($G(X),"^",2)=50!($P($G(X),"^",2)=51) PRCH="&"
 . S T=$P($$FP^PRCH0A(+PRCJ),U,2),$P(PRCH,"^",2)="R"
 . QUIT
 QUIT:$D(C1)
WRT Q:Z1=U  D:IOSL-$Y<8 HOLD Q:Z1=U  S X1=$S(Z="O":"OBLIGATION",Z="A":"ADJUSTMENT",Z="CA":"CANCELLED",1:"CEILING")
 I $P($G(^PRCS(410,N(1),0)),"^",4)=5 S X1="ISSUE BOOK"
 S PZIP=$P($P(X,"^"),"-",5),PZIP=$E(PZIP,1,4)
 W !,PRCK,?8,$E(X1,1,3),?12,T(0)
 S Y=$P($G(^PRCS(410,N(1),4)),"^",4) S:Y="" Y=$P($G(^PRCS(410,N(1),7)),"^",5) I Y'="" W ?26,$E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3)
 W ?36,$J(T(1),10,2),$P(PRCH,"^")
 W ?47,$J(PRCS("C"),10,2) I T'="",T(3)'="Y" W ?58,$J(T,10,2),$P(PRCH,"^",2)
 W ?69,$J(PRCS("O"),10,2) Q
HDR S P=P+1 W @IOF,"CONTROL POINT BALANCE - ",Z(0)_" "_$P(PRC("CP")," ",2),?50,TDATE,?73,"PAGE ",P
 W !!,?69,"FISCAL"
 W !,"FYQSeq# TXN OBL #",?26,"AP/OB DT",?37,"COMM $AMT",?50,"CP $BAL",?60,"OBL $AMT",?69,"UNOBL $BAL"
 S L="",$P(L,"-",IOM)="-" W !,L S L="" Q
HDR2 S P=P+1 W @IOF,"CONTROL POINT BALANCE - ",Z(0)_" "_$P(PRC("CP")," ",2),?50,TDATE,?73,"PAGE ",P,! Q
HOLD G HDR:$E(IOST,1,2)'="C-"
CRT W !,"Press return to continue, uparrow (^) to exit: " R Z1:DTIME S:'$T Z1=U I ((Z1'=U)&('$D(C1)))  D HDR
 Q
CTR ;CEILING TRANS
 D EN^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0 S PRCSAZ=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 S FLDS="[PRCSCTR]",DHD="CEILING REPORT -  CP: "_PRC("CP"),BY="@.01,@1",FR=PRCSAZ_"-0001,C",TO=PRCSAZ_"-9999,C" D S
 N REPORT2 S REPORT2=1 D T2^PRCSAPP1 K PRC("CP"),PRCSAZ G CTR
ITEMH ;EP;Entry Point for Control Point ITEM HISTORY ; AAC/JDM 10-12-97 -  ADDED LINES 66-67 & 69-80 FOR E3R #3344
 ;EN3^PRCSUT Gets the SITE & Prompts for CONTROL POINT
 ;DODIP Runs EN1^DIP to list history to selected device
 D EN3^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0 S D0=+Y
 S CTL=$P(Y,U,2),(FR1,TO1)=CTL
 ;
 ; CHOOSE OLD WAY ( LAST 5 ) OR NEW WAY ( DATE RANGE )
 K DIR
 S DIR(0)="S^L:Last 5 Purchase Orders;D:Date Range"
 S DIR("A")="Select ITEM HISTORY Viewing Method"
 S DIR("B")="L"
 D ^DIR
 G:$D(DIRUT) EXIT
 W !
 G:Y="L" ITEMH1
 ;
 ; FALL THROUGH TO DATE RANGE DISPLAY
 ;
ITEMH0 ; VIEW HISTORY BY DATE RANGE
 ;
 S DIC="^PRC(441,",DIC(0)="AEMNQZ" D ^DIC G EXIT:Y<0
 S (FR2,TO2)=$P(Y,U,1)
 K DIR S DIR(0)="D",DIR("A")="DATE ORDERED (BEGIN RANGE) ",DIR("B")="T-30" D ^DIR G:$D(DIRUT) EXIT
 D ^%DT S FR3=Y
 K DIR S DIR(0)="D",DIR("A")="DATE ORDERED   (END RANGE) ",DIR("B")="T" D ^DIR G:$D(DIRUT) EXIT
 D ^%DT S TO3=Y
 D DODIP
 G ITEMH
 ;
ITEMH1 S DIC="^PRC(441,",DIC(0)="AEMNQZ" D ^DIC G EXIT:Y<0 S D0=+Y
 D DEV G EXIT:POP
 ;
ITEMH2 W @IOF S X=D0 D ITEM0^PRCSES1 I $D(ZTSK) D KILL^%ZTLOAD G EXIT
W3 D:$E(IOST,1,2)="C-" W W !!,"Would you like to look at another Item History" S %=2 D YN^DICN G W3:%=0,EXIT:%=2!(%<0) G ITEMH
S S L=0,DIC="^PRCS(410,"
 D EN1^DIP Q
 ;
DEV K IO("Q") S IOP="HOME" D ^%ZIS Q
 ;
DEV1 K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q
 ;
W1 K YY S YY(1)="Would you like to run another running balances report",YY(1,"F")="!!" D EN^DDIOL(.YY)
 S %=2 D YN^DICN G W1:%=0 Q
W2 K YY S YY(1)="You are not an authorized control point user.",YY(1,"F")="!!",YY(2)="Contact your control point official.",YY(2,"F")="!" D EN^DDIOL(.YY)
 K DIR S DIR(0)="E" D ^DIR G EXIT
W4 K YY S YY(1)="Enter information for another report or '^' to return to the menu.",YY(1,"F")="!!" D EN^DDIOL(.YY) Q
W I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR
 I $E(IOST,1,2)'="C-" D ^%ZISC U IO
 ;
EXIT K PUR,TDATE,REPORT2,%,%IS,%DT,BY,C0,C2,C3,D,D0,DA,DHD,DIC,DIE,P
 K PRCSZ,PRCS,FLDS,FR,I,L,N,T,TO,X,X1,Y,Z,Z1,PZIP,ZTRTN,ZTSAVE Q
 K C,CTL,DIR,DTOUT,DUOUT,DIROUT,DIRUT,FR1,FR2,FR3,PRC,PRCSIP,TO1,TO2,TO3,AA,YY
 Q
WRITMD ;EP0; WRITES ITEM SHORT DESCRIPTION ON HISTORY HEADER
 W $P(^PRC(441,FR2,0),U,2)
 Q
WRITMN ;EP; WRITES ITEM NUMBER
 W $P(^PRC(441,FR2,0),U,1)
 Q
DODIP ; EP ;FOR RTNS CALLING FOR CP ITEM HIST
 ; AAC/JDM 11/12/97 - THIS SECTION ADDED FOR E3R #3344
 ; PRCSPGQ  is page variable
 ; PRCSDT   is Date/Time in DEC 11, 1998@8:35 format
 ;
 S PRCSPGQ=0
 D NOW^%DTC
 S Y=$J(%,7,4)
 D DD^%DT
 S PRCSDT=Y
 S FLDS="[PRCS CP ITEMHIST]",BY="[PRCS CP ITEMHIST]",L=0,DIC="^PRCS(410,"
 S FR=FR1_","_FR2_","_FR3
 S TO=TO1_","_TO2_","_TO3
 D EN1^DIP
 Q
