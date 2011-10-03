SDWLQOF ;;IOFO BAY PINES/TEH - OVERDUE APPOINTMENT
 ;;5.3;scheduling;**263,414,425,448**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;
EN ;Header
 N ZCODE,ZTDESC,ZTDTH,ZTIO,ZTQUEDED,ZTREQ,ZTRTN,ZTSAVE,ZTSK,SDWLSPT
 D HD
 S SDWLINST="",SDWLERR=0 K ^TMP("SDWLQOF",$J),DIC,DIR,DR,DIE
1 D INS G END:$D(DUOUT)
2 D CAT G 1:SDWLERR,END:$D(DUOUT)
3 D FORM G 2:SDWLERR,END:$D(DUOUT)
4 D DIS G EN:SDWLERR=1,END:SDWLERR=2
 D QUE
 Q
INS ;Get Institution
 S SDWLERR=0,SDWLPROM="Select Institution ALL // "
IN W ! S DIC(0)="QEMA",DIC("A")=SDWLPROM,DIC=4,DIC("S")="I $D(^SDWL(409.32,""C"",+Y))!($D(^SDWL(409.31,""E"",+Y)))!($D(^SCTM(404.51,""AINST"",+Y)))" D ^DIC I Y<0,'SDWLERR Q:$D(DUOUT)  S Y="ALL"
 G IN2:Y<0 Q:$D(DUOUT)
 I Y<0 S SDWLINST=$S(Y="ALL":"ALL",Y="":"ALL",Y="all":"ALL",Y="All":"ALL",Y["A":"ALL",Y["a":"ALL")
 I Y="All"!(Y="")!(Y="all")!(Y="ALL") S SDWLINST="ALL",^TMP("SDWLQOF",$J,"INS")="ALL" G IN3
 S SDWLPROM="Another Institution: ",SDWLERR=1
 G IN:$D(SDWLIN(+Y)) S SDWLIN(+Y)=""
 S SDWLINST=SDWLINST_Y_";",SDWLPROM="Another Institution: ",SDWLERR=1 G IN
IN2 S ^TMP("SDWLQOF",$J,"INS")=SDWLINST
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
 S SDWLX=$S(X="C":"Clinic: ALL/ ",X="S":"Service/Specialty: ALL/ ")
 S SDWLF=$S(X["C":409.32,X["S":409.31,X["c":409.32,X["s":409.31)
 S SDWLFD=$S(X="C":8,1:7)
 S SDWLCTX=X
 K DIR,DIC,DR
 S ^TMP("SDWLQOF",$J,"CT1")=SDWLCTX_"^"_SDWLF_"^"_SDWLFD,DIC("A")=SDWLX,SDWLE=0
CT1 W ! S DIC(0)="QEMNZA",DIC=SDWLF D ^DIC I 'SDWLE,Y<1 S ^TMP("SDWLQOF",$J,"CT2")="ALL" G CT3
 I Y<0,'$D(^TMP("SDWLQOF",$J,"CT1")) W !,"This Entry is Required." G CAT
 G CT2:Y<0
 S SDWLCAT=SDWLCAT_Y_";",DIC("A")="Another "_$P(SDWLX,":",1)_": ",SDWLE=1 G CT1
CT2 G CT1:'$D(SDWLCAT) S ^TMP("SDWLQOF",$J,"CT2")=SDWLCAT
CT3 Q
FORM ;Report Format
 S SDWLERR=0,DIR(0)="SO^1:D:Detailed;S:Summary",DIR("L",2)="     D Detailed"
 S DIR("L")="     S Summary",DIR("L",1)="Select One of the Following: "
 D ^DIR
 I X="^" S DUOUT=1 Q
 S SDWLFORM=$S(X["D":"D",X["d":"D",X["S":"S",X["s":"S",1:"")
 I X="" W !,"Required!" G FORM
 S ^TMP("SDWLQOF",$J,"FORM")=SDWLFORM
 Q
DIS ;Display Parameters
 S SDWLERR=0 W !!,?80-$L("*** Selected Report Parameters ***")\2,"*** Selected Report Parameters ***",!
 F SDWLI="INS","CT1","CT2","FORM" D
 .S X="SDWL"_SDWLI,@X=$G(^TMP("SDWLQOF",$J,SDWLI))
 F SDWLTAG="IS","CT","OP" D @SDWLTAG
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
OP W !,?18,"Output Format: ",$S(SDWLFORM="D":" Detailed",1:" Summary")
 Q
 S %=1 W !!,"Are these Parameters Correct " D YN^DICN I %=2 S SDWLERR=1 W !,"  This Report will NOT be queued to print."
 I SDWLERR S DIR(0)="E" D ^DIR I X["^" S SDWLERR=2
 Q
QUE ;Queue Report
 N ZTQUEUED,POP
 K %ZIS,IOP,IOC,ZTIO S %ZIS="MQ" D ^%ZIS G:POP QUE1
 S ZTRTN=$S(SDWLFORM="D":"EN^SDWLROF",1:"EN^SDWLROS"),ZTDTH=$H,ZTDESC="WAIT LIST OVERDUE REPORT"
 S SDWLTASK="" F  S SDWLTASK=$O(^TMP("SDWLQOF",$J,SDWLTASK)) Q:SDWLTASK=""  D
 .S SDWLTK=$G(^TMP("SDWLQOF",$J,SDWLTASK))
 .S ZTSAVE(SDWLTASK)=SDWLTK
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED" G END
QUE1 S:$E(IOST,1,2)="C-" SDWLSPT=1 I $D(ZTRTN) U IO D @ZTRTN K SDWLSPT
 ;
END ;
 K SDWLTASK,SDWLY,SDWLED,WDWLBD,SDWLOPEN,SDWLDATE,SDWLFORM,SDWLPRI,I
 K DIR,DIC,DR,DIE
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HD W:$D(IOF) @IOF W !,?80-$L("Overdue Appointment Wait List Report")\2,"Overdue Appointment Wait List Report"
 Q
