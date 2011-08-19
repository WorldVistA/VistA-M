DGENRPT3 ;ALB/DW,LBD - EGT Actual Summary Impact Report ; 04/24/03 2:40pm ; 07/22/02 9:40am
 ;;5.3;Registration;**232,306,417,456,491,513**;Aug 13,1993
 ;
 ;
ENPT ;Actual Summary Report selected.
 K ^TMP($J,"SS3"),^TMP($J,"RT3")
 N BDT,EDT S (BDT,EDT)=""
 D RPDT I BDT="^"!(EDT="^")!($D(DTOUT)) Q
 D PRINT
 Q
 ;
RPDT ;Ask the user the Report Begin Date and Report End Date.
 N DIR,X,Y
 S DIR(0)="DA^::E"
 S DIR("A")="Report Begin Date: "
 S DIR("?")="Please enter the Enrollment End Date as the beginning date that will be reported on."
 D ^DIR S BDT=Y
 I BDT="^" Q
 I ($D(DTOUT)) W *7 Q
 ;
RPDT2 S DIR(0)="DA^::E"
 S DIR("A")="Report End Date: "
 S DIR("?")="Please enter the Enrollment End Date as the end date that will be reported on. Report End Date cannot be earlier than Report Begin Date."
 D ^DIR S EDT=Y
 I EDT="^" Q
 I ($D(DTOUT)) W *7 Q
 I EDT<BDT G RPDT2
 Q
 ;
GETEGTS ;First get the current EGT parameters from file #27.16.
 N GETEGTS,REC,TP S (GETEGTS,REC,TP)=""
 S REC=$$FINDCUR^DGENEGT() I REC=0 Q
 S TP=$$GET^DGENEGT(REC,.GETEGTS)
 ;Get EGT Priority.
 S EGT=GETEGTS("PRIORITY"),RLEGT=EGT
 I EGT="" W !,"No EGT setting on file.",! S EGT=0
 S EGTSUB=GETEGTS("SUBGRP")
 ;Get EGT Effective Date.
 S EGTEDT=GETEGTS("EFFDATE") I EGTEDT S EGTEDT=$$FMTE^XLFDT(EGTEDT)
 ;Get last EGT setting Date/Time.
 S EGTLDT=GETEGTS("ENTDATE") I EGTLDT S EGTLDT=$$FMTE^XLFDT(EGTLDT)
 ;Get EGT Type.
 S EGTTP=GETEGTS("TYPE")
 S EGTTP=$$EXTERNAL^DILFD(27.16,.04,"F",EGTTP) S:EGTTP="" EGTTP="UNSPECIFIED"
 Q
 ;
PRESRT1 ;Sort for patient's current record and get the potentially affected.
 N IND,PRT,DFN,INPT,PSSN,PEDT,PCTRY,TMP,PRTSUB,ABV
 S (IND,PRT,DFN,PSSN,PEDT,PCTRY,TMP,PRTSUB,ABV)="",INPT="OUT"
 K ^TMP($J,"SS3"),^TMP($J,"RT3")
 F  S DFN=$O(^DGEN(27.11,"C",DFN)) Q:DFN=""  D
 . S IND=$$FINDCUR^DGENA(DFN) I IND D
 .. D EGTP
 .. S PEDT=$P($G(^DGEN(27.11,IND,0)),U,11)
 .. S PCTRY=$$CATEGORY^DGENA4(DFN)
 .. I ABV=0&(PCTRY="N")&(PEDT'<BDT)&(PEDT'>EDT) D
 ... K VAIP(2) S INPT="OUT" D IN5^VADPT S TMP=$P($G(VAIP(2)),U) I TMP=1!(TMP=2)!(TMP=6) S INPT="IN"
 ... K VADM(2) D DEM^VADPT S PSSN=$P($G(VADM(2)),U)
 ... S ^TMP($J,"RT3",PRT,PSSN)=PRT_"^"_INPT
 ;
PRESRT2 ;Sort the sorted.
 N CNT,ICNT,OCNT,J,K
 S (J,K)=""
 F  S J=$O(^TMP($J,"RT3",J)) Q:J=""  D
 . S (CNT,ICNT,OCNT)=0
 . F  S K=$O(^TMP($J,"RT3",J,K)) Q:K=""  D
   .. S INPT=$P($G(^TMP($J,"RT3",J,K)),U,2)
   .. S CNT=CNT+1 S:INPT="IN" ICNT=ICNT+1 S:INPT="OUT" OCNT=OCNT+1
   .. S ^TMP($J,"SS3",J)=CNT_"^"_ICNT_"^"_OCNT
 K ^TMP($J,"RT3")
 Q
 ;
EGTP ;Get patients EGT Priority.
 S (PRT,PRTSUB,ABV,ENRDT)=""
 S PRT=$P($G(^DGEN(27.11,IND,0)),U,7)
 S:((PRT=7)!(PRT=8)) PRTSUB=$P($G(^DGEN(27.11,IND,0)),U,12)
 S ENRDT=$P($G(^DGEN(27.11,IND,0)),U,10)
 S:'ENRDT ENRDT=$P($G(^DGEN(27.11,IND,0)),U)
 S ABV=$$ABOVE^DGENEGT1(DFN,PRT,PRTSUB)
 I PRT=7!(PRT=8) D
 . S PRTSUB=$$EXTERNAL^DILFD(27.11,.12,"F",PRTSUB)
 . S:PRTSUB="" PRTSUB="ER"
 S PRT=PRT_PRTSUB
 Q
 ;
PRINT ;Print the report.
 N POP,IO,IOBS,IOF,IOHG,IOM,ION,IOPAR,IOS,IOSL,IOST,IOT,IOUPAR,IOXY,ZTSAVE,TSK,%ZIS,ZTRTN,ZTDESC
 S %ZIS="QM" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="WRITER^DGENRPT3",ZTDESC="DG EGT Actual Summary Report."
 . S ZTSAVE("BDT")="",ZTSAVE("EDT")=""
 . D ^%ZTLOAD
 . S TSK=$S($D(ZTSK)=0:"C",1:"Y")
 . I TSK="Y" W !!,"Report queued! Task number: ",ZTSK
 . D HOME^%ZIS
 ;
WRITER ;Write out the report.
 U IO
 I $E(IOST,1,2)="C-" W @IOF
 N EGT,EGTSUB,EGTEDT,EGTLDT,EGTTP,COUNT,RLEGT,ENRDT
 S (EGT,EGTSUB,EGTEDT,EGTLDT,EGTTP,RLEGT)="",COUNT=0
 I $$FINDCUR^DGENEGT()=0 W !,"No EGT setting on file.",! S EGT=0
 I $$FINDCUR^DGENEGT()'=0 D GETEGTS
 D PRESRT1
 D PSHEAD
 D DATA
 D ^%ZISC
EXIT S:$D(ZTQUEUED) ZTREQ="@"
 D KVA^VADPT
 K ^TMP($J,"SS3")
 Q
 ;
PSHEAD ;Header for the Preliminary Detailed Report.
 ;Get the date/time the report is run.
 N RDT,Y,DT1,DT2 S (RDT,Y,DT1,DT2)=""
 D NOW^%DTC S Y=% X ^DD("DD")
 S RDT=$P(Y,"@",1)_" @ "_$P($P(Y,"@",2),":",1,2)
 S DT1=$$FMTE^XLFDT(BDT),DT2=$$FMTE^XLFDT(EDT)
 S EGTSUB=$$EXTERNAL^DILFD(27.16,.03,"F",EGTSUB)
 I ((EGT=7)!(EGT=8)),EGTSUB="" S EGTSUB="ER"
 ;Write the header.
 W !,?((IOM-32)\2),"EGT Actual Summary Impact Report"
 W !,?((IOM-62)\2),"Date Range of Enrollment End Date: ",DT1," - ",DT2
 W !,?((IOM-41)\2),"Date/Time Report Run: ",RDT
 W !,?((IOM-45-$L(RLEGT_EGTSUB_EGTTP_EGTEDT))\2),"EGT Setting: ",RLEGT_EGTSUB," EGT Type: ",EGTTP," EGT Effective Date: ",EGTEDT
 W !,?((IOM-28-$L(EGTLDT))\2),"Date/Time Last EGT Setting: ",EGTLDT
 W !!,"IMPORTANT NOTE:  Actual report is based on a comparison of the EGT Setting and the Enrollment Category as provided by HEC."
 W !!,"ENROLLMENT PRIORITY",?23,"TOTAL (UNIQUE SSN)",?43,"# INPATIENT",?57,"# OUTPATIENT",!
 Q
 ;
DATA ;Get all the data for the report.
 N T,EP,TLT,INPT,OPT S (T,EP,TLT,INPT,OPT)=""
 F  S T=$O(^TMP($J,"SS3",T)) Q:T=""  D
 . S EP=T,TLT=$P($G(^TMP($J,"SS3",T)),U),INPT=$P($G(^TMP($J,"SS3",T)),U,2),OPT=$P($G(^TMP($J,"SS3",T)),U,3)
 . S COUNT=COUNT+TLT
 . W !,EP,?25,TLT,?45,INPT,?59,OPT
 W !,"TOTAL PATIENTS (UNIQUE SSNS) FOR THIS FACILITY:     ",COUNT
 Q
