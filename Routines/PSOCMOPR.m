PSOCMOPR ;BHAM ISC/PDW - CMOP CONTROLLED SUBSTANCE RX DISPENSE REPORT ; 05 Nov 1999  9:39 AM
 ;;7.0;OUTPATIENT PHARMACY;**33,52**;DEC 1997
 ; External reference to file #550.2 granted by DBIA 2231
 ; External reference to file #50 granted by DBIA 221
 Q
 ;
S ;ENTRY
 I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"A Pharmacy Division Must Be Selected!",! G EXIT
 ; check for multi divisions
 ;
 S X=0,I=0 F  S I=$O(^PS(59,I)) Q:'I  S X=X+1
 I X<2 S QDIV="A" G CNT1
 K DIR S DIR(0)="SA^A:All divisions;S:Single division"
 S DIR("A")="Print for (A)ll or a (S)ingle division? (A/S) "
 S DIR("B")="S"
 D ^DIR K DIR
 G:$D(DIRUT) EXIT
 S QDIV=Y
 ; select division if QDIV="S"
 I QDIV="S" D  G:Y'>0 S
 . K DIC
 . S DIC(0)="AEQM",DIC=59 D ^DIC
 . S:+Y QDIV=+Y
 . K DIC
CNT1 ;Continue point 1
 K DIR S DIR(0)="S^1:Sort by Release Date;2:Sort by Drug"
 S DIR("A")="Select one of the following: "
 S DIR("B")=1
 D ^DIR K DIR
 G:$D(DIRUT) EXIT
 S QSORT=Y
DATE ; ask date range
 K %DT
 S %DT(0)="-NOW",%DT("A")="Enter Start date: ",%DT="AEPX" D ^%DT
 G:"^"[$E(X) EXIT
 S (%DT(0),SCANBDT)=Y
 S Y=DT X ^DD("DD") S END=Y S %DT("A")="Ending date: ",%DT("B")=END D ^%DT K %DT
 G:"^"[$E(X) EXIT
 S SCANEDT=Y D DD^%DT S EDATE=Y
 S Y=SCANBDT D DD^%DT S BDATE=Y
 ;
 W !!,"This report is designed for a 132-column format.",!
 W !,"It is recommended that this report be queued.",!!
 ;***
 K IO("Q"),%ZIS,IOP,ZTSK S %ZIS="Q"
 D ^%ZIS I POP S IOP=PSOION D ^%ZIS K IOP,PSOION G EXIT
 K PSOION
 ; set subscript for ^XTMP storage
 S PSOJOB=$J_"_"_$P($H,",",2)
 S PSOSUB="PSO_CMOP_CS"_PSOJOB
 ; setup queing
 I $D(IO("Q")) D  G EXIT
 . F X="BDATE","EDATE","QDIV","QSORT","SCANBDT","SCANEDT","PSOSUB" S ZTSAVE(X)=""
 . S ZTRTN="DEQUEUE^PSOCMOPR",ZTDESC="Report of CMOP CS RX Dispenses"
 . D ^%ZTLOAD W:$D(ZTSK) !,"Report Queued to Print !!",! K ZTSK,IO("Q")
 ;
DEQUEUE ; TASKING RE-ENTRY POINT AND PROCESSING
 D COMPUTE,PRINT
 G EXIT
 Q
COMPUTE ; Deque point for computing
 ; store in ^XTMP(PSOSUB, for printing queue
 K ^XTMP(PSOSUB),PSOQUIT
 S X1=DT,X2=2 D C^%DTC
 S ^XTMP(PSOSUB,0)=X_U_DT_"^  Storage for CMOP-CS-RX STATUS DIVISION REPORT"
 S SCANDT=SCANBDT\1-.1
 ; Set status catagories
 ;
 F  S SCANDT=$O(^PSRX("AD",SCANDT)) Q:SCANDT>SCANEDT  Q:SCANDT'>0  D
 . S RX=0 F  S RX=$O(^PSRX("AD",SCANDT,RX)) Q:RX'>0  D
 .. S FILL="" F  S FILL=$O(^PSRX("AD",SCANDT,RX,FILL)) Q:FILL=""  D RX
 Q
RX ; check & gather RX,Fills data
 ;
 I '$D(^PSRX(RX,4)) Q  ;no CMOP events
 I '$O(^PSRX(RX,4,0)) Q  ; no CMOP events
 D CMOP ;                          get CMOP ST - FAC
 Q:'TRANDA  ; no CMOP event for FILL
 ;
 ;    test for CS category 3,4,5 & C
 S DRUGDA=$$GET1^DIQ(52,RX,6,"I")
 S DEA=$$GET1^DIQ(50,DRUGDA,3)
 I DEA'[3,DEA'[4,DEA'[5 Q
 ;
 ; get qty & div & reldt per original or refil
 I FILL=0 S QTY=$$GET1^DIQ(52,RX,7),DIV=$$GET1^DIQ(52,RX,20),DIVDA=$$GET1^DIQ(52,RX,20,"I") S RELDT=$$GET1^DIQ(52,RX,31,"I") I 1
 E  D
 . S RXF=^PSRX(RX,1,FILL,0)
 . S QTY=$P(RXF,U,4),DIVDA=$P(RXF,U,9)
 . S RELDT=$P(RXF,U,18)
 . S DIV=$$GET1^DIQ(59,DIVDA,.01)
 ; test div if QDIV
 I +QDIV,DIVDA'=QDIV Q
 ;
 S:RELDT="" RELDT="Not Released"
 S DRUG=$$GET1^DIQ(50,DRUGDA,.01) ; get DRG;
 S PAT=$$GET1^DIQ(52,RX,2) ;       get PAT
 S PATDA=$$GET1^DIQ(52,RX,2,"I")
 S SSN=$$GET1^DIQ(2,PATDA,.09),SSN="("_$E(SSN,6,9)_")"
 ;
 ; store according to sort
 I QSORT=2 S ^XTMP(PSOSUB,DIV,DRUG,RELDT,TRANDA)=PAT_U_SSN_U_QTY_U_ST_U_FAC_U_RX_U_FILL_U_DRUG
 E  S ^XTMP(PSOSUB,DIV,RELDT,TRANDA)=PAT_U_SSN_U_QTY_U_ST_U_FAC_U_RX_U_FILL_U_DRUG
 ;
 Q
 ;
CMOP ;loop CMOP event for fill, status, and facility
 ; sets TRANDA for XTMP subscript
 S EVTRDA=0,TRANDA=0
 S (ST,FAC)=""
 ; loop events : EVTRDA will be the last event for the FILL in question
 S EVDA=0
 F  S EVDA=$O(^PSRX(RX,4,EVDA)) Q:EVDA'>0  S:FILL=$P(^(EVDA,0),U,3) EVTRDA=EVDA
 Q:'EVTRDA
 S EVENT=^PSRX(RX,4,EVTRDA,0)
 S ST=$P(EVENT,U,4)
 S ST=$S(ST=0:"T",ST=1:"D",ST=2:"RT",ST=3:"ND",1:"")
 S TRANDA=$P(EVENT,U,1)
 S FAC=$$GET1^DIQ(550.2,TRANDA,3)
 K EVDA,EVTRDA
 Q
PRINT ; print entry point
 K PSOQUIT,PSOPG,DIV
 S PSOQUIT=0
 D COLUMN ; set column spacing
 D PGHDR
 I $O(^XTMP(PSOSUB,0))="" D  G EXIT
 . W !!,?5,"No Data To Report",!!
 D:QSORT=1 BYDATE
 D:QSORT=2 BYDRUG
 K ^XTMP(PSOSUB)
 Q
BYDATE ; print report by release date
 ;^XTMP(PSOSUB,DIV,SCANDT,TRANDA)=PAT_U_SSN_U_QTY_U_ST_U_FAC_U_RX_U_FILL_U_DRUG
 S DIV=0 F  S DIV=$O(^XTMP(PSOSUB,DIV)) Q:DIV=""  Q:$G(PSOQUIT)  D
 . D DIVHDR
 . S SCANDT=0 F  S SCANDT=$O(^XTMP(PSOSUB,DIV,SCANDT)) Q:SCANDT=""  Q:$G(PSOQUIT)  D
 .. S TRANDA=0 F  S TRANDA=$O(^XTMP(PSOSUB,DIV,SCANDT,TRANDA)) Q:TRANDA'>0  Q:$G(PSOQUIT)  D PRTDATE
 Q
PRTDATE ; print by date output
 ;^XTMP(PSOSUB,DIV,SCANDT,TRANDA)=PAT_U_SSN_U_QTY_U_ST_U_FAC_U_RX_U_FILL_U_DRUG
 S X=^XTMP(PSOSUB,DIV,SCANDT,TRANDA)
 S PAT=$P(X,U,1),SSN=$P(X,U,2),QTY=$P(X,U,3),ST=$P(X,U,4)
 S FAC=$P(X,U,5),RX=$P(X,U,6),FILL=$P(X,U,7),DRUG=$P(X,U,8)
 S (DATE,Y)=SCANDT I +Y D DD^%DT S DATE=Y
 S PAT=PAT_" "_SSN
 S RX=$$GET1^DIQ(52,RX,.01)
 ;
 D PG Q:$G(PSOQUIT)
 W !,DATE,?C1,RX_" ("_FILL_")",?C2,PAT,?C3,ST,?C4,FAC,!,DRUG,?C5,"QTY: ",QTY,!
 Q
BYDRUG ; pull in & print byDrug
 ;^XTMP(PSOSUB,DIV,DRUG,SCANDT,TRANDA)=PAT_U_SSN_U_QTY_U_ST_U_FAC_U_RX_U_FILL_U_DRUG
 S DIV=0 F  S DIV=$O(^XTMP(PSOSUB,DIV)) Q:DIV=""  Q:$G(PSOQUIT)  D
 . D DIVHDR
 . S DRUG="" F  S DRUG=$O(^XTMP(PSOSUB,DIV,DRUG)) Q:DRUG=""  Q:$G(PSOQUIT)  D
 .. W !!,?3,DRUG
 .. S SCANDT=0 F  S SCANDT=$O(^XTMP(PSOSUB,DIV,DRUG,SCANDT)) Q:SCANDT=""  Q:$G(PSOQUIT)  D
 ... S TRANDA=0 F  S TRANDA=$O(^XTMP(PSOSUB,DIV,DRUG,SCANDT,TRANDA)) Q:TRANDA'>0  Q:$G(PSOQUIT)  D PRTDRUG
 Q 
PRTDRUG ; print by Drug
 ;^XTMP(PSOSUB,DIV,DRUG,SCANDT,TRANDA)=PAT_U_SSN_U_QTY_U_ST_U_FAC_U_RX_U_FILL_U_DRUG
 S X=^XTMP(PSOSUB,DIV,DRUG,SCANDT,TRANDA)
 S PAT=$P(X,U,1),SSN=$P(X,U,2),QTY=$P(X,U,3),ST=$P(X,U,4)
 S FAC=$P(X,U,5),RX=$P(X,U,6),FILL=$P(X,U,7)
 S (DATE,Y)=SCANDT I +Y D DD^%DT S DATE=Y
 S PAT=PAT_" "_SSN,RX=$$GET1^DIQ(52,RX,.01),RX=RX_" ("_FILL_")"
 D PG Q:$G(PSOQUIT)
 ;"Release Date",?D1,"Rx#",?D2,"QTY",?D3,"Patient",?D4,"CMOP",?D5,"CMOP
 W !,DATE,?D1,RX,?D2,QTY,?D3,PAT,?D4,ST,?D5,FAC
 Q
EXIT ;EXIT
 K BDATE,C1,C2,C3,C4,C5,C6,CMOP,D1,D2,D3,D4,D5,DATE,DEA,DIV,DIVDA,DRUG
 K DRUGDA,EDATE,END,FAC,FIL,FLD,PAT,PATDA,PSOPG,PSOSUB,EVENT,RXF
 K QDIV,QSORT,QTY,RX,SCANDT,SCANBDT,SCANEDT,SSN,ST,TRANDA,PSOQUIT
 K FILL,EVDA,PSOJOB,PSOPAR,PSUIOP,PSUFQ,PSURC,PSURP,PSURX,PSUNS,X1,X2
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
PG ;EP  Page controller
 ;S PSOQUIT=0
 Q:$G(PSOQUIT)
 I $Y<(IOSL-4) Q
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR I $D(DIRUT) S PSOQUIT=1 Q
 ;
PGHDR ; Write Page Header
 U IO W @IOF
 S PSOPG("PG")=$G(PSOPG("PG"))+1
 W !,"CMOP Controlled Substance Prescription Dispensing Report",?(IOM-12),"Page: ",PSOPG("PG")
 W !,BDATE," through ",EDATE
 D:$D(DIV) DIVHDR
 Q
 ;
DIVHDR ; write division header
 S X=DIV_"  Division"
 W !!,?((IOM-$L(X))\2),X,!!
 I QSORT=1 D
 . W !,"Release Date",?C1,"Rx#",?C2,"Patient",?C3,"CMOP",?C4,"CMOP"
 . W !,?C3,"STATUS",?C4,"Facility",! ; RX at C5 QTY AT C6
 . F X=1:1:IOM-2 W "-"
 I QSORT=2 D
 . W !,"Release Date",?D1,"Rx#",?D2,"QTY",?D3,"Patient",?D4,"CMOP",?D5,"CMOP"
 . W !,?D4,"STATUS",?D5,"Facility",!
 . F X=1:1:IOM-2 W "-"
 . I PSOPG("PG")>1,$L($G(DRUG)) W !,?3,DRUG
 Q
COLUMN ; setup column spacing
C1 ; setup column spacing for byDate
 S C1=23,C2=39,C3=77,C4=85,C5=42
 ;W !,DATE,?C1,RX_" ("_FILL_")",?C2,PAT,?C3,ST,?C4,FAC,!,DRUG,?C5,"QT: ",QTY
D1 ; setup column spacing for byDrug
 ;"Release Date",?D1,"Rx#",?D2,"QTY",?D3,"Patient",?D4,"CMOP",?D5,"CMOP
 S D1=23,D2=39,D3=53,D4=91,D5=99
 Q
CLEAR ; clear ^XTMP
 S X="PSO_CMOP_",Y=X
 F  S X=$O(^XTMP(X)) Q:X'[Y  K ^XTMP(X)
 Q
