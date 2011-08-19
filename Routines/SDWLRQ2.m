SDWLRQ2 ;;IOFO BAY PINES/TEH - ADHOC WAIT LIST REPORT PRIM CARE TEAM AND POSITION ASSIGNMENTS;06/12/2002 ; 29 Aug 2002  2:53 PM
 ;;5.3;scheduling;**263,425,482**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   
 ;   
 ;   
 ;   
EN ;Header
 N ZCODE,ZTDESC,ZTDTH,ZTIO,ZTQUEDED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 N SDTEAM,SDHIST,SDACTIVE
 D HD
1 S SDWLINST="",SDWLERR=0,SDWLE=0 K ^TMP("SDWLRQ2",$J),DIC,DIR,DR,DIE
 D INS G END:SDWLERR
2 D CAT G 1:SDWLERR
3 D OPEN G 2:SDWLERR
 S ^TMP("SDWLRQ2",$J,"DATE")=""
4 I %=2 D DATE G 3:SDWLERR
6 D FORM G 4:SDWLERR,END:$D(DUOUT)
7 D DIS G EN:SDWLERR=1,END:SDWLERR=2
 D QUE
 Q
INS ;Get Institution
 S SDWLPROM="Select Institution ALL // ",SDWLERR=0
IN W ! S DIC(0)="QEMA",DIC("A")=SDWLPROM,DIC=4,DIC("S")="I $D(^SCTM(404.51,""AINST"",+Y))" D ^DIC I Y<0,'SDWLE D
 .S (SDWLINS,SDWLINST)="" F  S SDWLINS=$O(^SCTM(404.51,"AINST",SDWLINS)) Q:SDWLINS=""  S SDWLINST=SDWLINST_SDWLINS_";"
 I X="^" S SDWLERR=1 Q
 G IN2:Y<0,END:$D(DUOUT)
 I Y="All"!(Y="")!(Y="all")!(Y="ALL") S ^TMP("SDWLRQ2",$J,"INS")=SDWLINST G IN3
 S SDWLINST=SDWLINST_+Y_";",SDWLPROM="Another Institution: ",SDWLE=1 G IN
IN2 S ^TMP("SDWLRQ2",$J,"INS")=SDWLINST
IN3 Q
DATE ;Date range selection
 S %=1 W !,"Print Report for ALL dates? " D YN^DICN
 I %=1 S ^TMP("SDWLRQ2",$J,"DATE")="ALL" G E1
 Q:%=0
 Q:%=-1
 S SDWLERR=0 W ! S %DT="AE",%DT("A")="Start with Date Entered: " D ^%DT G E1:Y<1 S SDWLBDT=Y
 S %DT(0)=SDWLBDT,%DT("A")="End with Date Entered: " D ^%DT
 I X["^" S SDWLERR=1 Q
 G E1:Y<1 S SDWLEDT=Y K %DT(0),%DT("A")
 I SDWLEDT<SDWLBDT W !,"Beginning Date must be greater than Ending Date." G DATE
 S ^TMP("SDWLRQ2",$J,"DATE")=SDWLBDT_"^"_SDWLEDT Q
E1 Q
CAT ;Report category selection
 W !!,"    *** Report Category Selection ***" S SDWLERR=0
 S SDWLERR=0,SDWLCAT="",DIR(0)="S0^1:Team;2:Position",DIR("L",1)="     1. Team",DIR("L")="     2. Position"
 D ^DIR
 I X="^" S SDWLERR=1 Q
 S X=$S(X["T":"T",X["t":"T",X["P":"P",X["p":"P",X=1:"T",X=2:"P",1:"")
 I X="" W *7," Invalid Selection." G CAT
 W !!,"Select Category for Report Output",!
 S SDWLX=$S(X="T":"Team: ALL/ ",X="P":"Position: ALL/ ")
 S SDWLF=$S(X="T":404.51,X="P":404.57)
 K DIR,DIC,DR
 S ^TMP("SDWLRQ2",$J,"CT1")=X_"^"_SDWLF
 S DIC("A")=SDWLX
 I SDWLF=404.51 D
 .S DIC("S")="I $$ACTIVE^SDWLRQ2(Y),SDWLINST[+$P($G(^SCTM(404.51,+Y,0)),""^"",7)"
CT1 W ! S DIC(0)="QEMNZA",DIC=SDWLF D ^DIC
 I X="^" S SDWLERR=1 Q
 I Y<1,SDWLCAT="" S ^TMP("SDWLRQ2",$J,"CT2")="ALL" G CT3
 I Y<0,'$D(^TMP("SDWLRQ2",$J,"CT1")) W !,"This Entry is Required." G CAT
 G CT2:Y<0
 S SDWLCAT=SDWLCAT_Y_";",DIC("A")="Another "_$P(SDWLX,":",1)_": ",SDWLE=1 G CT1
CT2 G CT1:'$D(SDWLCAT) S ^TMP("SDWLRQ2",$J,"CT2")=SDWLCAT
CT3 Q
OPEN ;OPEN Wait List Entries  
 S %=1 W !!,"Do you want only 'OPEN' Wait List Entries " D YN^DICN
 I '% W *7,"Must Enter 'YES' or 'NO'." G OPEN
 I %=-1 S SDWLERR=1
 S ^TMP("SDWLRQ2",$J,"OPEN")=$S(%=1:"O",1:"C")
 Q
FORM ;Report Format
 S SDWLERR=0,DIR(0)="SO^1:Detailed;2:Summary",DIR("L",2)="     1. Detailed"
 S DIR("L")="     2. Summary",DIR("L",1)="Select One of the Following: "
 D ^DIR
 I X="^" S DUOUT=1 Q
 S X=$S(X["S":"S",X["s":"S",X["D":"D",X["d":"D",X=1:"D",X=2:"S",1:"")
 I X="" W *7," Invalid Response" G FORM
 S ^TMP("SDWLRQ2",$J,"FORM")=X
 Q
DIS ;Display Parameters
 S SDWLERR=0 W !!,?80-$L("*** Selected Report Parameters ***")\2,"*** Selected Report Parameters ***",!
 F SDWLI="INS","CT1","CT2","FORM","OPEN" D
 .S X="SDWL"_SDWLI,@X=$G(^TMP("SDWLRQ2",$J,SDWLI))
 F SDWLTAG="IS","CT","OP","PR" D @SDWLTAG
 Q
IS I SDWLINS'["ALL" D
 .K SDWLY F I=1:1 S SDWLY=$P($P(SDWLINS,";",I),U,1) Q:SDWLY=""  S SDWLY(I)=SDWLY
 .W !,?20,"Institution: "
 .I $D(SDWLY) S I="" F  S I=$O(SDWLY(I)) Q:I=""  W:I>1 !,?33 W $P($G(^DIC(4,SDWLY(I),0)),U,1)
 .K SDWLY
 I SDWLINS["ALL" W !,?20,"Institution: ALL "
 Q
CT I SDWLCT2'["ALL" D
 .S SDWLF=$P(SDWLCT1,U,2)
 .K SDWLY F I=1:1 S SDWLY=$P($P(SDWLCT2,";",I),U,2) Q:SDWLY=""  S SDWLY(I)=SDWLY
 .W !,?16,"Report Category: " W $S(SDWLCT1["T":"Team",1:"Position"),!,?36 I @X="ALL" W "All "
 .I $D(SDWLY) S I="" F   S I=$O(SDWLY(I)) Q:I=""  W:I>1 !,?35 W $$EXTERNAL^DILFD(SDWLF,.01,,SDWLY(I))
 I SDWLCT2["ALL" W !,?16,"Report Category: " W $S(SDWLCT1["T":"Team",1:"Position"),!,?36 W "ALL "
 Q
OP W !,?18,"Output Format: ",$S(SDWLFORM="D":" Detailed",1:" Summary")
 Q
PR I SDWLOPEN="O" W !,?25,"Printing 'OPEN' Entries Only."
 E  W !,?25,"Printing ALL Entries."
 S %=1 W !!,"Are these Parameters Correct " D YN^DICN I %=2 S SDWLERR=1 W !,"  This Report will NOT be queued to print."
 I SDWLERR S DIR(0)="E" D ^DIR I X["^" S SDWLERR=2
 Q
ACTIVE(Y) ;Active Team
 S SDTEAM="",SDHIST="",SDACTIVE=""
 I SDWLF="404.51" D
 .S SDHIST=$O(^SCTM(404.58,"B",+Y,SDHIST),-1)
 .S SDACTIVE=$P($G(^SCTM(404.58,+SDHIST,0)),"^",3)
 Q +SDACTIVE
QUE ;Queue Report
 N ZTQUEUED,POP
 K %ZIS,IOP,IOC,ZTIO,SDWLSPT S %ZIS="MQ" D ^%ZIS G:POP QUE1
 S ZTRTN=$S(SDWLFORM="D":"EN^SDWLRPT2",1:"EN^SDWLRPS2"),ZTDTH=$H,ZTDESC="WAIT LIST REPORT FORMAT 2"
 S SDWLTASK="" F  S SDWLTASK=$O(^TMP("SDWLRQ2",$J,SDWLTASK)) Q:SDWLTASK=""  D
 .S SDWLTK=$G(^TMP("SDWLRQ2",$J,SDWLTASK))
 .S ZTSAVE(SDWLTASK)=SDWLTK
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED" G END
QUE1 S:$E(IOST,1,2)="C-" SDWLSPT=1 I $D(ZTRTN) U IO D @ZTRTN K SDWLSPT
 ;
END K SDWLTASK,SDWLY,SDWLED,WDWLBD,SDWLOPEN,SDWLDATE,SDWLFORM,SDWLPRI
 K DIR,DIC,DR,DIE,SDWLSPT,I
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HD W:$D(IOF) @IOF W !,?80-$L("Primary Care Team/Position Assignment Wait List Report")\2,"Primary Care Team/Position Assignment Wait List Report"
