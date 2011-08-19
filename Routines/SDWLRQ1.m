SDWLRQ1 ;;IOFO BAY PINES/TEH - ADHOC WAIT LIST REPORT;06/12/2002 ; 20 Aug 2002  2:10 PM
 ;;5.3;scheduling;**263,399,412,425,448**;AUG 13 1993
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
 D HD
 S SDWLINST="",SDWLERR=0 K ^TMP("SDWLRQ1",$J),DIC,DIR,DR,DIE
1 D INS G END:$D(DUOUT)
2 D CAT G 1:SDWLERR,2:$D(DUOUT)
3 D DATE G 2:SDWLERR,END:$D(DUOUT)
4 D OPEN G 3:SDWLERR,3:$D(DUOUT)
5 D FORM G 4:SDWLERR,4:$D(DUOUT)
6 D DIS G EN:SDWLERR=1,END:SDWLERR=2
 D QUE
 Q
INS ;Get Institution
 N SDWLINST S SDWLINST=""
 S SDWLERR=0,SDWLPROM="Select Institution ALL // "
IN W ! S DIC(0)="QEMA",DIC("A")=SDWLPROM,DIC=4,DIC("S")="I $D(^SDWL(409.32,""C"",+Y))!($D(^SDWL(409.31,""E"",+Y)))!($D(^SCTM(404.51,""AINST"",+Y)))" D ^DIC I Y<0,'SDWLERR Q:$D(DUOUT)  S Y="ALL"
 G IN2:Y<0 Q:$D(DUOUT)
 I Y<0 S SDWLINST=$S(Y="ALL":"ALL",Y="":"ALL",Y="all":"ALL",Y="All":"ALL",Y["A":"ALL",Y["a":"ALL")
 I Y="All"!(Y="")!(Y="all")!(Y="ALL") S SDWLINST="ALL",^TMP("SDWLRQ1",$J,"INS")="ALL" G IN3
 S SDWLINST=SDWLINST_Y_";",SDWLPROM="Another Institution: ",SDWLERR=1 G IN
IN2 S ^TMP("SDWLRQ1",$J,"INS")=SDWLINST
IN3 Q
CAT ;Report category selection
 K DIR,DIE,DR,DIC
 W !!,"    *** Report Category Selection ***" S SDWLERR=0
 S SDWLERR=0,SDWLCAT="",DIR(0)="SO^1:Clinic;2:Select Service/Specialty",DIR("L",1)="     1. Clinic",DIR("L")="     2. Service/Specialty"
 D ^DIR
 I X="^" S SDWLERR=1 W *7 Q
 I X="" S SDWLERR=1 W *7 Q
 S X=$S(X["C":"C",X["c":"C",X["S":"S",X["s":"S",X=1:"C",X=2:"S",1:"")
 I X="" W *7," Invalid Selection." G CAT
 W !!,"Select Category for Report Output",!
 S SDWLX=$S(X="C":"Clinic: ALL// ",X="S":"Service/Specialty: ALL// ")
 S SDWLF=$S(X["C":409.32,X["S":409.31,X["c":409.32,X["s":409.31)
 S SDWLFD=$S(X="C":8,1:7)
 S SDWLCTX=X
 K DIR,DIC,DR
 S ^TMP("SDWLRQ1",$J,"CT1")=SDWLCTX_"^"_SDWLF_"^"_SDWLFD,DIC("A")=SDWLX,SDWLE=0
CT1 W ! S DIC(0)="QEMNZA",DIC=SDWLF D ^DIC I 'SDWLE,Y<1 S ^TMP("SDWLRQ1",$J,"CT2")="ALL" G CT3
 I Y<0,'$D(^TMP("SDWLRQ1",$J,"CT1")) W !,"This Entry is Required." G CAT
 G CT2:Y<0
 S SDWLCAT=SDWLCAT_Y_";",DIC("A")="Another "_$P(SDWLX,":",1)_": ",SDWLE=1 G CT1
CT2 G CT1:'$D(SDWLCAT) S ^TMP("SDWLRQ1",$J,"CT2")=SDWLCAT
CT3 Q
DATE ;Date range selection
 K X,Y,%DT
 S %=1 W !!,"Print Report for ALL dates? " D YN^DICN
 I %=1 S ^TMP("SDWLRQ1",$J,"DATE")="ALL" G E1
 Q:%=0
 Q:%=-1
 S SDWLERR=0 W ! S %DT="AE",%DT("A")="Start with Desired Appointment Date: " D ^%DT
 I X["^" S SDWLERR=1 Q
 G E1:Y<0 S SDWLBDT=Y
 Q:$D(DUOUT)
 S %DT(0)=SDWLBDT,%DT("A")="End with Desired Appointment Date: " D ^%DT G DATE:Y<1 S SDWLEDT=Y K %DT(0),%DT("A")
 G DATE:$D(DUOUT)
 I SDWLEDT<SDWLBDT W !,"Beginning Date must be greater than Ending Date." G DATE
 S ^TMP("SDWLRQ1",$J,"DATE")=SDWLBDT_"^"_SDWLEDT Q
E1 Q
OPEN ;OPEN Wait List Entries  
 S %=1 W !!,"Do you want only 'OPEN' Wait List Entries " D YN^DICN
 I %=0 W " Response must be 'YES' or 'NO'." G OPEN
 I %=-1 S SDWLERR=1 W *7,"?? "
 S ^TMP("SDWLRQ1",$J,"OPEN")=%
 Q
FORM ;Report Format
 S SDWLERR=0,DIR(0)="SO^1:D:Detailed;S:Summary",DIR("L",2)="     D Detailed"
 S DIR("L")="     S Summary",DIR("L",1)="Select One of the Following: "
 D ^DIR
 S SDWLFORM=$S(X["D":"D",X["d":"D",X["S":"S",X["s":"S",1:"")
 I X="^" S DUOUT=1 Q
 I SDWLFORM="" W *7,"Required!" G FORM
 S ^TMP("SDWLRQ1",$J,"FORM")=SDWLFORM
 Q
DIS ;Display Parameters
 S SDWLERR=0 W !!,?80-$L("*** Selected Report Parameters ***")\2,"*** Selected Report Parameters ***",!
 F SDWLI="INS","CT1","CT2","DATE","FORM","OPEN" D
 .S X="SDWL"_SDWLI,@X=$G(^TMP("SDWLRQ1",$J,SDWLI))
 F SDWLTAG="IS","CT","DA","OP","PR" D @SDWLTAG
 Q
IS I SDWLINS'["ALL" D
 .K SDWLY F I=1:1 S SDWLY=$P($P(SDWLINS,";",I),U,2) Q:SDWLY=""  S SDWLY(I)=SDWLY
 .W !,?20,"Institution: "
 .I $D(SDWLY) S I="" F  S I=$O(SDWLY(I)) Q:I=""  W:I>1 !,?33 W SDWLY(I)
 .K SDWLY
 I SDWLINS["ALL" W !,?20,"Institution: ALL "
 Q
CT I SDWLCT2'["ALL" D
 .S SDWLF=$P(SDWLCT1,U,2)
 .K SDWLY F I=1:1 S SDWLY=$P($P(SDWLCT2,";",I),U,2) Q:SDWLY=""  S SDWLY(I)=SDWLY
 .W !,?16,"Report Category: " W $S(SDWLCT1["C":"Clinic",1:"Service Specialty"),!,?36 I @X="ALL" W "All "
 .I $D(SDWLY) S I="" F   S I=$O(SDWLY(I)) Q:I=""  W:I>1 !,?35 W $$EXTERNAL^DILFD(SDWLF,.01,,SDWLY(I))
 I SDWLCT2["ALL" W !,?16,"Report Category: " W $S(SDWLCT1["C":"Clinic",1:"Service Specialty"),!,?36 W "ALL "
 Q
DA W !,?13,"Date Desired Range: " S Y=$P(SDWLDATE,U,1) D DD^%DT S SDWLBD=Y S Y=$P(SDWLDATE,U,2) D DD^%DT S SDWLED=Y
 W " ",SDWLBD
 I SDWLED'="" W " to ",SDWLED
 Q
OP W !,?18,"Output Format: ",$S(SDWLFORM="D":" Detailed",1:" Summary")
 Q
PR I SDWLOPEN=1 W !,?25,"Printing 'OPEN' Entries Only."
 E  W !,?25,"Printing ALL Entries."
 S %=1 W !!,"Are these Parameters Correct " D YN^DICN I %=2 S SDWLERR=1 W !,"  This Report will NOT be queued to print."
 I SDWLERR S DIR(0)="E" D ^DIR I X["^" S SDWLERR=2
 Q
QUE ;Queue Report
 N ZTQUEUED,POP
 K %ZIS,IOP,IOC,ZTIO S %ZIS="MQ" D ^%ZIS G:POP QUE1
 S ZTRTN=$S(SDWLFORM="D":"EN^SDWLRPT1",1:"EN^SDWLRPS1"),ZTDTH=$H,ZTDESC="WAIT LIST REPORT FORMAT 1"
 S SDWLTASK="" F  S SDWLTASK=$O(^TMP("SDWLRQ1",$J,SDWLTASK)) Q:SDWLTASK=""  D
 .S SDWLTK=$G(^TMP("SDWLRQ1",$J,SDWLTASK))
 .S ZTSAVE(SDWLTASK)=SDWLTK
 S ZTSAVE("SDWLF")=""  ; SD*5.3*412
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED" G END
QUE1 S:$E(IOST,1,2)="C-" SDWLSPT=1 I $D(ZTRTN) U IO D @ZTRTN K SDWLSPT
 ;
END ;
 K SDWLTASK,SDWLY,SDWLED,WDWLBD,SDWLOPEN,SDWLDATE,SDWLFORM,SDWLPRI,I
 K DIR,DIC,DR,DIE,SDWLERR,SDWLF,SDWLX,SDLFD,SDWLCTX,SDWLDAT,SDWLPROM,SDWLINST,SDWLI,SDWLTAG,SDWLY
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HD W:$D(IOF) @IOF W !,?80-$L("Appointment Wait List Report")\2,"Appointment Wait List Report"
 Q
