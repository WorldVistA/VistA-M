QACCONV0 ;HISC/DAD-CONVERT SERVICES ;2/10/95  11:04
 ;;2.0;Patient Representative;;07/25/1995
 ;
 W !!,"The data from the SERVICES INVOLVED multiple (745.1,15->"
 W !,"745.115,.01, a pointer to the NATIONAL SERVICE file [#730])"
 W !,"will be moved to the SERV/SECT INVOLVED multiple (745.1,21->"
 W !,"745.121,1->745.1211,.01, a pointer to the SERVICE/SECTION file"
 W !,"[#49]).  The conversion may be run multiple times without adverse"
 W !,"effects on the database.  The SERVICES INVOLVED will be duplicated"
 W !,"for each ISSUE CODE.  A report will be printed showing any"
 W !,"conversion problems/issues.  It is recommended that you queue"
 W !,"this report.  If you wish to run this conversion/report at a"
 W !,"later time, enter 'DO ^QACCONV0' at the M programmer prompt."
 ;
 K %ZIS,IOP S %ZIS="QM" W ! D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="TASK^QACCONV0"
 . S ZTDESC="Patient Representative Service Conversion"
 . D ^%ZTLOAD
 . I $G(ZTSK) W !,"Task Number: ",ZTSK
 . Q
TASK ;
 S QACD0=0 K ^TMP($J,"QACPROB")
 F  S QACD0=$O(^QA(745.1,QACD0)) Q:QACD0'>0  D CONVERT
PRINT ;
 K QACUNDL S $P(QACUNDL,"-",81)="",QACPAGE=1,QACQUIT=0
 S QACTODAY=$$FMTE^XLFDT(DT,1)
 U IO D HEADER
 I $O(^TMP($J,"QACPROB",""))="" D  G EXIT
 . W !!,"No conversion problems found."
 . Q
 S QACNUMBR=""
 F  S QACNUMBR=$O(^TMP($J,"QACPROB",QACNUMBR)) Q:QACNUMBR=""!QACQUIT  D
 . W !!,"Contact Number: ",QACNUMBR
 . S QACPROB=""
 . F  S QACPROB=$O(^TMP($J,"QACPROB",QACNUMBR,QACPROB)) Q:QACPROB=""!QACQUIT  D
 .. W !,^TMP($J,"QACPROB",QACNUMBR,QACPROB)
 .. I $Y>(IOSL-6) D PAUSE,HEADER
 .. Q
 . Q
EXIT ;
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %ZIS,D0,D1,DD,DIC,DINUM,DIR,DLAYGO,DO,POP,QAC49,QAC730,QACD0,QACD1
 K QACFOUND,QACNUMBR,QACPAGE,QACPROB,QACQUIT,QACTODAY,QACUNDL,X,Y
 K ZTDESC,ZTRTN,ZTSK,^TMP($J,"QACCONV0"),^TMP($J,"QACPROB"),DA(1),DA(2)
 Q
CONVERT ;
 S QACNUMBR=$P($G(^QA(745.1,QACD0,0)),U) Q:QACNUMBR=""
 I $O(^QA(745.1,QACD0,1,0)),$O(^QA(745.1,QACD0,3,0))'>0 D
 . S X=" * No Issue Codes found, cannot convert services."
 . S ^TMP($J,"QACPROB",QACNUMBR,"ISSUE")=X
 . Q
 K ^TMP($J,"QACCONV0")
 S QACD1=0
 F  S QACD1=$O(^QA(745.1,QACD0,1,QACD1)) Q:QACD1'>0  D
 . S QAC730=$P($G(^QA(745.1,QACD0,1,QACD1,0)),U)
 . S QAC730(0)=$P($G(^ECC(730,QAC730,0)),U) Q:QAC730(0)=""
 . S (QAC49,QACFOUND)=0
 . F  S QAC49=$O(^DIC(49,"A1",QAC730,QAC49)) Q:QAC49'>0  D
 .. I $P($G(^DIC(49,QAC49,0)),U)="" Q
 .. S ^TMP($J,"QACCONV0",QAC49)="",QACFOUND=QACFOUND+1
 .. Q
 . I 'QACFOUND D
 .. S X=" * No Serv/Sect's for National Serv '"_QAC730(0)_"'."
 .. S ^TMP($J,"QACPROB",QACNUMBR,QAC730)=X
 .. Q
 . I QACFOUND>1 D
 .. S X="   Multiple Serv/Sect's for National Serv '"_QAC730(0)_"'."
 .. S ^TMP($J,"QACPROB",QACNUMBR,QAC730)=X
 .. Q
 . Q
 S QACD1=0
 F  S QACD1=$O(^QA(745.1,QACD0,3,QACD1)) Q:QACD1'>0  D
 . S QAC49=0
 . F  S QAC49=$O(^TMP($J,"QACCONV0",QAC49)) Q:QAC49'>0  D
 .. I $O(^QA(745.1,QACD0,3,QACD1,1,"B",QAC49,0)) Q
 .. K DD,DIC,DINUM,DO
 .. S DIC="^QA(745.1,"_QACD0_",3,"_QACD1_",1,",DIC(0)="L"
 .. S DIC("P")=$P(^DD(745.121,1,0),U,2),DLAYGO=745.1,X=QAC49
 .. S (D0,DA(2))=QACD0,(D1,DA(1))=QACD1
 .. D FILE^DICN
 .. Q
 . Q
 Q
PAUSE ;
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S QACQUIT=$S(Y'>0:1,1:0)
 Q
HEADER ;
 I QACQUIT Q
 W:$E(IOST)="C"!(QACPAGE>1) @IOF
 W !!?29,"Patient Representative",?68,"Page: ",QACPAGE
 W !?28,"Service Conversion Report",?68,QACTODAY
 W !?24,"* - indicates data not converted"
 W !,QACUNDL S QACPAGE=QACPAGE+1
 Q
