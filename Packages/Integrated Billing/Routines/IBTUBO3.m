IBTUBO3 ;ALB/RB - UNBILLED AMOUNTS - GENERATE UNBILLED REPORTS ;03 Aug 2004  9:12 AM
 ;;2.0;INTEGRATED BILLING;**123,159,192,155,277**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
REPORT ; - Prepare report if requested, send summary bulletin.
 N IBRUN,IBN,IBPAG,IBQ,DFN,DTE,FL,PT,X0,X1
 S IBRUN=$$HTE^XLFDT($H,1)
 D BULL^IBTUBUL G:'IBDET REPRTQ
 ;
REPRT1 S (IBPAG,IBQ,IBX)=0
 I '$D(^TMP($J)) S X0="" D HDR,NIM D:'IBQ PAUSE G REPRTQ
 F X0=1,2,3 I IBSEL[X0 D  Q:IBQ
 . S X1="IBTUB-"_$S(X0=2:"OPT",X0=3:"RX",1:"INPT")
 . D HDR Q:IBQ  I '$D(^TMP($J,X1)) D NIM Q
 . S PT="" F  S PT=$O(^TMP($J,X1,PT)) Q:PT=""  D  Q:IBQ
 . . S DFN=+$P(PT,"@@",2) Q:'DFN
 . . S (DTE,FL)="" F  S DTE=$O(^TMP($J,X1,PT,DTE)) Q:DTE=""  D  Q:IBQ
 . . . S IBX="" F  S IBX=$O(^TMP($J,X1,PT,DTE,IBX)) Q:IBX=""  D  Q:IBQ
 . . . . S IBN=^TMP($J,X1,PT,DTE,IBX) D LINE Q:IBQ  I X1["OPT" D CPTS Q:IBQ
 ;
 D:'IBQ PAUSE
 ;
REPRTQ Q
 ;
HDR ; - Output header.
 N I,X,XTP
 I $E(IOST,1,2)="C-",IBPAG D PAUSE G HDRQ:IBQ
 W:'$G(IBPAG) ! I $E(IOST,1,2)="C-"!$G(IBPAG) W @IOF,*13
 S IBPAG=$G(IBPAG)+1 W !,"Unbilled Amounts Report"
 W ?60,"Run Date: ",IBRUN,?124,"Page ",$J(IBPAG,3)
 S XTP=$S(X0=1:"INPATIENT",X0=2:"OUTPATIENT",X0=3:"PRESCRIPTIONS",1:"")
 S:X0'=3 XTP=XTP_" EPISODES" S X="ALL "_XTP_" FROM "
 S X=X_$$DTE(IBBDT)_" TO "_$$DTE(IBEDT\1)
 I $G(IBCOMP) D
 .S X=X_" / DATA RECOMPILED/STORED FOR "_$$DAT2^IBOUTL(IBTIMON)
 S X=X_" / '*' AFTER THE PATIENT NAME = USUALLY BILLED MEANS TEST COPAYMENT"
 I X0=1 S X=X_" / 'H' AFTER THE ADMISSION DATE = PATIENT CURRENTLY HOSPITALIZED"
 I X0=3 S X=X_" / '$' AFTER THE ORIGINAL FILL DATE = ORIGINAL FILL DATE HAS BEEN BILLED"
 S X=X_" / 'CF' COLUMN = NUMBER OF CLAIMS ON FILE FOR THE EPISODE"
 I X0'=3 D
 .S X=X_" / 'I/P' COLUMN = 'I' - INSTUTIONAL CLAIM MISSING,"
 .S X=X_" 'P' - PROFESSIONAL CLAIM MISSING"
 F I=1:1 W !,$E(X,1,132) S X=$E(X,133,999) Q:X=""
 ;
 I 'X0 W !,$TR($J(" ",IOM)," ","-"),! G HDRQ
 W !!?29,"Last Prim.  Claims" W:X0=3 ?52,"Fill",?123,"Original"
 W !,"Name",?29,"4SSN Elig.  Track.ID#"
 I X0=1 W ?52,"Admission CF Insurance Carrier(s)",?98,"I/P",?102,"MRA"
 I X0=2 W ?52,"Care Dt.  CF Insurance Carrier(s)",?98,"I/P",?102,"MRA",?106,"CPT     I. Rate   P. Rate"
 I X0=3 W ?52,"Date     CF Ins. Carrier(s)     MRA Drug Name        Physician",?123,"Fill Dt."
 W !,$TR($J(" ",IOM)," ","-"),!
 I $D(ZTQUEUED),$$S^%ZTLOAD D
 . W !!,"...Task stoped at user request" S (IBQ,ZTSTOP)=1
 ;
HDRQ Q
 ;
CPTS ; - Outpatient Only (CPTs and Rates)
 N CPT,IBN1
 I $O(^TMP($J,X1,PT,DTE,IBX,""))="" W ?98,"I",?103,$S('$G(IBINMRA):"",$G(^TMP($J,X1_"_MRA",PT,DTE,IBX)):"M",1:"") W ! Q
 S CPT="" F  S CPT=$O(^TMP($J,X1,PT,DTE,IBX,CPT)) Q:CPT=""  D  Q:IBQ
 . S IBN1=^TMP($J,X1,PT,DTE,IBX,CPT)
 . I $Y>(IOSL-5) D HDR Q:IBQ  S FL=0 D LINE
 . W ?98,$P(IBN1,U,3),?103,$S('$G(IBINMRA):"",$G(^TMP($J,X1_"_MRA",PT,DTE,IBX)):"M",1:""),?106,CPT,?113,$J(+IBN1,8,2)
 . W ?124,$J($P(IBN1,U,2),8,2),!
 Q
 ;
LINE ; - Print detail line.
 I $Y>(IOSL-6) D HDR G:IBQ LINQ S FL=0
 I 'FL D
 . W $E($P(PT,"@@"),1,26) I $$BIL^DGMTUB(DFN,+DTE) W " *"
 . W ?29,$$SSN(DFN),?34,$E($$ELIG(DFN),1,5) S FL=1
 ;
 W ?39,$J(IBX,11)
 ; - Inpatient and Outpatient Only
 I X1'["RX" D
 . W ?52,$$DTE(+DTE) W:X1["INPT" $S($P(IBN,U,5):"H",1:"")
 . W ?62,$J($P(IBN,U),2),?65,$$INS(DFN,+DTE,34)
 . I X1["INPT" D
 .. I $P(IBN,U,2)'="" W ?98,$E($P(IBN,U,2),1,3),!
 .. I '$G(^TMP($J,X1_"_MRA",PT,DTE,IBX))!'$G(IBINMRA) W:$P(IBN,U,2)="" ! Q
 .. W ?98,$E($P(^TMP($J,X1_"_MRA",PT,DTE,IBX),U,2),1,3),?103,"M",!
 ;
 ; - Pharmacy Only
 I X1["RX" D  G LINQ
 . W ?52,$$DTE(+DTE),?61,$J($P(IBN,U),2),?64,$$INS(DFN,+DTE,19),?85,$S('$G(IBINMRA):"",$G(^TMP($J,X1_"_MRA",PT,DTE,IBX)):"M",1:"")
 . W ?88,$E($P(IBN,U,6),1,15),?105,$E($P(IBN,U,2),1,14)
 . W ?123,$$DTE($P(IBN,U,3)) W:$P(IBN,"^",5) "$" W !
 ;
LINQ Q
 ;
SSN(DFN) ; - Return last 4 of patient's SSN.
 N SSN,VADM
 D DEM^VADPT S SSN=$P(VADM(2),"^"),SSN=$E(SSN,6,9) D KVA^VADPT
 Q SSN
 ;
ELIG(DFN) ; - Return patient's primary eligibility (1st 10 characters).
 N ELIG,VAEL
 D ELIG^VADPT S ELIG=$E($P(VAEL(1),"^",2),1,10) D KVAR^VADPT
 Q ELIG
 ;
DTE(D) ; - Format date (MM/DD/YY or MM/YY).
 Q $S('$G(D):"",1:$E(D,4,5)_"/"_$S($E(D,6,7)'="00":$E(D,6,7)_"/",1:"")_$E(D,2,3))
 ;
INS(P,D,C) ; - Return patient's insurance carrier(s).
 ;   Input: P=patient IEN, D=event date, C=Size of the Ins.Carrier column
 ;  Output: List of Providers
 ;
 I '$G(P)!('$G(D)) Q ""
 ;
 N INSC,INSL,INSN,LST,TMP,X
 ;
 S INSL="" D ALL^IBCNS1(P,"LST",1,D)
 S X=0 F  S X=$O(LST(X)) Q:'X  D
 . S INSC=+$G(LST(X,0)) Q:$D(TMP(INSC))!'INSC
 . S INSN=$P($G(^DIC(36,INSC,0)),U)
 . I $G(LST(0))>1 S INSN=$E(INSN,1,C\2)
 . S INSL=INSL_","_INSN
 . S TMP(INSC)=""
 ;
 S $E(INSL)=""
 I $L(INSL,",")>1,$L(INSL)>C D
 . S INSL=$E(INSL,1,C-3),$P(INSL,",",$L(INSL,","))="..."
 S INSL=$E(INSL,1,C)
 ;
 Q INSL
 ;
NIM ; - Print 'no info' message.
 W !?3,"No information available for the period specified."
 Q
 ;
PAUSE ; - Page break.
 I $E(IOST,1,2)'="C-" Q
 N IBI,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBI=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR S:$D(DIRUT)!($D(DUOUT)) IBQ=1
 Q
