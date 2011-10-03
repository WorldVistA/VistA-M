PSOTPRP1 ;BIR/MR - Report of Patients with TPB and Non-TBP Active Rx's ;12/03/03
 ;;7.0;OUTPATIENT PHARMACY;**160,227**;DEC 1997
 ;
EN ;
 Q  ;placed out of order by PSO*7*227
 N OINAM,INS,INSNAM,VADM,TYPE,DRGIEN,TPBRXCNT,SEQ,DFN,RXIEN,RXEXT,RX,POP
 N PSOPAT,PSOAINS,PATNAM,PATCNT,PAT,PAG,INST,PATSSN,PSOAPT,VARXCNT,Y
 ;
 W !!,"This report prints entries from the TPB ELIGIBILITY file (#52.91)."
 W !,"If multiple Institutions are selected, and some Institutions have data and"
 W !,"some don't, only those Institutions that have data will print on the report.",!
 ;
 ;Ask for Institutions
 N DIC,X,I K PSOINS S PSOAINS=0
 W !,?5,"You may select a single or multiple INSTITUTIONS,"
 W !,?5,"or enter ^ALL to select all INSTITUTIONS.",!
 S DIC=4,DIC(0)="QEAM",DIC("A")="     INSTITUTION: "
 F  D ^DIC Q:Y<0  S PSOINS(+Y)="" K DIC("B")
 I X="^ALL" S PSOAINS=1 K PSOINS,DUOUT G PAT
 I $D(DUOUT)!($D(DTOUT)) G END
 I '$D(PSOINS)&(Y<0) G END
 ;
PAT ; - Selection of PATIENTS to print on the Report
 N DIC,X,I K PSOPT S PSOAPT=0
 W !!,?5,"You may select a single or multiple PATIENTS,"
 W !,?5,"or enter ^ALL to select all PATIENTS.",!
 S DIC=2,DIC(0)="QEAM",DIC("A")="     PATIENT: "
 S DIC("S")="I $D(^PS(52.91,+Y))"
 F  D ^DIC Q:Y<0  S PSOPT(+Y)="" K DIC("B")
 I X="^ALL" S PSOAPT=1 K PSOPT,DUOUT G DEV
 I $D(DUOUT)!($D(DTOUT)) G END
 I '$D(PSOPT)&(Y<0) G END
 ;
DEV W ! K %ZIS,IOP,POP,ZTSK S %ZIS="QM" D ^%ZIS K %ZIS I POP G END
 I $D(IO("Q")) D  G END
 . N VAR K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="RPT^PSOTPRP1"
 . S ZTDESC="Report of Patients with TPB and Non-TPB  Rx's"
 . F VAR="PSOPT","PSOAPT","PSOINS","PSOAINS" S:$D(@VAR) ZTSAVE(VAR)=""
 . S:$D(PSOPT) ZTSAVE("PSOPT(")="" S:$D(PSOINS) ZTSAVE("PSOINS(")=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
 ;
 G RPT
 ;
END K ^TMP("PSOTPB",$J)
 Q
 ;
RPT ;- Print the Report
 ;
SORT ;- Sort the Data by Institution,Patient Name
 S DFN=0 K ^TMP("PSOTPB",$J)
 ;
 ;- ALL Patients
 I PSOAPT D  G PRINT
 . F  S DFN=$O(^PS(52.91,DFN)) Q:'DFN  D STMP
 ;
 ;- Selected Patiens
 F  S DFN=$O(PSOPT(DFN)) Q:'DFN  D STMP
 ;
PRINT ;- Read TMP global and Print Report
 S PAG=0
 I '$D(^TMP("PSOTPB",$J)) D  G END
 . D HDR W !!?30,"*** NO DATA TO PRINT ***"
 ;
 S (INS,PAT,TYPE,RX)=""
 F  S INS=$O(^TMP("PSOTPB",$J,INS)) Q:INS=""  D  I $D(DIRUT) Q
 . D HDR I $D(DIRUT) Q
 . S (PATCNT,VARXCNT,TPBRXCNT)=0
 . F  S PAT=$O(^TMP("PSOTPB",$J,INS,PAT)) Q:PAT=""  D  I $D(DIRUT) Q
 . . W !,PAT
 . . F  S TYPE=$O(^TMP("PSOTPB",$J,INS,PAT,TYPE)) Q:TYPE=""  D  I $D(DIRUT) Q
 . . . F  S RX=$O(^TMP("PSOTPB",$J,INS,PAT,TYPE,RX)) Q:RX=""  D  I $D(DIRUT) Q
 . . . . I $Y>(IOSL-4) D HDR Q:$D(DIRUT)  W !,PAT
 . . . . S RXEXT=$$GET1^DIQ(52,RX,.01),DRGIEN=$$GET1^DIQ(52,RX,6)
 . . . . S OINAM=$$GET1^DIQ(50,DRGIEN,2.1) S:OINAM="" OINAM=$$GET1^DIQ(52,RX,6)
 . . . . W ?$S(TYPE=0:30,1:42),RXEXT,?54,$E(OINAM,1,26),!
 . . . . S:TYPE=0 VARXCNT=VARXCNT+1 S:TYPE=1 TPBRXCNT=TPBRXCNT+1
 . . S PATCNT=PATCNT+1
 . I '$D(DIRUT) D
 . . W !,"TOTAL ",INS,": ",PATCNT," Patient(s) ",VARXCNT," VA Prescriptions"
 . . W TPBRXCNT," TPB Prescriptions."
 Q
 ;
STMP ;- Set Temporary Global (^TMP)
 ;
 ;- Check the Patient Instituion
 S INS=$$GET1^DIQ(52.91,DFN,7,"I")
 I 'PSOAINS,'$D(PSOINS(INS)) Q
 S INSNAM="Institution Missing" I INS S INSNAM=$$GET1^DIQ(4,INS,.01)
 ;
 ;- Get Patient Information (Name,SSN)
 D DEM^VADPT S PATNAM=$P(VADM(1),U) S:PATNAM="" PATNAM="Patient Missing"
 S PATSSN=$P($P(VADM(2),U,2),"-",3)
 S PATNAM=$E(PATNAM,1,22)_"("_PATSSN_")"
 ;
 ;Start Loop of PHARMACY PATIENT (#55)
 S (SEQ,VARXCNT,TPBRXCNT)=0
 F  S SEQ=$O(^PS(55,DFN,"P",SEQ)) Q:'SEQ  D
 . ;Get Prescription Number
 . S RXIEN=$G(^PS(55,DFN,"P",SEQ,0)) I $G(^PSRX(RXIEN,0))="" Q
 . ;
 . ;- Rx not Active
 . I '$$ACTIVE^PSOTPCUL(RXIEN) Q
 . ;
 . ;- VA or TPB prescription
 . S TYPE=$S($$GET1^DIQ(52,RXIEN,201,"I"):1,1:0)
 . S:TYPE=0 VARXCNT=VARXCNT+1 S:TYPE=1 TPBRXCNT=TPBRXCNT+1
 . ;
 . S ^TMP("PSOTPB",$J,INSNAM,PATNAM,TYPE,RXIEN)=""
 ;
 ;- VA and TPB Active prescritpions must be found
 I (VARXCNT'>0)!(TPBRXCNT'>0) K ^TMP("PSOTPB",$J,INSNAM,PATNAM)
 Q
 ;
HDR ; - Prints the Header
 N X,DIR S PAG=$G(PAG)+1
 I PAG>1,$E(IOST)="C" D  Q:$D(DIRUT)
 . F  Q:$Y>(IOSL-2)  W !
 . S DIR(0)="E",DIR("A")=" Press ENTER to Continue or ^ to Exit" D ^DIR
 ;
 W @IOF,!,"REPORT OF PATIENTS WITH TPB AND NON-TBP RX's ON FILE",?70,"Page: ",$J(PAG,3)
 W !,?48,"Run Date: "_$$FMTE^XLFDT($$NOW^XLFDT())
 W:$G(INST)'="" !,"INSTITUTION: ",INS
 S X="",$P(X,"-",80)="" W !,X
 W !,"PATIENT (LAST4SSN)",?30,"VA RX#",?42,"TPB RX#",?54,"DRUG"
 W !,X
 Q
