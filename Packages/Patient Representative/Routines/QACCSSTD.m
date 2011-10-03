QACCSSTD  ;WCIOFO/ERC - Routine for CSS totals ;8/16/97
 ;;2.0;Patient Representative;**3,5,7,9,12**;07/25/1995
DATE ; Establish date range
 K QACDVTOT
 N QACCSS,QACDC,QACDFLG,QACISS,QACNODIV,QACSFLG,QACSRV,QACSV,QACYES
 S QACRTN="QACCSSTD"
 S QACDESC="Customer Service Standards Totals"
 S (QACSUM,QACYES)=0
 S DIR(0)="SOA^D:Detailed;S:Summary"
 S DIR("A")="Select report format: "
 S DIR("A",1)="Report Format (D)etailed or (S)ummary:"
 S DIR("?")="Select ""D"" for detailed or ""S"" for summary."
 D ^DIR Q:$D(DIRUT)
 K DIR
 I Y="S" S QACSUM=1
 D DATDIV^QACUTL0 Q:$G(QAQPOP)=1
 I $G(QACDV)=0!($G(QACDV)']"") S QACNODIV=1
 I $G(QACSUM)=1 G TASK
 S DIR(0)="YOA"
 S DIR("A")="Do you want to print this report for just one Discipline? "
 S DIR("B")="No"
 S DIR("?")="Enter 'YES' if you prefer to print this report for one specific Discipline."
 D ^DIR Q:$D(DIRUT)  I Y=1 D DISC
 I QACYES=0 D
 . S DIR("A")="Do you want to print this report for just one Service/Discipline? "
 . S DIR("B")="No"
 . S DIR("?")="Enter 'Yes' if you prefer to print this report for one Service/Discipline."
 . D ^DIR Q:$D(DIRUT)
 . I Y=1 D SERV
 Q:$D(DIRUT)
TASK ;
 K %ZIS,IOP S %ZIS="MQ" W ! D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S (ZTSAVE("QACD0"),ZTSAVE("QAISS"),ZTSAVE("QACISSC"))=""
 . S ZTSAVE("QACSTD")=""
 . S (ZTSAVE("QACSFLG"),ZTSAVE("QACDFLG"))=""
 . S (ZTSAVE("QACDIS"),ZTSAVE("QACSVD"))=""
 . S ZTDESC=QACDESC
 . S ZTSAVE("QACCSS")=""
 . S ZTSAVE("QACRTN")=""
 . S ZTSAVE("QACSTD")=""
 . S ZTSAVE("QAQRANG")=""
 . S ZTSAVE("QACSUM")=""
 . S ZTSAVE("QACEE")=""
 . S ZTRTN="TSK^QACCSSTD"
 . D TASK^QACUTL0
 . Q
TSK ; Get data for totaling
 U IO
INIT ; set up counters for each CSS, discipline and for the total count
 D SETUP^QACEMPE
 ;set up local array for CSS in external format
 S QACAA=0
 F  S QACAA=$O(^QA(745.6,QACAA)) Q:QACAA'>0  D
 . S QACSTD(QACAA)=$P(^QA(745.6,QACAA,0),U,2)
 S QACROU="SET^QACCSSTD"
 ;loop through "D" cross-reference (date)
 D LOOP1^QACSPRD(QACROU,QAQNBEG,QAQNEND,.QACD0)
 I $G(QACSUM)=1 D PRINTSUM D EXIT Q
 D PRINT
 D EXIT
 Q
SET ;
 S QACDDV=$P(^QA(745.1,QACD0,0),U,16)
 D INST^QACUTL0(QACDDV,.QACDDD)
 I $G(QAC1DIV)]"" I $G(QAC1DIV)'=$G(QACDDV) Q
 S QACDDV=QACDDD
 ;if not integrated division set to 0 for sorting purposes in ^TMP
 S QACDDV=$S($G(QACNODIV)'=1:$G(QACDDV,"Unknown"),1:0)
 ;loops through the issue code multiple
 K QACIC
 D ISSLOOP^QACBYLOC
 I '$D(QACIC) Q
 S QACAA=0
 F  S QACAA=$O(QACIC(QACAA)) Q:QACAA'>0  D
 . Q:'$D(^QA(745.2,QACIC(QACAA),0))
 . S QACCSS=$P(^QA(745.2,QACIC(QACAA),0),U,7) Q:QACCSS']""
 . S QACCSS=$P(^QA(745.6,QACCSS,0),U,2)
 . I $G(QACSUM)=1 D COUNTSUM Q
 . S QACBB=0,QACQUT=""
 . F  S QACBB=$O(^QA(745.1,QACD0,3,QACAA,3,QACBB)) Q:(QACBB'>0)&(QACBB]"")  Q:$G(QACQUT)  D
 . . I $G(QACBB)'>0 I ($G(QACDFLG)=1!$G(QACSFLG)=1) S QACQUT=1 Q
 . . I $G(QACBB)'>0 S (QACSVD,QACDIS)="Unknown",QACQUT=1 G COUNT
 . . S QACNODE=^QA(745.1,QACD0,3,QACAA,3,QACBB,0)
 . . S QACSVD=$P(^QA(745.55,$P(QACNODE,U),0),U) Q:$G(QACSVD)']""
 . . I $G(QACSFLG)=1 I $G(QACSRV)'=$P(QACNODE,U) Q
 . . I $P(QACNODE,U,2)]"" S QACDIS=$P(^QA(745.5,$P(QACNODE,U,2),0),U,2) Q:$G(QACDIS)']""
 . . I $P(QACNODE,U,2)']"" S QACDIS="Unknown"
 . . I $P(QACNODE,U,2)']"",($G(QACDISC)]"") Q  ;if discipline
 . . ;is unknown, there will be no match with the one discipline
 . . ;in variable QACDISC
 . . I $G(QACDFLG)=1 I $G(QACDISC)'=$P(^QA(745.5,$P(QACNODE,U,2),0),U) Q
COUNT . . ;counts for detailed report
 . . S QACTOT=$G(QACTOT)+1
 . . I $G(QACDDV)]"" S QACDVTOT(QACDDV)=$G(QACDVTOT(QACDDV))+1
 . . S ^TMP(QACRTN,$J,QACDDV,QACSVD,QACDIS,QACCSS)=$G(^TMP(QACRTN,$J,QACDDV,QACSVD,QACDIS,QACCSS))+1
 . . S ^TMP(QACRTN,$J,"COUNT",QACDDV,QACSVD)=$G(^TMP(QACRTN,$J,"COUNT",QACDDV,QACSVD))+1
 . .S ^TMP(QACRTN,$J,"COUNT",QACDDV,QACSVD,QACDIS)=$G(^TMP(QACRTN,$J,"COUNT",QACDDV,QACSVD,QACDIS))+1
 Q
PRINT ;print routine for detailed report
 U IO
 S QACEE=""
 F  S QACEE=$O(^TMP(QACRTN,$J,QACEE)) Q:QACEE']""  D  Q:QACQUIT
 . I QACEE="COUNT" Q
 . S QACFF=""
 . F  S QACFF=$O(^TMP(QACRTN,$J,QACEE,QACFF)) Q:QACFF']""  D  Q:QACQUIT
 . . D HEAD
 . . I $G(QACEE)'=0 W !?5,"Total for Division: "_QACEE_"    "_QACDVTOT(QACEE)
 . . I $G(QACFF)'=0 W !?5,"Total for Service/Discipline: "_QACFF_"    "_^TMP(QACRTN,$J,"COUNT",QACEE,QACFF)
 . . S QACGG=""
 . . F  S QACGG=$O(^TMP(QACRTN,$J,QACEE,QACFF,QACGG)) Q:QACGG']""  D  Q:QACQUIT
 . . . I $G(QACGG)'=0 W !?5,"Total for Discipline: "_QACGG_"    "_^TMP(QACRTN,$J,"COUNT",QACEE,QACFF,QACGG),!
 . . . S QACHH=""
 . . . F  S QACHH=$O(QACSTD(QACHH)) Q:QACHH']""  D  Q:QACQUIT
 . . . . I $Y>(IOSL-6) D HEAD Q:QACQUIT  I $G(QACEE)'=0 W !?5,"Division: ",QACEE
 . . . . W !?10,QACSTD(QACHH),?50,$G(^TMP(QACRTN,$J,QACEE,QACFF,QACGG,QACSTD(QACHH)),0)
 W:$G(QACTOT)>0 !!?20,"Grand Total: "_QACTOT
 I '$D(^TMP(QACRTN,$J)) D
 . D HEAD
 . W !!!?25,"No data to report."
 Q
HEAD ;
 S QACPAGE=$G(QACPAGE)+1
 I QACPAGE>1 D  Q:QACQUIT
 . W $C(7)
 . I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S QACQUIT=$S(Y'>0:1,1:0)
 W:$E(IOST)="C"!(QACPAGE>1) @IOF
 W !,QACDESC,?48,QACTODAY,?70,"PAGE ",QACPAGE
 W !,"Date "_QAQRANG
 W !,$S($G(QACSUM)=1:"SUMMARY",1:"DETAILED")," Report"
 W !?51,"NUMBER OF"
 W !?10,"CUSTOMER SERVICE STANDARD",?50,"OCCURRENCES"
 W !,QACUNDL,!
 Q
EXIT ;
 W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP(QACRTN,$J)
 K QAC1DIV,QACCSS,QACD0,QACDCNT,QACDESC,QACDDD,QACDDV,QACDFLG,QACDV
 K QACDVTOT,QACDIS,QACDISC,QACIC,QACNODE,QACPAGE,QACQUIT,QACQUT
 K QACROU,QACRTN,QACSFLG,QACSTD,QACSUM,QACSVD,QACTODAY,QACTOT,QACUNDL
 K QACAA,QACBB,QACDD,QACEE,QACFF,QACGG,QACHH
 K QAQNBEG,QAQNEND,QAQPOP,QAQRANG
 K DIR,DIRUT,POP,ZTSAVE,ZTDESC,ZTRTN
 D K^QAQDATE
 Q
DISC ; Select one discipline for this report
 K DIR
 S DIR(0)="FAO^^K:X'?2U X"
 S DIR("A")="Enter the Discipline as a two letter abbreviation: "
 D ^DIR K DIR Q:$D(DIRUT)!($D(DIROUT))
 I $O(^QA(745.5,"B",Y,0)) S QACDISC=Y,QACDFLG=1,QACYES=1
 E  D  G DISC
 . W !!,"Not a valid Discipline, choose from:"
 . S QACEE=0
 . F  S QACEE=$O(^QA(745.5,QACEE)) Q:QACEE'>0  D
 . . W !?5,$P(^QA(745.5,QACEE,0),U),"   (",$P(^QA(745.5,QACEE,0),U,2),")"
 Q
SERV ; Select one Service/Discipline for this report
 K DIR
 S DIR(0)="POA^745.55:EMZ"
 S DIR("A")="Enter the Service/Discipline: "
 D ^DIR K DIR Q:$D(DIRUT)!($D(DIROUT))
 I $G(^QA(745.55,+Y,0))]"" S QACSRV=+Y,QACSFLG=1
 E  D  G SERV
 . W !!,"Not a valid service/discipline.  Try again."
 Q 
COUNTSUM ;counts for summary report
 S QACBB=0
 F  S QACBB=$O(^QA(745.1,QACD0,3,QACAA,3,QACBB)) Q:QACBB'>0  D
 . S ^TMP(QACRTN,$J,"TOT")=$G(^TMP(QACRTN,$J,"TOT"))+1
 . S ^TMP(QACRTN,$J,"TOT",QACDDV)=$G(^TMP(QACRTN,$J,"TOT",QACDDV))+1
 . S ^TMP(QACRTN,$J,"SUM",QACDDV,QACCSS)=$G(^TMP(QACRTN,$J,"SUM",QACDDV,QACCSS))+1
 . S ^TMP(QACRTN,$J,"SUMCSS",QACCSS)=$G(^TMP(QACRTN,$J,"SUMCSS",QACCSS))+1
 Q
PRINTSUM ;print routine for summary report
 U IO
 D HEAD
 I '$D(^TMP(QACRTN,$J)) D  Q
 . W !!!?25,"No data to report."
 S QACDCN=0,QACEE=""
 F  S QACEE=$O(^TMP(QACRTN,$J,"SUM",QACEE)) Q:QACEE']""  D  Q:QACQUIT
 . S QACDCNT=$G(QACDCNT)+1
 . I $G(QACEE)=0,($D(QAC1DIV)) W !?5,"For all Divisions"
 . I $G(QACEE)'=0 W !?5,"Division: ",QACEE
 . S QACGG=""
 . F  S QACGG=$O(QACSTD(QACGG)) Q:QACGG']""  D
 . . I $Y>(IOSL-6) D HEAD Q:QACQUIT  I $G(QACEE)'=0 W !?5,"Division: ",QACEE
 . . W !?10,QACSTD(QACGG),?55,$G(^TMP(QACRTN,$J,"SUM",QACEE,QACSTD(QACGG)),0)
 . W !?53,"-----"
 . W !?45,"TOTAL:",?55,^TMP(QACRTN,$J,"TOT",QACEE)
 I $G(QACDCNT)>1 D
 . I $Y>(IOSL-6) D HEAD Q:QACQUIT  I $G(QACEE)'=0 W !?5,"Division: ",QACEE
 . W !!!?5,"Totals for all Divisions:"
 . S QACFF=""
 . F  S QACFF=$O(QACSTD(QACFF)) Q:QACFF']""  D
 . . I $Y>(IOSL-6) D HEAD Q:QACQUIT
 . . W !?10,QACSTD(QACFF),?55,$G(^TMP(QACRTN,$J,"SUMCSS",QACSTD(QACFF)),0)
 . W !?53,"-----"
 . W !?38,"GRAND TOTAL:",?55,^TMP(QACRTN,$J,"TOT")
 Q
