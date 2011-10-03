IBATO ;LL/ELZ - TRANSFER PRICING REPORTS ; 18-DEC-98
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENW ; produces a workload report
 N IBHEAD,IBMARG,IBFIELD,IBMUL
 S IBHEAD="Transfer Pricing Workload Report "
 D DISP^IBATO1
 S IBMARG=$$SEL^IBATO1("70,60,61,50,51,53,52") Q:'IBMARG
 D START
 Q
ENP ; produces a patient detail report
 N IBHEAD,IBMARG,IBFIELD,IBMUL
 S IBHEAD="Transfer Pricing Patient Report "
 D DISP^IBATO1
 S IBMARG=$$SEL^IBATO1("1,2,40,41,60,50,52,53") Q:'IBMARG
 D START
 Q
ENEX ; excel formatted report
 N IBHEAD,IBMARG,IBFIELD,IBMUL,IBEX,IBQUIT
 S IBEX=1,IBQUIT=0
 W !!,"This will produce a report that can be exported into an excel spread sheet."
 W !,"If you select any fields with an asterisk (*) then the report will contain"
 W !,"fields which are multiples.  Multiple fields will cause dollar amounts to"
 W !,"repeat for each multiple line!",! Q:$$PAGE
 D DISP^IBATO1
 S IBMARG=$$SEL^IBATO1() Q:'IBMARG
 D START
 Q
ENS ; produces a summary report
 N IBHEAD
 S IBHEAD="Transfer Pricing Summary Report "
START ;
 N IBBDT,IBEDT,IBFAC,IBXREF,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 ; status for sorting
 W !,"Select how you want this report to sort by for a date range."
 S DIR(0)="S^E:EVENT DATE;P:PRICED DATE"
 S DIR("A")="Select Sort"
 D ^DIR Q:$D(DIRUT)  S IBXREF=$S(Y="E":"AG",1:"AE")
 S IBHEAD=$S(Y="E":"Event ",1:"Priced ")_$G(IBHEAD)
 ;
 Q:$$FAC^IBATUTL  Q:$$SLDR^IBATUTL
 Q:$$DEV("Transfer Pricing Report","DQ")
 ;
DQ ; queued entry point
 N IBPAGE,IBDT,IBVISN,IBIEN,IBLOC,IBTYPE,IBTMP,IBCOPAY,IBCOUNT,IBQUIT
 N IBSAVE,IBX,IBLINE,IBLAST
 U IO K ^TMP("IBATO",$J)
 S (IBQUIT,IBPAGE,IBSAVE,IBLAST)=0,IBDT=$$FMADD^XLFDT(IBBDT,-1)_.99999
 S IBLINE="" F IBX=1:1:80 S IBLINE=IBLINE_"-"
 F  S IBDT=$O(^IBAT(351.61,IBXREF,IBDT)) Q:IBDT<1!(IBDT>IBEDT)  S IBIEN=0 F  S IBIEN=$O(^IBAT(351.61,IBXREF,IBDT,IBIEN)) Q:IBIEN<1  D
 . S IBIEN(0)=$G(^IBAT(351.61,IBIEN,0))
 . Q:$P(IBIEN(0),"^",5)="X"!('$P(IBIEN(0),"^",11))
 . S IBVISN=+$$VISN^IBATUTL($P(IBIEN(0),"^",11))
 . S IBLOC=$P(IBIEN(0),"^",11)
 . S IBTYPE=$P($P(IBIEN(0),"^",12),";",2)
 . I $D(IBFAC)'=0,$D(IBFAC(IBVISN,"C",$P(IBIEN(0),"^",11)))=0 Q
 . S ^TMP("IBATO",$J,IBVISN,IBLOC,IBTYPE,IBIEN)=IBIEN(0)
 ;
 ;use excel format for printing
 I $G(IBEX) D  K ^TMP("IBATO",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
 . N A,B,C,D
 . ;
 . ;first print header
 . S A=0 F  S A=$O(IBFIELD(A)) Q:A<1  S B=0 F  S B=$O(IBFIELD(A,B)) Q:B<1  W $P(IBFIELD(A,B),"^"),"|"
 . S A=0 F  S A=$O(IBMUL(A)) Q:A<1  S B=0 F  S B=$O(IBMUL(A,B)) Q:B<1  W $P(IBMUL(A,B),"^"),"|"
 . W !
 . ;
 . ;now onto printing excel
 . S A=0 F  S A=$O(^TMP("IBATO",$J,A)) Q:A<1  S B=0 F  S B=$O(^TMP("IBATO",$J,A,B)) Q:B<1  S C=0 F  S C=$O(^TMP("IBATO",$J,A,B,C)) Q:C=""  S D=0 F  S D=$O(^TMP("IBATO",$J,A,B,C,D)) Q:D<1  D EXPRT^IBATO1(D)
 ;
 ; start all other printing
 S IBVISN=0
 F  S IBVISN=$O(^TMP("IBATO",$J,IBVISN)) Q:IBVISN<1!IBQUIT  D
 . D ZERO(.IBVISN)
 . S IBLOC=0
 . F  S IBLOC=$O(^TMP("IBATO",$J,IBVISN,IBLOC)) Q:IBLOC<1!IBQUIT  D
 .. D ZERO(.IBLOC)
 .. S IBTYPE=""
 .. F  S IBTYPE=$O(^TMP("IBATO",$J,IBVISN,IBLOC,IBTYPE)) Q:IBTYPE=""!IBQUIT  D
 ... S IBIEN=0
 ... F  S IBIEN=$O(^TMP("IBATO",$J,IBVISN,IBLOC,IBTYPE,IBIEN)) Q:IBIEN<1!IBQUIT  D
 .... S IBIEN(0)=^TMP("IBATO",$J,IBVISN,IBLOC,IBTYPE,IBIEN)
 .... S IBIEN(6)=$G(^IBAT(351.61,IBIEN,6))
 .... S IBCOPAY=$$COPAY^IBATUTL($P(IBIEN(0),"^",2),$P(IBIEN(0),"^",12),$P($P(IBIEN(0),"^",9),"."),$P($P(IBIEN(0),"^",10),"."))
 .... I IBCOPAY,IBTYPE="SCE(" S (IBCOUNT,IBTMP)=0 F  S IBTMP=$O(^IBAT(351.61,"AH",$P(IBIEN(0),"^",2),$P(IBIEN(0),"^",4),IBTMP)) Q:IBTMP<1  I $P(^IBAT(351.61,IBTMP,0),"^",12)["SCE(" S IBCOUNT=IBCOUNT+1
 .... I  S IBCOPAY=IBCOPAY/IBCOUNT
 .... S IBIEN(6)="1^"_$P(IBIEN(6),"^",1,2)_"^"_IBCOPAY_"^"_($P(IBIEN(6),"^",2)-IBCOPAY)
 .... D:$D(IBMARG) PRT^IBATO1(IBIEN)
 .... D SUM(.IBLOC,.IBTYPE,IBIEN(6)),SUM(.IBVISN,.IBTYPE,IBIEN(6))
 .. D:'IBQUIT TOTAL(.IBLOC)
 .. D:'IBQUIT PRINT(.IBLOC)
 . D:'IBQUIT TOTAL(.IBVISN)
 . D:'IBQUIT PRINT(.IBVISN):$D(IBFAC)=0!($D(IBFAC(IBVISN))=11)
 I $E(IOST,1,2)="C-" I $$PAGE
 K ^TMP("IBATO",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
TOTAL(X) ; totals up types in subscripted X
 N IBP,IBX
 F IBX="DGPM(","SCE(","PSRX(","RMPR(660," F IBP=1:1:5 S $P(X("TOTAL"),"^",IBP)=$P(X("TOTAL"),"^",IBP)+$P(X(IBX),"^",IBP)
 Q
SUM(X,Z,Y) ; adds up amounts for type in X
 N IBP
 F IBP=1:1:5 S $P(X(Z),"^",IBP)=$P(X(Z),"^",IBP)+$P(Y,"^",IBP)
 Q
ZERO(X) ; zeros out variables
 N IBP
 F IBP="DGPM(","PSRX(","SCE(","RMPR(660,","TOTAL" S X(IBP)=0
 Q
PRINT(IBPRT) ; prints out report sum from what is passed
 N IBP
 D HEAD(IBPRT)
 F IBP="DGPM(","SCE(","PSRX(","RMPR(660,","TOTAL" Q:IBQUIT  D
 . W !!,$S(IBP="DGPM(":"INPATIENT",IBP="SCE(":"OUTPATIENT",IBP="PSRX(":"PHARMACY",IBP="RMPR(660,":"PROSTHETICS",1:"TOTAL")
 . W ":",?27,"COUNT: ",$$NUM($P(IBPRT(IBP),"^"),0)
 . W:IBP="DGPM(" !,?20,"OUTLIER DAYS: ",$$NUM($P(IBPRT(IBP),"^",2),0)
 . W !,?20,"TOTAL AMOUNT: ",$$NUM($P(IBPRT(IBP),"^",3))
 Q
DEV(ZTDESC,ZTRTN) ; device handler for reports
 ; needs task description and entry point returns 1 if queued or pop
 N %ZIS,ZTSAVE,POP,ZTSK
 I $D(IBMARG) W !,?5,"*** Requires a margin of at least ",IBMARG," ***"
 S %ZIS="MQ" D ^%ZIS Q:POP 1
 I $D(IO("Q")) D  Q 1
 . S ZTRTN=ZTRTN_"^IBATO",ZTSAVE("IB*")=""
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q") W !,"Task# ",ZTSK
 Q 0
HEAD(X) ;
 N Z
 I IBPAGE,$E(IOST,1,2)="C-" I $$PAGE S IBQUIT=1 Q
 S IBPAGE=IBPAGE+1
 W @IOF,!,IBHEAD,$$FMTE^XLFDT(IBBDT,"5D")," to ",$$FMTE^XLFDT(IBEDT,"5D"),?IOM-10,"Page: ",IBPAGE
 W ! F Z=1:1:IOM W "-"
 W !,"LOCATION: "_$P($$INST^IBATUTL(X),"^")
 Q
PAGE() ; performs page reads and returns 1 if quitting is needed
 Q:IBQUIT 1
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="E" D ^DIR
 Q $D(DIRUT)
NUM(X,X2,X3) ; calls to format numbers
 D COMMA^%DTC
 Q X
