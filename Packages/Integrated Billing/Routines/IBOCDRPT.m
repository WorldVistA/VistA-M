IBOCDRPT ;ELZ/OAK - CATASTROPHICALLY DISABLED PATIENT BILLING ;03/21/2011
 ;;2.0;INTEGRATED BILLING;**449**;21-MAR-94;Build 15
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
EN ; - this will produce a report of patient's with charges that are CD.
 ;
 N POP,%ZIS,ZTRTN,ZTDESC,ZTSK,IBEDT,IBBDT,%DT,ZTSAVE
 W !,"The Catastrophically Disabled legislation effective date is May 5, 2010."
 W !,"You should not enter a date prior to that date, any date entered before"
 W !,"that will be automatically changed to May 5, 2010."
 S %DT(0)=3100505,%DT("B")="May 5, 2010"
 D DATE^IBOUTL Q:'IBEDT
 ;
 W !!,"Select the device for the Catastrophically Disabled Charge report.  It"
 W !,"should be queued to a printer off hours as it can take some time to run"
 W !,"with at least a margin of 132 columns."
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .S ZTRTN="DQ^IBOCDRPT",ZTDESC="Catastrophically Disabled Copay Report"
 .S (ZTSAVE("IBEDT"),ZTSAVE("IBBDT"))=""
 .D ^%ZTLOAD D HOME^%ZIS K IO("Q")
 .D MES^XPDUTL("Catastrophically Disabled Copay Report queued #"_ZTSK)
DQ U IO
 ;
 N IBX,IBZ,IBDT,IBDG,DFN,IBP,IBARX,IBARBILL,IBARDATA,IBDPT,IBDDT,IBQUIT
 ;
 S (IBP,IBQUIT)=0
 D HEAD
 I IBBDT<3100505 S IBBDT=3100505 ; not before CD effective date
 S IBDDT=IBBDT-1 F  S IBDDT=$O(^IB("D",IBDDT)) Q:'IBDDT!(IBQUIT)  S IBX=0 F  S IBX=$O(^IB("D",IBDDT,IBX)) Q:'IBX!(IBQUIT)  D
 . S IBZ=$G(^IB(IBX,0)),DFN=+$P(IBZ,"^",2)
 . S IBDT=$S($E($P(IBZ,"^",4),1,2)=52:IBDDT,$P(IBZ,"^",8)="RX COPAYMENT":IBDDT,$P(IBZ,"^",15):$P(IBZ,"^",15),1:$P(IBZ,"^",14))
 . K IBDG
 . S IBDG=$$GET^DGENCDA(DFN,.IBDG)  ; IA# 4969
 . S IBARX=+$O(^PRCA(430,"B",$S($P(IBZ,"^",11):$P(IBZ,"^",11),1:0),0))  ; IA# 389
 . S IBARBILL=$S(IBARX:$$BILL^RCJIBFN2(IBARX),1:"")  ; IA# 1452
 . K IBARDATA
 . I IBARX D DIQ^RCJIBFN2(IBARX,"77:79;141;203;255.1","IBARDATA") ; IA# 1452
 . ;
 . ; quit if no date, status cancelled (ib) or pt not CD, or no charge
 . Q:'IBDT!($P(IBZ,"^",5)=10)!($G(IBDG("VCD"))'="Y")!('$P(IBZ,"^",7))
 . ; quit if cancelled in AR (if passed)
 . I IBARX,$P(IBARBILL,"^",2)=26 Q
 . ; quit if CD effective date not before event date
 . Q:IBDT<3100505!(IBDT<$G(IBDG("DATE")))
 . ; quit if not within specified date range
 . Q:IBDT<IBBDT!($P(IBDT,".")>(IBEDT+1))
 . ; quit if LTC inpatient
 . I $P($G(^IBE(350.1,+$P(IBZ,"^",3),0)),"^")["DG LTC INPT"!($P($G(^(0)),"^")["DG LTC FEE INPT") Q
 . ;
 . S IBDPT=$G(^DPT(DFN,0))
 . W !,$E($P(IBDPT,"^"),1,20) ; patient name
 . W ?22,$E($P(IBDPT,"^",9),6,9) ; last 4 snn
 . W ?27,$$FMTE^XLFDT($G(IBDG("DATE")),"2DZ") ; Catastrophically Disabled Date, IA# 10103
 . W ?36,$$FMTE^XLFDT(IBDT,"2DZ") ; date of service, IA# 10103
 . W:$E($P(IBZ,"^",4),1,2)=52 ?45,$E($P($P(IBZ,"^",8),"-"),1,11) ; rx
 . W ?57,$E($P($G(^IBE(350.1,+$P(IBZ,"^",3),0)),"^"),1,9) ; action type
 . W ?67,$E($P($P(IBZ,"^",11),"-",2),1,8) ; ar bill no
 . W ?76,$E($P($G(^IBE(350.21,+$P(IBZ,"^",5),0)),"^"),1,8) ; 350 status
 . W ?85,$J($FN($P(IBARBILL,"^",3),"",2),7) ; current balance
 . W ?93,$J($FN($G(IBARDATA(430,IBARX,77,"E")),"",2),7) ; pd principal
 . W ?101,$J($FN($G(IBARDATA(430,IBARX,78,"E")),"",2),5) ; pd int
 . W ?107,$J($FN($G(IBARDATA(430,IBARX,79,"E")),"",2),5) ; pd admin
 . W ?113,$$FMTE^XLFDT($G(IBARDATA(430,IBARX,141,"I")),"2DZ") ; IA# 10103
 . W ?122,$E($G(IBARDATA(430,IBARX,203,"E")),1,6)
 . W ?129,$E($G(IBARDATA(430,IBARX,255.1,"E")),1,4)
 . I $Y+3>IOSL D HEAD
 ; 
 D ^%ZISC
EXIT S:$D(ZTQUEUED) ZTREQ="@"
 Q
HEAD ;
 N IBL,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I IBP,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR I $D(DIRUT) S IBQUIT=1 Q
 S IBP=IBP+1
 W @IOF,!,"Catastrophically Disabled Copayment Charge Report                     PAGE: ",IBP,!
 W "PATIENT                SSN CD DATE   DOS     RX          TYPE      BILL NO  STATUS   BALANCE PD PRIN  INT   ADM   TOP     FUND   RSC",!
 F IBL=1:1:$S(IOM:IOM,1:132) W "-"
 Q
